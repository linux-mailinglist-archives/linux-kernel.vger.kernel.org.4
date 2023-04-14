Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5426E1BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDNFaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:30:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335694;
        Thu, 13 Apr 2023 22:29:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4uVrs008647;
        Fri, 14 Apr 2023 05:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=OD53C0wzFVs6/7dc5praUg2eouwu68LuCpd1GG9uZ5Y=;
 b=IWjJRBtPtGhLZJRAqS/zfOLQX2iFMVgWZA46OVWXZCAO6DVdYVE8Pw+Mw+uMAqccCQik
 GLuATXej3VmuiNeItM5bQevcmLhOBFcfj7LCGDPRwSbE6kn+Wc6ELYGpq/1k+vpMKzCT
 /c27A9khXX3g3a/ZYovjfaFTMTjJACyjlsmtjnPYH/wZ6A/aNelB28DYIeYLoUcGY2+4
 TCGQ9dt/jhb1ze5tzbOA5J2FjO2wR1M/FqExrleEzBHHv9kHzIir9/ekPaJvc6AKo6Tn
 dy1jctbCPopVIoza/+kU2ikxj8UD7hOAhalSnm0YzRdaeLtXmnxxMHl8Q5sDAgCMVUQi Zw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px689u43h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:29:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E5T7ne008874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 05:29:07 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 22:29:06 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243]) by
 nasanex01a.na.qualcomm.com ([fe80::c03c:fa3e:4516:3243%12]) with mapi id
 15.02.0986.042; Thu, 13 Apr 2023 22:29:05 -0700
From:   "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Bhaskar Valaboju (QUIC)" <quic_bhaskarv@quicinc.com>,
        "Sachin Gupta (QUIC)" <quic_sachgupt@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Thread-Topic: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
Thread-Index: AQHZZLsSreM1n2UsG0iOAGSJueq9468YbsCAgBDCMuA=
Date:   Fri, 14 Apr 2023 05:29:05 +0000
Message-ID: <f5f8735e1dcc47e29698ea3f44c81362@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
 <20230401165723.19762-2-quic_sartgarg@quicinc.com>
 <CACRpkdam5M+Px58hHJp30tCYz-Vh54KvMei7WeZmqmTvtw5X8w@mail.gmail.com>
