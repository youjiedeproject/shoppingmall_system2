
window.onload=function(){
	var i=1;
	setInterval(time,3000);
	function time(){
		var a=document.getElementById("myd7");
		i++;
		a.src="img/b"+i+".jpg";
		if(i==3){
			i=1;
		}
	}
}
