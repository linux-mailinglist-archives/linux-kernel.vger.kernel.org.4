Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C071FC76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjFBIsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjFBIsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:48:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A310D9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:47:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so2395281e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685695656; x=1688287656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYR18ZMkSgeDGw1wy03UTm2hI/2CDrWky4kqWDiBOMU=;
        b=cQdSo/7m771fssHra9Xn9v7OIxfU8dvwiBjiN3vjvguKROTPra/NRA8DwPtxdr0MN1
         WddfU24wzwdcH6Rri3lHS78vPN0G7DFrscoo4uMPibq0z/SVmTcSN4jDBpmIqanOcixc
         8DEADyvrzWfr7OdywN+gEy0ht91de8X9OQF4oyGbqxRo6624uAwJPTkr0e/NYhN5cSZe
         6eQv5FkleqM4Q24gc9OhabqZeQIFXoJ+1U5dXN6Th4plk3R/XQN1XFoKzAvtFRxuwaDW
         JLQoA8HlF/nB+Qbm0L0qPWJPsRE0ujb33t0pDCS1KbGZpK0nRw8xu1fq7UnQXueXHlbu
         1MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695656; x=1688287656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYR18ZMkSgeDGw1wy03UTm2hI/2CDrWky4kqWDiBOMU=;
        b=FfdHN/zvUCInsTZv0lPtrO4j4zLswy1bJrQPv1jDXJbt/jMxwi9dVjDd7VfKXyJnaD
         HH3zXYaoNnLGkOru9Nj5xpLSx1OTdN8dTzZgTdo0uewN30p/8hlktyR8kBnTUHAdyFRS
         s2vvf92dQr4Z8JTcoZi9OBmGizV9IzmW8Aso1PtQaPOyDMY/LUAHN5MtvYKTtSD/Xu2Z
         SYuZwJLEgO42lkAplONz3o93tSad3Ben6tJSxRyOztlrzdEdY2ReWLNSbGvdr8xNqx83
         NmV+um47BF5aXxtoBLBpQzQDDxJdyZd/1z6K3SfPaxKeWm1aMYoCcsi8M7ox9+5VwqXb
         5ZXg==
X-Gm-Message-State: AC+VfDy1uCh+x783+BHDJJENiQl3ca/AT4+O4rMkJkEysG4czx2MbAVK
        CJhOpkt/hjKr2xuTYQIOeMNp2uUFt6NHG84shQQ=
X-Google-Smtp-Source: ACHHUZ6H97AUwpEGg3mXKew7H84MpDUbBUkunLJSspBCNnwbiwMnbcPPL8kHo6zyJbkElQaRQxqI8w==
X-Received: by 2002:a19:c511:0:b0:4ec:89d3:a8ac with SMTP id w17-20020a19c511000000b004ec89d3a8acmr1142743lfe.30.1685695656244;
        Fri, 02 Jun 2023 01:47:36 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d14-20020ac2544e000000b004f3830143f2sm91635lfn.253.2023.06.02.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:47:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.4-rc5
Date:   Fri,  2 Jun 2023 10:47:33 +0200
Message-Id: <20230602084733.40750-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.4-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 81dce1490e28439c3cd8a8650b862a712f3061ba:

  mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works (2023-05-09 11:55:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1-2

for you to fetch changes up to 0b5d5c436a5c572a45f976cfd34a6741e143e5d9:

  mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order (2023-05-24 14:33:32 +0200)

----------------------------------------------------------------
MMC core:
 - Fix pwrseq for WILC1000/WILC3000 SDIO card

MMC host:
 - vub300: Fix invalid response handling

----------------------------------------------------------------
Deren Wu (1):
      mmc: vub300: fix invalid response handling

Marek Vasut (1):
      mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order

 drivers/mmc/core/pwrseq_sd8787.c | 34 ++++++++++++++++++++++++++--------
 drivers/mmc/host/vub300.c        |  3 +++
 2 files changed, 29 insertions(+), 8 deletions(-)
