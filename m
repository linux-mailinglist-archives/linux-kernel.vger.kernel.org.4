Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3042D6340BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiKVQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiKVQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:10 -0500
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 08:02:06 PST
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C37208A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:06 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjg41VhzMq8yR;
        Tue, 22 Nov 2022 16:54:47 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjg0WF3zMpqZ7;
        Tue, 22 Nov 2022 16:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132487;
        bh=Y7RPRDcaRxdv85eSDu9iEGiAtGxkmXgrVv83frg2xSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPHkXLErAdYmECbFvecqMoG91x0nJkTuOSBoku8p7B6jS+CI28nlNe3VV6a0b0iJN
         7jwTbJnzIeOZMe8RzexLrLOfj6IBY8Hupdnil7yhG0i/f7fEMwEBhvV6DZdyGFxi8Z
         LtWHC/DNYEw3eiwTCUGs5sBa2H0pT1mRJWqGKTu8=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] arm64: dts: verdin-imx8mm: Disable usb over-current
Date:   Tue, 22 Nov 2022 16:54:38 +0100
Message-Id: <20221122155439.456142-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Disable usb over-current of the chipidea driver on all Carrier-Boards
used by Toradex. Do this as we don't want to use this functionality on
our Carrier Boards and to leave it open to someone who includes our
module-level device-trees.

Remove the now obsolete disable-over-current flag from module-level
device-tree imx8mm-verdin.dtsi and leave it as already mentioned to
the people actually implementing the carrier-board to implement this.

This will prevent the warning "No over current polarity defined" from
being printed on boot.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi        | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index c2a5c2f7b204..0360f6a08d30 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -136,11 +136,13 @@ &uart3 {
 
 /* Verdin USB_1 */
 &usbotg1 {
+	disable-over-current;
 	status = "okay";
 };
 
 /* Verdin USB_2 */
 &usbotg2 {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 0d454e0e2f7c..0680cee9aeb0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -741,7 +741,6 @@ &usbotg1 {
 	adp-disable;
 	dr_mode = "otg";
 	hnp-disable;
-	over-current-active-low;
 	samsung,picophy-dc-vol-level-adjust = <7>;
 	samsung,picophy-pre-emp-curr-control = <3>;
 	srp-disable;
@@ -751,7 +750,6 @@ &usbotg1 {
 /* Verdin USB_2 */
 &usbotg2 {
 	dr_mode = "host";
-	over-current-active-low;
 	samsung,picophy-dc-vol-level-adjust = <7>;
 	samsung,picophy-pre-emp-curr-control = <3>;
 	vbus-supply = <&reg_usb_otg2_vbus>;
-- 
2.38.1

