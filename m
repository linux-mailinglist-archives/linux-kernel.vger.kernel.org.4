Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D525EEF92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiI2HrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiI2Hqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:46:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CD139F79
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:46:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w10so563898pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=TNaR/+pz7Hg0YfceN1LSKGgvcAeNNA3RzZ4ATYe1Ozg=;
        b=cktwDTaa5g3oaNOGR/nLpIpNTgybXYwMT/BIF8F9RBN7xBYniG+zkLkajmmn1HCC+J
         M7vlGWeQ1+sqGp5kVs5MPMWfYCmgQAYrEgdTwv4aHvT2v6D4vEFEbsYH75vt/YvAcnw4
         la03fyCdjgfsHK6/Et/e23zknbkR9Z7CCNgz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TNaR/+pz7Hg0YfceN1LSKGgvcAeNNA3RzZ4ATYe1Ozg=;
        b=koZe5HoQq9nDgVzBudsePGk5hp4cA4uUIA+ZfRwxYyuXKTJ9xi7OfRb0BlGxHUFvSX
         daL3QlCZQWpDTVC0dwI1SplIvVcZlWBAwUtuH1+HJet8m9pJ+uaAWtmhT94ggvvtkPeQ
         1b09Qn8KT+x2U1iOHzfPHbDdN+QP8DWjyKHHmKmxcLfE7QJZha5jPlspufMzwOtwEHKq
         cENta9lwbaBcmCmu5DyYb2nreCYhhjZ8FOhXIQvOl9bul/Gh4c2JGlrelMU0pxy6Uf43
         DrE7/oPtgATZxebLCJPtOymvmi/3NaLR4kED0W1dEeFJks6ieIFe+BOc6XWVmM2Y7EWI
         kEWw==
X-Gm-Message-State: ACrzQf03AtEklWkdMa6uPrJ7e4MIqV7ZjmRNtXjdEC+dAKH1ntoJ6dzT
        bLSIcw31jbHvd8RcCVm5zm+j7US8zwQFRA==
X-Google-Smtp-Source: AMsMyM7sKhjEa98Ymh0uWoFFOv/jllvMlkdfLEAffc4nUBHzT8N5D0LGfhDRNCxIobBHr/t4Kp1JCA==
X-Received: by 2002:a17:902:6b41:b0:178:a475:6641 with SMTP id g1-20020a1709026b4100b00178a4756641mr2205346plt.120.1664437611030;
        Thu, 29 Sep 2022 00:46:51 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:13a9:39f3:3979:b1d6])
        by smtp.gmail.com with ESMTPSA id a18-20020a634d12000000b0043c7996f7f0sm4923659pgb.58.2022.09.29.00.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:46:50 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:46:47 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [GIT PULL] MediaTek Clock Changes for 6.1
