Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116FD737851
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFUAia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFUAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:38:28 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E186173B;
        Tue, 20 Jun 2023 17:38:27 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KMuq5a030204;
        Tue, 20 Jun 2023 20:38:11 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r99r552fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 20:38:11 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 35L0cAfF038764
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 20:38:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 20 Jun
 2023 20:38:09 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Tue, 20 Jun 2023 20:38:09 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v7 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZo3rtGCivtyQnbE6X/wvGJBapo6+UECKAgABVl0A=
Date:   Wed, 21 Jun 2023 00:38:08 +0000
Message-ID: <e92f919e59974bb2ae32a8d961e07538@analog.com>
References: <20230620132641.256307-1-kimseer.paller@analog.com>
 <20230620132641.256307-2-kimseer.paller@analog.com>
 <CAHp75VdR9W8U9VmP5WZntzB9qW3fM6qy1Q2-yeBSAG5PJimkaw@mail.gmail.com>
In-Reply-To: <CAHp75VdR9W8U9VmP5WZntzB9qW3fM6qy1Q2-yeBSAG5PJimkaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsTWpaaE5UQXhPUzB3Wm1OaUxURXhaV1V0WVdVM1pDMW1PR05p?=
 =?utf-8?B?TmpjME9XVmhOMkpjWVcxbExYUmxjM1JjWlRJMllUVXdNV0l0TUdaallpMHhN?=
 =?utf-8?B?V1ZsTFdGbE4yUXRaamhqWWpZM05EbGxZVGRpWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpOelE0SWlCMFBTSXhNek16TVRjNE1UUTROVFk0TlRrMU56WWlJR2c5SWxG?=
 =?utf-8?B?NlQwTk1iRlV3U0ZSc1ZFSnFVa1l3V1VJclNreG1aRzB4TkQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUXpSUU9HRnJNa3RRV2tGbVVrZEJTMk00TkZnMFZE?=
 =?utf-8?B?bEZXVUZ3ZW5wb1ptaE5SRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmRtUm9hM2huUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-originating-ip: [10.116.184.234]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: PA4y_X--hQFcq7cBL9NzwZowbtlR6YdK
X-Proofpoint-ORIG-GUID: PA4y_X--hQFcq7cBL9NzwZowbtlR6YdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210003
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyMCwgMjAy
MyAxMToxNSBQTQ0KPiBUbzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJAYW5hbG9n
LmNvbT4NCj4gQ2M6IGppYzIzQGtlcm5lbC5vcmc7IGxhcnNAbWV0YWZvby5kZTsgbGdpcmR3b29k
QGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBIZW5uZXJpY2gsIE1pY2hhZWwgPE1p
Y2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+Ow0KPiByb2JoQGtlcm5lbC5vcmc7IGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtDQo+IGlp
b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBpaW86IGFk
YzogbWF4MTQwMDE6IE5ldyBkcml2ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwg
SnVuIDIwLCAyMDIzIGF0IDQ6MjfigK9QTSBLaW0gU2VlciBQYWxsZXINCj4gPGtpbXNlZXIucGFs
bGVyQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIE1BWDE0MDAxIGlzIGNvbmZpZ3Vy
YWJsZSwgaXNvbGF0ZWQgMTAtYml0IEFEQ3MgZm9yIG11bHRpLXJhbmdlDQo+ID4gYmluYXJ5IGlu
cHV0cy4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBBbGln
biByZWNlaXZlZCBkYXRhIGZyb20gdGhlIHJlY2VpdmUgYnVmZmVyLCByZXZlcnNpbmcgYW5kIHJl
b3JkZXJpbmcNCj4gPiArICAgICAgICAqIGl0IHRvIG1hdGNoIHRoZSBleHBlY3RlZCBNU0ItZmly
c3QgZm9ybWF0Lg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICAqZGF0YSA9IChfX2ZvcmNl
IHUxNikoYmUxNl90b19jcHUoYml0cmV2MTYoc3QtPnNwaV9yeF9idWZmZXIpKSkgJg0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFY
MTQwMDFfREFUQV9NQVNLOw0KPiANCj4gVXNpbmcgX19mb3JjZSBpbiB0aGUgQyBmaWxlcyBpcyBz
b21laG93IHN0aW5reS4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAg
ICAgKiBDb252ZXJ0IHRyYW5zbWl0IGJ1ZmZlciB0byBiaWctZW5kaWFuIGZvcm1hdCBhbmQgcmV2
ZXJzZSB0cmFuc21pdA0KPiA+ICsgICAgICAgICogYnVmZmVyIHRvIGFsaWduIHdpdGggdGhlIExT
Qi1maXJzdCBpbnB1dCBvbiBTREkgcG9ydC4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAg
c3QtPnNwaV90eF9idWZmZXIgPSAoX19mb3JjZSB1MTYpKGNwdV90b19iZTE2KGJpdHJldjE2KA0K
PiANCj4gWW91IGhhdmUgYSBkaWZmZXJlbnQgdHlwZSBvZiBzcGlfdHhfYnVmZmVyIHRoYW4gdTE2
LCBkb24ndCB5b3U/DQoNCkkgaGF2ZSB0aGUgc2FtZSB0eXBlIG9mIHNwaV90eF9idWZmZXIgYXMg
dTE2LiANCg0KT3RoZXIgdGhhbiB1c2luZyBmb3JjZSBjYXN0LCBpcyB0aGVyZSBhbnkgd2F5IHRv
IHJlc29sdmUgdGhlIGVuZGlhbiB3YXJuaW5nPyBJIGhhdmUgDQphY3R1YWxseSBzd2FwcGVkIHRo
ZSBvcmRlciBvZiBiaXRyZXYxNigpIGFuZCBjcHVfdG9fYmUxNi9iZTE2X3RvX2NwdSgpIGZ1bmN0
aW9ucy4gDQpJIGhhdmUgdGVzdGVkIGFuZCB0aGV5IGFsc28gd29yayBmaW5lLg0KDQpCZXN0IHJl
Z2FyZHMsDQpLaW0gU2VlciBQYWxsZXINCg0K
