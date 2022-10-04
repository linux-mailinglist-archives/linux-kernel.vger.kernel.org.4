Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D605F41B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJDLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJDLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:11:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A6C20BF0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:11:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso7310873wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=waeAw6nVidn2Z1MNuWBA98zRNurIETpUSmW37z7qEow=;
        b=yIX+mYN38FWzX6famWPBlf9ZjebH6HRHJsjfU85oeBOf+W/rt1cZsAqZlWRjgypd6l
         AaCt3PCxYFdJwoi5u2DQh2CcYX8WdA6w6PPv0o1QnoSJlXvLGiwdIpqjsTZK+ZIi0moz
         AGF6ykziPJ4uatv1slw4SzvYmC6wgnjnluQhPn1s6y8YK6gYctzZCLAJcakluygUwuYl
         AJZaIwiYGft9j5IGHKAuvCqIwOks8AMgqO67tmEtb83aNyWc6S6WEkiWbKfcjur693zm
         LUEHfK0x75f8BvId59bargoIRG0qeNQiH9sUWsA9Oq5JyYG6i84IMM/Af7cdW5kiQKBN
         BnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=waeAw6nVidn2Z1MNuWBA98zRNurIETpUSmW37z7qEow=;
        b=pJOgUrqH9Dk/c58aIUZhSeGIbcg6cEizqXxu8N8reYqfxu9ncJTzNdIsSr2Yv8PY9J
         wVG8s13C6YhVjGsZTVVSE4bdMITviIV58VG4iOgoFlR6DM1da9iG6Ei0wevvYmNymncz
         MIHoc2YzoFOV2UjJnbSE7NwJcFW6nMOj4dZ4Wij6hez45HiKXV1iHYmt4xhKXmtwGZhT
         C+ctg/u8I14xYSwltv490FroKsWBAMtak4lvSY0vLIRxNpezYoEjZnjLP1fterS9WEKZ
         jhozJf9INHYEcOai48XufspJ3GY8atfEmPVZdWYhgtN2TYvw9HmLNh4sXzSZcj2gUVrX
         H0dw==
X-Gm-Message-State: ACrzQf184sAIX2K0rqvJsb1kDcvA4CmmBTUKkjQ75Sww3zrZxMSqjOs1
        2Crz4JsgXuvtqARBPY74TJWQLQ==
X-Google-Smtp-Source: AMsMyM4GDoHyu4UZ7io9nYEgf80EAUwwovWZCk9y/nryGemAgMOivGSbU4BH/Vm3d7iP3eMOKadaCA==
X-Received: by 2002:a05:600c:2d05:b0:3b4:7788:9944 with SMTP id x5-20020a05600c2d0500b003b477889944mr10038438wmf.57.1664881889852;
        Tue, 04 Oct 2022 04:11:29 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j2-20020adfd202000000b002285f73f11dsm15361698wrh.81.2022.10.04.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:11:29 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 04 Oct 2022 13:10:36 +0200
Subject: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names
 for SPI signal states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664881888; l=1463;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=Ke2EUTvINs95mUpMERJPIoATA/4M6T38d1rluEloC5g=;
 b=2poaN2OdU4FG83mvQ9Vu23Qhg4fzsx1Ttji06klA6qEItdVkv4ij/xC7b5ya7IZxQTnI4p/+8wxU
 rRm7TLkJCRCqkcQq92Xu2BH2C28nvEhr4dc8JPV03tM9CKmSaODS
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
pin biais when idle. Therefore define three pinctrl names:
- default: SPI pins are controlled by spi function.
- idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
by spi function.
- idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
by spi function.

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 0c10f7678178..53013e27f507 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -43,6 +43,14 @@ properties:
     minItems: 1
     maxItems: 2
 
+  pinctrl-0:
+    minItems: 1
+
+  pinctrl-1:
+    maxItems: 1
+
+  pinctrl-names: true
+
 if:
   properties:
     compatible:
@@ -69,6 +77,13 @@ else:
       items:
         - const: core
 
+    pinctrl-names:
+      minItems: 1
+      items:
+        - const: default
+        - const: idle-high
+        - const: idle-low
+
 required:
   - compatible
   - reg

-- 
b4 0.10.1
