Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B90A6F9F18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjEHFd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEHFdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:33:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ECF17DED;
        Sun,  7 May 2023 22:33:20 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3482MLQf010789;
        Mon, 8 May 2023 05:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Pd2CPz6IpIHjoAamSUZ93Xd1mYNqPbypMGkfUyfjVTQ=;
 b=b8r/IYO3t2MszuI+D51B1RZG06ooLFKy/KnOsUBBD+WqERebF5xM0JMfHpYkmGs8rP5i
 atmouJjeUCMX0HO/eF+rWJlhKlEh+fCrJgGEGMjwmgCF9Gu1bs3can8v4+9CzwcFKpfZ
 WwblpI04yFC8ImeY3xing/ZFSPwv9oUP6OzlHx2F03lXdWCSj3fFOZU3n1v6IbG0u6e3
 sxbyhbipPl4jiwPOlzhUWeNRv+wMjVcZZ1P0bQNbsrBFmxYLx3ltyT8vUtPZLx2v7U2l
 v79gO/pBiw0b3FKp7FmQDO3bv9nKGgyoSkP+duArGcqYpcjW8liOQF6EB7Ya9RS0DPHF Vw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qdc8xk0bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 05:33:15 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3485XE3j009551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 05:33:14 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 7 May 2023 22:33:10 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: ipq9574: add tsens node
Date:   Mon, 8 May 2023 11:02:39 +0530
Message-ID: <81653f1ac4bf42e57a7d6c4f1af844846d091224.1683523370.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683523370.git.quic_varada@quicinc.com>
References: <cover.1683523370.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DPFqz02X9I4u8XaVAII6tvPS2_gBvDFl
X-Proofpoint-GUID: DPFqz02X9I4u8XaVAII6tvPS2_gBvDFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=877
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 has a tsens v2.3.1 peripheral which monitors temperatures
around the various subsystems on the die.

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
[v2]:
	Add "qcom,ipq8074-tsens" as fallback compatible
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 93e3026..85bba6a 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -1056,6 +1056,15 @@
 			status = "disabled";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq9574-tsens", "qcom,ipq8074-tsens";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <16>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.7.4

