Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8056E29B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNRxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:53:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D2210C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681494831; x=1713030831;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7Hx+Omyp0+uRADzPTyUI8liud0WF0sfpmueKmpHIJAs=;
  b=iaXRo8klThi6l0P9r1JsUf5aNBKKqwWM4Lb5F1P1NYGiD3viQZZ4R5gA
   NNiD4p8mxkcpQLSdLWzHn2mBZPpcCP6Vo1o4k5gtbfGpm/M8AUnl6LXpz
   qbN+pDvprp0HxOfQha6y62E26W23YApJvCy7aRy2o19rUrh5Qr6hYN6n4
   BkkR2QanfuL1Rzig859YbZvlAV8Gf5myTvOolRgvd0TGst/uY21YSkeBt
   /YSoyC7IK90kWJ6W2sAXTOSLhdY+UsHVaaQYyDD5nDfdeSSyW3k8gHNL+
   z7BfDnddoEiWPT6oR9WsJK2F1WEkqHt1AxpRCrW9FSAAN7Xuu98oefW+/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324154759"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="324154759"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="683426532"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="683426532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2023 10:53:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:53:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 10:53:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 10:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKGY01sqsOGCoiMCvpFVFmtw2QAsqEm6ANgIMZIkW54MfaG43XEFYAU+NUA+d+ecVFGtN8qP6eAH2vWROC/6lDNpQzLsGRbpZTi51bqamSDJIQm9XZZ8VAC0lc8v9FNfNT1Q95xxt2QlKLJucuwZo1ByAJaSIzJPLCCLnhO0QZK8Yl4O/fHyyUoYvrNjhvQUgscPMzUmmfJ0E06POL4NVvOi5JAY91kkL0jggl+9RhWF+DYvMgpe6ahydiJ0gvO3I4L+5PiF4LJgbmrP7sMwdQJZlIMX0yWrw5j70/wElCiSXqsQroPsvAhJMm9HG8nxLuyHsm/w9afUJFW55gmSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hx+Omyp0+uRADzPTyUI8liud0WF0sfpmueKmpHIJAs=;
 b=ScGj6yrfqJKSJXnbXP6MCaO/ua7zsZNw7NLthnFSYjECFHD/aRSTnoksuqubwJLQnpm6Q5ZVJnFgtKyD43Y5yRM6hUn4KjjBcwIyBf51GYWPpqwovHJ0fKzQBAW2bA99BY7Sc1EesPfrTiFke6MHH/xjzh8QkaTx/JIrQwCucKr2YZeSoa6C4/3PjXdOONh37Gn0al1IdaZrh5ZvT+4E+Qd3JSktQ8OqaM/8YQTcHfmGF1vvjPTiW3Q56aIPhAnoppos7hnUcH46hKyugLLtQayWz25PboAYh3QVmmpD3j+JjndQDq/1hN0wsGhWHfiWXKfHCHhtWCd0x8BVvW5GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6271.namprd11.prod.outlook.com (2603:10b6:8:95::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 17:53:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 17:53:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Topic: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Index: AQHZbuGFm4Wq+BshnkmYPdeOWIdmDa8q/i4AgAAQdwCAAADhgIAABtUA
Date:   Fri, 14 Apr 2023 17:53:48 +0000
Message-ID: <3f30fe59dd6b368db82ae91b61152bb133c4831f.camel@intel.com>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
         <20230414145728.4067069-3-Liam.Howlett@oracle.com>
         <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
         <20230414172610.f35pngvz6cilxsdq@revolver>
         <20230414172919.ynxybbocc4o4tbtd@revolver>
In-Reply-To: <20230414172919.ynxybbocc4o4tbtd@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6271:EE_
x-ms-office365-filtering-correlation-id: ad67117f-121a-478b-4f91-08db3d1132e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5NAEy4BHBtIdUJ0tlqFVwo0uJvBGm8SrsJs85AJhl3bdVSyg2GW6syE/4VkmhQtIDMHPvp1/M0NYhLuDQkV/M3EaOV+FcI7IUOcd9Aa4UTkPPV5zCdsNObXeX60vDEooqqqH2j1cw0/2ER5IvJsFyn0n9mY6kBTbbmgT6HnAHc8juW9WW8nea+ljQWGZVhgobEhIduZnbho+B+YaD4cB9JwA05MpwO3tgcCdDNvI/6Dj5Bnm5v5CMnnwY1emAB7XSl9e9LSxxBviO/4PFob2LFyTrfW4BGJqioqirwu1QO8WAEFCpOAs/WmIDa7wSH4aZ1GKcPykUc5guAu0L/sxxHYh/yJr4+ugoj5VcNlVjBlt/z+PT+26nV54ZuI5+S6JAR52Gbt9D5eEozQ38NIOKHTnkLsxxZk/KWO1YAqcwAUYL0TFhm2m/zAgxWPAM0U7CRg9QKxL0zUbpmxmAgf5bmTIBDDQ6vNMbXrRotiF0cpTjoqNCRo+dIRraVvlbAjED641hszJZVEWvgAJ9TMPs9ynbo8uVaLXBInn64qCG6Qb2fz1cPYonOexhzBm8nAD+yRCn6qcRClhtwvZNvzaXbcO3akWN3ThzSGZXUhwqHz6oeUxAez3iCMqKz1mXcI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(478600001)(110136005)(6512007)(2616005)(6506007)(6486002)(26005)(71200400001)(66946007)(66556008)(91956017)(64756008)(66446008)(76116006)(316002)(66476007)(41300700001)(186003)(83380400001)(82960400001)(122000001)(38070700005)(38100700002)(8676002)(8936002)(2906002)(86362001)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWtCSWhsakhrNDhkVFRnVTNUQThjejdpeXp6dEw3U01lcFV2L2IzY21TWTlG?=
 =?utf-8?B?bnNlaDEyYmtoVER3R213TW1DVWgrQTZkallXQVhLVGdvcWREQU9CQ3NoREM3?=
 =?utf-8?B?TXczQXRuS0xxaVNkbXQ2QWJjb1lZMXU3MDJkY0hIbzNyTGhyRlhyRFpBcytM?=
 =?utf-8?B?VnBZNlplVWtyaFhjOVlJYnVoQ3BobENYdStGaFNBQVRZbjY5WjdUL1V2RXU2?=
 =?utf-8?B?MlRFL0FRdlZJcU93LzJoMVQ5VGx0WXhETXZJUTBHTFI4RFRUSXdEdHhyM0M5?=
 =?utf-8?B?VkhUZWRSM2d4WGp3Zi9odldJTDlKbmxFSlhKSW1GWHpJb2RMT2tIMnptZG90?=
 =?utf-8?B?ajJEcUNxbGJhREtERjZzVnJsWFdnTzBOazdRMS9KcW1halY5TUtuU2ZMeitU?=
 =?utf-8?B?OWRwVDNPNStLdkVxMVZtT3ZSYzNaK2V4bk9pdFBhTklMNno3NXBmVldsWSs3?=
 =?utf-8?B?aUppL29JUzloTWtGejl2ak0rTDMrUzJjUEc1TUpuczBLK0ZnVklEMnEra1Jx?=
 =?utf-8?B?bFVZbzdrd1ovNU8vMkpJNWJTSU9qNTBqcmpMWm54djMxRlhwL1lyQ2hJbHZG?=
 =?utf-8?B?UVB0UGVBRGkvQlRIRENXaG51eHJjakpWSS9kbUtsV2pBM3VMUTVKU2pwMXBn?=
 =?utf-8?B?WW11YlVSUmk4ZlNWMHc1M3JpUzJOZUt4Y0tBQ0ZPYnVJY3JmWHpjdUg5dnBM?=
 =?utf-8?B?RFJZZWpabzVRMGVuZ2lYUnI1RFRueC9xYU1ZR2hQQlRpdXR5d2hGTlZTdlcx?=
 =?utf-8?B?cXNscUtZVFR0bDFEelRrbmRCbXhhTFlwdnJZSUdyUFFwNEppUmUveVZvOXBX?=
 =?utf-8?B?VXNhM1BKUG52ek1Ec1Z4eXdsb0kveUFOZ3ExQXlVaHQwRGRsKzRoQ05UZFRn?=
 =?utf-8?B?U0E3Z2oyU1BCdndWb3dab3owck45SlplMUxoYnJDOHNOVUs1ODRwdjFMNWVE?=
 =?utf-8?B?WnJYM1J4d1J3c2hkWWoxSDEzWWJvbEZSWEZVbVdmcjd5OURURUgwS1BRdVBG?=
 =?utf-8?B?MEtRTEhFSVlaSzByOVo2M1JoMGQyTFZkaXBobG1pbFgwcHBncXVETVYvdXJR?=
 =?utf-8?B?cUkyUHVPZk14QWhubnc4VjUrRnNrc3A3QVN1cXlwTitDbXAxckcyZ3c4MjYy?=
 =?utf-8?B?YllENEg0WmtBY3VTUnJUdVNlTWw2bEpKZjd3c0NaSWZWNkE1OWhwVkEwQ091?=
 =?utf-8?B?L3NyWG9LNGtkWkM0U0RUamxGR01ZTEhKYUpveVNXbVhaUWV2ZmNKeDdUTCsw?=
 =?utf-8?B?RlQrVjQvYVJhbjFsZWhydi8vSzdYOHd3RHdDa1hGd0J2Zm01cUM5K3ZzL2lP?=
 =?utf-8?B?YVE0TFVFMWY3RVlzNFRlU25ueDJOa3NLZ1oyZWpTaVVGY3piZHNiQ1l2OWR5?=
 =?utf-8?B?TkFUK0VzQktIZExNbHc5OVZLMlRFMDNJajZZanBjVm1DUTFpSGVaZDlsUXE0?=
 =?utf-8?B?aldncXpiWnpXcXE4L3hUa3RUaW1hRnNjd2RpQ1IzaXZ3SDViaVZrS1FaSXRP?=
 =?utf-8?B?anlSZndFdXNodHMrRjNwcHhVK3pvYmxOSHNRVzdOZWxpcVN3K2NCZnl0T2lF?=
 =?utf-8?B?UHFaWklmYU42TTQ0ejV5eWMya0Y2ZkEya2xpVU1XMTBoUGpTYTFPVFlFQWxJ?=
 =?utf-8?B?aHZOMjc2eFUvNFR2d3l3UWdaVHY4MSs4eWpuMVdwRXdlQUdKaXRzY1JoQkdY?=
 =?utf-8?B?Rmw0RGpFYStzek5MbU5aTHV6TXc3Z0VydWZMR2xnMTYyaEhEN3paUVNaVUNj?=
 =?utf-8?B?K0NFUEhsd3oya0RlQ2xEYVVIMjh1K3cvZlpaM3R0R3BiSEtzNE80UjFBNytK?=
 =?utf-8?B?TDBkSE5aU0Fhc3JTR0dyQjBOZTl1NjY3SVgzQ0xuOThVcUFOalRqcFVwNXJa?=
 =?utf-8?B?NlVxdDBWeXUrMkJBdFM4bnRPd1lQSkd2SEN6YU5uUzIzaXZaUFVIUWpJVEVx?=
 =?utf-8?B?YWJYZXZPWkVzbk5IWjMzMUJ4WXFLYlVKSUkzcmNiQWxqeXFzbUtBVW8vbFQy?=
 =?utf-8?B?OGVKejlZM2lhbzhUZGpOSmRLcE9EQmRhV283aGJMWmNXSDdlTHlwUGl6Njhk?=
 =?utf-8?B?ZkJ6SFd1blcwT0JiK1FOUE1qZXF4L0tEd01xOGo4V21HVzJoQk83Vk1KRVpi?=
 =?utf-8?B?c3dIRmVSQ1BQb3hhOEpuRDRlKyt0bThld09lY01RR2dya0xvSi9BbzJxM0w4?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22F49F5D127F164394BDFB4A3292C875@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad67117f-121a-478b-4f91-08db3d1132e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 17:53:48.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV7WRmhbWo6M4V/3EtfszbpmnbRM/Q9DHsOaui51dp460ghAYYYNETOfH7JCNclj981dFgJ4QyFR+zwzhQfzr2uw2fFrsK+TOEjNq56O+jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6271
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEzOjI5IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
Cj4gKiBMaWFtIFIuIEhvd2xldHQgPExpYW0uSG93bGV0dEBPcmFjbGUuY29tPiBbMjMwNDE0IDEz
OjI2XToKPiA+ICogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
PiBbMjMwNDE0IDEyOjI3XToKPiA+ID4gT24gRnJpLCAyMDIzLTA0LTE0IGF0IDEwOjU3IC0wNDAw
LCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6PGJyPgo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHRtcCA9
IG1hc19uZXh0KCZtYXMsIFVMT05HX01BWCk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHRt
cCAmJiAodG1wLT52bV9mbGFncyAmIFZNX0dST1dTRE9XTikpIHsKPiA+ID4gCj4gPiA+IFdoeSBh
bHNvIGNoZWNrIFZNX0dST1dTRE9XTiBoZXJlIChhbmQgVk1fR1JPV1NVUCBiZWxvdyk/Cj4gPiA+
IHZtX3N0YXJ0L2VuZF9nYXAoKSBhbHJlYWR5IGhhdmUgY2hlY2tzIGluc2lkZS4KPiA+IAo+ID4g
QW4gYXJ0aWZhY3Qgb2YgYSBwbGFuIHRoYXQgd2FzIGxhdGVyIGFiYW5kb25lZC4KPiA+IAo+ID4g
PiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHZtX3N0YXJ0X2dh
cCh0bXApIDwgZ2FwICsgbGVuZ3RoIC0gMSkgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG93X2xpbWl0ID0gdG1wLT52bV9lbmQ7Cj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYXNfcmVz
ZXQoJm1hcyk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIHJldHJ5Owo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdG1wID0gbWFzX3ByZXYoJm1hcywgMCk7Cj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh0bXAgJiYgKHRtcC0+dm1fZmxhZ3MgJiBWTV9H
Uk9XU1VQKSAmJgo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dm1fZW5kX2dhcCh0bXApID4gZ2FwKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb3dfbGltaXQgPSB2bV9lbmRfZ2FwKHRtcCk7IAo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWFzX3Jl
c2V0KCZtYXMpOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byByZXRyeTsgCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9IAo+ID4gPiA+ICsKPiA+ID4gCj4gPiA+IENv
dWxkIGl0IGJlIGxpa2UgdGhpcz8KPiA+IAo+ID4gWWVzLCBJJ2xsIG1ha2UgdGhpcyBjaGFuZ2Uu
wqAgVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4KPiAKPiAKPiBXYWl0LCBJIGxpa2UgaG93IGl0
IGlzLgo+IAo+IEluIG15IHZlcnNpb24sIGlmIHRoZXJlIGlzIGEgc3RhY2sgdGhhdCBpcyBWTV9H
Uk9XU0RPV04gdGhlcmUsIGJ1dAo+IGRvZXMKPiBub3QgaW50ZXJjZXB0IHRoZSBnYXAsIHRoZW4g
SSB3b24ndCBjaGVjayB0aGUgcHJldi4uIGluIHlvdXJzLCB3ZQo+IHdpbGwKPiBuZXZlciBhdm9p
ZCBjaGVja2luZyBwcmV2LgoKSG1tLCBJIHNlZS4gSSBndWVzcyBJJ20gdGhpbmtpbmcgYWhlYWQg
YSBiaXQgdG8gYWRkaW5nIHRoZSBzaGFkb3cgc3RhY2sKZ3VhcmQgZ2FwLCBidXQgSSBjYW4gYWx3
YXlzIGFkZCB0byB0aGVzZSB2bV9mbGFncyBjaGVja3MuCgpCdXQgYXJlIHlvdSBzdXJlIHRoaXMg
b3B0aW1pemF0aW9uIGlzIGV2ZW4gcG9zc2libGU/IFRoZSBvbGQKdm1hX2NvbXB1dGVfZ2FwKCkg
aGFkIHRoaXMgY29tbWVudDoKLyoKICogTm90ZTogaW4gdGhlIHJhcmUgY2FzZSBvZiBhIFZNX0dS
T1dTRE9XTiBhYm92ZSBhIFZNX0dST1dTVVAsIHdlCiAqIGFsbG93IHR3byBzdGFja19ndWFyZF9n
YXBzIGJldHdlZW4gdGhlbSBoZXJlLCBhbmQgd2hlbiBjaG9vc2luZwogKiBhbiB1bm1hcHBlZCBh
cmVhOyB3aGVyZWFzIHdoZW4gZXhwYW5kaW5nIHdlIG9ubHkgcmVxdWlyZSBvbmUuCiAqIFRoYXQn
cyBhIGxpdHRsZSBpbmNvbnNpc3RlbnQsIGJ1dCBrZWVwcyB0aGUgY29kZSBoZXJlIHNpbXBsZXIu
CiAqLwoKQXNzdW1pbmcgdGhpcyBpcyBhIHJlYWwgc2NlbmFyaW8sIGlmIHlvdSBoYXZlIFZNX0dS
T1dTRE9XTiBhYm92ZSBhbmQKVk1fR1JPV1NVUCBiZWxvdywgZG9uJ3QgeW91IG5lZWQgdG8gY2hl
Y2sgdGhlIGdhcHMgZm9yIGFib3ZlIGFuZCBiZWxvdz8KQWdhaW4gdGhpbmtpbmcgYWJvdXQgYWRk
aW5nIHNoYWRvdyBzdGFjayBndWFyZCBwYWdlcywgc29tZXRoaW5nIGxpa2UKdGhhdCBjb3VsZCBi
ZSBhIG1vcmUgY29tbW9uIHNjZW5hcmlvLiBOb3QgdGhhdCB5b3UgbmVlZCB0byBmaXggbXkgb3V0
Cm9mIHRyZWUgaXNzdWVzLCBidXQgSSB3b3VsZCBwcm9iYWJseSBuZWVkIHRvIGFkanVzdCBpdCB0
byBjaGVjayBib3RoCmRpcmVjdGlvbnMuCgpJIGd1ZXNzIHRoZXJlIGlzIG5vIHdheSB0byBlbWJl
ZCB0aGlzIGluc2lkZSBtYXBsZSB0cmVlIHNlYXJjaCBzbyB3ZQpkb24ndCBuZWVkIHRvIHJldHJ5
PyAoc29ycnkgaWYgdGhpcyBpcyBhIGR1bWIgcXVlc3Rpb24sIGl0J3MgYW4gb3BhcXVlCmJveCB0
byBtZSkuCg==
