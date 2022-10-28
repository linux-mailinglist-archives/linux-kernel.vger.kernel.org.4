Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D050B611459
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ1OTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJ1OTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:19:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A21E3EFA;
        Fri, 28 Oct 2022 07:19:08 -0700 (PDT)
Received: from Falcon9.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFF796602929;
        Fri, 28 Oct 2022 15:19:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966747;
        bh=m/1hch4d/QsPLuNqP8lJpPMkiEIjR7tmyE3F0XJH+GA=;
        h=From:To:Cc:Subject:Date:From;
        b=NO0A98iXxE24KM+jOU28FC8gP4S/ntjkLRyOYis5wAj6kOy4bYhTasScC4Ah+kOF3
         FZJLC15vrNq5O6iiKWgHfVKXPoGYmTcZzaK+DDxCB12tV01UyP9pSRq6IzaSsIc0KY
         F4AeVy2qu/eD6dRk8AH0oXeavAJl7UHnepA5AFh2mcBqBPgv299BGUBwGI/fCX4fKi
         2A4fdKU8OP9pQOqIgIVLJxeI4psydrJewiAmqHwcAxluSjvRSYwLterpz0j4dq1Sg0
         EYSKG3FDmPbmPp9iwySnzOGQreiyimrYpLYZt9B/9ytbZJAUbO92FWktIdVWp05qWP
         JEIb5it3rXqyw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] ARM: dts: imx6qdl-sabre: Add mmc aliases
Date:   Fri, 28 Oct 2022 10:18:11 -0400
Message-Id: <20221028141811.101122-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not specified, the mmc0 and mmc1 devices will be the devices
mmc@2190000 and mmc@2194000, which are in disabled state on the iMX.6
Sabrelite devices.

The actual SD card reader devices are the ones at mmc@2198000 and
mmc@219c000.

Set aliases to use the correct mmc devices order.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 22f8e2783cdf..12573e1f917c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -14,6 +14,11 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc4;
+	};
+
 	memory@10000000 {
 		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
-- 
2.38.1

