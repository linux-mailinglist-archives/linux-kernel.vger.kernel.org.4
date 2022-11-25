Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF8638882
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKYLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKYLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5523EBE;
        Fri, 25 Nov 2022 03:19:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n7so6254552wrr.13;
        Fri, 25 Nov 2022 03:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ/Ad4hSKfagSWXJgtJNFFKqplgksfsr8uetGe6EuYA=;
        b=dHZmajYnzz4u1jEo2HZja6kVm1mWJREW0f3tbiQn1KmezmC7S0VAc6VWFkNXA0eZaB
         EHAjzMMhncEiD+gratUs0iJRq+ZhBY42zlYNrV5JoLQBB8uwcLZ0+WwGDWnaGwb7ri1M
         K6GyCqwCqr5XqpnGJSimkapXZVnWD5QyBb2f/qj4qHGWuyO5Y4unUXkQo7REY0Ab4yUY
         nxWMqqzpHIsz6tjDAc5sBBUlhB4NUi5XSwz8w829yZycYO3+0kutXTTuEeEdxGEp3BvT
         y3u4079+nY36PXhoFse7cqNF4oRZ164FJtNjnISILNNq24uLevUhZMAluMl6TXhjp1EB
         5RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ/Ad4hSKfagSWXJgtJNFFKqplgksfsr8uetGe6EuYA=;
        b=hxi0YjXhjZ8oghJnvuEKJxvrjVrclnTrNELEM7FCPEBPfAKHe2P4TszwgoX2jumvY6
         22anC6MYSUVnG3f0C1pSWUOpAjIgytx9fRk4XnHN4WLddE1cD2r0NrVpYj5Az3ZiLjTL
         JSO5If8I/PA+60yqxybWPhOIIsozZFuQ1hML9G7QdpApUa8Fdm1l2jmMfQFkIqQMHdii
         8gitwnDxkj5zNSjJyKHiKfL5/HNXguvsNHgWy0YE6E2M5BvM0dtixdb+PxpzMoMzGoy6
         Tg4sOFptqzZjhpHqkWgN3bMh3duDr4fUw/z6nRXgp5VufqYpD6p5IrqLD1vPoMqVHpbM
         v7Dg==
X-Gm-Message-State: ANoB5pk4QexYHrfh3FiJxD0Puv/kMc9n3JLqYhsTtW4c6iEGqSjh5Gn7
        fFsVXA9zxILCCpyr8POZ+Iw=
X-Google-Smtp-Source: AA0mqf7qcwBF0kX1Tp8rgnVWvydougD+PQOYjSSxRa5bPdGbWmiAjgx6M/qac3U1VJJkyI9gVdzcdg==
X-Received: by 2002:a5d:6b45:0:b0:236:7a1c:c41a with SMTP id x5-20020a5d6b45000000b002367a1cc41amr11849573wrw.680.1669375177118;
        Fri, 25 Nov 2022 03:19:37 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:36 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
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
Subject: [PATCH 0/6] Support for the NPU in Vim3
Date:   Fri, 25 Nov 2022 12:19:13 +0100
Message-Id: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

The IP is very closeley based on previous Vivante GPUs, so the etnaviv
driver works basically unchanged.

Regards,

Tomeu

Tomeu Vizoso (6):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: meson-g12-common: Add reference to NNA reset to pwrc
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 15 +++++++--
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 31 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 ++++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 6 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.38.1

