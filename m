Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC363EC46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLAJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLAJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:01 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58D85679;
        Thu,  1 Dec 2022 01:21:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so2655947ejb.13;
        Thu, 01 Dec 2022 01:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D4GMG59V6FeZymcJDpr/Ed9DLLQeE59Ry2O920ck0QI=;
        b=HSmShfYANbJDMjl8pkqcdgD+IxVD2GxDxg+y3Ge4ZK1rg9vO/pdbZeZOZaiFMKkY8O
         BG1ax4x2uVfk2bcfv0HXXgKiaRThvqzYv5tLa2Tl3vSQR11ZIMwg/0ehIQUB4AISF4sV
         vc1KJjb4O3Tr98nvcTXzuxr90rYQvX5Iv4MO604v2wjCkIYP9yLtOE7Nomx2klxuT2Pc
         VDh4Y/s+Si0rd0BVsLXaRHPNc/QMAcZPxwB34bdgfuJaMQbvx8sKk66W4JJpUoc+Drpw
         4ubmTbp7/WwT3ESDIUix7rIMNeCm9VqH2jvu7je3HYaPaLVMHOt4h8UgTh3b9i1Ozz4g
         4B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4GMG59V6FeZymcJDpr/Ed9DLLQeE59Ry2O920ck0QI=;
        b=wzkHF5oX5hXPasBd4kQSX6lCe0wNkaZb/Ao2R1Ao3k3qd1GuHaGn5rtL+gpKedy+hI
         Gmbs/i/KpcTwWeeZsQUIFpjMBmZG7RIWBHd9DD3pUB4dBcPQJtlgV+1EzBM7kpr6i7TB
         O/KOM+HYfiSvbsBJsmA5QUN1MBrwQE9m6ozH9RF8iayEeDtVevV5ONTUv22Er1SCYtMQ
         Ttnc8uImMyj+EmxGuEsM9EOrHwa+lLa+Oc1PunVIug1jbKSp0EiO3eSs7+VFqtIk58O0
         tRP5ObGp204LL1cRsk5j5e4P1TtDo50lY5CII/jsnbm9iMcMOn0TU98L6avow/8EKQ1K
         tTEA==
X-Gm-Message-State: ANoB5pl1SVfufF1VV1r5vYWgigftEfU6c6CS8NllYYttX7lyxi80On9a
        idvzbBJWZjPGKlTxBtlQAbU=
X-Google-Smtp-Source: AA0mqf6f4lVGT4CKfMKN/i+FgTMcHP2+I0vW+kDXBs6t4YjojlLCLzJcqhVgDVLzAPZAQR/1g2HNZg==
X-Received: by 2002:a17:906:4cc1:b0:7ae:50c6:fd0a with SMTP id q1-20020a1709064cc100b007ae50c6fd0amr21346768ejt.184.1669886518206;
        Thu, 01 Dec 2022 01:21:58 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:21:57 -0800 (PST)
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
Subject: [PATCH v4 0/7] Support for the NPU in Vim3
Date:   Thu,  1 Dec 2022 10:21:21 +0100
Message-Id: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
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
v4: Add warning when etnaviv probes on a NPU

Regards,

Tomeu

Tomeu Vizoso (7):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add G12A NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055
  drm/etnaviv: Add nn_core_count to chip feature struct
  drm/etnaviv: Warn when probing on NPUs

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 11 ++++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |  3 ++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 36 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 +++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 8 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.38.1

