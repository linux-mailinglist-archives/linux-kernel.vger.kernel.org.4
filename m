Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCD7235B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjFFDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjFFDWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:22:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12E13A;
        Mon,  5 Jun 2023 20:22:04 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35616nBf026820;
        Mon, 5 Jun 2023 23:21:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r02e4eans-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 23:21:48 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3563Llfe042071
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 23:21:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Jun 2023
 23:21:46 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Mon, 5 Jun 2023 23:21:46 -0400
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings:iio:adc: add max14001
Thread-Topic: [PATCH v2 1/2] dt-bindings:iio:adc: add max14001
Thread-Index: AQHZl67WyGRdUJts+Um7/Pp5ceySxK98d3EAgACNLYA=
Date:   Tue, 6 Jun 2023 03:21:45 +0000
Message-ID: <b8aaef202de1464e875cf85ec2b1831e@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
 <20230605130755.92642-2-kimseer.paller@analog.com>
 <56137e35-3eac-41db-5f4f-b1a140df08f5@linaro.org>
In-Reply-To: <56137e35-3eac-41db-5f4f-b1a140df08f5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwTUdSaVlqTmlOUzB3TkRFNUxURXhaV1V0WVdVM1lpMW1PR05r?=
 =?utf-8?B?WWpnNU1HSmxORGRjWVcxbExYUmxjM1JjTkRCa1ltSXpZamN0TURReE9TMHhN?=
 =?utf-8?B?V1ZsTFdGbE4ySXRaamhqWkdJNE9UQmlaVFEzWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STVOVE13SWlCMFBTSXhNek16TURRNU5UTXdNVFF3TmpNeE1Ea2lJR2c5SWtZ?=
 =?utf-8?B?NWVGSTJiREEzY0c1a1JETnNVRGx6WjNSWlEwTnJiemxaV1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVVaRlJGRkVTbkJxV2tGaE1HNHlWRVZHY1hNMVVI?=
 =?utf-8?B?SlRabHBOVVZkeGVtczRSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlUycEZXSGgzUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-originating-ip: [10.116.242.24]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: RVabr56qMF9aGX0JwaypSVxYSOoHeUaY
