Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CE679548
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjAXKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjAXKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BA3FF24
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10573611wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WXUqNr0omZn2Rzya6oTYL0L5UK3JiJ1gNmHJWL868Q=;
        b=oEeufaD9IG4HKtBmw9IUpi7PNPFYjWXdfDfZrr79xlRobJLxQonSZJJETp1V09wz2p
         IT7MDFtZ1yu4Fm/Lwr/wTj8apiwgf+Hr952dBVdSjxF5tZUinBPRGJfVFBl+ZrhopX3J
         4DGwIV95rLDAKOx5lVSs69ONN8tNIExvuIPcDBYVZjI8Uytlnfks2h+/NBBjfVr1WwsZ
         WUu/PPtMWJ0XZ/OW3bJr+iyz1Tcez4yV2Uz3W4ZFRbSqsF4iWllxVwK19rHznse1WRWF
         jmSC5kpvv5+sfC6z6ZGHUs1FRpAyqS0GmuBbMzJdVqvUMqQByDjpYhS4v25G9D/m2aJ4
         gRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WXUqNr0omZn2Rzya6oTYL0L5UK3JiJ1gNmHJWL868Q=;
        b=jgq8EemXLsb+zrMV/AIdjdE1h8a45MYRQwOdv3jWuFuM+rTAMOniHadcWtzfZAqYox
         j3zDX4bW9I7eFKf+5Yhoyr32mfyS+7xuzD6lvZ1oTC5bHALSjx4dj2b0C1WU+ZqfvHxn
         D5EuSq5Dq6cqK4cphhMN/BOBbZvvqFlb16nHgahpbJ3gs5cuJCv9120IDOPE6XrOywe0
         uD/nDA9OBELurE/K/2ultw1VREbMdJ/RLcKkA7q+1F7bPxEPZfoyqVqnagN1nozIK4NY
         yV2Cza1AK2kt1rg53yvOZV46sSzMgquuQPesX134y25WEcubYqgmt2bGE8SJUr5I9gAf
         FdUA==
X-Gm-Message-State: AFqh2koeyPjtNkpUQoOJNPm9LYWwYb2oV1piMiExAwqFeoIZj8QuTRJl
        SEjuHJ+DxgTZGtRIsyTY+ReTZg==
X-Google-Smtp-Source: AMrXdXtDpVKI1j8CS7Z1C7IKcQ4hhQiMgTqbZ6FKv/cX+i+pUeg8ggGJYcqvVFicN+gNwKHwuS0qpg==
X-Received: by 2002:a05:600c:1c02:b0:3d2:3b8d:21e5 with SMTP id j2-20020a05600c1c0200b003d23b8d21e5mr27485228wms.14.1674556464749;
        Tue, 24 Jan 2023 02:34:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 00/14] arm64: meson: bunch of DT fixes
Date:   Tue, 24 Jan 2023 11:34:21 +0100
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC20z2MC/x2N0QqDMAxFf0XyvIC2omy/MvbQ1lgDXZQGZSD++
 4KP53A59wSlyqTwak6odLDyKgbdo4G0BMmEPBmDa51vO9dj7DF8y5o5YWSZWLLizL99U/QpeD8
 //UjDCBaIQQljDZIWS8heismtks3vx/fnuv4dYe77gQAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bunch of fixes against the current applied and reviewed bindings.

It takes in account the following bindings conversions:
[1] https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org
[2] https://lore.kernel.org/r/20230124091602.44027-1-krzysztof.kozlowski@linaro.org

Remaining fixes will require a complete TXT to dt-schema transition.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (14):
      arm64: dts: amlogic: meson-gx: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-axg: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-gx: add missing SCPI sensors compatible
      arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix supply name of USB controller node
      arm64: dts: amlogic: meson-gxl-s905d-sml5442tw: drop invalid clock-names property
      arm64: dts: amlogic: meson-gx: add missing unit address to rng node name
      arm64: dts: amlogic: meson-gxl-s905w-jethome-jethub-j80: fix invalid rtc node name
      arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix invalid rtc node name
      arm64: dts: amlogic: meson-gxl: add missing unit address to eth-phy-mux node name
      arm64: dts: amlogic: meson-gx-libretech-pc: fix update button name
      arm64: dts: amlogic: meson-sm1-bananapi-m5: fix adc keys node names
      arm64: dts: amlogic: meson-gxl-s905d-phicomm-n1: fix led node name
      arm64: dts: amlogic: meson-gxbb-kii-pro: fix led node name
      arm64: dts: amlogic: meson-g12b-odroid-go-ultra: fix rk818 pmic properties

 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi     | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                         | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi             | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                          | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts                 | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts          | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts              | 4 ++--
 11 files changed, 14 insertions(+), 15 deletions(-)
---
base-commit: d72a45a4d6ec431c761231e3d8846550a6fc8303
change-id: 20230124-b4-amlogic-bindings-fixups-3ca33f937e67

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

