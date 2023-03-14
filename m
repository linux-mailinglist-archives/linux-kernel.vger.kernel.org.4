Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992986B8FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCNKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCNKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:04 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA009224D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:34 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4r6CJBzMqQGj;
        Tue, 14 Mar 2023 11:24:28 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4r2gkmz2N45;
        Tue, 14 Mar 2023 11:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789468;
        bh=0VwtUlqDsiiH7eBNGmI+n8uAT1MX4x0mNO/mm+3badA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKBIfFhrYs1T+VeWg6uE/PB/2Zq27QfVHqz3/htZv7C/6jbCx5aBQMbmnCtecGSpX
         cJZ7KaGdh9WmUXZ3VdqxuvpEeW1ojJVQNrws6hf2jgNvZWWeu//0RPMBzTy4bqem2j
         tJ9Tf96peeWLBiK7EPx/whBwV+neSppFr+loh+NE=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/23] arm64: dts: colibri-imx8x: Add jpegenc/dec
Date:   Tue, 14 Mar 2023 11:23:59 +0100
Message-Id: <20230314102410.424773-14-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

jpeg encoder and decoder are available. Do enable them in the module
level device-tree since those are self-contained.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 2fd7f3483b3a..778f2f43a8c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -53,6 +53,14 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 };
 
+&jpegdec {
+	status = "okay";
+};
+
+&jpegenc {
+	status = "okay";
+};
+
 /* Colibri UART_B */
 &lpuart0 {
 	pinctrl-names = "default";
-- 
2.39.2

