Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E66DF97E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDLPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDLPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:14:28 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F90F729F;
        Wed, 12 Apr 2023 08:14:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CCguLK012377;
        Wed, 12 Apr 2023 17:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=P2PtWKI6YfEalebJHuMe+I95r6/HVvixKLwm20SX2QM=;
 b=Ty8jSxXpxURJf5TB5qiEpF9YuzCSBIvvBHAgfAxfzeopwa7CdDNypP3NaDtKSxddPCh8
 BX8VBpbG+9/9CUEvRxBmBfwd2gcnmp9dSYv2kna8Bp7DFX3p7flUrq1I7wmp1Cg/dZet
 PkApiCqQ7yKnZfw9pcWfFV/Otli/lld9APhsAlBqe8bKx1QTDSiuGRnEsFcLJEKPw+uA
 ODdyt7Gz72rH2A4wEA4H0sPCYM8Aq4DylS/10GKm5rTil3ZgF/MXPgeC9gGilEDj50/B
 NxByH9Cx/vPAVaIqQhenIvRAi9YJfcSidUzOwwL9aCLvDxQ1vK5s+cBBBbKJ7JR6aQux 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pw7wp040x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:14:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF22B100045;
        Wed, 12 Apr 2023 17:14:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1217E218610;
        Wed, 12 Apr 2023 17:14:00 +0200 (CEST)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 17:13:59 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [RFC PATCH] ARM: dts: stm32: remove typec port dtbs_check warning on stm32mp15xx-dkx
Date:   Wed, 12 Apr 2023 17:13:32 +0200
Message-ID: <20230412151332.3037845-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to usb-connector.yaml, typec connector should always use:
- ports property
- with port@0 (required).
This is also true for a single HS port. This removes dtbs_check warning:
stusb1600@28: connector: Unevaluated properties are not allowed ('port'
was unexpected)

Downside is it introduces another warning when building with W=1:

Warning (graph_child_address): /soc/i2c@5c002000/stusb1600@28/connector/
ports: graph node has single child node 'port@0', #address-cells
/#size-cells are not necessary

By removing #address-cells/#size-cells as suggested, another couple of
W=1 warning shows up:
Warning (avoid_default_addr_size): /soc/i2c@5c002000/stusb1600@28/
connector/ports/port@0: Relying on default #address-cells value
Warning (avoid_default_addr_size): /soc/i2c@5c002000/stusb1600@28/
connector/ports/port@0: Relying on default #size-cells value

Is there a clean way or necessary change to reach a clean build and clean
dtbs_check ?
Maybe this kind of concern has already been addressed ?
As far as I understand, the OF graph allows a single port {} node (e.g.
code being reworked here). Could this be added in relevant dtschema, to
address the single HS port use case (usb-connector.yaml) ?

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index cefeeb00fc22..41e79c8cc752 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -259,9 +259,14 @@ connector {
 			power-role = "dual";
 			typec-power-opmode = "default";
 
-			port {
-				con_usbotg_hs_ep: endpoint {
-					remote-endpoint = <&usbotg_hs_ep>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					con_usbotg_hs_ep: endpoint {
+						remote-endpoint = <&usbotg_hs_ep>;
+					};
 				};
 			};
 		};
-- 
2.25.1

