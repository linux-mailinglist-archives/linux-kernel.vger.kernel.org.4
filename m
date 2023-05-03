Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164E6F4F96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjECErZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjECErL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:47:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050540EB;
        Tue,  2 May 2023 21:47:00 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3434Ku6q005171;
        Wed, 3 May 2023 04:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FZAP9U5KvTotJqc0TH2vwDOXv2WZ20mB6NQ/dTJQCH0=;
 b=jl7uuV4fuqaKHdEX5IelrPuFdxsHMa9sLacEkZtMPf3w9AnnA8DDmd/alPAJfA2G6eyy
 YAjbBkwWIc0+u59fUu4owz9kBGCvDV5Wmp43O7TcGFZ3d1R36qKlDu+o78ck16gJRPQE
 Gu6AsCfFqUtgf4EV43luGELgua8Kt4ZqY8dtI4oFIXWdIXywHvvYSmsLu12uBiOkseK/
 X7qphdy0mbx1CPhMt+OwUDU1BU02gnK/MEtWag05+CrzMSgk81Qxyu2wm6uq+Wk6lMZh
 /9W29knzIekePLYfdFZIjjJI0ISeqVPyGQI49mJeDFMX6GPA4qeWlHj4cBFrn/JyugXk BA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qb4us9cx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 04:46:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3434kmHL007182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 04:46:48 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 21:46:43 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: [PATCH v1 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
Date:   Wed, 3 May 2023 10:16:02 +0530
Message-ID: <65d05b81201a8d24c14f0d7564e708348a368068.1683027347.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1683027347.git.quic_varada@quicinc.com>
References: <cover.1683027347.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x7PRlmtq6JjWKG1jQz5bLCr2unPs7bHT
X-Proofpoint-ORIG-GUID: x7PRlmtq6JjWKG1jQz5bLCr2unPs7bHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_01,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=980 spamscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds thermal zone nodes for the various
sensors present in IPQ9574

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
[v1]:
	Fix node names
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index b22b999..bc4d061 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -1067,6 +1067,214 @@
 		};
 	};
 
+	thermal-zones {
+		nss-top-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				nss-top-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi-0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				ubi_0-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi-1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				ubi_1-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi-2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				ubi_2-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ubi-3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				ubi_3-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				cpu-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <10000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 11>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <10000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 12>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <10000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 13>;
+
+			trips {
+				cpu-critical {
+					temperature = <120000>;
+					hysteresis = <10000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wcss-phyb-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 14>;
+
+			trips {
+				wcss_phyb-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsens 15>;
+
+			trips {
+				top_glue-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.7.4

