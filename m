Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8956A613BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiJaQrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiJaQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:47:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6D12629
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so16841913wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=jxq7Kit5ewu9alvw6v26dSql8rnzDq0nCvqHaHXZbsc=;
        b=BLgwe1DfbNcToNja0I5ablkTHUZTolxvc/J+2guV1ofgW2O0ZkmzsTV+rbohlGCiMO
         6alYezYMn3i1bUec2jl8HIBLbZsSTOPEIuUmgumFBOxKb8joazGFaf81bqFWbGKu8lcQ
         kq9WQo4RnI8nX8ANFFXx6p+bIzoN/j9Bg/n63dyNS2TiCEOrnZVHX3gswMnmkBqy3CLB
         Tv24Fklhb/f56VQKGKx/vvhTMV98yd0SSWhu/LHi5kZRarR6Ncw1i5XgrznM0opIg1qd
         d7nBoVcBy6l81sY1EEvv4CNgFx67bYZq6l6ZOD1kWHVi4JvCOFAAAoFn91k04Z/mr5Nb
         +zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxq7Kit5ewu9alvw6v26dSql8rnzDq0nCvqHaHXZbsc=;
        b=2v+e8SAylv2ZTqDBIamK6PHHXw9uU5HKhXY/hSl4VCcazf+GDOLHVKQ7ZUQUsSTh7t
         STfAJvpZn+lkU+x5IOXXPlN+6Z/EBFEkVjpYWS9BG0FKU+ilDyr8OziHY0YeYkLtSWnP
         O5ZOVGKUmGOHZRbiicQOE0UD916288BALSJA+6Z2wid0KpkUUUM1IP+8S2xbkWC/B1nh
         RzBd1xKoyVN8x8eVfi6WkahvGckI8TbNfG0rvDJE39puXAEWhxkdmCBN/CSFjfJc8I2a
         c2hACIk+mMDj/tQLPRlI7Bfdb+derCYKyHRqSqxBb/YGz+aS6hpb8uzl8eh69pjliQE5
         T6kw==
X-Gm-Message-State: ACrzQf1N8rhavyurecBaV7NLsGly0cHOhHTuemBTaO0H1XStg+7PBEPc
        dM6Cif+rPpRPatbpURdhkeEw2A==
X-Google-Smtp-Source: AMsMyM4uCIJl5FzuUBvAx55rrePRHBWvJHlDInwsB5i3biXxKtWVuCdFt25ddWPZhDdx0h3GVqlyzg==
X-Received: by 2002:a5d:6d42:0:b0:236:c9a6:5523 with SMTP id k2-20020a5d6d42000000b00236c9a65523mr4378601wri.222.1667234847726;
        Mon, 31 Oct 2022 09:47:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003b4868eb71bsm7488871wmo.25.2022.10.31.09.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:47:27 -0700 (PDT)
Subject: [PATCH 0/4] arm64: amlogic: add initial Odroid Go Ultra DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABz8X2MC/w3MMQ6AIAwAwK+YzjYREAd/U6DRJqQkRV2Mf5fxlnuhswl32KcXjB/p0nTAzRPkk/
 RglDIMfvHeLcFhWrEVa1LwaHjXywhF5RKqGHmLuXBkHwhGkKgzJiPN5yj0rvX7fvF2aJ9xAAAA
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:47:24 +0100
Message-Id: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for the Hardkernel Odroid Go Ultra.

The Odroid Go Ultra is a portable gaming device with the following
characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

The following are not yet handled:
- Battery RK818 Gauge and Charging
- Earphone stereo jack detect
- 5inch 854×480 MIPI-DSI TFT LCD

This adds:
- Poweroff bindings
- Poweroff driver
- Device bindings
- Initial device DT

This serie depends on:
- https://lore.kernel.org/all/20221025-rk808-multi-v2-0-d292d51ada81@linaro.org/

To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (4):
      dt-bindings: reset: document Odroid Go Ultra power-off
      power: reset: add Odroid Go Ultra poweroff driver
      dt-bindings: amlogic: document Odroid Go Ultra compatible
      arm64: dts: amlogic: add initial Odroid Go Ultra DTS

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../reset/hardkernel,odroid-go-ultra-poweroff.yaml |  42 ++
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-g12b-odroid-go-ultra.dts     | 730 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/odroid-go-ultra-poweroff.c     | 122 ++++
 7 files changed, 904 insertions(+)
---
base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
change-id: 20221031-b4-odroid-go-ultra-initial-5e65cde5e23a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
