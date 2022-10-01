Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534785F1942
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiJADJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiJADHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50822E318C;
        Fri, 30 Sep 2022 20:07:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912puFL012021;
        Sat, 1 Oct 2022 03:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=IjK9zVJOXKYgoA3dvxjM9g3vnQSeUVYSH6OEJu8iyz0=;
 b=MILBwbajVmUSTqxZinz3/BNELiqw4gPHEfUb0LwmiazAtKA7fRMS9sCdLLiYtqEBjp2+
 ZA6SjZCvQ+UG6MrpZR4kf86QblOTpz72CBaH0GvnL8yDNKd/GUc19skch8k9L3ZNINq4
 BG4LxNJgsO7ZcqO58GNk9Vz9cJj5D3Gp8uJIsZdb7hJ7cIFpJ3C9FAJFqKosN2mGVIWa
 jYQljorEEBTXgzNB9U6iRuQx76bEGZ56UBv3FWNgMEXSxDU8PXvBigBuF9JPS98z5jNT
 nI31euigKndFEbipCCYANZHuuJCxnSxSuonpAynZhrIrIi9RJ2WPVRTDileC6nGXv5CC WQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwkee47qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:06:57 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136uiH004990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:06:56 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:55 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 5/5] soc: qcom: socinfo: Add QDU1000/QRU1000 and variant IDs
Date:   Fri, 30 Sep 2022 20:06:41 -0700
Message-ID: <20221001030641.29354-6-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030641.29354-1-quic_molvera@quicinc.com>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1LpebKUp_PBJd4M8bemCWfsgUCaIP8OP
X-Proofpoint-ORIG-GUID: 1LpebKUp_PBJd4M8bemCWfsgUCaIP8OP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=979 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add soc IDs for QDU1000 and QRU1000 and their variants.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4554fb8655d3..d10942b1b9a7 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -334,6 +334,12 @@ static const struct soc_id soc_id[] = {
 	{ 482, "SM8450" },
 	{ 487, "SC7280" },
 	{ 495, "SC7180P" },
+	{ 539, "QRU1000" },
+	{ 545, "QDU1000" },
+	{ 587, "QDU1010" },
+	{ 588, "QRU1032" },
+	{ 589, "QRU1052" },
+	{ 590, "QRU1062" },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.37.3

