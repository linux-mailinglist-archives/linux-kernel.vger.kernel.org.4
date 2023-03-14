Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AD6B9DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCNSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCNSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:06:41 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C3AF68B;
        Tue, 14 Mar 2023 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678817198;
        bh=gD22LXsDuJoOUZMHNihJKmJh7CtVqSFbDM6qf+BB0HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgYo11vfsICDsczAtcp1SMIxA3idmEfCMfx2l5iqLYc85xl+nr7k1MUlwD9eGvcwA
         XoFpi/FOiAXivi07tkpPAMw/pQb5MuzyQHM27lIkOUbXhjqBk/We3pOJAtcWtR8wzP
         PKrdcrlSpnDLI39nfFMNOq0nhtEvsBkC3Y4p12PM=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.30.161])
        by uho.ysoft.cz (Postfix) with ESMTP id BA896A052A;
        Tue, 14 Mar 2023 19:06:37 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 3/5] ARM: dts: imx6dl-yapp4: Remove unneeded status "okay"
Date:   Tue, 14 Mar 2023 19:06:06 +0100
Message-Id: <20230314180608.44482-4-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314180608.44482-1-michal.vokac@ysoft.com>
References: <20230314180608.44482-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicit status = "okay" is not needed as it is the default.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
- new patch

 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 8a78a656bac0..a498f14b662d 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -98,7 +98,6 @@ reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		status = "okay";
 	};
 };
 
@@ -302,7 +301,6 @@ eeprom@57 {
 		compatible = "atmel,24c128";
 		reg = <0x57>;
 		pagesize = <64>;
-		status = "okay";
 	};
 
 	touchscreen: touchscreen@5c {
-- 
2.25.1

