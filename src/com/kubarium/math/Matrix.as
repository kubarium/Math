package com.kubarium.math {

	public class Matrix {
		public function Matrix(rows:uint, columns:uint, array:Array = null) {
			_rows = rows;
			_columns = columns;
			_m = new Vector.<Number>(rows * columns);

			if(array && rows * columns == array.length)
				for(var j:int = 0; j < rows; j++)
					for(var k:int = 0; k < columns; k++)
						_m[(j * columns) + k] = array[(j * columns) + k];
		}

		public function assignValue(row:uint, column:uint, value:Number):void{
			_m[(row-1) * columns + column-1] = value; 
		}

		private var _columns:uint;

		private var _m:Vector.<Number>;

		private var _rows:uint;

		public function get columns():uint {
			return _columns;
		}

		public function set columns(value:uint):void {
			_columns = value;
		}

		public function get rows():uint {
			return _rows;
		}

		public function set rows(value:uint):void {
			_rows = value;
		}

		public function toString():String {
			var output:Array = new Array();
			var text:String = "";

			/*for(var j:int = 0; j < rows * columns; j++)
				output.push(_m[j]);*/
			for(var j:int = 0; j < rows; j++) {
				for(var k:int = 0; k < columns; k++) {
					//						$m[j][k] = arr[(j*$rows)+(k%$columns)];
					output.push(_m[(j * columns) + k]);
					text += _m[(j * columns) + k] + ',';
				}
				text = text.substr(0, text.length - 1) + '\n';
			}
			return text; //output.join(',');
		}
	}
}


