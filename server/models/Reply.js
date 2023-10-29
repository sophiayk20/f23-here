// Data model schema for Replies
import mongoose, { mongo } from "mongoose";
const { Schema } = mongoose;

export const ReplySchema = new Schema({
    parent_message: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    content: {
        type: String,
        required: true,
    },
    likes: {
        type: Number,
        default: 0,
    },
});

const ReplyModel = mongoose.model("Reply", ReplySchema);
export default ReplyModel;
