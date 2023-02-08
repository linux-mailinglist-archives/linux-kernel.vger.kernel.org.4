Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2E68F3C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjBHQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjBHQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:49:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9046712
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:49:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so17383825wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3G/Ec/I67LOBTN0hvlN6I7gSKlKYim+l8P/Jf3IE2g=;
        b=yAg+i3GxKT4KKCtkB8mGEOx5w9nRB6FYfvtGFDR0kiwqUxT8HQfAJGtnrpnvNzqaTy
         JLsuKN3bwVgushk/7FXG4FEbw+bzrc1RlcnX6N8feFl/bmIHy4gnb9seHRr2BZTLJ0Gg
         M5uDQsgYcrGXImVzbBqxLW+Qp8ymxxQac+dmk+szDk5R2tsG8qHBHxd3ddzrKkwwDMrH
         bHIHe7UDXYzQO0w2SVeh9cv1Hx6g8DGpW7obP9cA3/qzM+6xzvvm3bTiOhz7PB3pzRhf
         bTdr+lL3ZXJ16+Nt/029aajb0gfsyIUk9Cox9EQkOFnH/zxbHuCCPU3hQiflalxQCm1O
         Q49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3G/Ec/I67LOBTN0hvlN6I7gSKlKYim+l8P/Jf3IE2g=;
        b=7C0W0TyEq1pCKBp9BVkv8EOFLu6ul2ayBgdNjFPteZ75xfWV7Sd8EWo5CIp8zV/Sqb
         Zd7UU00IrhrGaRMKEhnlF3EyASRmVfqGSkMHzhTwaj6TrZQhvH70ZCSDOHf+mQIpdYvR
         8PJZmgMaoYymgX0Dao95SbPqx09q8OVL4p7/MklDgNa9a0cgJ0t2iz/a+jfgm6yi7778
         X2c2CQwIqDdjoYxiVBfJKLvOetrH3mhryC5eroNk0uW9PCOgnEOSyGDrLzcldmDukHwV
         M69izeHl9UOicnqFmLa/9B32XHfIWlGbv/eB4ft+JnTfbNt/LH24apvRMpOBVfccLp9g
         jmqw==
X-Gm-Message-State: AO0yUKVGb9LP9t4V54VcRCoNKCiegoTTw+FogytTASAEhxlFCGtXR4th
        VWMx14f+YS7KrVCOIclDIHG6Pw==
X-Google-Smtp-Source: AK7set/WYwIT1r4O3G/DdIE9LO+WHY+o8aHwbmptiMaw9gZP1OI0JmP9nMPBms3gxpYGil+i7rIhZg==
X-Received: by 2002:adf:cd84:0:b0:2c3:dafd:c729 with SMTP id q4-20020adfcd84000000b002c3dafdc729mr7162110wrj.47.1675874988003;
        Wed, 08 Feb 2023 08:49:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d4907000000b002c3e306d3eesm9637434wrq.17.2023.02.08.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:49:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: exynos: correct SPI nor compatible in SMDK5250
Date:   Wed,  8 Feb 2023 17:49:42 +0100
Message-Id: <20230208164942.387390-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208164942.387390-1-krzysztof.kozlowski@linaro.org>
References: <20230208164942.387390-1-krzysztof.kozlowski@linaro.org>
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

SPI NOR flash compatible should come with generic jedec,spi-nor fallback
and proper vendor prefix:

  exynos5250-smdk5250.dtb: /soc/spi@12d30000/flash@0: failed to match any schema with compatible: ['w25x80']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 71293749ac48..831b3494bd46 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -391,7 +391,7 @@ &spi_1 {
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "w25x80";
+		compatible = "winbond,w25x80", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
 
-- 
2.34.1

