Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85DE5F223F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJBJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJBJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4C23162
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:02 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu25so12787050lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bn11ROdfdpwm+pLhcHHe/jAlddmxiu8wNOBInX3vz4w=;
        b=GU5T016DesMRb9PWPeNsraKqC6o3gment/4VYhGD58OgdKU09S5jsltpJEvZvLjECx
         2H9vElfbdIhRAOeALFeqbwNUprSnbkHx1VhSQ/dVAeQACQmFI7EthGCLNk11U5eGT7qG
         Co8IYFKnfA7aAbmXfBNdZr6mTpE1ViHMcHSWQAeSX5RNJAkwW1xZIb235UEtIKmOs1XX
         9rJrdXbe9zE2HYGYzo1y1g6lwGny8J0EAdJtrpMEZpz+omhDeZkgQzv51M6IvHAn7cP9
         fmxWU37f8ECDdeTMq/u48LXaYJsIlLQu3e1JZea2HoTLiMnBf/Kp57zRJ/3yzYuK+SFX
         h/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bn11ROdfdpwm+pLhcHHe/jAlddmxiu8wNOBInX3vz4w=;
        b=oEtAQDpWAch5MEEn1hr9sTbHYXQA2jZuT3SLxQ/+9JU8rkzt79wkfcu0Bvu+TnYRDL
         wko2TU14IZ2LYtO4deJ6YTKpM/xNFf9Qw9RDf21Glea2rWQPFWLd9rypAOmKKLzS9gjt
         dalb9kvHmyaE341ZbrRsXGVvULQN3/gEugEmhC1wSfEpqTKzjeM/0qNBt5VRXGK3hfBa
         xEqiAkgqfZUnovCP11Dt0e5V5bFg8XTDDE/BBdvUdCKGgZXnjlm8bkF+ALByVmDPBAPV
         5sEjZZQyo+xatVj+/k6yU2bEba/JNectIm6hZn+4RP55moNt/2HOGsPNf92QVWEk9YH0
         dCWg==
X-Gm-Message-State: ACrzQf26rMD1gmewwp4ZWslEOTQeYseCgk7fs9ASHaAkVDoFE4lxfXXo
        ApnSYXn6xCRJPj0v3xB8QZu94A==
X-Google-Smtp-Source: AMsMyM4w+lYlLKZZhbkKGhO/XiQI77DNkWVpKV2Sw19tp3osAwXYr/rhRfgU7y37lA5+ODq/z3Ok9w==
X-Received: by 2002:ac2:5384:0:b0:4a2:3a45:520 with SMTP id g4-20020ac25384000000b004a23a450520mr440227lfh.560.1664702400558;
        Sun, 02 Oct 2022 02:20:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j2-20020a056512398200b0048ad4c718f3sm1026393lfu.30.2022.10.02.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: sunxi: correct indentation
Date:   Sun,  2 Oct 2022 11:19:59 +0200
Message-Id: <20221002091959.68815-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index e899d14f38c3..1d1d127cf38f 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -89,13 +89,13 @@ switch-4 {
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
-		      compatible = "regulator-fixed";
-		      regulator-name = "gmac-3v3";
-		      regulator-min-microvolt = <3300000>;
-		      regulator-max-microvolt = <3300000>;
-		      startup-delay-us = <100000>;
-		      enable-active-high;
-		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
 	wifi_pwrseq: wifi_pwrseq {
-- 
2.34.1

