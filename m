Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4450369735F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjBOBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBOBRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:17:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52B3400D;
        Tue, 14 Feb 2023 17:17:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j17so25823882lfr.3;
        Tue, 14 Feb 2023 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xckzojwyNuatglXQ8YBBBb8WXJgZ0AoA0JB30UI/Xs=;
        b=OgYp86eufa4KJDkPuznprFyD9bBb5XXjiNsIs6ic99AHYTTPSVR/1RXGmuIPcBnVZS
         S2thwIhTULgtlMFbIaDQSlEPApuegu4bG6DVC4jyz/cF6PHIm7u1Dk8yQsuOmbXZiggP
         T+S4q8Ma+sqAn6g5ffekiyI5OPuEZR3C0KVYxyjmE07jpiEm9Bjkx6upNOSuKv0aktoa
         LGl+MK4WWemu2Ghtd9I8WVd1lIc9W600tp+BIMw1myFzATAX3r5bAHzXgYnUaMzQtW1W
         +Pq4fPZbfDX50Utvo2d5I4SABLTUDlBdeQxaf9Gzjk4Xi1yBCOJppwI6bSfqhktn0XFv
         nbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xckzojwyNuatglXQ8YBBBb8WXJgZ0AoA0JB30UI/Xs=;
        b=Ajf45M47y+YR6m+y0XxwAPiMQM3ad5YHmowaXHa37i4cBiDLRveNFFrkwLtSFtP4qk
         IW0X0HxIdBVLMeOrUwX7d2qNZ3X67JjakidKpdnK0ikbpRtYJbxSevH7rpzgzyPLBfJY
         cshbAbxib8rjzMtuIHJVYz9WkOpMhfxqY7ZDFuehy2o1pK0XSn5cqK/j2MOp4jf2hJoS
         JfRbc3IxGpN3EuQJDYDWm7CtRg4EEEx+68TOAY38JR3lh4Y81gfockjQjD9T7fnhk7/Z
         sd6AdMF4E3AHDzA6HisNgzDRNxxGowZ7bmvM1WM/TBbwcGnTImpz7+Zd6K/Kwta3znNC
         JAtg==
X-Gm-Message-State: AO0yUKVNsHm6l9VLQB/8JbwuRIgE4Uk7JQksT92EtM6bjiTIFB+s4Q+K
        7jSYefSdC+PtpNCQx3pnRp5Ej47WhBOxIQ==
X-Google-Smtp-Source: AK7set+MASCAI4zdR7KY8dZVKqdEdoQgs6qmT0L36Iv2j549YbQiS8O883w1aFN1+K4OobCJghWHVg==
X-Received: by 2002:adf:fece:0:b0:2c5:5ff8:6b01 with SMTP id q14-20020adffece000000b002c55ff86b01mr112414wrs.1.1676423357323;
        Tue, 14 Feb 2023 17:09:17 -0800 (PST)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v15-20020adfebcf000000b002c3f81c51b6sm14198505wrn.90.2023.02.14.17.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 17:09:16 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Always enable sd regulator on SOQuartz CM4IO
Date:   Wed, 15 Feb 2023 02:09:14 +0100
Message-Id: <20230215010914.104754-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3.3V line coming from the SDMMC regulator is required for USB
on the CM4IO board. Without it, the USB mux (U13 in the CM4IO
schematic[1]) that's used likely remains unpowered, and no USB
devices show up.

The consequence of this was the behaviour of an inserted SD card
allowing USB to work, while pulling it out turned off all USB
devices.

[1]: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 263ce40770dd..88a61fa8a95c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -135,6 +135,12 @@ &sdmmc0 {
 };
 
 &sdmmc_pwr {
+	/*
+	 * USB also needs this regulator to work on this board, so just enable
+	 * it unconditionally.
+	 */
+	regulator-always-on;
+	regulator-boot-on;
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
 	status = "okay";
-- 
2.39.1

