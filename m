Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494E6FDD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjEJMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjEJMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:02:18 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 05:02:17 PDT
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED444ED7;
        Wed, 10 May 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z8H44rBFTZY4TjUWBjN6TrB1XXhRt5aeYvbMpCw9dXc=; b=umz3uG+c8l/FBlg+yh4/xaC1Zx
        cx6v/g0gitksL1b15tseps4BYnsdNDLhiF7OoeQaBLwqIGYqgmh1f941M6ml9nOgqWxrKDCbOfuTo
        pAW/eBRHbKiYv+l13qFHxsF3bNiKbvSyiQvMcfyEm2EtGVCYVENtoIWhHjlCh79gbhHdCbONx1DVX
        KdSy96olRByAMPO4wVSLv28Zu6lJVwnefohEone4TyJ+3BL46inO5h8cQq+nJahXJEtPCIBEmP5hU
        cRTB25iF6ihoYrci9Hn+PVP1csBmRi5Cp103GdHjFldUKVNIQBxSwPPA3YZTcAUVT7qmDrAC/RcZe
        DUJp0voQ==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pwiWF-007uiT-CU; Wed, 10 May 2023 13:02:07 +0100
Date:   Wed, 10 May 2023 13:02:02 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 4/5] ARM: dts: sun5i: Add port E pinmux settings for mmc2
Message-ID: <7949169f581cab37175602188f44bc26e79a45c0.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683719613.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These alternate pins for mmc2 are brought out to the 40 pin U14 header
on the C.H.I.P and can be used to add an external MMC device with a 4
bit interface. See

https://byteporter.com/ntc-chip-micro-sd-slot/

for further details on how.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/sun5i.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 250d6b87ab4d..ab7f675aeec4 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -517,6 +517,15 @@ mmc2_4bit_pc_pins: mmc2-4bit-pc-pins {
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			mmc2_4bit_pe_pins: mmc2-4bit-pe-pins {
+				pins = "PE4", "PE5", "PE6", "PE7",
+				       "PE8", "PE9";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_8bit_pins: mmc2-8bit-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 				       "PC10", "PC11", "PC12", "PC13",
-- 
2.39.2

