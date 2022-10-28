Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51C6113A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJ1NxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1NxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:53:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838591B1E6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:52:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so8376810lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiWvRk5q394PNtyPtfd7RRYQFcCCdv9RmCjUimVbiRc=;
        b=u/CESXdXFuPawAP1b5wROE8H7g1FCRybxiltZnhqhICp8E+B/lrUnTRBdS6e/MCZEq
         aYSGu+/hTirXeaI+N/4d6zRaHn8HF4O6HxoCaRhGxhx0p2dGnqkn7aDIkX96ijWIz9Hq
         DG46k4r+LQI4g3QDtUAjRHfpWEGhd3GO8s7StrVkEd9ACR4pGhO0yeWBumhv/pEHuyRJ
         mCnkpu3xD8JbUBprupa6nNVQeMoV+3zGjbJq2jb3Kp0NkB/tsgtdnEahIYA4HPrtEHdV
         zzBoAyF1C4JbBcG1ZBReI1aUK6DB/rIeySOQyrr4qZcKYLaDJC+QkouCVmHdwTFzYgfZ
         MCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiWvRk5q394PNtyPtfd7RRYQFcCCdv9RmCjUimVbiRc=;
        b=UVcxgG6fL0SRHJvWgq6DBcfHsH52OotAnyzkY6bkYi84t/ODYPOcDRVDN8o4aswnVI
         X08S8E5G0TwdMFhhVvAG0i1vVMgm11TUY5p3CZz8nexuv8wu39YyXcK+G2Bf5qfMqDd0
         QANX0jxaswL1GV9f+oslmRXtYbsgzNhNf13r/XWPALseH4n6x8e7asN41tNpBtTDhlUp
         3Pqx95//9V1inPqBc4eOxSP5VwvYtrHqZakwBmZZmpR3puU1pL5zCIHNYQX1uCrRfksP
         uY+0o2mB293iqflwGYnUWQVkWXCtdMeC7vG6B+aAoy5Xx3doVRr6EeRAqrkvm9YTC/SS
         S9qQ==
X-Gm-Message-State: ACrzQf0ShqIS0MuVPuEIYU6mC6kMecKHev9I8GcSfL1cGNnIMn44viSn
        cUosGNQKKInBeWOKlVVQMVcP1w==
X-Google-Smtp-Source: AMsMyM6xwa69zPU5Api0/SuUeh0vhLdfvaskkbvOqtLiVAlR/kBVhkzG42NM/VUs77WXPYk9xEjL3w==
X-Received: by 2002:ac2:5dce:0:b0:4a2:2dad:7ad4 with SMTP id x14-20020ac25dce000000b004a22dad7ad4mr19544897lfq.654.1666965177599;
        Fri, 28 Oct 2022 06:52:57 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d3-20020a056512368300b00492ce573726sm572523lfs.47.2022.10.28.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:52:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc3
Date:   Fri, 28 Oct 2022 15:52:55 +0200
Message-Id: <20221028135255.8070-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.1-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc1

for you to fetch changes up to 8d280b1df87e0b3d1355aeac7e62b62214b93f1c:

  mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO (2022-10-26 11:48:03 +0200)

----------------------------------------------------------------
MMC core:
 - Cancel recovery work on cleanup to avoid NULL pointer dereference
 - Fix error path in the read/write error recovery path
 - Fix kernel panic when remove non-standard SDIO card
 - Fix WRITE_ZEROES handling for CQE

MMC host:
 - sdhci_am654: Fixup Kconfig dependency for REGMAP_MMIO
 - sdhci-esdhc-imx: Avoid warning of misconfigured bus-width
 - sdhci-pci: Disable broken HS400 ES mode for ASUS BIOS on Jasper Lake

----------------------------------------------------------------
Brian Norris (1):
      mmc: sdhci_am654: 'select', not 'depends' REGMAP_MMIO

Christian Löhle (2):
      mmc: block: Remove error check of hw_reset on reset
      mmc: queue: Cancel recovery work on cleanup

Matthew Ma (1):
      mmc: core: Fix kernel panic when remove non-standard SDIO card

Patrick Thompson (1):
      mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake

Sascha Hauer (1):
      mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus

Vincent Whitchurch (1):
      mmc: core: Fix WRITE_ZEROES CQE handling

 drivers/mmc/core/block.c           | 44 ++++++++++++++++++++++----------------
 drivers/mmc/core/queue.c           |  8 +++++++
 drivers/mmc/core/sdio_bus.c        |  3 ++-
 drivers/mmc/host/Kconfig           |  3 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++------
 drivers/mmc/host/sdhci-pci-core.c  | 14 +++++++++---
 6 files changed, 57 insertions(+), 29 deletions(-)