Message-ID: <YzVNZzp6+S7ePIRr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cc53c57d0d54b7fc307879443d555c95b466510:

  clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY (2022-08-31 18:16:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git tags/mtk-clk-for-6.1

for you to fetch changes up to 99f3a5e851e9a1d82d73c4f396c6dbf123413c16:

  clk: mediatek: mt8192: deduplicate parent clock lists (2022-09-29 12:27:33 +0800)

----------------------------------------------------------------
MediaTek clk driver changes for 6.1

A lot of clean up work, as well as new drivers and new functions

- New clock drivers for MediaTek Helio X10 MT6795
- Add missing DPI1_HDMI clock in MT8195 VDOSYS1
- Clock driver changes to support GPU DVFS on MT8183, MT8192, MT8195
  - Fix GPU clock topology on MT8195
  - Propogate rate changes from GPU clock gate up the tree
  - Clock mux notifiers for GPU-related PLLs
- Conversion of more "simple" drivers to mtk_clk_simple_probe()
- Hook up mtk_clk_simple_remove() for "simple" MT8192 clock drivers
- Fixes to previous |struct clk| to |struct clk_hw| conversion
- Shrink MT8192 clock driver by deduplicating clock parent lists

----------------------------------------------------------------
AngeloGioacchino Del Regno (14):
      dt-bindings: mediatek: Document MT6795 system controllers bindings
      dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
      dt-bindings: reset: Add bindings for MT6795 Helio X10 reset controllers
      dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
      clk: mediatek: clk-apmixed: Remove unneeded __init annotation
      clk: mediatek: Export required symbols to compile clk drivers as module
      clk: mediatek: clk-apmixed: Add helper function to unregister ref2usb_tx
      clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
      clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d and propagate rate changes
      clk: mediatek: clk-mt8195-topckgen: Register mfg_ck_fast_ref as generic mux
      clk: mediatek: clk-mt8195-topckgen: Add GPU clock mux notifier
      clk: mediatek: clk-mt8195-topckgen: Drop univplls from mfg mux parents
      clk: mediatek: clk-mt8192-mfg: Propagate rate changes to parent
      clk: mediatek: clk-mt8192: Add clock mux notifier for mfg_pll_sel

Chen-Yu Tsai (6):
      clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
      clk: mediatek: mux: add clk notifier functions
      clk: mediatek: mt8183: Add clk mux notifier for MFG mux
      clk: mediatek: fix unregister function in mtk_clk_register_dividers cleanup
      clk: mediatek: Migrate remaining clk_unregister_*() to clk_hw_unregister_*()
      clk: mediatek: mt8192: deduplicate parent clock lists

Miles Chen (7):
      clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt2712: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6765: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt6797: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt8183: use mtk_clk_simple_probe to simplify driver
      clk: mediatek: mt8192: add mtk_clk_simple_remove

Pablo Sun (2):
      dt-bindings: clk: mediatek: Add MT8195 DPI clocks
      clk: mediatek: add VDOSYS1 clock

Yassine Oudjana (2):
      clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
      clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe

 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |   2 +
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |   1 +
 .../bindings/arm/mediatek/mediatek,pericfg.yaml    |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml        |   1 +
 .../bindings/clock/mediatek,mt6795-clock.yaml      |  66 +++
 .../bindings/clock/mediatek,mt6795-sys-clock.yaml  |  54 ++
 .../bindings/clock/mediatek,topckgen.yaml          |   1 +
 drivers/clk/mediatek/Kconfig                       |  37 ++
 drivers/clk/mediatek/Makefile                      |   6 +
 drivers/clk/mediatek/clk-apmixed.c                 |  12 +-
 drivers/clk/mediatek/clk-cpumux.c                  |   2 +
 drivers/clk/mediatek/clk-gate.c                    |   1 +
 drivers/clk/mediatek/clk-mt2701-bdp.c              |  36 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |  36 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |  36 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |  34 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |  34 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |  34 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |  34 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |  34 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |  34 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |  34 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |  33 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |  33 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |  34 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |  33 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |  34 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |  29 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |  29 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |  29 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |  29 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |  27 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |  29 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |  29 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c       | 157 ++++++
 drivers/clk/mediatek/clk-mt6795-infracfg.c         | 151 +++++
 drivers/clk/mediatek/clk-mt6795-mfg.c              |  50 ++
 drivers/clk/mediatek/clk-mt6795-mm.c               | 132 +++++
 drivers/clk/mediatek/clk-mt6795-pericfg.c          | 160 ++++++
 drivers/clk/mediatek/clk-mt6795-topckgen.c         | 610 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mt6795-vdecsys.c          |  55 ++
 drivers/clk/mediatek/clk-mt6795-vencsys.c          |  50 ++
 drivers/clk/mediatek/clk-mt6797-img.c              |  36 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |  36 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |  36 +-
 drivers/clk/mediatek/clk-mt8183-cam.c              |  27 +-
 drivers/clk/mediatek/clk-mt8183-img.c              |  27 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |  27 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |  27 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |  27 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |  27 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |  35 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c             |  27 +-
 drivers/clk/mediatek/clk-mt8183-venc.c             |  27 +-
 drivers/clk/mediatek/clk-mt8183.c                  |  28 +
 drivers/clk/mediatek/clk-mt8192-cam.c              |   1 +
 drivers/clk/mediatek/clk-mt8192-img.c              |   1 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |   1 +
 drivers/clk/mediatek/clk-mt8192-ipe.c              |   1 +
 drivers/clk/mediatek/clk-mt8192-mdp.c              |   1 +
 drivers/clk/mediatek/clk-mt8192-mfg.c              |   7 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c             |   1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |   1 +
 drivers/clk/mediatek/clk-mt8192-vdec.c             |   1 +
 drivers/clk/mediatek/clk-mt8192-venc.c             |   1 +
 drivers/clk/mediatek/clk-mt8192.c                  | 234 ++------
 drivers/clk/mediatek/clk-mt8195-mfg.c              |   6 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |  46 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |  11 +
 drivers/clk/mediatek/clk-mtk.c                     |  17 +-
 drivers/clk/mediatek/clk-mtk.h                     |   1 +
 drivers/clk/mediatek/clk-mux.c                     |  38 ++
 drivers/clk/mediatek/clk-mux.h                     |  15 +
 drivers/clk/mediatek/reset.c                       |   1 +
 include/dt-bindings/clock/mediatek,mt6795-clk.h    | 275 ++++++++++
 include/dt-bindings/clock/mt8195-clk.h             |   4 +-
 include/dt-bindings/reset/mediatek,mt6795-resets.h |  53 ++
 77 files changed, 2509 insertions(+), 858 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6795-clk.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6795-resets.h
