Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47222646848
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLHEfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHEfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:35:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46579950C5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:35:41 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8428ot026365
        for <linux-kernel@vger.kernel.org>; Thu, 8 Dec 2022 04:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=fnOiwKU7dx2sVNVT0gww8hTF46Vlj3JdoazSNDkkTMc=;
 b=T28kVhDIFXge/G9Us73YLVoRgQiJiAOdd8f0qxMykj19s89sXU6/e8xSh0XbFKEKVn/K
 8pcatqFSrVLEQbw/AO3yMw3OP9qQqp3ktqLc6ALwsK4rxaehZQeAJ3OOattsq3BWFiq+
 Ho9Fq4+8+DA12+ucF7XVkXMfKSC0uwdFvhnijiaOvzXpLSSvvP+nG6+3HG2JK3UtC2I9
 5meZFedMb4AWUJ9PT9UjMXKgCwFF6wdLsydQUKSYofKrHNDuC5Y15fGNGBvRH1Jj7B4Y
 AiByHy8a2w9GiwXkfN0sfrPRKbc/Nc7GkErvzlSd25qan2HJShm6AX4/5pzI9Q6OIbSY Ug== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3majt4b4pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 04:35:41 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B84ZeFX023973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 8 Dec 2022 04:35:40 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 20:35:39 -0800
Received: from nasanex01a.na.qualcomm.com ([fe80::ee26:f363:2738:f953]) by
 nasanex01a.na.qualcomm.com ([fe80::ee26:f363:2738:f953%12]) with mapi id
 15.02.0986.036; Wed, 7 Dec 2022 20:35:39 -0800
From:   "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>
To:     "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>
Subject: RE: [PATCH] soc: qcom-geni-se: Update Tx and Rx fifo depth based on
 QUP HW version
Thread-Topic: [PATCH] soc: qcom-geni-se: Update Tx and Rx fifo depth based on
 QUP HW version
Thread-Index: AQHY/aYb84iM+7JnME65ZOEDXxLWrq5kB9iA
Date:   Thu, 8 Dec 2022 04:35:39 +0000
Message-ID: <31c4f532ec6646f7977ebf930b8a2812@quicinc.com>
References: <20221121123758.5052-1-quic_vtanuku@quicinc.com>
In-Reply-To: <20221121123758.5052-1-quic_vtanuku@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.55.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4vJWkEypACcPzX8kyvjsKH_NCEITd1Vp
X-Proofpoint-ORIG-GUID: 4vJWkEypACcPzX8kyvjsKH_NCEITd1Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_02,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=599 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080038
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Reminder!

-----Original Message-----
From: Visweswara Tanuku <quic_vtanuku@quicinc.com>=20
Sent: Monday, November 21, 2022 6:08 PM
To: linux-kernel@vger.kernel.org
Cc: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>; Visw=
eswara Tanuku (QUIC) <quic_vtanuku@quicinc.com>
Subject: [PATCH] soc: qcom-geni-se: Update Tx and Rx fifo depth based on QU=
P HW version

From QUP HW Version 3.10 and above the Tx and Rx fifo depth bits are increa=
sed to 23:16 bits from
21:16 bits in SE_HW_PARAM registers accomodating 256bytes of fifo depth.

Updated geni_se_get_tx_fifo_depth and
geni_se_get_rx_fifo_depth to retrieve right fifo depth based on QUP HW vers=
ion.

Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
---
 include/linux/qcom-geni-se.h | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h in=
dex f5672785c0c4..5ea5351f8818 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -242,12 +242,22 @@ struct geni_se {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+/*
+ * For QUP HW Version >=3D 3.10 Tx fifo depth support is increased
+ * to 256bytes and corresponding bits are 16 to 23  */
+#define TX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
 #define TX_FIFO_DEPTH_MSK		GENMASK(21, 16)
 #define TX_FIFO_DEPTH_SHFT		16
=20
 /* SE_HW_PARAM_1 fields */
 #define RX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define RX_FIFO_WIDTH_SHFT		24
+/*
+ * For QUP HW Version >=3D 3.10 Rx fifo depth support is increased
+ * to 256bytes and corresponding bits are 16 to 23  */
+#define RX_FIFO_DEPTH_MSK_256_BYTES	GENMASK(23, 16)
 #define RX_FIFO_DEPTH_MSK		GENMASK(21, 16)
 #define RX_FIFO_DEPTH_SHFT		16
=20
@@ -388,7 +398,8 @@ static inline void geni_se_abort_s_cmd(struct geni_se *=
se)
=20
 /**
  * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engin=
e
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * TX fifo of the serial engine.
@@ -397,11 +408,20 @@ static inline void geni_se_abort_s_cmd(struct geni_se=
 *se)
  */
 static inline u32 geni_se_get_tx_fifo_depth(struct geni_se *se)  {
-	u32 val;
+	u32 val, hw_version, hw_major, hw_minor, tx_fifo_depth_mask;
+
+	hw_version =3D geni_se_get_qup_hw_version(se);
+	hw_major =3D GENI_SE_VERSION_MAJOR(hw_version);
+	hw_minor =3D GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major =3D=3D 3 && hw_minor >=3D 10) || hw_major > 3)
+		tx_fifo_depth_mask =3D TX_FIFO_DEPTH_MSK_256_BYTES;
+	else
+		tx_fifo_depth_mask =3D TX_FIFO_DEPTH_MSK;
=20
 	val =3D readl_relaxed(se->base + SE_HW_PARAM_0);
=20
-	return (val & TX_FIFO_DEPTH_MSK) >> TX_FIFO_DEPTH_SHFT;
+	return (val & tx_fifo_depth_mask) >> TX_FIFO_DEPTH_SHFT;
 }
=20
 /**
@@ -424,7 +444,8 @@ static inline u32 geni_se_get_tx_fifo_width(struct geni=
_se *se)
=20
 /**
  * geni_se_get_rx_fifo_depth() - Get the RX fifo depth of the serial engin=
e
- * @se:	Pointer to the concerned serial engine.
+ * based on QUP HW version
+ * @se: Pointer to the concerned serial engine.
  *
  * This function is used to get the depth i.e. number of elements in the
  * RX fifo of the serial engine.
@@ -433,11 +454,20 @@ static inline u32 geni_se_get_tx_fifo_width(struct ge=
ni_se *se)
  */
 static inline u32 geni_se_get_rx_fifo_depth(struct geni_se *se)  {
-	u32 val;
+	u32 val, hw_version, hw_major, hw_minor, rx_fifo_depth_mask;
+
+	hw_version =3D geni_se_get_qup_hw_version(se);
+	hw_major =3D GENI_SE_VERSION_MAJOR(hw_version);
+	hw_minor =3D GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major =3D=3D 3 && hw_minor >=3D 10) || hw_major > 3)
+		rx_fifo_depth_mask =3D RX_FIFO_DEPTH_MSK_256_BYTES;
+	else
+		rx_fifo_depth_mask =3D RX_FIFO_DEPTH_MSK;
=20
 	val =3D readl_relaxed(se->base + SE_HW_PARAM_1);
=20
-	return (val & RX_FIFO_DEPTH_MSK) >> RX_FIFO_DEPTH_SHFT;
+	return (val & rx_fifo_depth_mask) >> RX_FIFO_DEPTH_SHFT;
 }
=20
 void geni_se_init(struct geni_se *se, u32 rx_wm, u32 rx_rfr);
--
2.17.1

