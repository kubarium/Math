package com.kubarium.math {

	public class Matrix {
		public function Matrix(rows:uint, columns:uint, array:Array = null) {
			_rows = rows;
			_columns = columns;
			_m = new Vector.<Vector.<Number>>();

			if(!array) {
				var i:int = 0;
				array = new Array();

				while(i < rows * columns)
					array[i++] = 0;
			}

			for(var j:int = 0; j < rows; j++) {
				_m[j] = new Vector.<Number>();

				for(var k:int = 0; k < columns; k++)
					_m[j][k] = array[(j * columns) + k];
			}
		}

		public const SIZE_ERROR:String = "Matrix size doesn't match";

		private var _columns:uint;

		private var _m:Vector.<Vector.<Number>>; //Array;

		private var _rows:uint;

		public function add(matrix:Matrix):Matrix {
			if(rows != matrix.rows || columns != matrix.columns)
				throw new Error(SIZE_ERROR);
			else {
				for(var j:uint = 0; j < rows; j++)
					for(var k:uint = 0; k < columns; k++)
						_m[j][k] += matrix._m[j][k];
				return this;
			}
		}

		public function assignValue(row:uint, column:uint, value:Number):void {
			_m[row - 1][column - 1] = value;
			//_m[(row-1) * columns + column-1] = value; 
		}

		public function get columns():uint {
			return _columns;
		}

		public function set columns(value:uint):void {
			_columns = value;
		}

		public function constant(value:Number):Matrix {
			for(var j:uint = 0; j < rows; j++)
				for(var k:uint = 0; k < columns; k++)
					_m[j][k] = value;
			return this;
		}



		public function identity():Matrix {
			var temp:Matrix = new Matrix(rows, columns);

			if(rows != columns)
				throw new Error(SIZE_ERROR);
			else {
				for(var j:uint = 0; j < rows; j++)
					_m[j][j] = 1;
				_m = temp._m;
				return this;
			}
		}

		public function multiply(matrix:Matrix):Matrix {
			if(columns != matrix.rows)
				throw new Error(SIZE_ERROR);
			else {
				var temp:Matrix = new Matrix(rows, matrix.columns);

				for(var i:uint = 0; i < rows; i++)
					for(var j:uint = 0; j < matrix.columns; j++)
						for(var k:uint = 0; k < matrix.rows; k++)
							temp._m[i][j] += _m[i][k] * matrix._m[k][j];
				_m = temp._m;
				return this;
			}
		}

		/**
		 * Reduced row echelon form
		 * @return
		 *
		 */		
		public function RREF():Matrix {
			var lead:uint, i:uint, j:uint, r:uint = 0;

			for(r = 0; r < rows; r++) {
				if(columns <= lead)
					break;
				i = r;

				while(_m[i][lead] == 0) {
					i++;

					if(rows == i) {
						i = r;
						lead++;

						if(columns == lead)
							return this;
					}
				}
				rowSwitch(i, r);
				var val:Number = _m[r][lead];

				for(j = 0; j < columns; j++)
					_m[r][j] /= val;

				for(i = 0; i < rows; i++) {
					if(i == r)
						continue;
					val = _m[i][lead];

					for(j = 0; j < columns; j++)
						_m[i][j] -= val * _m[r][j];
				}
				lead++;
			}
			return this;
		}

		public function resize(r:Number, c:Number):void {
			var j:Number, k:Number;
			var diffR:Number = r - rows;
			var diffC:Number = c - columns;

			// add new rows
			if(diffR > 0) {
				for(j = 0; j < diffR; j++) {
					_m.push(new Array());

					// initialize new elements as zero
					for(k = 0; k < columns + diffC; k++)
						_m[columns + j][k] = 0;
				}
			}

			// add new columns
			if(diffC > 0) {
				for(j = 0; j < rows; j++) {
					for(k = 0; k < diffC; k++)
						_m[j].push(0);
				}
			}

			// take away extra rows
			if(diffR < 0) {
				for(j = 0; j > diffR; j--)
					_m.pop();
			}

			// take away extra columns
			if(diffC < 0) {
				for(j = 0; j < r; j++) {
					for(k = 0; k > diffC; k--)
						_m[j].pop();
				}
			}
			rows = r;
			columns = c;
		}





		public function rowSwitch(row1:uint, row2:uint):Matrix {
			var temp:Vector.<Number> = temp = _m[row1];
			_m[row1] = _m[row2];
			_m[row2] = temp;
			return this;
		}

		public function get rows():uint {
			return _rows;
		}

		public function set rows(value:uint):void {
			_rows = value;
		}

		public function scalar(scalar:Number):Matrix {
			for(var j:uint = 0; j < rows; j++)
				for(var k:uint = 0; k < columns; k++)
					_m[j][k] *= scalar;
			return this;
		}

		public function subtract(matrix:Matrix):Matrix {
			if(rows != matrix.rows || columns != matrix.columns)
				throw new Error(SIZE_ERROR);
			else {
				for(var j:uint = 0; j < rows; j++)
					for(var k:uint = 0; k < columns; k++)
						_m[j][k] -= matrix._m[j][k];
				return this;
			}
		}

		public function toArray():Array {
			return _m.join().split(',') as Array;
		}

		public function toString():String {
			return _m.join('\n');
		}

		public function trace():Number {
			var result:Number = 0;

			if(rows != columns)
				throw new Error(SIZE_ERROR);
			else {
				for(var j:uint = 0; j < rows; j++)
					result += _m[j][j];
				return result;
			}
		}

		public function transpose():Matrix {
			var temp:Matrix = new Matrix(columns, rows);

			for(var j:uint = 0; j < rows; j++)
				for(var k:uint = 0; k < columns; k++)
					temp._m[k][j] = _m[j][k];
			//resize(columns, rows);
			_m = temp._m;
			return this;
		}
	}
}


