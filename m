Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933B6E5852
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDRFFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:05:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646584EDD;
        Mon, 17 Apr 2023 22:05:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I55PMT080544;
        Tue, 18 Apr 2023 00:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681794325;
        bh=DAvbK9YhqnI5EH390ONMuZ5K7iZN3hEyKwv4U4Wg+8I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NGd//sHFnEeaiQ4G+2nBDlKQMlvkYSplEdEobOF+plLP417+VWujGfa3i9erk/vc1
         NsZTY00GN2TOlUJJzU7WnBHczG3QxPmzovwvCrJ20geHSb1Mb5kgG5LN70OM5oe0B6
         z5+fveejR7CxupBkq5Y2/kQOrvs7GNLVM84NsrkU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I55Psi010828
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 00:05:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 00:05:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 00:05:25 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I55Hc6046130;
        Tue, 18 Apr 2023 00:05:21 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     Keerthy <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j7200: Fix  physical address of pin
Date:   Tue, 18 Apr 2023 10:35:13 +0530
Message-ID: <20230418050514.2392717-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418050514.2392717-1-u-kumar1@ti.com>
References: <20230418050514.2392717-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

wkup_pmx splits into multiple regions. Like

    wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
    wkup_pmx1 -> 2 pins (WKUP_PADCONFIG 14 - 15)
    wkup_pmx2 -> 59 pins (WKUP_PADCONFIG 26 - 84)
    wkup_pmx3 -> 8 pins (WKUP_PADCONFIG 93 - 100)

With this split, pin offset needs to be adjusted to
match with new pmx for all pins above wkup_pmx0.

Example a pin under wkup_pmx1 should start from 0 instead of
old offset(0x38 WKUP_PADCONFIG 14 offset)

J7200 Datasheet (Table 6-106, Section 6.4 Pin Multiplexing) :
https://www.ti.com/lit/ds/symlink/dra821u.pdf

Fixes: 9ae21ac445e9 ("arm64: dts: ti: k3-j7200: Fix wakeup pinmux range")

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 0d39d6b8cc0c..63633e4f6c59 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -83,25 +83,25 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 &wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
-			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
-			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
-			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
-			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
-			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
-			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
-			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
-			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
-			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
-			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
-			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
-			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
 };
-- 
2.34.1

