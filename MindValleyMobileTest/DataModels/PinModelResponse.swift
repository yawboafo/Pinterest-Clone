/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation


typealias PinModelResponse = [Pin]

struct Pin : Codable {
	let id : String?
	let created_at : String?
	let width : Int?
	let height : Int?
	let color : String?
	let likes : Int?
	let liked_by_user : Bool?
	let user : User?
	let current_user_collections : [String]?
	let urls : Urls?
	let categories : [Categories]?
	let links : Links?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case created_at = "created_at"
		case width = "width"
		case height = "height"
		case color = "color"
		case likes = "likes"
		case liked_by_user = "liked_by_user"
		case user = "user"
		case current_user_collections = "current_user_collections"
		case urls = "urls"
		case categories = "categories"
		case links = "links"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
		user = try values.decodeIfPresent(User.self, forKey: .user)
		current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
		urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
		categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
	}

}
