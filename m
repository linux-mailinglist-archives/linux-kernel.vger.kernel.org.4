Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666BA63EDCA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiLAKbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLAKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:30:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA117E0D;
        Thu,  1 Dec 2022 02:30:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so3096875ejc.8;
        Thu, 01 Dec 2022 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b6S0scQh8yy8m15dX2Y4lOBnYQdGXad7fSn2qrpTdRk=;
        b=HFcyySkPqaTM7WBiMKlZeWgslSqeqpLPwySBhEvlh80264v7CzkSuBaMbhEX/C0Lv8
         759cQ5lN9Q4+zZd2pxh/WhTBAYMgx6J9bimo23yhBDYKWmCONcTeIZ3WkuPbp4mY68Rs
         jbyAqWPRz7DNe60YBJ6iIB+8no69TZvtEewnV525c2K70Y6iptETbQty4DLTChFHwo27
         H//Mgfh9Q8x2ZAmjS+wHf9NCHIQ2mn8kKGY1Sk3dYRAhn13VTEepvZ1v+uNrXVpLLQnC
         lYdfDjmtVVIoXL1K/Q9PpGeLwgDSjwS/rFhZW2iEzu2Rhg7uvq1TNSGK7v9pYDRMRs1I
         FjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6S0scQh8yy8m15dX2Y4lOBnYQdGXad7fSn2qrpTdRk=;
        b=he4nxTZnmwh+OU8CNQe99kK7b5NKxgDalcjpuIv0NeljVXePL7EVy6qyJmCrZh7e2+
         KsDuMgeiEhHhFvdNddjr7XoaHhn3QAVkXcdYASn94K0dMru2TFbHsu/Rm1oIRF+9Rce3
         gDIK2kb/2j5zNMtLiDKwTJ67vte80kAgCDyD9mFbY1AphSWcCQlRb5685O3vNXB+jBEB
         GxTVJ67MxQwUjIfcULHX9BfynY888RwqPwttHbEaKIpASx3uyj3apiIf701AScQAkJnM
         yA8jGrEdQROvE2FVASM4g37H0ahQBsNt0hgM1YvjNpdARi8b6gzrc9vHTjz7IpvNzo9D
         hmLA==
X-Gm-Message-State: ANoB5pnnARueu2ad4uiI+FAlh5PesfAGivYuluHOa1yCTc1Z90rn5UOs
        xQBhBhP832dkj1xwo0tFhhM=
X-Google-Smtp-Source: AA0mqf6Ku5iWPl8X7VDR/8A9LQk+tuRf8R4xRAp9qx7nZWslQnUcAyrE5bu2txEmOsaNWiv265OUag==
X-Received: by 2002:a17:907:11cb:b0:7a6:598f:1fb1 with SMTP id va11-20020a17090711cb00b007a6598f1fb1mr56078222ejb.606.1669890653698;
        Thu, 01 Dec 2022 02:30:53 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:30:53 -0800 (PST)
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
Subject: [PATCH v5 0/7] Support for the NPU in Vim3
Date:   Thu,  1 Dec 2022 11:30:16 +0100
Message-Id: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
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

Regards,

Tomeu

Tomeu Vizoso (7):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add G12A NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: Add nn_core_count to chip feature struct
  drm/etnaviv: Warn when probing on NPUs
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 11 ++++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |  3 ++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 35 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 +++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 8 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.38.1

