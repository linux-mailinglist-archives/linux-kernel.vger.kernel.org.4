Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B76F7ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjEEIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjEEIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:23:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB751893A;
        Fri,  5 May 2023 01:22:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3457quNV027492;
        Fri, 5 May 2023 08:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WZtO0HqANQYzG7rjKke7I95LJ7e1euJQtwGimPfnjXM=;
 b=lSa8tsuRIkesTK4+67xE6VQ38GhR56fzrSBGYIUAGV/6Egt1/EPJ0fGlyUVp0rkW8H6M
 yvplfAp3I4X7+gJBs3BlRupAU8F5SRpdTfkqwbaPPDU1XYs+2jBTbRPfy/QGq1GWDAH1
 8GOOCrhB14uNbTOPnIiYaUXLTnA6cvX6m1/WsbqDmspaO+sDd3BZTqbQQZCnEM+YgP4/
 RjQmXNqgHq6vWIio4dk1wAHDfWV8GSnaN2s9OLRRvcIfVlZFdAiB72eXiJO6lowS4ipF
 UCh/uzhWMgUasOU8FvTBcqI2CNLjQSdL6EOvl4LfwjKOqcD5qA215Z+UlRz000vUNdo0 lw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qckf714vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 08:22:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3458Mn8S016460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 08:22:49 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 5 May 2023 01:22:44 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v10 8/9] arm64: dts: qcom: ipq9574: Add LDO regulator node
Date:   Fri, 5 May 2023 13:05:09 +0530
Message-ID: <8894bf2c44eaf4959c7a1966b66229e6cf5cda96.1683183860.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683183860.git.quic_varada@quicinc.com>
References: <cover.1683183860.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wxr9xcnmWvKmX3mjpxUMBVK4BlGVJUG4
X-Proofpoint-ORIG-GUID: wxr9xcnmWvKmX3mjpxUMBVK4BlGVJUG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=776
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LDO regulator node

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v10:
	- Add LDO regulator node
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index bdc1434..1f5d14f 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -60,6 +60,13 @@
 			regulator-min-microvolt = <725000>;
 			regulator-max-microvolt = <1075000>;
 		};
+
+		mp5496_l2: l2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
 	};
 };
 
-- 
2.7.4

