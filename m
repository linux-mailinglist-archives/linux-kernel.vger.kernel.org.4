Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05677366C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjFTI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:57:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62118C2;
        Tue, 20 Jun 2023 01:57:21 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8P91s025129;
        Tue, 20 Jun 2023 10:57:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=BuuKOnOm8Z2Mpwb61kJNl/g5ahSF1GNjc4okmHDiako=;
 b=kbubHx1UunA+l0URDgzF0o9PpjLHDIFohkzMiEddTEKjbZD/bHDmdx8G0eLqhIVmuQVi
 q88N7F8T/gtD/XRTXZIPnFfiIsq5J81pqbV4vgHKmWq0T/l5P54JLWNGBIuVtk/TzW64
 16jhxl8R5jZ5AfdMIX+cVBad1EHBqAc0uIRwnZBcSic35XHEmdBrsrw0WsHU5pT5nLPt
 zCJUn1TvzSs+UNsciTOPZxVl0RO3bV+vEvSegN7XCxiHABihI8s6zj7l8QSdqMRWmvFE
 BVfFOHMxWTepu24+7iHcVVhY23TVCCxSdw2Br3aOwEE1Y5e1+x8UIJ5MDG4FsRnwtdM3 CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rb8k8r83r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 10:57:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45D79100071;
        Tue, 20 Jun 2023 10:57:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EA6621A22B;
        Tue, 20 Jun 2023 10:57:13 +0200 (CEST)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 20 Jun
 2023 10:57:12 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] dt-bindings: connector: usb: allow a single HS port
Date:   Tue, 20 Jun 2023 10:56:33 +0200
Message-ID: <20230620085633.533187-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a single HS port to be used e.g. without reg property and a unit
address. OF graph allows a single port node, without 'reg' property.

This removes a couple of Warnings or errors on STM32MP boards.
When using single HS port currently, when doing building with W=1:
arch/arm/boot/dts/stm32mp157c-dk2.dtb: stusb1600@28: connector:
Unevaluated properties are not allowed ('port' was unexpected)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Notes: Other attempts seem to lead to a dead end. Ex: by updating the
relevant dts files, to use ports, and port@0, make W=1 shows
...connector/ports: graph node has single child node
'port@0', #address-cells/#size-cells are not necessary.
But not adding them lead to another "Warning (avoid_default_addr_size)"
---
 .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index ae515651fc6b..1c4d3eb87763 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -168,6 +168,13 @@ properties:
       offer the power, Capability Mismatch is set. Required for power sink and
       power dual role.
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: OF graph bindings modeling a data bus to the connector, e.g.
+      there is a single High Speed (HS) port present in this connector. If there
+      is more than one bus (several port, with 'reg' property), they can be grouped
+      under 'ports'.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description: OF graph bindings modeling any data bus to the connector
@@ -322,6 +329,19 @@ examples:
         };
     };
 
+  # USB-C connector attached to SoC with a single High-Speed controller
+  - |
+    connector {
+        compatible = "usb-c-connector";
+        label = "USB-C";
+
+        port {
+            high_speed_ep: endpoint {
+                remote-endpoint = <&usb_hs_ep>;
+            };
+        };
+    };
+
   # USB-C connector attached to SoC and USB3 typec port controller(hd3ss3220)
   # with SS 2:1 MUX. HS lines routed to SoC, SS lines routed to the MUX and
   # the output of MUX is connected to the SoC.
-- 
2.25.1

