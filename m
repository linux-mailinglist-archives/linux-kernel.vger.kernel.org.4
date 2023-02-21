Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EDC69DAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjBUGvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjBUGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:51:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659E23117;
        Mon, 20 Feb 2023 22:51:27 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L2atWw029898;
        Tue, 21 Feb 2023 06:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=rYjT1VPCrDbOXAoWaWzQslbAY+4S4TBlb0O4SpceqL0=;
 b=IgoDGMe3P9ZZWtn9gd+iBVdOmHB1kpUJ+/k7PWXwqVB2vqDli5Lh0svb+NZcn9Pty8it
 3hUl9bC4A7muYTFd75HNjiNdkJl5Ntkwmrc2nKnr+CqD4vkrYMbeJVljbDWUMFw6xLWs
 C0sQNQBZjxqubFOx9klnIZ4bgobpRRel8CYkN0/o7fST/yKxEweJxlvLwWgnP7vzr0T9
 VcZdQe9siakXAaolPvv/aDA9zL+/yvsthD3KEGsDQdzui65na/PIjsxNxmwATkyO0AWH
 kHLA6aYYOA6vUKdq9Ma3za8K5olrkEVRaMLkQH8b+wv9thiF9b/+wuBJzp5cawzYN2ch Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nubb1w08a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 06:49:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31L6nLEv004488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 06:49:21 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Feb 2023 22:49:20 -0800
Received: from nalasex01b.na.qualcomm.com ([fe80::5e14:2d59:8da8:b152]) by
 nalasex01b.na.qualcomm.com ([fe80::5e14:2d59:8da8:b152%12]) with mapi id
 15.02.0986.041; Mon, 20 Feb 2023 22:49:20 -0800
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Steev Klimaszewski <steev@kali.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "quic_saluvala@quinc.com" <quic_saluvala@quinc.com>
Subject: RE: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Thread-Topic: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Thread-Index: AQHZQeg+G1wnKRsWA0alDqcMCYIjUK7UG4eAgANTyyCAAf18gP//iffw
Date:   Tue, 21 Feb 2023 06:49:20 +0000
Message-ID: <e2026b606ae14ff6a793d45723b13a1e@quicinc.com>
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
 <20230218041545.3801-1-steev@kali.org>
 <DM5PR02MB36863752A525F50AC05662B0EDA49@DM5PR02MB3686.namprd02.prod.outlook.com>
 <CAKXuJqigh=5LMei4ym5s4vKCxkMR5vfM++k7Jk7C4Ge-GRVK6A@mail.gmail.com>
