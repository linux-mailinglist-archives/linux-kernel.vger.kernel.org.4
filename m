Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4331E6E5CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDRJIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDRJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:08:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1ADD;
        Tue, 18 Apr 2023 02:07:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6sONK001477;
        Tue, 18 Apr 2023 09:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=hkd67ZcHHcZ2PxJOeb+Bj40m+qJvUCSHPfKnmCtpALI=;
 b=IyyKTRn8V9wNJxaCtPiT7qW+0Y0xuu96Gi6w4AniprUWBoUmyX13JP8FTfgzVoSBlrfB
 SommhvO62onOBbyPoiWQZhGQduyUdvTHdE+MZuQurrPTHMRfwwYff3SfIah1Yc36EgDF
 RVj68xFgPsUvqnlqIj2f4823QTFda027KqFvnvrPGaa9/Asc3+HT/T/SVpoi/hvbhCUA
 erMg+6mNIv0Xj3wEAFd35WEqXVPlVP1HYU061BeCDF7HajoxfyNXzbv2aiI0wpffZcYR
 ojQ8pa3XBUrf0B4ii+glvY5HBeSX6h31zbiBzuMK5qUvTq/OqTRAJeFaJ04YOgkn1SwO Iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nk4gccg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:07:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I97WjJ030122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:07:32 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 02:07:32 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::27dd:ab4b:a3c:3d0a]) by
 nalasex01b.na.qualcomm.com ([fe80::27dd:ab4b:a3c:3d0a%12]) with mapi id
 15.02.0986.042; Tue, 18 Apr 2023 02:07:32 -0700
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Subject: RE: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Topic: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Index: AQHZbdNSzRZimAa7YESiLSr50VCixK8rwqCAgAMeQQCAAmHlgP//ixIg
Date:   Tue, 18 Apr 2023 09:07:31 +0000
Message-ID: <a908e04e9b7d4b97bc6b5ee3c713e71f@quicinc.com>
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
 <CAA8EJpoc4nn+Wr131-o=YQoDeL0t7aj9hC=8NNnJa3SeHwgJ-w@mail.gmail.com>
 <934c32ef9427464a9d0b898b843df6ab@quicinc.com>
 <CAA8EJpqz9o9CtAnXRE86kw-cfL=_d-c5BDAXwQLSJAyZRy_fEg@mail.gmail.com>
In-Reply-To: <CAA8EJpqz9o9CtAnXRE86kw-cfL=_d-c5BDAXwQLSJAyZRy_fEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.79.29]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GlFQaehGJY23Nsbhtw4qoOWhXp5lVh8B
X-Proofpoint-GUID: GlFQaehGJY23Nsbhtw4qoOWhXp5lVh8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=729 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5Og0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRG1pdHJ5IEJh
cnlzaGtvdiA8ZG1pdHJ5LmJhcnlzaGtvdkBsaW5hcm8ub3JnPiANClNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDE4LCAyMDIzIDU6MDMgUE0NClRvOiBUaW0gSmlhbmcgKFFVSUMpIDxxdWljX3RqaWFuZ0Bx
dWljaW5jLmNvbT4NCkNjOiBtYXJjZWxAaG9sdG1hbm4ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNt
QHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEgR29kYXZhcnRoaSAoUVVJQykgPHF1aWNfYmdv
ZGF2YXJAcXVpY2luYy5jb20+OyBIZW1hbnQgR3VwdGEgKFFVSUMpIDxxdWljX2hlbWFudGdAcXVp
Y2luYy5jb20+OyBta2FAY2hyb21pdW0ub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBCbHVl
dG9vdGg6IGJ0dXNiOiBBZGQgV0NONjg1NSBkZXZjb3JlZHVtcCBzdXBwb3J0DQoNCk9uIFR1ZSwg
MTggQXByIDIwMjMgYXQgMDQ6MDIsIFRpbSBKaWFuZyAoUVVJQykgPHF1aWNfdGppYW5nQHF1aWNp
bmMuY29tPiB3cm90ZToNCj4NCj4gSGkgRG1pdHJ5Og0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBEbWl0cnkgQmFyeXNoa292IDxkbWl0cnkuYmFyeXNoa292QGxpbmFy
by5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxNSwgMjAyMyA1OjAzIEFNDQo+IFRvOiBU
aW0gSmlhbmcgKFFVSUMpIDxxdWljX3RqaWFuZ0BxdWljaW5jLmNvbT4NCj4gQ2M6IG1hcmNlbEBo
b2x0bWFubi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eC1ibHVl
dG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgDQo+
IEJhbGFrcmlzaG5hIEdvZGF2YXJ0aGkgKFFVSUMpIDxxdWljX2Jnb2RhdmFyQHF1aWNpbmMuY29t
PjsgSGVtYW50IA0KPiBHdXB0YSAoUVVJQykgPHF1aWNfaGVtYW50Z0BxdWljaW5jLmNvbT47IG1r
YUBjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gQmx1ZXRvb3RoOiBidHVz
YjogQWRkIFdDTjY4NTUgZGV2Y29yZWR1bXAgDQo+IHN1cHBvcnQNCj4NCj4gT24gVGh1LCAxMyBB
cHIgMjAyMyBhdCAwOTo0NCwgVGltIEppYW5nIDxxdWljX3RqaWFuZ0BxdWljaW5jLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBXQ042ODU1IHdpbGwgcmVwb3J0IG1lbWR1bXAgdmlhIEFDTCBkYXRhIG9y
IEhDSSBldmVudCB3aGVuIGl0IGdldCANCj4gPiBjcmFzaGVkLCBzbyB3ZSBjb2xsZWN0IG1lbWR1
bXAgdG8gZGVidWcgZmlybXdhcmUuDQo+DQo+IElzIGl0IGFwcGxpY2FibGUgb25seSB0byB3Y242
ODU1IG9yIHRvIHNvbWUgb2YgZWFybGllciBjaGlwcyB0b28/DQo+ICBbVGltXSAgQWxzbyBhcHBs
aWNhYmxlIHRvIGVhcmxpZXIgY2hpcHMgLCBidXQgY3VycmVudGx5IGdvb2dsZSBvbmx5IA0KPiBy
ZXF1aXJlIHVzIHRvIHN1cHBvcnQgd2NuNjg1NQ0KDQpTaW5jZSB1cHN0cmVhbSBpcyBub3QgYSBn
b29nbGUga2VybmVsLCBwbGVhc2UgZW5hYmxlIHRoaXMgZmVhdHVyZSBmb3IgYWxsIHJlbGV2YW50
IGNoaXBzZXRzLg0KW1RpbV0gYWdyZWVkICwgYnV0IHRoZSB0aXRsZSBvZiB0aGlzIGdlcnJpdCB1
bmNoYW5nZWQsICBJIHJhaXNlIGEgbmV3IGdlcnJpdCBmb3Igb3RoZXIgcmVsZXZhbnQgY2hpcHNl
dHMgLCBpcyBPSz8NCg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGltIEppYW5nIDxxdWlj
X3RqaWFuZ0BxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYyB8IDIyMg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMjIgaW5zZXJ0aW9ucygrKQ0KDQoNCg0KDQotLQ0KV2l0aCBi
ZXN0IHdpc2hlcw0KRG1pdHJ5DQo=
