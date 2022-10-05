Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788175F55B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJENkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJENkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:40:07 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8471BE92
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:39:52 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjFzv2KKNzMqFpd;
        Wed,  5 Oct 2022 15:39:39 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjFzv04mqzMpnPh;
        Wed,  5 Oct 2022 15:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1664977179;
        bh=5WAdU/ZfhtphXUGEjTHM+U+v64EjHQonzrwuNMeg3Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9u59RnzsjMSHIWxsH/mdFGumJpz+Xoj/fsX2l7Wk3wdvrM6mpdnxhIM/vlIkg5El
         HlB0RWUOGC/kD20fV/nmh+/9Iy3wtpZFV7Nu6mPED9NXt7g/smG9U0u/3SWK0hinYD
         zMAy4vfJAO0NcDXvpIpG+W0C6k4nndqtluZSeDc0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm: dts: colibri-imx7: fix confusing naming
Date:   Wed,  5 Oct 2022 15:39:29 +0200
Message-Id: <20221005133929.1243443-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005133929.1243443-1-dev@pschenker.ch>
References: <20221005133929.1243443-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

fix the naming of node-name vs label-name to the correct one, that is
the label was always correct.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx7-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a8c31ee65623..3bea7549b762 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -652,7 +652,7 @@ &iomuxc {
 	 * NOTE: This pin group conflicts with pin groups pinctrl_pwm2/pinctrl_pwm3.
 	 * Don't use them simultaneously.
 	 */
-	pinctrl_atmel_adapter: atmelconnectorgrp {
+	pinctrl_atmel_adapter: atmeladaptergrp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74 /* SODIMM 28 / INT */
 			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14 /* SODIMM 30 / RST */
@@ -660,7 +660,7 @@ MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14 /* SODIMM 30 / RST */
 	};
 
 	/* Atmel MXT touchsceen + boards with built-in Capacitive Touch Connector */
-	pinctrl_atmel_connector: atmeladaptergrp {
+	pinctrl_atmel_connector: atmelconnectorgrp {
 		fsl,pins = <
 			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x14 /* SODIMM 106 / RST */
 			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 / INT */
-- 
2.37.3

