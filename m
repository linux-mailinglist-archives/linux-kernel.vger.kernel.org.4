Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0C707CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjERJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjERJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:18:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD31FDC;
        Thu, 18 May 2023 02:18:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I97CFE032218;
        Thu, 18 May 2023 09:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=vXdEjbV2kaWvRyKtIHLSDKeeI9K1RFI26hTtFd+wRno=;
 b=KrXy7PiE4nPWYQlWmRxtoADWxu1Aka0hPwA7T0d2hiGCrKIRupgJAfLNNRl1l+qy6O3z
 gOguiStNdXacTUZJ/8Prvdoje+dNdvSN6vQJovXwrHGz9JQFKbq00TFUKFT2jRiPPrMH
 i2EyI1D1bPKlA18HR5ZAHed+RPZSaEkevsQExQD/OYicMGbLrts3z9nV8gAnHbFX7STa
 prn2gqZi2E0H9FJs539vjcl/yLAiZdIqSm1xt5+9c+vS62DKw8mHPJevKJqLV9QFwO2/
 8ceSTY02KsvtPIxqXIs7DEoiqJ2fod5zWI6g15nl3NdZn8v2Ou1EMJdf7ozi2EK/e+92 Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73us1qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:18:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I9IYDn019191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 09:18:34 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 02:18:33 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6]) by
 nalasex01b.na.qualcomm.com ([fe80::a057:7d2:b40d:81d6%12]) with mapi id
 15.02.0986.042; Thu, 18 May 2023 02:18:33 -0700
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Subject: RE: [PATCH v1] dt-bindings: net: Add QCA2066 Bluetooth
Thread-Topic: [PATCH v1] dt-bindings: net: Add QCA2066 Bluetooth
Thread-Index: AQHZiUbO1REsBdeXJEy/qzRX7KF/Nq9gJiyA//+aKfA=
Date:   Thu, 18 May 2023 09:18:33 +0000
Message-ID: <1eb03ab0ab3f49deb0f390478bd40c3a@quicinc.com>
References: <20230518050826.27316-1-quic_tjiang@quicinc.com>
 <a422a4ec-5fc9-9b4b-0cdc-8ea4e9dfc292@kernel.org>
In-Reply-To: <a422a4ec-5fc9-9b4b-0cdc-8ea4e9dfc292@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.77.31]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KjzUNRfi-WzjH2id9TYSOI54upJqxAsd
X-Proofpoint-GUID: KjzUNRfi-WzjH2id9TYSOI54upJqxAsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=471 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S3J6eXN6dG9mOiANClRoYW5rcyBmb3IgeW91ciByZXBseSwgSW5saW5lIGNvbW1lbnRzDQoNClJl
Z2FyZHMuDQpUaW0NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiANClNlbnQ6IFRodXJzZGF5LCBNYXkgMTgs
IDIwMjMgNDoyMSBQTQ0KVG86IFRpbSBKaWFuZyAoUVVJQykgPHF1aWNfdGppYW5nQHF1aWNpbmMu
Y29tPjsgbWFyY2VsQGhvbHRtYW5uLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21Admdlci5r
ZXJuZWwub3JnOyBCYWxha3Jpc2huYSBHb2RhdmFydGhpIChRVUlDKSA8cXVpY19iZ29kYXZhckBx
dWljaW5jLmNvbT47IEhlbWFudCBHdXB0YSAoUVVJQykgPHF1aWNfaGVtYW50Z0BxdWljaW5jLmNv
bT47IG1rYUBjaHJvbWl1bS5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGR0LWJpbmRpbmdz
OiBuZXQ6IEFkZCBRQ0EyMDY2IEJsdWV0b290aA0KDQpPbiAxOC8wNS8yMDIzIDA3OjA4LCBUaW0g
Smlhbmcgd3JvdGU6DQo+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIFFDQTIwNjYgY2hpcHNldC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFRpbSBKaWFuZyA8cXVpY190amlhbmdAcXVpY2luYy5jb20+DQoN
ClBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBu
ZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cyB0byBDQy4gIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBj
b21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2ZXMgeW91IG91dGRhdGVkIGVu
dHJpZXMuICBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UgeW91ciBwYXRjaGVzIG9u
IHJlY2VudCBMaW51eCBrZXJuZWwuDQpbVGltXSBvayAsIEkgd2lsbCB1cGRhdGUgbXkgbGludXgg
a2VybmVsDQoNCllvdSBtaXNzZWQgYXQgbGVhc3QgRFQgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRo
aXMgd29uJ3QgYmUgdGVzdGVkLg0KW1RpbV0gZG8geW91IG1lYW4gZW1haWwgQ0MgbGlzdCA/DQpQ
bGVhc2UgcmVzZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNlc3NhcnkgZW50cmllcy4NCg0KDQpCZXNp
ZGUgdGhhdCBwYXRjaCBsb29rcyBpbmNvbXBsZXRlLg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0
b2YNCg0K
