///@function						null(objectId)
///@param {object id} objectId		The ID to check
///@description						Return the boolean of <0 || undefined to save space
function null(objectId) {
	return (objectId <= 0 || objectId == undefined);
}