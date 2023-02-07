Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1868E28D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBGVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:00:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49423F29A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:00:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so11937818wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irbIrM6iNvfIuQkA6dwLqQukM4YTDraYmxUxdEyR37s=;
        b=GEqB5JyFASdGLPzbxIpkO1z+oER7ZUAR2DN8IXFhlHj4i8bTOUqOxTGJ9wHVAjQz2N
         xlWo1Vq/rmNd3X9cw7r2+O765XoiEClUks9FVGOi+JIgjrrtV7OelottDIOLN4BCHqvk
         5Q8VdbJPEjJf8CR/Zh+LJ3XqldrDaYs01XS7E5PirPLDAlmcA+U81Dk6qKEGwXZQQFFd
         rBGeIv+2HcqgWhtlqNGSYK8pzecKMpncwhXpZdcx3IlyZf+Ai4JKYxUYn8bEl0xanNVd
         Cr4Vm71Z8CsaLBh5Ezd8fHB1QZ0D/l9hujGaWljeMnkNDG94wIVmV1069flx5Ht+eQrj
         Hw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irbIrM6iNvfIuQkA6dwLqQukM4YTDraYmxUxdEyR37s=;
        b=ptot8dekRuHUL8mbgnS0fH2c7p4lmcpDPe1NW4Mhvn8a05iAD7Ue3H3IiWxkL1imsc
         +NlbCwLVgE08kkI9fMSVgcMWpmbEiV5LwP32Jal97Y2iuT19aXobDCeDorAh7ZEvn7FH
         g6AeJAz7V9YKGtRvkujScyi9ElHNcwaBPNE200uGZyj67uEgV350e4TnxuJC1eTaMtXl
         n2uheZW16QvchiRavgzUynbpA4YgKNKSt/wzX1trR9RzYTgABXMRXGEnikaVKN2dbd4N
         9e5ixGCLrToJJXW0+jXRim2T1iqnqtYc1/yJ6V2Om/56jZX82b5yOwyVXxWNNlJmMby5
         kK6g==
X-Gm-Message-State: AO0yUKVc2bXvH4/eHz7PXdcogWfZRe0xOJvGihwH7ou+PaSqfTTUaf+O
        e3Hfya52mJhBO7NAKYSDrBd2zg==
X-Google-Smtp-Source: AK7set+sdfgLYI6dfxPAmLNIPWUH1XP6v7bZUAe3btCu3pKRbvYcq4Ya1tDOI2+Wo7ujBVskEk1SVw==
X-Received: by 2002:a05:600c:a686:b0:3e0:fad:5fa8 with SMTP id ip6-20020a05600ca68600b003e00fad5fa8mr4269672wmb.33.1675803629390;
        Tue, 07 Feb 2023 13:00:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm8041631wmo.19.2023.02.07.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:00:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/7] ARM: dts: exynos: align status led name with bindings on Origen4210
Date:   Tue,  7 Feb 2023 22:00:17 +0100
Message-Id: <20230207210020.677007-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "status" is a reserved keyword and LED nodes should have generic
prefix:

  exynos4210-origen.dtb: leds: status: {'gpios': [[76, 3, 1]],
    'function': ['heartbeat'], 'linux,default-trigger': ['heartbeat']} is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 5f37b751f700..1103e7f92b57 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -85,7 +85,7 @@ key-menu {
 
 	leds {
 		compatible = "gpio-leds";
-		status {
+		led-status {
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			function = LED_FUNCTION_HEARTBEAT;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

