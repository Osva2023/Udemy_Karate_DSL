var stats = {
    type: "GROUP",
name: "All Requests",
path: "",
pathFormatted: "group_missing-name-b06d1",
stats: {
    "name": "All Requests",
    "numberOfRequests": {
        "total": "159",
        "ok": "145",
        "ko": "14"
    },
    "minResponseTime": {
        "total": "152",
        "ok": "172",
        "ko": "152"
    },
    "maxResponseTime": {
        "total": "481",
        "ok": "481",
        "ko": "228"
    },
    "meanResponseTime": {
        "total": "231",
        "ok": "238",
        "ko": "168"
    },
    "standardDeviation": {
        "total": "73",
        "ok": "73",
        "ko": "18"
    },
    "percentiles1": {
        "total": "198",
        "ok": "200",
        "ko": "164"
    },
    "percentiles2": {
        "total": "244",
        "ok": "314",
        "ko": "169"
    },
    "percentiles3": {
        "total": "352",
        "ok": "361",
        "ko": "195"
    },
    "percentiles4": {
        "total": "451",
        "ok": "454",
        "ko": "221"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 145,
    "percentage": 91
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 14,
    "percentage": 9
},
    "meanNumberOfRequestsPerSecond": {
        "total": "1.71",
        "ok": "1.559",
        "ko": "0.151"
    }
},
contents: {
"req_post--api-users-7a661": {
        type: "REQUEST",
        name: "POST /api/users/login",
path: "POST /api/users/login",
pathFormatted: "req_post--api-users-7a661",
stats: {
    "name": "POST /api/users/login",
    "numberOfRequests": {
        "total": "1",
        "ok": "1",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "0",
        "ok": "0",
        "ko": "-"
    },
    "percentiles1": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "percentiles2": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "percentiles3": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "percentiles4": {
        "total": "432",
        "ok": "432",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 1,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.011",
        "ok": "0.011",
        "ko": "-"
    }
}
    },"req_post--api-artic-043e6": {
        type: "REQUEST",
        name: "POST /api/articles",
path: "POST /api/articles",
pathFormatted: "req_post--api-artic-043e6",
stats: {
    "name": "POST /api/articles",
    "numberOfRequests": {
        "total": "50",
        "ok": "36",
        "ko": "14"
    },
    "minResponseTime": {
        "total": "152",
        "ok": "184",
        "ko": "152"
    },
    "maxResponseTime": {
        "total": "247",
        "ok": "247",
        "ko": "228"
    },
    "meanResponseTime": {
        "total": "193",
        "ok": "203",
        "ko": "168"
    },
    "standardDeviation": {
        "total": "22",
        "ok": "15",
        "ko": "18"
    },
    "percentiles1": {
        "total": "196",
        "ok": "200",
        "ko": "164"
    },
    "percentiles2": {
        "total": "204",
        "ok": "207",
        "ko": "169"
    },
    "percentiles3": {
        "total": "230",
        "ok": "232",
        "ko": "195"
    },
    "percentiles4": {
        "total": "241",
        "ok": "242",
        "ko": "221"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 36,
    "percentage": 72
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 14,
    "percentage": 28
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.538",
        "ok": "0.387",
        "ko": "0.151"
    }
}
    },"req_get--api-articl-edf3b": {
        type: "REQUEST",
        name: "GET /api/articles?limit=10&offset=0",
path: "GET /api/articles?limit=10&offset=0",
pathFormatted: "req_get--api-articl-edf3b",
stats: {
    "name": "GET /api/articles?limit=10&offset=0",
    "numberOfRequests": {
        "total": "72",
        "ok": "72",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "172",
        "ok": "172",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "481",
        "ok": "481",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "271",
        "ok": "271",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "87",
        "ok": "87",
        "ko": "-"
    },
    "percentiles1": {
        "total": "314",
        "ok": "314",
        "ko": "-"
    },
    "percentiles2": {
        "total": "334",
        "ok": "334",
        "ko": "-"
    },
    "percentiles3": {
        "total": "438",
        "ok": "438",
        "ko": "-"
    },
    "percentiles4": {
        "total": "468",
        "ok": "468",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 72,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.774",
        "ok": "0.774",
        "ko": "-"
    }
}
    },"req_delete--api-art-7a37d": {
        type: "REQUEST",
        name: "DELETE /api/articles/title1-45546",
path: "DELETE /api/articles/title1-45546",
pathFormatted: "req_delete--api-art-7a37d",
stats: {
    "name": "DELETE /api/articles/title1-45546",
    "numberOfRequests": {
        "total": "9",
        "ok": "9",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "184",
        "ok": "184",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "241",
        "ok": "241",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "203",
        "ok": "203",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "17",
        "ok": "17",
        "ko": "-"
    },
    "percentiles1": {
        "total": "198",
        "ok": "198",
        "ko": "-"
    },
    "percentiles2": {
        "total": "204",
        "ok": "204",
        "ko": "-"
    },
    "percentiles3": {
        "total": "233",
        "ok": "233",
        "ko": "-"
    },
    "percentiles4": {
        "total": "239",
        "ok": "239",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 9,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.097",
        "ok": "0.097",
        "ko": "-"
    }
}
    },"req_delete--api-art-a6f0e": {
        type: "REQUEST",
        name: "DELETE /api/articles/title2-45546",
path: "DELETE /api/articles/title2-45546",
pathFormatted: "req_delete--api-art-a6f0e",
stats: {
    "name": "DELETE /api/articles/title2-45546",
    "numberOfRequests": {
        "total": "9",
        "ok": "9",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "176",
        "ok": "176",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "238",
        "ok": "238",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "197",
        "ok": "197",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "17",
        "ok": "17",
        "ko": "-"
    },
    "percentiles1": {
        "total": "192",
        "ok": "192",
        "ko": "-"
    },
    "percentiles2": {
        "total": "198",
        "ok": "198",
        "ko": "-"
    },
    "percentiles3": {
        "total": "226",
        "ok": "226",
        "ko": "-"
    },
    "percentiles4": {
        "total": "236",
        "ok": "236",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 9,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.097",
        "ok": "0.097",
        "ko": "-"
    }
}
    },"req_delete--api-art-38f94": {
        type: "REQUEST",
        name: "DELETE /api/articles/title3-45546",
path: "DELETE /api/articles/title3-45546",
pathFormatted: "req_delete--api-art-38f94",
stats: {
    "name": "DELETE /api/articles/title3-45546",
    "numberOfRequests": {
        "total": "9",
        "ok": "9",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "177",
        "ok": "177",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "226",
        "ok": "226",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "196",
        "ok": "196",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "15",
        "ok": "15",
        "ko": "-"
    },
    "percentiles1": {
        "total": "191",
        "ok": "191",
        "ko": "-"
    },
    "percentiles2": {
        "total": "204",
        "ok": "204",
        "ko": "-"
    },
    "percentiles3": {
        "total": "218",
        "ok": "218",
        "ko": "-"
    },
    "percentiles4": {
        "total": "224",
        "ok": "224",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 9,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.097",
        "ok": "0.097",
        "ko": "-"
    }
}
    },"req_delete--api-art-dbc34": {
        type: "REQUEST",
        name: "DELETE /api/articles/title4-45546",
path: "DELETE /api/articles/title4-45546",
pathFormatted: "req_delete--api-art-dbc34",
stats: {
    "name": "DELETE /api/articles/title4-45546",
    "numberOfRequests": {
        "total": "9",
        "ok": "9",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "183",
        "ok": "183",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "293",
        "ok": "293",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "204",
        "ok": "204",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "33",
        "ok": "33",
        "ko": "-"
    },
    "percentiles1": {
        "total": "191",
        "ok": "191",
        "ko": "-"
    },
    "percentiles2": {
        "total": "203",
        "ok": "203",
        "ko": "-"
    },
    "percentiles3": {
        "total": "262",
        "ok": "262",
        "ko": "-"
    },
    "percentiles4": {
        "total": "287",
        "ok": "287",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "htmlName": "t < 800 ms",
    "count": 9,
    "percentage": 100
},
    "group2": {
    "name": "800 ms <= t < 1200 ms",
    "htmlName": "t >= 800 ms <br> t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t >= 1200 ms",
    "htmlName": "t >= 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "htmlName": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.097",
        "ok": "0.097",
        "ko": "-"
    }
}
    }
}

}

