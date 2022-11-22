Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D816340C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiKVQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiKVQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:11 -0500
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0F7213D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:07 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjd3QnKzMq7gp;
        Tue, 22 Nov 2022 16:54:45 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjd05kxzMpqZJ;
        Tue, 22 Nov 2022 16:54:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132485;
        bh=4aDZ4qVl9DSvXhaDhhjNCUrfEbqzPIInMZAyi4WnsqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vic2WimnxnD18PFjkQjAVahsc6OxYMV0BEEEQr35E7ZirHd+q/USQDOZrU/Dtl01/
         Y2HocKTVQFOaPArDQhP/sYFpXyuU5QkazYw2HUu9Y00qUyzPZlzyFxsyf3+zzpnzxd
         1AvDa0GIDsG3hmBn5PdGyhcNhRphNSDPRyp5M1XQ=
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
Subject: [PATCH v1 1/5] ARM: dts: apalis-imx6: Disable usb over-current
Date:   Tue, 22 Nov 2022 16:54:34 +0100
Message-Id: <20221122155439.456142-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Remove the now obsolete disable-over-current flag from module-level
device-tree imx6qdl-apalis.dtsi and leave it as already mentioned to
the people actually implementing the carrier-board to implement this.

This will prevent the warning "No over current polarity defined" from
being printed on boot.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts | 2 ++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 2 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 1 -
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index fa160a389870..3fc079dfd61e 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -147,11 +147,13 @@ &uart5 {
 };
 
 &usbh1 {
+	disable-over-current;
 	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	vbus-supply = <&reg_usb_otg_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
index f9f7d99bd4db..717decda0ceb 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
@@ -202,11 +202,13 @@ &uart5 {
 };
 
 &usbh1 {
+	disable-over-current;
 	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	vbus-supply = <&reg_usb_otg_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index ce39c6a3f640..f338be435277 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -151,11 +151,13 @@ &uart5 {
 };
 
 &usbh1 {
+	disable-over-current;
 	vbus-supply = <&reg_usb_host_vbus>;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	vbus-supply = <&reg_usb_otg_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 7c17b91f0965..f912697bfdb3 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -824,7 +824,6 @@ &uart5 {
 };
 
 &usbotg {
-	disable-over-current;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
 	status = "disabled";
-- 
2.38.1

