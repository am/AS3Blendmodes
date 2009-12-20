package am.blendmodes {
	import flash.display.BitmapData;

	/**
	 * The ColorBurn class is used to create a ColorBurn BlendMode, based on 2
	 * overlapping Bitmaps. It gives back another BitmapData, and it doesn't
	 * change the original data.
	 * <br/><br/>
	 * @author am, www.complexresponse.com
	 * @date November 24, 2009
	 * @version 0.1
	 */
	public class ColorBurn {

		/**
		 * This property will return the blended result of the 2 BitmapData's
		 * passed throught the constructor. NOTE: This operation can be processor
		 * intensive as it cicles all the pixels of the BitmapData on 2 for loops.
		 * @returns BitmapData
		 */
		public function get getBlend() : BitmapData {
			return blend();
		}

		private var bottom_bmpd : BitmapData;
		private var top_bmpd : BitmapData;

		/**
		 * Constructor for creating new ColorBurn instances.<br/>
		 * @example <listing version="3.0"><br/>
		 * var colorBurn:ColorBurn = new ColorBurn(img_bot.bitmapData, img_top.bitmapData);<br/>
		 * var result:Bitmap = new Bitmap(colorBurn.getBlend);<br/>
		 * addChild(result);<br/>
		 * </listing>
		 * @param $bottom_bmpd The BitmapData of the bottom image.
		 * @param $top_bmpd The BitmapData of the top image.
		 *
		 */
		public function ColorBurn($bottom_bmpd : BitmapData, $top_bmpd : BitmapData) {
			bottom_bmpd = $bottom_bmpd;
			top_bmpd = $top_bmpd;
		}

		private function blend() : BitmapData {

			var it_W : int = top_bmpd.width;
			var it_H : int = top_bmpd.height;

			var bmpd : BitmapData = new BitmapData(it_W, it_H);

			var top_c : uint, bot_c : uint;
			var topRGB : Object, botRGB : Object;
			var end_r : int, end_g : int, end_b : int;

			for( var _x : uint = 0;_x < it_H;_x++ ) {
				for( var _y : uint = 0;_y < it_W;_y++ ) {

					top_c = top_bmpd.getPixel(_x, _y);
					bot_c = bottom_bmpd.getPixel(_x, _y);

					topRGB = hex2rgb(top_c);
					botRGB = hex2rgb(bot_c);

					end_r = end_g = end_b = 0;

					if (topRGB['r'] > 0) end_r = 255 - Math.min(255, ((255 - botRGB['r']) / topRGB['r']) * 255);
					if (topRGB['g'] > 0) end_g = 255 - Math.min(255, ((255 - botRGB['g']) / topRGB['g']) * 255);
					if (topRGB['b'] > 0) end_b = 255 - Math.min(255, ((255 - botRGB['b']) / topRGB['b']) * 255);

					bmpd.setPixel(_x, _y, rgb2hex(end_r, end_g, end_b));
				}
			}
			return (bmpd);
		}

		private function hex2rgb(hex : Number) : Object {
			var r : Number, g : Number, b : Number;

			r = (0xFF0000 & hex) >> 16;
			g = (0x00FF00 & hex) >> 8;
			b = (0x0000FF & hex);

			return {r:r, g:g, b:b};
		}

		private function rgb2hex(r : Number, g : Number, b : Number) : Number {
			return ((r << 16) | (g << 8) | b);
		}
	}
}
