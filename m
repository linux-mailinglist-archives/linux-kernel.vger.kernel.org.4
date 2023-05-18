Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E2707871
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjERD1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjERD1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:27:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1B19A4;
        Wed, 17 May 2023 20:27:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I22tcs011519;
        Thu, 18 May 2023 03:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=kmBYHzgW+7/N0QtPl3QLlZmCpbuyt39L2rZvDk9hai4=;
 b=VUjQTaO/7vuoTDNaHeqtNQ3xfc6gW13DAoaSEkdCUe3TVKAZKnOa8TTHJFeumsO0Zjmx
 BMBOZarZO/8HliuvQU9mTj2NTtSvylSwaUu+FIxP2TnNzS0jAUzKi+nYiHIoA+/iUskQ
 Gm6snxMLmn9Wsl8HdERKqpHWV628tHs4vp822b7KYCaupd2TTkBLWqhd83u3lQ8fNaoD
 bf+yl8PPMV/O3xpyiOKEcwhsvG5J8QNMAOU3pnV9VcXwr3gvcHNOKOK7O0VHXtx7N9Ff
 8yIYQYV/XoMbrJ4ByH7Kyd0ZK3/qWOv0dedf+FZCSbx2Ki4YhAH1TaPcFzCexz77ZS/x Mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmrvhtkae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 03:27:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I3RD2l025871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 03:27:13 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 20:27:12 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6]) by
 nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6%12]) with mapi id
 15.02.0986.042; Wed, 17 May 2023 20:27:12 -0700
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Subject: RE: [PATCH v3] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Thread-Topic: [PATCH v3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Thread-Index: AQHZh+LynupJQjFlJkSukmgcSPC0Fa9dMLGAgACQ4bCAARn3gIAAhH1w
Date:   Thu, 18 May 2023 03:27:12 +0000
Message-ID: <2c5902a8af724f3b9f376fc026a09c1d@quicinc.com>
References: <20230516104102.30775-1-quic_tjiang@quicinc.com>
 <3ef9259f-f778-d18c-6fc6-97aab9e9f9fc@molgen.mpg.de>
 <d3582e14e5204a7895ce34bcbf994533@quicinc.com>
 <506df7b0-6ffb-c829-0c82-89a52f0b0892@molgen.mpg.de>
In-Reply-To: <506df7b0-6ffb-c829-0c82-89a52f0b0892@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.14.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 11ohnpsic7ezAhUfW19gOZnDD1FWIUUH
X-Proofpoint-GUID: 11ohnpsic7ezAhUfW19gOZnDD1FWIUUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_01,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGF1bDoNCiAgSW5saW5lIGNvbW1lbnRzLg0KUmVnYXJkcy4NClRpbQ0KDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRl
PiANClNlbnQ6IFdlZG5lc2RheSwgTWF5IDE3LCAyMDIzIDg6MjggUE0NClRvOiBUaW0gSmlhbmcg
KFFVSUMpIDxxdWljX3RqaWFuZ0BxdWljaW5jLmNvbT4NCkNjOiBtYXJjZWxAaG9sdG1hbm4ub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEgR29kYXZh
cnRoaSAoUVVJQykgPHF1aWNfYmdvZGF2YXJAcXVpY2luYy5jb20+OyBIZW1hbnQgR3VwdGEgKFFV
SUMpIDxxdWljX2hlbWFudGdAcXVpY2luYy5jb20+OyBta2FAY2hyb21pdW0ub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIIHYzXSBCbHVldG9vdGg6IGhjaV9xY2E6IEFkZCBzdXBwb3J0IGZvciBRdWFs
Y29tbSBCbHVldG9vdGggU29DIFFDQTIwNjYNCg0KRGVhciBUaW0sDQoNCg0KQW0gMTcuMDUuMjMg
dW0gMDQ6NDYgc2NocmllYiBUaW0gSmlhbmcgKFFVSUMpOg0KPiBQYXVsIDoNCj4gICAgVGhhbmtz
IGZvciBjb21tZW50cywgcGxlYXNlIHNlZSBpbmxpbmUgY29tbWVudHMuDQoNClRoYW5rIHlvdSBm
b3IgeW91ciByZXBseS4gKEl04oCZZCBiZSBncmVhdCwgaWYgeW91IHVzZWQgYW4gZW1haWwgY2xp
ZW50LCB0aGF0IGNhbiBwcm9wZXJseSBxdW90ZS9jaXRlIGxpa2UgTW96aWxsYSBUaHVuZGVyYmly
ZC4pDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwg
PHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDE2LCAyMDIzIDc6
MDAgUE0NCg0KPiBBbSAxNi4wNS4yMyB1bSAxMjo0MSBzY2hyaWViIFRpbSBKaWFuZzoNCj4+IFRo
aXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBRQ0EyMDY2IGZpcm13YXJlIHBhdGNoIGFuZCBudm0g
ZG93bmxvYWRpbmcuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSwgd2hhdCBuZXcg
ZmVhdHVyZXMgYXJlIG5lZWRlZCBmb3IgdGhpcyBhcyB5b3UgYWRkIGNvbW1vbiBmdW5jdGlvbnM/
DQo+IA0KPiBQbGVhc2UgZG9jdW1lbnQgdGhlIGRhdGFzaGVldC4NCj4gW1RpbV0gbm8gbmV3IGZl
YXR1cmUsIG9ubHkgc3VwcG9ydCBuZXcgY2hpcCBxY2EyMDY2IGJ0ZncgZG93bmxvYWRpbmcNCg0K
QXMgSSB3cm90ZSwgeW91IGFkZCBjb21tb24gZnVuY3Rpb25zIGxpa2UgYHFjYV9yZWFkX2Z3X2Jv
YXJkX2lkKClgLCB3aGljaCB3ZXJlIG5vdCByZXF1aXJlZCBiZWZvcmUuIFNvIHBsZWFzZSBlbGFi
b3JhdGUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KW1RpbV0gZ290IGl0ICwgd2lsbCBhZGRyZXNz
IGl0IGluIHY1IHZlcnNpb24NCg0KPj4gU2lnbmVkLW9mZi1ieTogVGltIEppYW5nIDxxdWljX3Rq
aWFuZ0BxdWljaW5jLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ibHVldG9vdGgvYnRxY2Eu
YyAgIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICAgZHJp
dmVycy9ibHVldG9vdGgvYnRxY2EuaCAgIHwgIDQgKysNCj4+ICAgIGRyaXZlcnMvYmx1ZXRvb3Ro
L2hjaV9xY2EuYyB8ICA4ICsrKy0NCj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KW+KApl0NCg0KPj4gQEAgLTU3NCw2ICs2MTYsMzAgQEAg
aW50IHFjYV9zZXRfYmRhZGRyX3JvbWUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGNvbnN0IGJkYWRk
cl90ICpiZGFkZHIpDQo+PiAgICB9DQo+PiAgICBFWFBPUlRfU1lNQk9MX0dQTChxY2Ffc2V0X2Jk
YWRkcl9yb21lKTsNCj4+ICAgIA0KPj4gK3N0YXRpYyB2b2lkIHFjYV9nZW5lcmF0ZV9udm1fbmFt
ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgY2hhciAqZnduYW1lLA0KPj4gKwkJICAgc2l6ZV90IG1h
eF9zaXplLCBzdHJ1Y3QgcWNhX2J0c29jX3ZlcnNpb24gdmVyLCB1MTYgYmlkKSB7DQo+PiArCXU4
IHJvbV92ZXIgPSAwOw0KPj4gKwl1MzIgc29jX3ZlcjsNCj4gDQo+IEFueSByZWFzb24gdG8gZml4
IHRoZSBzaXplIG9mIHRoZSB2YXJpYWJsZXM/DQo+IFtUaW1dIHNvcnJ5ICwgSSBkb2VzIG5vdCBn
b3QgeW91ciBwb2ludA0KDQpXaHkgY2Fu4oCZdCB5b3Ugc2ltcGx5IHVzZSBgdW5zaWduZWQgaW50
YCBbMV0/DQpbVGltXSB5b3UgY2FuIHJlZmVyIHRvIGZ1bmN0aW9uIHFjYV91YXJ0X3NldHVwICwg
d2hpY2ggYWxzbyB1c2UgdTMyDQoNClvigKZdDQoNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Js
dWV0b290aC9oY2lfcWNhLmMgDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYyBpbmRl
eCAxYjA2NDUwNGIzODguLmVjMjRjZTQ1MTU2OCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2hjaV9xY2EuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jDQo+
PiBAQCAtMTcyOSw3ICsxNzI5LDcgQEAgc3RhdGljIGludCBxY2Ffc2V0dXAoc3RydWN0IGhjaV91
YXJ0ICpodSkNCj4+ICAgIAlidF9kZXZfaW5mbyhoZGV2LCAic2V0dGluZyB1cCAlcyIsDQo+PiAg
ICAJCXFjYV9pc193Y24zOTl4KHNvY190eXBlKSA/ICJ3Y24zOTl4IiA6DQo+PiAgICAJCShzb2Nf
dHlwZSA9PSBRQ0FfV0NONjc1MCkgPyAid2NuNjc1MCIgOg0KPj4gLQkJKHNvY190eXBlID09IFFD
QV9XQ042ODU1KSA/ICJ3Y242ODU1IiA6ICJST01FL1FDQTYzOTAiKTsNCj4+ICsJCShzb2NfdHlw
ZSA9PSBRQ0FfV0NONjg1NSkgPyAid2NuNjg1NSIgOiAiUk9NRS9RQ0E2MzkwL1FDQTIwNjYiKTsN
Cj4+ICAgIA0KPj4gICAgCXFjYS0+bWVtZHVtcF9zdGF0ZSA9IFFDQV9NRU1EVU1QX0lETEU7DQo+
PiAgICANCj4+IEBAIC0xODc0LDYgKzE4NzQsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBxY2Ff
ZGV2aWNlX2RhdGEgcWNhX3NvY19kYXRhX3FjYTYzOTAgX19tYXliZV91bnVzZWQgPSB7DQo+PiAg
ICAJLm51bV92cmVncyA9IDAsDQo+PiAgICB9Ow0KPj4gICAgDQo+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCBxY2FfZGV2aWNlX2RhdGEgcWNhX3NvY19kYXRhX3FjYTIwNjYgPSB7DQo+PiArCS5zb2Nf
dHlwZSA9IFFDQV9RQ0EyMDY2LA0KPj4gKwkubnVtX3ZyZWdzID0gMCwNCj4+ICt9Ow0KPj4gKw0K
Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBxY2FfZGV2aWNlX2RhdGEgcWNhX3NvY19kYXRhX3dj
bjY3NTAgX19tYXliZV91bnVzZWQgPSB7DQo+PiAgICAJLnNvY190eXBlID0gUUNBX1dDTjY3NTAs
DQo+PiAgICAJLnZyZWdzID0gKHN0cnVjdCBxY2FfdnJlZyBbXSkgew0KPj4gQEAgLTIzNjQsNiAr
MjM2OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHFjYV9ibHVldG9vdGhf
b2ZfbWF0Y2hbXSA9IHsNCj4+ICAgIAl7IC5jb21wYXRpYmxlID0gInFjb20sd2NuMzk5OC1idCIs
IC5kYXRhID0gJnFjYV9zb2NfZGF0YV93Y24zOTk4fSwNCj4+ICAgIAl7IC5jb21wYXRpYmxlID0g
InFjb20sd2NuNjc1MC1idCIsIC5kYXRhID0gJnFjYV9zb2NfZGF0YV93Y242NzUwfSwNCj4+ICAg
IAl7IC5jb21wYXRpYmxlID0gInFjb20sd2NuNjg1NS1idCIsIC5kYXRhID0gDQo+PiAmcWNhX3Nv
Y19kYXRhX3djbjY4NTV9LA0KPj4gKwl7IC5jb21wYXRpYmxlID0gInFjb20scWNhMjA2Ni1idCIs
IC5kYXRhID0gJnFjYV9zb2NfZGF0YV9xY2EyMDY2fSwNCj4gDQo+IFNvcnQgaXQ/DQo+IFtUaW1d
IGl0IGhhdmUgYmVlbiBzb3J0ZWQgb3IgcGxlYXNlIGd1aWRlIG1lIGhvdyB0byBzb3J0IGl0ID8N
Cg0KU29ydCBpdCBsZXhpY29ncmFwaGljYWxseSwgdGhhdCBtZWFucywgcSBnb2VzIGJlZm9yZSB3
Lg0KW1RpbV0gd2lsbCBhZGRyZXNzIGluIHY1IHZlcnNpb24uDQoNCg0KPj4gICAgCXsgLyogc2Vu
dGluZWwgKi8gfQ0KPj4gICAgfTsNCj4+ICAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHFjYV9i
bHVldG9vdGhfb2ZfbWF0Y2gpOw0KDQoNCktpbmQgcmVnYXJkcywNCg0KUGF1bA0K
