Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4A63BC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiK2Ivi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiK2IvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11874198A;
        Tue, 29 Nov 2022 00:51:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r26so16714586edc.10;
        Tue, 29 Nov 2022 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EAwbcSycvljMKPe5ABsiy+cIxMkpLo2gUjI9R6uNdq4=;
        b=EFlFtRGjVY6hb45LYjfz4PKYSY8/eYXCDyH2jEWI+6o8+OWi5V8XhsyAL+pxN+iqwF
         JX1bgxltZTtg+XpbSCDvOeZ9WXsuJHdatr27JZRN9XqqmNcIAjk7Y0MZkVkLAyMQr8LA
         990qsOV9NVsjmRFs5iQ6x8HH6XoWFHWlztUXrFoLMrs3o8kIsHGcLIaaQan6E/Lputu1
         nKsNOWZNVdRTWH6cOJ5YJEjOtQQKqsZcp5spPCKfZvGqJQgZ4Bp9JVlhb4JMxvA2Ujnj
         eg3a1PIJZeRfxkP3OOgqMdAEQAkjUdnOtpkhIJ0aHSvxO8KweJtdH7BCbTxdX6X/iH0d
         Cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAwbcSycvljMKPe5ABsiy+cIxMkpLo2gUjI9R6uNdq4=;
        b=nqO0IF59wvrpy8Haccg3wj3cO8cI7ZaUA8zWvxCtJcEn+9NnpKeEx9UOrHo7P5narD
         g2e1qektyvHoEmD8G2UqWICpGlvecZGWjtN2ewFtkdy5llFrjoZdOKIP3VC69F5Rd4D3
         HSL9WD3Kx1etH0RnC9y4v2+2MRMKmkfPMKXSCwFHqieoLLeuTIdOHeHaucQkw5hmXPTi
         d/weHJbXxV5mR+3ayidl5WP2WoZCQNbPAL9TOLIR1AQwHpcJbf1hg0FyBYPwlsy3B8Sf
         rZAw8Xb0+sAm2AdOxo2kf6NPnOxShqK233BrG/65w+xRDdt9X4+Eouq/cMecW4DS9nyt
         DQIg==
X-Gm-Message-State: ANoB5pnryxx94ijTajxEjaPUfw5Rdaaj/43v2UY33iwVkGN6v5/k5BLo
        PG82qV+Y3ivTkiL6/5v7Fcw=
X-Google-Smtp-Source: AA0mqf47u3/yt28Ofv/5FqQdI2MHkbIfMEKktXtQYWe+me4por6kkPGitzwX2sTe4moLj7hZE7ipRA==
X-Received: by 2002:a05:6402:ea8:b0:462:67bf:c64e with SMTP id h40-20020a0564020ea800b0046267bfc64emr37911025eda.20.1669711871270;
        Tue, 29 Nov 2022 00:51:11 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm5873219ejc.114.2022.11.29.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:51:10 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP),
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP), Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support), linux-kernel@vger.kernel.org (open list),
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Subject: [PATCH v3 0/5] Support for the NPU in Vim3
Date:   Tue, 29 Nov 2022 09:50:40 +0100
Message-Id: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the Verisilicon VIPNano-QI NPU in the A311D
as in the VIM3 board.

The IP is very closely based on previous Vivante GPUs, so the etnaviv
kernel driver works basically unchanged.

The userspace part of the driver is being reviewed at:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/18986

v2: Move reference to RESET_NNA to npu node (Neil)
v3: Fix indentation mistake (Neil)

Regards,

Tomeu

Tomeu Vizoso (5):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add G12A NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 11 +++++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 31 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 ++++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 6 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.38.1

