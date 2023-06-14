Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D5872FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbjFNKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFNKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:43:24 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8CA7;
        Wed, 14 Jun 2023 03:43:23 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E7Gg8u013493;
        Wed, 14 Jun 2023 06:43:03 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4k16g586-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 06:43:03 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 35EAh2ms034535
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 06:43:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 14 Jun
 2023 06:43:01 -0400
Received: from ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f]) by
 ASHBMBX8.ad.analog.com ([fe80::30b9:230c:9621:902f%9]) with mapi id
 15.02.0986.014; Wed, 14 Jun 2023 06:43:01 -0400
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
Subject: RE: [PATCH v6 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v6 2/2] iio: adc: max14001: New driver
Thread-Index: AQHZnloUgA4PGHUTwk+qWfp1Oi26CK+KRuGA///U5DA=
Date:   Wed, 14 Jun 2023 10:43:00 +0000
Message-ID: <a6488485909d40b3810ad15787cd2100@analog.com>
References: <20230614004857.134980-1-kimseer.paller@analog.com>
 <20230614004857.134980-2-kimseer.paller@analog.com>
 <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
In-Reply-To: <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB6T0RNM1lqRmpaQzB3WVdFd0xURXhaV1V0WVdVM1pDMW1PR05p?=
 =?utf-8?B?TmpjME9XVmhOMkpjWVcxbExYUmxjM1JjTXpnek4ySXhZMll0TUdGaE1DMHhN?=
 =?utf-8?B?V1ZsTFdGbE4yUXRaamhqWWpZM05EbGxZVGRpWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpOakV3SWlCMFBTSXhNek16TVRJeE1qazNOVGszTXpjME1ESWlJR2c5SWpk?=
 =?utf-8?B?MVFuZ3dSbFpXYVZsSFRYWkpUMmswTVc1V1drMWlSbW80VVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVRaa2NGUTJja28zV2tGaFJsa3ZjMVZ3Y0ROWk5t?=
 =?utf-8?B?OVdhaXQ0VTIxdVpHcHZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlVqWnNWRXhCUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
X-Proofpoint-GUID: bsX-Uau_KRJz1fDofuJZmABMQNNRA1Fm
X-Proofpoint-ORIG-GUID: bsX-Uau_KRJz1fDofuJZmABMQNNRA1Fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=915 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140091
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE0LCAy
MDIzIDU6MTIgUE0NCj4gVG86IFBhbGxlciwgS2ltIFNlZXIgPEtpbVNlZXIuUGFsbGVyQGFuYWxv
Zy5jb20+DQo+IENjOiBqaWMyM0BrZXJuZWwub3JnOyBsYXJzQG1ldGFmb28uZGU7IGxnaXJkd29v
ZEBnbWFpbC5jb207DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgSGVubmVyaWNoLCBNaWNoYWVsIDxN
aWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gcm9iaEBrZXJuZWwub3JnOyBrcnp5c3p0
b2Yua296bG93c2tpQGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBp
aW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDIvMl0gaWlvOiBh
ZGM6IG1heDE0MDAxOiBOZXcgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQs
IEp1biAxNCwgMjAyMyBhdCAzOjQ54oCvQU0gS2ltIFNlZXIgUGFsbGVyDQo+IDxraW1zZWVyLnBh
bGxlckBhbmFsb2cuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBNQVgxNDAwMSBpcyBjb25maWd1
cmFibGUsIGlzb2xhdGVkIDEwLWJpdCBBRENzIGZvciBtdWx0aS1yYW5nZQ0KPiA+IGJpbmFyeSBp
bnB1dHMuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVu
a29AZ21haWwuY29tPiBPbmUgcXVlc3Rpb24NCj4gYmVsb3cuDQo+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEtpbSBTZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4NCj4gPiAtLS0N
Cg0KLi4uDQogDQo+ID4gKyAgICAgICAgICAgICAgIC8qIHNlbGVjdCBleHRlcm5hbCB2b2x0YWdl
IHJlZmVyZW5jZSBzb3VyY2UgZm9yIHRoZSBBREMgKi8NCj4gPiArICAgICAgICAgICAgICAgcmV0
ID0gbWF4MTQwMDFfcmVnX3VwZGF0ZShzdCwgTUFYMTQwMDFfQ0ZHLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BWDE0MDAxX0NGR19FWFJGLCAxKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZSh2cmVm
KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byBnZXQgdnJlZlxuIik7
DQo+IA0KPiBJcyBpdCBpbXBvcnRhbnQgdG8gY2hvb3NlIHRoZSBleHRlcm5hbCByZWZlcmVuY2Ug
c291cmNlIF9iZWZvcmVfIGdldHRpbmcgdGhlDQo+IHZvbHRhZ2Ugb2YgdGhlIHJlZ3VsYXRvcj8g
SWYgbm90LCBJIHdvdWxkIHN3YXAgdGhlc2UgY2FsbHMsIG90aGVyd2lzZSB0aGUNCj4gY29tbWVu
dCBpcyBuZWVkZWQgdG8gZXhwbGFpbiB3aHkgdGhlIHNlcXVlbmNlIGlzIGltcG9ydGFudCBpbiB0
aGUgd2F5IGl0J3MNCj4gd3JpdHRlbi4NCg0KSXQgaXMgbm90IGltcG9ydGFudC4gVGhlc2UgY2Fs
bHMgY2FuIGJlIHN3YXAgd2l0aG91dCBhbnkgaXNzdWVzLg0KDQpCZXN0IHJlZ2FyZHMsDQpLaW0g
U2VlciBQYWxsZXINCg0K