function fillStats(stat){
    $("#numberOfRequests").append(stat.numberOfRequests.total);
    $("#numberOfRequestsOK").append(stat.numberOfRequests.ok);
    $("#numberOfRequestsKO").append(stat.numberOfRequests.ko);

    $("#minResponseTime").append(stat.minResponseTime.total);
    $("#minResponseTimeOK").append(stat.minResponseTime.ok);
    $("#minResponseTimeKO").append(stat.minResponseTime.ko);

    $("#maxResponseTime").append(stat.maxResponseTime.total);
    $("#maxResponseTimeOK").append(stat.maxResponseTime.ok);
    $("#maxResponseTimeKO").append(stat.maxResponseTime.ko);

    $("#meanResponseTime").append(stat.meanResponseTime.total);
    $("#meanResponseTimeOK").append(stat.meanResponseTime.ok);
    $("#meanResponseTimeKO").append(stat.meanResponseTime.ko);

    $("#standardDeviation").append(stat.standardDeviation.total);
    $("#standardDeviationOK").append(stat.standardDeviation.ok);
    $("#standardDeviationKO").append(stat.standardDeviation.ko);

    $("#percentiles1").append(stat.percentiles1.total);
    $("#percentiles1OK").append(stat.percentiles1.ok);
    $("#percentiles1KO").append(stat.percentiles1.ko);

    $("#percentiles2").append(stat.percentiles2.total);
    $("#percentiles2OK").append(stat.percentiles2.ok);
    $("#percentiles2KO").append(stat.percentiles2.ko);

    $("#percentiles3").append(stat.percentiles3.total);
    $("#percentiles3OK").append(stat.percentiles3.ok);
    $("#percentiles3KO").append(stat.percentiles3.ko);

    $("#percentiles4").append(stat.percentiles4.total);
    $("#percentiles4OK").append(stat.percentiles4.ok);
    $("#percentiles4KO").append(stat.percentiles4.ko);

    $("#meanNumberOfRequestsPerSecond").append(stat.meanNumberOfRequestsPerSecond.total);
    $("#meanNumberOfRequestsPerSecondOK").append(stat.meanNumberOfRequestsPerSecond.ok);
    $("#meanNumberOfRequestsPerSecondKO").append(stat.meanNumberOfRequestsPerSecond.ko);
}
