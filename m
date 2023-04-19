Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92176E7208
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjDSEAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjDSEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:00:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040011736;
        Tue, 18 Apr 2023 21:00:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J40LO9122406;
        Tue, 18 Apr 2023 23:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681876821;
        bh=szy7311PgdkX4OcMbVwOXyI886+h9LN7JdLbzoQNfOA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IUDDumoroH4jMkQ2WxwN5mvMGtvogFx8XeQPBa2vFrrmunXwOicEWhDA0wfT/LmeM
         AwjotOPTA5BRaTzXh9mRHbaZeu187P/UiP8Bex67zDMMJuPOLqm7s6DJ6U+Tk+Asq/
         dHnPZcrPhA9t+MlaUNJedkagm7L8RSBo0Oncjm0Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J40Le3113532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 23:00:21 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 23:00:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 23:00:21 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J4098W025277;
        Tue, 18 Apr 2023 23:00:18 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-j7200-som: Enable I2C
Date:   Wed, 19 Apr 2023 09:30:07 +0530
Message-ID: <20230419040007.3022780-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419040007.3022780-1-u-kumar1@ti.com>
References: <20230419040007.3022780-1-u-kumar1@ti.com>
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

This patch enables wkup_i2c0 node in board dts file
along with pin mux and speed.
Also enables underneath eeprom CAV24C256WE.

J7200 Datasheet (Table 6-106, Section 6.4 Pin Multiplexing) :
https://www.ti.com/lit/ds/symlink/dra821u.pdf

J7200 User Guide (Section 4.3, Table 4-2) :
https://www.ti.com/lit/ug/spruiw7a/spruiw7a.pdf

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index fa44ed4c17d5..269424154771 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -118,6 +118,15 @@ J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
 	};
 };
 
+&wkup_pmx2 {
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+			pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x98, PIN_INPUT_PULLUP, 0) /* (F20) WKUP_I2C0_SCL */
+			J721E_WKUP_IOPAD(0x9c, PIN_INPUT_PULLUP, 0) /* (H21) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_i2c0_pins_default: main-i2c0-pins-default {
 		pinctrl-single,pins = <
@@ -214,6 +223,18 @@ exp_som: gpio@21 {
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-- 
2.34.1

