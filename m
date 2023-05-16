Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0670555C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjEPRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjEPRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:48:17 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF55A5FA;
        Tue, 16 May 2023 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NwKDN2wROXKQZ2KQl5DJ4omg17om01ewgOzriNwmhpQ=; b=o+eKAF4DKB2NXA4uiJKvdRv4++
        Rhk2UnZpDCeIDcXdP+wEiy5AcER6TtBerveeVkIIR1OiDsycPHvIu3aWyITi6aLtW+M8LAaWr0YWy
        UJU8MWqHXB7xKYFhijtrpDkyIgtAyDwOfbNoxk6xcaVrsGtJm0rUwjncKRcmClVz//zAZHHweN/Np
        icdWOhYK0mogyr4MgscWYZTT1q3NzZsSY/0ya+nVeMlxzCzzQy5wxanxeWPBilJe44lyJtz8qnfL5
        eeHiTS+WNBw3vpeN0djduxrE11+zVEENRY4i3sl8ETBjwBmV5GqKYJQX6ie1UGvfmjGyrqenq3NrT
        jRnNIjlA==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pyym9-00GMu0-L7; Tue, 16 May 2023 18:47:53 +0100
Date:   Tue, 16 May 2023 18:47:47 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/5] ARM: dts: sun5i: chip: Enable bluetooth
Message-ID: <08eb325e3332441ea102da109acb22557d12de89.1684258957.git.noodles@earth.li>
References: <cover.1683719613.git.noodles@earth.li>
 <cover.1684258957.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684258957.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C.H.I.P has an rtl8723bs device with the bluetooth interface hooked
up on UART3. Support for this didn't exist in mainline when the DTS was
initially added, but it does now, so enable it.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index fd37bd1f3920..4192c23848c3 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -255,6 +255,12 @@ &uart3 {
 	pinctrl-0 = <&uart3_pg_pins>,
 		    <&uart3_cts_rts_pg_pins>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+	};
 };
 
 &usb_otg {
-- 
2.39.2