In-Reply-To: <CAKXuJqigh=5LMei4ym5s4vKCxkMR5vfM++k7Jk7C4Ge-GRVK6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.32.31]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w5dVPHrD6aH24QMkZndHUNlrk_Jp7jTT
X-Proofpoint-GUID: w5dVPHrD6aH24QMkZndHUNlrk_Jp7jTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_03,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RlZXYgLCBpbmxpbmUgY29tbWVudHMhDQoNCj4gPlRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZv
ciBRQ0EyMDY2IGZpcm13YXJlIHBhdGNoIGFuZCBudm0gZG93bmxvYWRpbmcuDQo+DQo+IElzIHRo
aXMgYWN0dWFsbHkgY29ycmVjdD8gIEkgYXNrIGJlY2F1c2UgaGVyZSBJIGhhdmUgdGhlIFdDTjY4
NTUgaW4gdGhlIExlbm92byBUaGlua3BhZCBYMTNzLCBhbmQgd2hlbiBhdHRlbXB0aW5nIHRvIHVz
ZSB0aGlzIGRyaXZlciwgSSBlbmQgdXAgd2l0aCBhIGJvYXJkIGlkIG9mIDA4YywgYW5kIGFjY29y
ZGluZyB0byB0aGUgZmlybXdhcmUsIHdlIHNob3VsZCBoYXZlIGEgYm9hcmQgaWQgb2YgYjhjLg0K
Pg0KPiBbVGltXSBjb3JyZWN0LCBJIGRvZXMgbm90IGtub3cgd2hlcmUgeW91IGdldCB0aGUgV0NO
Njg1NSBmaXJtd2FyZSwgZm9yIG91ciBzaWRlLCB3ZSB3aWxsIHVzZSBkaWZmZXJlbnQgbmFtZSBy
dWxlIGZvciBhbmRyb2lkIGFuZCBsaW51eCAsIGZvciBhbmRyb2lkICwgd2Ugd2lsbCBhZGQgImIi
IGluIHRoZSBmcm9udCBvZiBib2FyZCBpZCwgZm9yIGxpbnV4IHdlIHdpbGwgbm90IGFkZCB0aGlz
IGJpdC4NCg0KU28sIHRoZSBUaGlua3BhZCBYMTNzIGlzLi4uIHdlbGwsIGl0J3MgYSBUaGlua3Bh
ZCwgYW5kIGl0IGNvbWVzIHdpdGggV2luZG93cy4gIFNvIHRoZSBmaXJtd2FyZSB0aGF0IHdlIGhh
dmUsIGNvbWVzIGZyb20uLi4uIHRoZW0/IHFjPw0KW1RpbV0geWVhaCAsIGZvciB3b3MgLCBidGZ3
IG5hbWUgc2VlbXMgYWxzbyB0aGUgc2FtZSB3aXRoIGFuZHJvaWQuIEkgdGhpbmsgY29tZSBmcm9t
IHFjIA0KSSBob25lc3RseSBkb24ndCBrbm93IHRoZSBwcm92ZW5hbmNlIG9mIGl0LCBqdXN0IHRo
YXQgSSBncmFiYmVkIHRoZSBmaWxlcyBmcm9tIHRoZSBXaW5kb3dzIHBhcnRpdGlvbjoNCg0KU28s
IGFsbCBvZiB0aGUgbnZtIHBhdGNoZXMgdGhhdCBhcmUgcHJvdmlkZWQgYnkgdGhlbSB3aXRoIHRo
ZSB3aW5kb3dzIGRyaXZlciwgYWxsIHN0YXJ0IHdpdGggJ2InLg0KDQo+IEknbSBub3Qgc3VyZSBo
b3cgdG8gcGhyYXNlIHRoaXMsIGFuZCBqdXN0IHRoaW5raW5nIG91dCBsb3VkIC0gaWYgdGhlIHFj
YTIwNjYgaXMgdGhlIHNhbWUgYXMgdGhlIHdjbjY4NTUsIGp1c3Qgd2l0aCBhbiBhZGRpdGlvbmFs
IGFudGVubmEsIHBlcmhhcHMgdGhlcmUgc2hvdWxkIGJlIHNvbWUgd2F5IHRvIGluZGljYXRlIGl0
PyAgSW4gbXkgcGF0Y2hzZXQsIEkgaGFkIGEgcHJpbnQgb2YgdGhlIG5hbWUgIlNldHRpbmcgdXAg
d2NuNjg1NSIgYW5kIGxvY2FsbHksIEkgY29tYmluZWQgeW91ciBwYXRjaCB3aXRoIG1pbmUsIGFs
dGhvdWdoIGRyb3BwaW5nIHRoZSBhYm92ZSBxY2EyMDY2IGh1bmtzIGluIGZhdm9yIG9mIG15IGFs
cmVhZHkgd3JpdHRlbiB3Y242ODU1IGh1bmtzLCBhbmQgdGhlbiBjb21iaW5lZCB0aGUgdHdvIGlu
IHRoZSBwcmludCBzbyBpdCBzYXlzICJTZXR0aW5nIHVwIHFjYTIwNjYvd2NuNjg1NSIgLSBpcyB0
aGVyZSBhbnkgd2F5IHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiB3aGF0IHF0aSBjb25zaWRlcnMg
YSBxY2EyMDY2IGFuZCB3aGF0IGlzIGNvbnNpZGVyZWQgdGhlIHdjbjY4NTU/DQo+IFtUaW1dIHN0
ZXZlICxhcyBJIG1lbnRpb25lZCBwcmV2aW91c2x5LCB3ZSBoYXZlIGRpZmZlcmVudCBib2FyZCBp
ZCAgZm9yIHFjYTIwNjYgYW5kIHdjbjY4NTUgLCBhbmQgdGhlbiB3aGljaCB3aWxsIHVzZSBkaWZm
ZXJlbnQgbnZtIGNvbmZpZyBmaWxlcyBiYXNlZCBvbiBib2FyZCBpZC4NCj4NCkkgZ2V0IHRoYXQ7
IEknbSB0aGlua2luZyBvZiBlbmQgdXNlcnMsIHdobyBtYXkga25vdyB0aGF0IHRoZXkgaGF2ZSBh
IHdjbjY4NTUsIGJ1dCBpZiB0aGUgbWVzc2FnZXMgYXJlIHFjYTIwNjYsIHRoZXkgbWF5IG5vdCB1
bmRlcnN0YW5kIHRoYXQgaXQncyB0aGUgc2FtZSBjaGlwLg0KW1RpbV0gSSBzZWUsICB3Y242ODU1
IGFuZCBxY2EyMDY2IGlzIGJlbG9uZyB0byAiaHNwIiBidGNoaXAgZmFtaWx5ICwgc28gbWF5YmUg
d2UgY2FuIHVzZSAiaHNwIiB0byBpbnN0ZWFkLg0KDQo+IEJlbG93IGlzIGRtZXNnIG91dHB1dCwg
YW5kIHNvIGlmIHdlIGdvIGJ5IHRoZSB3aWZpIGRldmljZSBjaGVjaywgd2UgDQo+IGVuZCB1cCBz
ZWVpbmcgdGhhdCB3ZSBnZXQNCj4NCj4gY2hpcF9pZCAweDINCj4gY2hpcF9mYW1pbHkgMHhiDQo+
IGJvYXJkX2lkIDB4OGMNCj4gc29jX2lkIDB4NDAwYzAyMTANCj4NCj4NCj4gQnV0IHdpdGggeW91
ciBkcml2ZXIgKG1pbmUgdG9vIGZvciB0aGF0IG1hdHRlciwgYnV0IHRoZW4gaXQncyBqdXN0IGRv
aW5nIHRoZSBzYW1lIGJpZCBiaXRzKS4uLg0KPg0KPiBbICAgIDkuMDgxMDAzXSBCbHVldG9vdGg6
IGhjaTA6IEZyYW1lIHJlYXNzZW1ibHkgZmFpbGVkICgtODQpDQo+IFsgICAgOS4xNDE5OTJdIEJs
dWV0b290aDogaGNpMDogUUNBIFByb2R1Y3QgSUQgICA6MHgwMDAwMDAxMw0KPiBbICAgIDkuMTQx
OTk5XSBCbHVldG9vdGg6IGhjaTA6IFFDQSBTT0MgVmVyc2lvbiAgOjB4NDAwYzAyMTANCj4gWyAg
ICA5LjE0MjAwM10gQmx1ZXRvb3RoOiBoY2kwOiBRQ0EgUk9NIFZlcnNpb24gIDoweDAwMDAwMjAx
DQo+IFsgICAgOS4xNDIwMDddIEJsdWV0b290aDogaGNpMDogUUNBIFBhdGNoIFZlcnNpb246MHgw
MDAwMzhlNg0KPiBbICAgIDkuMTcwNjEyXSBCbHVldG9vdGg6IGhjaTA6IFFDQSBjb250cm9sbGVy
IHZlcnNpb24gMHgwMjEwMDIwMQ0KPiBbICAgIDkuMTcwNjIwXSBCbHVldG9vdGg6IGhjaTA6IFFD
QSBEb3dubG9hZGluZyBxY2EvaHBidGZ3MjEudGx2DQo+DQo+DQo+IFsgICAgOS43NjA1MzddIEJs
dWV0b290aDogaGNpMDogUUNBIGJvYXJkIElEIGxlbiAyLGlkID0gMCA4Yw0KPiBbICAgIDkuNzYw
NTQ3XSBCbHVldG9vdGg6IGhjaTA6IFFDQSBEb3dubG9hZGluZyBxY2EvaHBudjIxLjA4Yw0KPiBb
ICAgIDkuNzYwNjM4XSBibHVldG9vdGggaGNpMDogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yIHFj
YS9ocG52MjEuMDhjIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+IFsgICAgOS43NjA2NDBdIEJsdWV0
b290aDogaGNpMDogUUNBIEZhaWxlZCB0byByZXF1ZXN0IGZpbGU6IHFjYS9ocG52MjEuMDhjICgt
MikNCj4gWyAgICA5Ljc2MDY0M10gQmx1ZXRvb3RoOiBoY2kwOiBRQ0EgRmFpbGVkIHRvIGRvd25s
b2FkIE5WTSAoLTIpDQo+DQo+IElzIHRoZXJlIGFub3RoZXIgd2F5IHRvIGNoZWNrIHRoZSBib2Fy
ZCBpZCBvciBib2FyZCBmYW1pbHk/ICBCZWNhdXNlIGl0J3Mgbm90IGNvbWluZyB1cCB3aXRoIHRo
ZSBjb3JyZWN0IG9uZSBoZXJlLg0KPiBbVGltXSBhcyBteSBjb21tZW50cyBhYm92ZSwgdGhlIHJl
YWQgYm9hcmQgaWQgd2F5IGlzIGNvcnJlY3QsIG9ubHkgd2UgaGF2ZSBkaWZmZXJlbnQgbmFtZSBy
dWxlIGZvciBhbmRyb2lkIGFuZCBsaW51eCAuDQoNClJpZ2h0LCBJIGdldCB0aGF0IHJlYWRpbmcg
dGhlIGJvYXJkIGlkIGlzIHRoZSByaWdodCB3YXkgLSBhbmQgaWYgeW91IHNlZSBpbiBteSBXaW5k
b3dzIGZpcm13YXJlIGFib3ZlICh0aGUgZmlybXdhcmUgc3VibWl0dGVkIHRvIGxpbnV4LWZpcm13
YXJlIGJ5IHlvdSBvbmx5IHNlZW1zIHRvIGhhdmUgbnZtIHBhdGNoZXMgdGhhdCBzdGFydCB3aXRo
ICczJywgYW5kIG5vIG90aGVycy4uKSAgSSdtIHNheWluZywgc2hvdWxkIHdlIGFsc28gcmVhZCB0
aGUgY2hpcF9mYW1pbHkgc29tZWhvdywgc2luY2UgdGhlIFdpRmkgZmlybXdhcmUgc2VlbXMgdG8g
cHJvcGVybHkgbm90aWNlIHRoYXQgd2UgYXJlIGNoaXBfZmFtaWx5IDB4YiwgaG93ZXZlciwgdGhl
IGJsdWV0b290aCBkcml2ZXIganVzdCByZXR1cm5zICcwJy4gIEFuZCBuZWl0aGVyIHRoZSBzdWJt
aXR0ZWQgZmlybXdhcmUsIG5vciB0aGUgZmlybXdhcmUgdGhhdCBMZW5vdm8vUXVhbGNvbW0gc2hp
cCB0byBXaW5kb3dzIHVzZXJzLCBoYXZlIG52bSBwYXRjaGVzIHRoYXQgc3RhcnQgd2l0aCAwLg0K
DQpbVGltXSAgd2UgZGV0ZWN0IHRoZSBjaGlwX2ZhbWlseSBieSBkZXRlY3QgcHJvZHVjdF9pZCBh
bmQgc29jX2lkICwgc3VjaCBhcyBmb3IgImhzcCIgY2hpcCBmYW1pbHksIGlmIHByb2R1Y3QgaWQg
ZXF1YWwgMHgxMyAsYW5kIHNvY19pZCAmIDB4ZmZmZjAwMDAgPT0gMHg0MDBjICwgd2UgYXNzdW1l
IHRoaXMgY2hpcCBpcyAiaHNwIi4gWW91IGNhbiByZWZlciB0aGUgbG9nIGFzIGFib3ZlLg0KDQpB
biBhZGRpdGlvbmFsIG5vdGUsIG5laXRoZXIgbXkgZHJpdmVyLCBub3IgeW91cnMsIHNlZW1zIHRv
IHdvcmsgd2l0aCBCTEUuICBJIGNhbm5vdCBjb25uZWN0IGEgcGFpciBvZiBBaXJQb2RzIHRvIG15
IFRoaW5rcGFkIGluIExpbnV4LCBidXQgSSBhbSBhYmxlIHRvIGRvIGp1c3QgZmluZSBpbiB0aGUg
V2luZG93cyBpbnN0YWxsYXRpb24uICBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBhIGtub3duIGxp
bWl0YXRpb24gYWxyZWFkeSBpbiBsaW51eCBvciBub3QuDQpbVGltXSBJIGFtIG5vdCBzdXJlLCBt
YXliZSBoYXZlIElPVCBpc3N1ZSwgbmVlZCB0byBjaGVjayBpdCBjYXNlIGJ5IGNhc2UuDQoNCj4N
Cj4gLS1zdGVldg0K
