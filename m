Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F568C8E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBFVrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFVrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:47:09 -0500
X-Greylist: delayed 2639 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 13:47:07 PST
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7A1A487;
        Mon,  6 Feb 2023 13:47:07 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pP8db-001voz-D9; Mon, 06 Feb 2023 22:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2pugRrrY/jHwIUYNyE6SM2LDsIXpPsZTjyGq9Jd3onI=; b=ReMUsQPqktqw6a46yc2kQ6w+D9
        BHoOWhRMShO/Zku8a9eTpYpYRTp3SoFPGEBORyT0PqkBJaOuJ48DCNmkjuFuKsFijtdciMG+M04wy
        iiGO6NuJ1IXx3OJDs+yS4t1SbmC7cz54V6MW9vUY56tKJez9ftC7NKpGnluS7/iEeAygb01l0Vs2w
        JEadKieyutvSDq+tojjHv0aWVXkZFObz/iq5YwPL83nRuqAhwhOF1Q1fioc4sQh4amg09eklA5Htz
        x/DWdXEavMST9IQErUCkol4VCduJqJJe3ZBw1isFVTIdPTKRgqfaNEORRLsKmJZwVf91iB6gMQP1r
        vuuz6hAQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2pugRrrY/jHwIUYNyE6SM2LDsIXpPsZTjyGq9Jd3onI=; b=eB83DX5bk1103SU9DMmPciicbb
        iMVjNniLEB4aREAiA3VHNQrinomAXwwZQPU5DXy2qxDR3Jdii3Bz7Diz8I7783aBF154l9ouhqe2J
        SjLbVjmBKkIUA525z836H9E55+asQHZ8oUX0ysmb/WwYBboguAonfojn/RjudyE95eWyDjvWbHFsQ
        QW3H+H1bu2yKErhyecrbJoopJMWQCaj8M50rJ8Drjyl6Dp/28VsnhqBgdr3nwWkHajgZ/BRHnVFrY
        cE3g7nrlsH4vn5On4edQ4KlBfqQvAv14xbwrxmnvijP+9ON1g6N3zGtCl1KOen7gN2purnLG6KeVS
        O/Sh7wIg==;
Received: from [2a02:908:1b0:8800:1400:2ed0:5344:b031] (helo=debian-qemu)
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pelzi@flying-snail.de>)
        id 1pP8dY-0005oP-Ru; Mon, 06 Feb 2023 22:02:54 +0100
Date:   Mon, 6 Feb 2023 20:51:50 +0100
From:   Andreas Feldner <pelzi@flying-snail.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per default
Message-ID: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC features debounce logic for external interrupts. Per default,
this is based on a 32kHz oscillator, in effect filtering away multiple
interrupts separated by less than roughly 100µs.

This patch sets different defaults for this filter for this board:
PG is connected to non-mechanical components, without any risk for
showing bounces. PA is mostly exposed to GPIO pins, however the
existence of a debounce filter is undesirable as well if electronic
components are connected.

Additionally, the clock-frequency attribute is added for each of
the 4 cores to eliminate the kernel error message on boot, that
the attribute is missing.

Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
---
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d729b7c705db..1fc0d5d1e51a 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -113,6 +113,22 @@ wifi_pwrseq: wifi_pwrseq {
 
 &cpu0 {
 	cpu-supply = <&reg_vdd_cpux>;
+	clock-frequency = <1296000000>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_vdd_cpux>;
+	clock-frequency = <1296000000>;
+};
+
+&cpu2 {
+	cpu-supply = <&reg_vdd_cpux>;
+	clock-frequency = <1296000000>;
+};
+
+&cpu3 {
+	cpu-supply = <&reg_vdd_cpux>;
+	clock-frequency = <1296000000>;
 };
 
 &de {
@@ -193,6 +209,8 @@ bluetooth {
 };
 
 &pio {
+	/* 1µs debounce filter on both IRQ banks */
+	input-debounce = <1 1>;
 	gpio-line-names =
 		/* PA */
 		"CON2-P13", "CON2-P11", "CON2-P22", "CON2-P15",
-- 
2.30.2

