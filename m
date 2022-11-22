Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB246340C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKVQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiKVQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:11 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099D72130
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:07 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjf3TgqzMq7XH;
        Tue, 22 Nov 2022 16:54:46 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjf0KQ5zMpqZ7;
        Tue, 22 Nov 2022 16:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132486;
        bh=KQJXqE+JmnB6mDifCLAOwhhFYmr+jtuDDPQjdvLtyG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfIEPVvq5kXFtGKZL3936aJ/BndOluvsqJ22VVXD3RIZK3N03+eWOrBA4cWv5CSvv
         3ku1XroH2reDu5okXLvtVFXLNoBdq/t7mu56Zx/QASZCK7AjsLJMgKIl4j3CIZ/rWC
         QUbxnN+sUbfHlWPPqvGc+FtK4K5f+PFvFLlfPTIQ=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ARM: dts: colibri-imx6ull: Disable usb over-current
Date:   Tue, 22 Nov 2022 16:54:36 +0100
Message-Id: <20221122155439.456142-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Disable usb over-current of the chipidea driver on all Carrier-Boards
used by Toradex. Do this as we don't want to use this functionality on
our Carrier Boards and to leave it open to someone who includes our
module-level device-trees.

This will prevent the warning "No over current polarity defined" from
being printed on boot.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6ull-colibri-aster.dtsi   | 2 ++
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 2 ++
 arch/arm/boot/dts/imx6ull-colibri-iris.dtsi    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi b/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
index c9133ba2d705..de4dc7c1a03a 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-aster.dtsi
@@ -130,11 +130,13 @@ &uart5 {
 };
 
 &usbotg1 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
 
 &usbotg2 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index e29907428c20..692ef26fbab3 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -106,11 +106,13 @@ &uart5 {
 };
 
 &usbotg1 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
 
 &usbotg2 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
index 166a0aefc869..f52f8b5ad8a6 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-iris.dtsi
@@ -117,11 +117,13 @@ &uart5 {
 };
 
 &usbotg1 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
 
 &usbotg2 {
+	disable-over-current;
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
 };
-- 
2.38.1