In-Reply-To: <CACRpkdam5M+Px58hHJp30tCYz-Vh54KvMei7WeZmqmTvtw5X8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.5.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5zG53tBZE4OWqpMuX-YnJtAIOcOa4_p5
X-Proofpoint-ORIG-GUID: 5zG53tBZE4OWqpMuX-YnJtAIOcOa4_p5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgbGludXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KQXMgbWVudGlvbmVkIGlu
IHRoZSBjb3ZlciBsZXR0ZXIgdGhhdCB0aGVzZSBvcHMgYXJlIG5lZWRlZCB0byBpbXBsZW1lbnQg
Y2xvY2sgc2NhbGluZyBhbmQgcGFydGlhbCBpbml0IGZlYXR1cmVzIGZvciB3aGljaCB3ZSBhbHJl
YWR5IGhhZCBiZWxvdyBkaXNjdXNzaW9ucyBidXQgZmFjZWQgc3Ryb25nIHJlc2lzdGFuY2UgZnJv
bSBjb21tdW5pdHkuIFNpbmNlIHRoZXNlIHdlcmUgaHVnZSBjb2RlIGNoYW5nZXMgc28gbWFpbnRh
aW5hYmlsaXR5IHdhcyB0aGUgbWFpbiBjb25jZXJuLiBIZW5jZSBJIGhhdmUgcmVkZXNpZ25lZCBv
dXIgZW50aXJlIGxvZ2ljIGFuZCBtb3ZlZCBjb21wbGV0ZSBjb2RlIHRvIHZlbmRvciBzcGVjaWZp
YyBmaWxlIGFuZCB0byBzdXBwb3J0IHRoaXMgbmV3IGRlc2lnbiBub3cgSSBqdXN0IG5lZWQgdGhl
c2UgdHdvIGhvb2tzIGluIHN1c3BlbmQgYW5kIHJlc3VtZSBmdW5jdGlvbnMgdGhhdOKAmXMgd2h5
IEkgaGF2ZSBhZGRlZCB0aGVzZSBjYWxsYmFja3MgaW4gaG9zdF9vcHMuDQoNCkkgY2FuIHJlbmFt
ZSB0aGVzZSB0byB2ZW5kb3Jfc3VzcGVuZC9yZXN1bWUgb3BzIHRvIGxldCB2ZW5kb3IgbW9kaWZ5
IGZldyB0aGluZ3MgbmVlZGVkIGluIHN1c3BlbmQvcmVzdW1lIHBhdGhzLiBBbHNvIGlmIHlvdSB3
YW50IHRvIHN1Z2dlc3QgYW55IGJldHRlciBuYW1lIHRoZW4gSSBhbSBvcGVuIGZvciB0aGF0IGFs
c28uDQoNCk9sZCBkaXNjdXNzaW9uIGZvciBDbG9jayBzY2FsaW5nIGZlYXR1cmUgOg0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1tYy9jb3Zlci8xNTcxNjY4MTc3
LTM3NjYtMS1naXQtc2VuZC1lbWFpbC1yYW1wcmFrYUBjb2RlYXVyb3JhLm9yZy8NCg0KT2xkIGRp
c2N1c3Npb24gZm9yIFBhcnRpYWwgaW5pdCBmZWF0dXJlIDoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tbWMvcGF0Y2gvMTY1MDk2Mzg1Mi00MTczLTEtZ2l0LXNl
bmQtZW1haWwtcXVpY19zcGF0aGlAcXVpY2luYy5jb20vDQoNClRoYW5rcywNClNhcnRoYWsNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXByaWwgMiwgMjAyMyA2OjE5
IFBNDQo+IFRvOiBTYXJ0aGFrIEdhcmcgKFFVSUMpIDxxdWljX3NhcnRnYXJnQHF1aWNpbmMuY29t
Pg0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7
IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0tDQo+IG1zbUB2Z2VyLmtlcm5lbC5vcmc7IFJhbSBQcmFrYXNoIEd1cHRh
IChRVUlDKQ0KPiA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IEJoYXNrYXIgVmFsYWJvanUg
KFFVSUMpDQo+IDxxdWljX2JoYXNrYXJ2QHF1aWNpbmMuY29tPjsgU2FjaGluIEd1cHRhIChRVUlD
KQ0KPiA8cXVpY19zYWNoZ3VwdEBxdWljaW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChR
VUlDKQ0KPiA8cXVpY19wcmFnYWxsYUBxdWljaW5jLmNvbT47IFNheWFsaSBMb2toYW5kZSAoUVVJ
QykNCj4gPHF1aWNfc2F5YWxpbEBxdWljaW5jLmNvbT47IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3Jy
aXNAY2hyb21pdW0ub3JnPjsNCj4gV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2lu
ZWVyaW5nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAxLzJdIG1tYzogY29yZTogRGVm
aW5lIG5ldyB2ZW5kb3Igb3BzIHRvIGVuYWJsZQ0KPiBpbnRlcm5hbCBmZWF0dXJlcw0KPiANCj4g
SGkgU2FydGhhaywNCj4gDQo+IHRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+IE9uIFNhdCwg
QXByIDEsIDIwMjMgYXQgNjo1N+KAr1BNIFNhcnRoYWsgR2FyZyA8cXVpY19zYXJ0Z2FyZ0BxdWlj
aW5jLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IERlZmluZSBuZXcgb3BzIHRvIGxldCB2ZW5kb3Ig
ZW5hYmxlIGludGVybmFsIGZlYXR1cmVzIGluDQo+ID4gbW1jX3N1c3BlbmQvcmVzdW1lIHBhdGhz
IGxpa2UgcGFydGlhbCBpbml0IGZlYXR1cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYXJ0
aGFrIEdhcmcgPHF1aWNfc2FydGdhcmdAcXVpY2luYy5jb20+DQo+ICguLi4pDQo+IA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1j
L2hvc3QuaA0KPiA+IEBAIC0yMTIsNiArMjEyLDEwIEBAIHN0cnVjdCBtbWNfaG9zdF9vcHMgew0K
PiA+DQo+ID4gICAgICAgICAvKiBJbml0aWFsaXplIGFuIFNEIGV4cHJlc3MgY2FyZCwgbWFuZGF0
b3J5IGZvciBNTUNfQ0FQMl9TRF9FWFAuICovDQo+ID4gICAgICAgICBpbnQgICAgICgqaW5pdF9z
ZF9leHByZXNzKShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfaW9zICppb3MpOw0K
PiA+ICsNCj4gPiArICAgICAgIHZvaWQgICAgKCpjYWNoZV9jYXJkX3Byb3BlcnRpZXMpKHN0cnVj
dCBtbWNfaG9zdCAqaG9zdCk7DQo+ID4gKyAgICAgICBib29sICAgICgqcGFydGlhbF9pbml0X2Nh
cmQpKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCk7DQo+IA0KPiBUaGVzZSBoYXZlIGNvbmZ1c2luZyBu
YW1lcywgZmlyc3QgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBjYXJkcyBzaW5jZSB0aGUNCj4g
Y2FsbGJhY2tzIGFyZSB0byB0aGUgaG9zdC4gU2Vjb25kIHRoZSBmdW5jdGlvbnMgYXJlIG5hbWVk
IGFmdGVyIHVzZWNhc2VzIGluIGENCj4gY2VydGFpbiBob3N0IHJhdGhlciB0aGFuIGZ1bmN0aW9u
Lg0KPiANCj4gSSB3b3VsZCBqdXN0IGNhbGwgdGhlbSAuc3VzcGVuZCgpIGFuZCAucmVzdW1lKCks
IHRoZSB1c2UgaXMgb2J2aW91cyBhbmQgdGhleSBhcmUNCj4gY2FsbGVkIGZyb20gdGhlIGRyaXZl
ciAuc3VzcGVuZCgpIGFuZCAucmVzdW1lKCkgaG9va3MuDQo+IA0KPiBZb3VycywNCj4gTGludXMg
V2FsbGVpag0K
