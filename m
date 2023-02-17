Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37EC69A925
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBQKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBQKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:38:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4F2129F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:38:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x4so885528lfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGtDzzuefwzTlyPLD1iHm2KsU2gFe3Js3bhjfE+68t0=;
        b=uPig5tk1p2UwftW/Xv8bb0NTNmRU4AzYltWwYXNfjQPNB0iKwdqFXPk/u3HUqHEPZM
         pigFjDr+spJbVU1J5Xsh1KSWzd6KI7v9JMSVIuBkrudosOjZwH3O9A0mzQ0ye2CycrcJ
         iNPO5cMvKd26gJMptd3Sw08WL2hKCkJvY1ES8bNUnfrl0RxrAT7z1r4kqcQCNo0DhCUa
         fBb+e4njNqtdYA7TEL64cccGF2u/T1poYesPxyEA80gMxlCkRYSMyP895sM90vPy0zIa
         dP7naC5Rk0VvgbHTAMASub18c3ZJhRU2c/u9pQEBGJRb9BTFjwntWBnIT+Q6+3PVTsPt
         2nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGtDzzuefwzTlyPLD1iHm2KsU2gFe3Js3bhjfE+68t0=;
        b=MalxiR68wWdZr9x+vHoKyB25VFRvtJO9PolUeH96zRGAOV8fKHSgFdKnFfYShu6esC
         zXkiXtAWRspfozO6rmTv/iVaOTKtce847ObdmmOKraUSzQHUjiJ8Urz/YMZxGUoVLA0a
         UePQfpSYJbsqL0tIRqXolZpakpWgiH73gsp3jl/Bsn/kLuoXD5aDlsfaKjKVYC8mpIXn
         1WS5+EWISzOy/A9Z6ivAL6aBOAx7JkVOiBtZd4TmVCPdYXkHsZTEo+CWDzyXghJikDe0
         9Gk2VaU0w7aPUZQghOKJT2O/cin4JlooaG/8mYgH/Rrsp56eFaR9X2STA3g4UVRQe5Pf
         DC1A==
X-Gm-Message-State: AO0yUKWm7mTsTk/+5rBggcu2zAplJGLuYSaztY3QzIN1KGXsnvHuY+oP
        59Bunc8UyvcTt0fFChMvnxszzQ==
X-Google-Smtp-Source: AK7set8bsdmxRWZoPaaS/YX8HuNI5AG19UI3e7nLQJ4EzskQ9e/Na9/MXHPZsm6vZB+0Yqh0qG1LEg==
X-Received: by 2002:ac2:4ac1:0:b0:4d5:8dd8:75f9 with SMTP id m1-20020ac24ac1000000b004d58dd875f9mr2491890lfp.24.1676630281084;
        Fri, 17 Feb 2023 02:38:01 -0800 (PST)
Received: from uffe-XPS13.. ([84.216.156.215])
        by smtp.gmail.com with ESMTPSA id l3-20020a19c203000000b004ceb053c3ebsm634341lfc.179.2023.02.17.02.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:38:00 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.2-rc9
Date:   Fri, 17 Feb 2023 11:37:57 +0100
Message-Id: <20230217103757.61244-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Here's a PR with a couple of MMC fixes intended for v6.2-rc9. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc5

for you to fetch changes up to 3f18c5046e633cc4bbad396b74c05d46d353033d:

  mmc: jz4740: Work around bug on JZ4760(B) (2023-02-14 00:14:05 +0100)

----------------------------------------------------------------
MMC core:
 - Fix potential resource leaks in SDIO card detection error path

MMC host:
 - jz4740: Decrease maximum clock rate to workaround bug on JZ4760(B)
 - meson-gx: Fix SDIO support to get some WiFi modules to work again
 - mmc_spi: Fix error handling in ->probe()

----------------------------------------------------------------
Heiner Kallweit (1):
      mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set

Paul Cercueil (1):
      mmc: jz4740: Work around bug on JZ4760(B)

Yang Yingliang (2):
      mmc: sdio: fix possible resource leaks in some error paths
      mmc: mmc_spi: fix error handling in mmc_spi_probe()

 drivers/mmc/core/sdio_bus.c     | 17 ++++++++++++++---
 drivers/mmc/core/sdio_cis.c     | 12 ------------
 drivers/mmc/host/jz4740_mmc.c   | 10 ++++++++++
 drivers/mmc/host/meson-gx-mmc.c | 23 +++++++++++++----------
 drivers/mmc/host/mmc_spi.c      |  8 ++++----
 5 files changed, 41 insertions(+), 29 deletions(-)
