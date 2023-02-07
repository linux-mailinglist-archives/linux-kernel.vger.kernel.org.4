Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661568DC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBGPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjBGPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC28B760
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so13384864wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM6mE5QQJpoqds1gCo8qiNxsAn2F9Tp8VH6d29xrfwI=;
        b=msjrh5RvSQF4TO2MTrbvAdH1SIzX8qirZgDIqT8zPGcCttBfBO2aKJYczm3tLgINYf
         Qm25Gpi4sx6LSXODawg+CUcgeHy1ocbhFJS+XNuRN3oH5Cr1RgIEV4hGyqdYK9tHwE/h
         DjbL6fvtCi0yLcoFQSoDLjNvYN4VfB0V1oKL09Xm3vzldoxc6xnkZnZ5VTZhXVaFaEJz
         0BF2I2V/bIVxRidQWq94ip9VSrx8NF3uIstW8TM3f9W/aUs0HyMLXfORHoOEdBowRlvn
         prNCA+K81bYSgWchPkqiLDkNOZu96hdOhfhnL8wEbmwSL0SHy+EBZdx/6Ovmm3wSNCRU
         Z8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM6mE5QQJpoqds1gCo8qiNxsAn2F9Tp8VH6d29xrfwI=;
        b=gIjpd4bJ3/PW0U6WJ/Y+IkL+1Rk/Heo+V1F3ADoTUjJ4j4W2G34MfYd0fgd4IsTPdO
         vUWZKEndWqZqrpVgQPWBHvhA9p8q7At/AwU/Kvz2Hj5UhNyds2QpDmAgocybyQzh1Pl/
         bGkz7yyXgcVW5gJpJezfavXY+uMVFN/8XELG8Ox5eQqidmYDBGUwwn+8sjzCq8DHil1P
         mcSZNWgmvrJdqHg/Vdh1DpnM32d/m7vcgGdaA9aqQnlpH569ulEA5znrUJUkasvMT+6i
         /ww+pXjloyMXCJK5x4BWa78EytdZUTrudIudEFngVY53ZSyewFYo9773KKDc7g8n/DRt
         dA2Q==
X-Gm-Message-State: AO0yUKV8hGPNBdMr3auGOfv24pwIlu3t6uhrXGB3jxvJI8ewQzURW1Tk
        +GoVxGICwXzJcRr8A58YJxCRMQ==
X-Google-Smtp-Source: AK7set/JcKh5pGWXFRtFWAidVapjfTFJ5cZn5R7xUcLHFuz1iVF/XQN7UBuy3Tqic1S84xzLspt+Fw==
X-Received: by 2002:a05:600c:502b:b0:3dc:c05:9db6 with SMTP id n43-20020a05600c502b00b003dc0c059db6mr3321667wmr.33.1675782501689;
        Tue, 07 Feb 2023 07:08:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:08:00 +0100
Subject: [PATCH 7/8] arm64: dts: amlogic: meson-sm1: use correct
 enable-gpios
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-7-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace enable-gpio by enable-gpios to match the bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
index e1683e0630b0..17045ff81c69 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
@@ -105,7 +105,7 @@ vddio_c: regulator-vddio_c {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
+		enable-gpios = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index ddb1b345397f..2fce44939f45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_5v>;
 
-		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
+		enable-gpios = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 

-- 
2.34.1

