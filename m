Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D16175DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKCE7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:59:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983B92192;
        Wed,  2 Nov 2022 21:59:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A34h2tE021459;
        Thu, 3 Nov 2022 04:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cdO44aLqtlUgc7uvbFUTp9qjSSt0TOiq7byBU5M2Ayw=;
 b=cWmlrwcOP8r0zwnUG2+XK8+q6/f0/MwpKT03GTSrpOYep0h+oVRuO3nZQ3ks4nHFBfCi
 yaQ2y/tbHErO+S3ae+Rvh9ba6rSfT2GFU/2lOWcsI+NCl0UBn4KJrlreKQbV4i6N452G
 DOp2ewei21ISvVsCbIgAM3ENx3wfPL3hvPDBJvB7l9i0G3fSi06wWyRCkGQGnvCszahA
 uIcZNY/IJmZGwIT9P3X87oAu605G3KgJ2uVV/dFZUdlVWPhOlbaK1NktQRe0eSon37FE
 DDfu2Dwm5tlfNCw7Ax3KLnDzW9Y6KIykREIvRqblLKT1IEdQgfdTELA7cPYysJI7MaJD Ig== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km6v1g28v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:59:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A34xHgP006643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 04:59:17 GMT
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:59:13 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <quic_avajid@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RFC 1/2] dt-bindings: firmware: arm,scmi: Add support for memlat vendor protocol
Date:   Thu, 3 Nov 2022 10:28:31 +0530
Message-ID: <1667451512-9655-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: npfn_TKwMs-sNg4vgPPX8P0moW15zZG8
X-Proofpoint-GUID: npfn_TKwMs-sNg4vgPPX8P0moW15zZG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings support for the SCMI QTI memlat (memory latency) vendor
protocol. The memlat vendor protocol enables the frequency scaling of
various buses (L3/LLCC/DDR) based on the memory latency governor
running on the CPUSS Control Processor.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 1c0388da6721..efc8a5a8bffe 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -189,6 +189,47 @@ properties:
       reg:
         const: 0x18
 
+  protocol@80:
+    type: object
+    properties:
+      reg:
+        const: 0x80
+
+      qcom,bus-type:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          minItems: 1
+        description:
+          Identifier of the bus type to be scaled by the memlat protocol.
+
+      cpu-map:
+        type: object
+        description:
+          The list of all cpu cluster configurations to be tracked by the memlat protocol
+
+        patternProperties:
+          '^cluster[0-9]':
+            type: object
+            description:
+              Each cluster node describes the frequency domain associated with the
+              CPUFREQ HW engine and bandwidth requirements of the buses to be scaled.
+
+            properties:
+              operating-points-v2: true
+
+              qcom,freq-domain:
+                $ref: /schemas/types.yaml#/definitions/phandle-array
+                description:
+                  Reference to the frequency domain of the CPUFREQ HW engine
+                items:
+                  - items:
+                      - description: phandle to CPUFREQ HW engine
+                      - description: frequency domain associated with the cluster
+
+            required:
+              - qcom,freq-domain
+              - operating-points-v2
+
 additionalProperties: false
 
 patternProperties:
@@ -429,4 +470,127 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    firmware {
+        scmi {
+            compatible = "arm,scmi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mboxes = <&cpucp_mbox>;
+            mbox-names = "tx";
+            shmem = <&cpu_scp_lpri>;
+
+            scmi_memlat: protocol@80 {
+                reg = <0x80>;
+                qcom,bus-type = <0x2>;
+
+                cpu-map {
+                    cluster0 {
+                        qcom,freq-domain = <&cpufreq_hw 0>;
+                        operating-points-v2 = <&cpu0_opp_table>;
+                    };
+
+                    cluster1 {
+                        qcom,freq-domain = <&cpufreq_hw 1>;
+                        operating-points-v2 = <&cpu4_opp_table>;
+                    };
+
+                    cluster2 {
+                        qcom,freq-domain = <&cpufreq_hw 2>;
+                        operating-points-v2 = <&cpu7_opp_table>;
+                    };
+                };
+            };
+        };
+
+        cpu0_opp_table: opp-table-cpu0 {
+            compatible = "operating-points-v2";
+
+            cpu0_opp_300mhz: opp-300000000 {
+                opp-hz = /bits/ 64 <300000000>;
+                opp-peak-kBps = <9600000>;
+            };
+
+            cpu0_opp_1325mhz: opp-1324800000 {
+                opp-hz = /bits/ 64 <1324800000>;
+                opp-peak-kBps = <33792000>;
+            };
+
+            cpu0_opp_2016mhz: opp-2016000000 {
+                opp-hz = /bits/ 64 <2016000000>;
+                opp-peak-kBps = <48537600>;
+            };
+        };
+
+        cpu4_opp_table: opp-table-cpu4 {
+            compatible = "operating-points-v2";
+
+            cpu4_opp_691mhz: opp-691200000 {
+                opp-hz = /bits/ 64 <691200000>;
+                opp-peak-kBps = <9600000>;
+            };
+
+            cpu4_opp_941mhz: opp-940800000 {
+                opp-hz = /bits/ 64 <940800000>;
+                opp-peak-kBps = <17817600>;
+            };
+
+            cpu4_opp_2611mhz: opp-2611200000 {
+                opp-hz = /bits/ 64 <2611200000>;
+                opp-peak-kBps = <48537600>;
+            };
+        };
+
+        cpu7_opp_table: opp-table-cpu7 {
+            compatible = "operating-points-v2";
+
+            cpu7_opp_806mhz: opp-806400000 {
+                opp-hz = /bits/ 64 <806400000>;
+                opp-peak-kBps = <9600000>;
+            };
+
+            cpu7_opp_2381mhz: opp-2380800000 {
+                opp-hz = /bits/ 64 <2380800000>;
+                opp-peak-kBps = <44851200>;
+            };
+
+            cpu7_opp_2515mhz: opp-2515200000 {
+                opp-hz = /bits/ 64 <2515200000>;
+                opp-peak-kBps = <48537600>;
+            };
+        };
+    };
+
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        cpucp_mbox: mailbox@17400000 {
+            compatible = "qcom,cpucp-mbox";
+            reg =   <0x0 0x17c00000 0x0 0x10>, <0x0 0x18590300 0x0 0x700>;
+            interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+            #mbox-cells = <0>;
+        };
+
+        sram@18509400 {
+            compatible = "mmio-sram";
+            reg = <0x0 0x18509400 0x0 0x400>;
+            no-memory-wc;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0x0 0x0 0x18509400 0x400>;
+
+            cpu_scp_lpri: scp-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+        };
+    };
+
 ...
-- 
2.7.4

