Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEF640625
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiLBLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiLBLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF21019;
        Fri,  2 Dec 2022 03:52:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so6100901edc.13;
        Fri, 02 Dec 2022 03:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V7DGE39pLfDtpE6nfiaaKVKzntw4VUS/Inc+Ohx4WpQ=;
        b=SwYGBT2S6+aQVfMDUC6h/9BMQR7Aa/rv/nZKofiHLvTU/0Q4vEdenr2xH0AK90Iu3N
         Q3c4Rzoy1RPYQPbuhxIHjA2D6XXPWzkdpKFqM8lSRvv9+Ts7pEVAbvC0ujDR3hSQ5ZxN
         vD3uurUCf7q8gTLZVVLJ+a+GBp5jmkXigxdaU6jT1DHYEUuZHb5oDdpzCP5CgF6Z7B5O
         u7NAxl3AwQzRLkzS/byhochh/uO28yZGlEcUMh6vQnzjLqxrytmc3WlVT4i235L7vWAd
         0gGeloQm/h47sHWQc73VFtu7SAPAB5bpqEY5keAo9pYSeCsiCSyH8qJzZFh0BdC5Wlh+
         A8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7DGE39pLfDtpE6nfiaaKVKzntw4VUS/Inc+Ohx4WpQ=;
        b=D/pQgzduuNDMeuITvbTTfc0fz2HM1Mr/R/yDr+ZX5OARUu6bYYL6F2intTTklsPlQp
         a4aVVN/pc9HVBjSm8ZLmivAnc0VMTYk4d0wzBKGiSVMl5nKvagM+DSaE5a8KcqDTw854
         EEPL+UQeOPK7YACoW+pxRWxQMQLalTpizLWmpKsNASRLJwmaKpctdi595mB5daNFVqFb
         9y4pbcw7hCImKigV2BhODT2Sa4vYQtWpnmht7x3lVNOO86ddJSj6KjYGf0dDms08sYQb
         z3oog9a9hlhUUUNM68bvUoTFsYkcOFj7qRf0HlBApRNrmVz6mB7O5Pgdyij/xM6jq1+q
         RezA==
X-Gm-Message-State: ANoB5pmuckgeOyp17ERcVQub4I53xfLoY3FHbRf1TPTkDuhbL53CawTq
        Soh3Z5w86CSQLOG8m91IP7c=
X-Google-Smtp-Source: AA0mqf4pKF+GIFOv0aOMCQp58IrKzGzJId6KW1UCp0ZSXlFh3tlc5fcL6ng1NZL1EdK19TM8zWr5uA==
X-Received: by 2002:a05:6402:24a0:b0:458:ad54:20d5 with SMTP id q32-20020a05640224a000b00458ad5420d5mr62176585eda.86.1669981954534;
        Fri, 02 Dec 2022 03:52:34 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:33 -0800 (PST)
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
Subject: [PATCH v6 0/8] Support for the NPU in Vim3
Date:   Fri,  2 Dec 2022 12:52:12 +0100
Message-Id: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
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
v4: Add warning when etnaviv probes on a NPU (Lucas)
v5: Reorder HWDB commit to be the last (Lucas)
v6: Add patch to move the power domain to the SoC-specific dtsi (Neil)

Regards,

Tomeu

Tomeu Vizoso (8):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add G12A NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: Add nn_core_count to chip feature struct
  drm/etnaviv: Warn when probing on NPUs
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
  arm64: dts: Fix NPU power domain references in Amlogic G12-based SoCs

 .../boot/dts/amlogic/meson-g12-common.dtsi    |  9 +++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  4 +++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |  3 ++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 35 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 +++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 10 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.38.1