X-Proofpoint-GUID: RVabr56qMF9aGX0JwaypSVxYSOoHeUaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060029
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdW5l
IDUsIDIwMjMgOTozMCBQTQ0KPiBUbzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJA
YW5hbG9nLmNvbT47IGppYzIzQGtlcm5lbC5vcmc7DQo+IGxhcnNAbWV0YWZvby5kZQ0KPiBDYzog
YnJvb25pZUBrZXJuZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczppaW86YWRjOiBhZGQgbWF4MTQwMDENCj4gDQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDA1LzA2LzIwMjMgMTU6MDcsIEtpbSBTZWVyIFBhbGxlciB3
cm90ZToNCj4gPiBUaGUgTUFYMTQwMDEgaXMgY29uZmlndXJhYmxlLCBpc29sYXRlZCAxMC1iaXQg
QURDcyBmb3IgbXVsdGktcmFuZ2UNCj4gPiBiaW5hcnkgaW5wdXRzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogS2ltIFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiAN
Cj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9m
IG5lY2Vzc2FyeSBwZW9wbGUgYW5kDQo+IGxpc3RzIHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0
aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLA0KPiBnaXZlcyB5b3Ugb3V0
ZGF0ZWQgZW50cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBh
dGNoZXMNCj4gb24gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVh
c3QgRFQgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUgdGVzdGVkLg0KPiBQbGVh
c2UgcmVzZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNlc3NhcnkgZW50cmllcy4NCj4gDQo+IFN1Ympl
Y3QgLSBpZ25vcmVkIGNvbW1lbnRzLg0KPiANCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVy
IGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQo+IA0KPiBJdCBzZWVtcyBteSBwcmV2aW91cyBj
b21tZW50cyB3ZXJlIG5vdCBmdWxseSBhZGRyZXNzZWQuIE1heWJlIG15DQo+IGZlZWRiYWNrIGdv
dCBsb3N0IGJldHdlZW4gdGhlIHF1b3RlcywgbWF5YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5
IGl0Lg0KPiBQbGVhc2UgZ28gYmFjayB0byB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0
aGVyIGltcGxlbWVudCBhbGwgcmVxdWVzdGVkDQo+IGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5n
IHRoZW0uDQoNClRoYW5rIHlvdSBmb3IgeW91ciBpbnB1dC4gSSBhcHByZWNpYXRlIHlvdXIgZmVl
ZGJhY2ssIGFuZCBJIGFwb2xvZ2l6ZSBmb3Igbm90IA0KYWRkcmVzc2luZyBhbGwgeW91ciBwcmV2
aW91cyBjb21tZW50cy4gSXQgc2VlbXMgSSBtYXkgaGF2ZSBtaXNzZWQgdGhlbS4NCg0KPiANCj4g
VGhhbmsgeW91Lg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvYWRpLG1h
eDE0MDAxLnlhbWwgICAgICAgIHwgNTUgKysrKysrKysrKysrKysrKysrKw0KPiA+ICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNyArKysNCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxtYXgxNDAw
MS55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksbWF4MTQwMDEueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLG1heDE0MDAxLnlhbWwNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uMWIxN2Y1ZGMwDQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vYWRjL2FkaSxtYXgxNDAwMS55YW1sDQo+ID4gQEAgLTAsMCArMSw1NSBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICMgQ29weXJp
Z2h0IDIwMjMNCj4gPiArQW5hbG9nIERldmljZXMgSW5jLg0KPiA+ICslWUFNTCAxLjINCj4gPiAr
LS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby9hZGMvYWRpDQo+ID4NCj4gKyxtYXgxNDAwMS55YW1s
Kl9fO0l3ISFBM05pOENTMHkyWSE0a3lmMTE2Y1dubWREUVlmU182SHdkTHFuc0NkMw0KPiBtR0lE
QUcNCj4gPiArdUh5b3JuZWNCMndqbzZZdjNTNllEODhEUkNWcGxWUWh5T1ZZTnZoZlNkQS0NCj4g
Z3lxdURHWnBlQlpQMjVXZyQNCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLQ0KPiBzY2hlbWFzL2NvcmUueQ0K
PiA+DQo+ICthbWwqX187SXchIUEzTmk4Q1MweTJZITRreWYxMTZjV25tZERRWWZTXzZId2RMcW5z
Q2QzbUdJREFHdUgNCj4geW9ybmVjQjJ3DQo+ID4gK2pvNll2M1M2WUQ4OERSQ1ZwbFZRaHlPVllO
dmhmU2RBLWd5cXVER1pwZV9ySWwyX2MkDQo+ID4gKw0KPiA+ICt0aXRsZTogQW5hbG9nIERldmlj
ZXMgTUFYMTQwMDEgQURDDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEtpbSBT
ZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2Ny
aXB0aW9uOiB8DQo+ID4gKyAgICBTaW5nbGUgY2hhbm5lbCAxMCBiaXQgQURDIHdpdGggU1BJIGlu
dGVyZmFjZS4gRGF0YXNoZWV0DQo+ID4gKyAgICBjYW4gYmUgZm91bmQgaGVyZToNCj4gPiArDQo+
ID4gK2h0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRp
b24vZGF0YS0NCj4gc2hlZXRzL00NCj4gPiArQVgxNDAwMS1NQVgxNDAwMi5wZGYNCj4gPiArDQo+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4g
KyAgICAgIC0gYWRpLG1heDE0MDAxDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0
ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPiA+ICsgICAgbWF4aW11
bTogNTAwMDAwMA0KPiA+ICsNCj4gPiArICB2cmVmLXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0
aW9uOiBWb2x0YWdlIHJlZmVyZW5jZSB0byBlc3RhYmxpc2ggaW5wdXQgc2NhbGluZy4NCj4gPiAr
DQo+ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFs
LXByb3BzLnlhbWwjDQo+IA0KPiBQbGFjZSBpdCBsaWtlIG90aGVyIGJpbmRpbmdzLCBzbyBhZnRl
ciByZXF1aXJlZCBvciBiZWZvcmUgcHJvcGVydGllcy4NCj4gDQo+IEFueXdheSwgd2hhdCBoYXBw
ZW5lZCB3aXRoIGFsbCB0aGUgcHJvcGVydGllcyB5b3UgaGFkIGhlcmUgYW5kIHNob3VsZCBiZQ0K
PiBzd2l0Y2hlZCB0byBnZW5lcmljIG9uZXM/DQoNCkkgaGF2ZSBkZWNpZGVkIHRvIHJlbW92ZSB0
aGUgcHJvcGVydGllcyBhbmQgdXRpbGl6ZSB0aGUgZGVmYXVsdCByZWdpc3RlciB2YWx1ZXMgDQpk
dXJpbmcgaW5pdGlhbGl6YXRpb24gdG8gY2xlYXIgbWVtb3J5IHZhbGlkYXRpb24gZmF1bHRzLCB3
aGljaCBJIGJlbGlldmUgaXMgYSANCmJldHRlciBhcHByb2FjaC4gSSBhbSBub3QgeWV0IGZhbWls
aWFyIHdpdGggaG93IHRvIGltcGxlbWVudCBzb21lIG9mIHRoZSANCnByb3BlcnRpZXMgdG8gc3dp
dGNoIHRvIHRoZSB1c2Vyc3BhY2UgQUJJLCBidXQgZm9yIG5vdywgaXMgaXQgb2theSB0byBleGNs
dWRlIGl0IA0KYW5kIHBsYW4gdG8gaW1wbGVtZW50IGl0IGZvciBmdXR1cmUgc3VwcG9ydD8gDQoN
Cj4gDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAt
IHJlZw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4g
PiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzcGkgew0KPiA+ICsgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+
ICsgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gDQo+IFJlYWxseS4uLiBZb3UgZGlkIG5vdCBy
ZXNwb25kIHRvIG15IGZlZWRiYWNrLCBzbyBzZW5kaW5nIHVuY29ycmVjdGVkIHZlcnNpb24NCj4g
ZmVlbHMgbGlrZSBiZWluZyBpZ25vcmVkLiA6KA0KDQpJIHNpbmNlcmVseSBhcG9sb2dpemUsIGl0
IHdhcyBhbiBvdmVyc2lnaHQgb24gbXkgcGFydCBhbmQgSSBkaWRuJ3QgbWVhbiB0byANCmlnbm9y
ZSBpdCwgYW5kIEkgdW5kZXJzdGFuZCBpZiBpdCBjYXVzZWQgYW55IHByb2JsZW1zLiBNb3Zpbmcg
Zm9yd2FyZCwgSSB3aWxsIGVuc3VyZSANCnRvIHRob3JvdWdobHkgcmV2aWV3IGFuZCBhZGRyZXNz
IGFsbCBmZWVkYmFjayBwcm92aWRlZC4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCg0K
