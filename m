Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB216625A71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiKKM0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiKKM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:26:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE5C1FFAB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:25:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c25so4352339ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cPVQZP3CJGISOBWbQDciZSTi0SHMrLWneRzV2KFYjE=;
        b=pHyFqDhc31s4yZZDCxs8Vq3ZeKBNLc0fRCACiqjqJzKBzlvW5RnyFSWM2G5f+RNbIR
         AGjEkkB4f6DMdpBgiBp2yNp3KKP/03kFMpFXzcC6aGgMBaKkkAf3VwRzrPyvx8prohgs
         zqKx5t6tBJQ+z2UxNnqrzhq4i1kEHK6mphpz3bTfKEpKAKkMp5zX0t4FIkgJJsZKQ7/R
         s2sbjRuFX450+H7NCnGAdgKnrJr4uQ0Fdqty53aOUQeTsT1cBckt2JSL3lDEaVfTY1/S
         GTYpSUqpz3w+WGmoZ3sXogxzKY5tCAXiLDOaTkY8rtx/OlYOvDfi7k3tWu+RjCAAdl9m
         7dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cPVQZP3CJGISOBWbQDciZSTi0SHMrLWneRzV2KFYjE=;
        b=E4szJNqybFtQwRV9XApgr9qLyNeg9mF3Ti0RusKBNbcyANIoUgGDwRs+068w5x+NSv
         WHgfF7667MtebUAhUnKlPmPBKoMhFayn6eA0/Ma1dLyMhWSYDbH2ai2OprdQoX+vmZ4d
         ZZzyaV+TfziXxFoeP+NLpERY03ngayBMo6Kr6EdnXT5yPmOi7uXSTcfy7OyXaRWycDhV
         F+QHM4PqsEiTsSbNq013hQNEIqNN6Izbm0Q3r+d3NnPkaQFHRPKequ5aVLxFgwb3Q2+W
         xlFFEPX7THppViB5mgpVR89EVTn4iwT/e0/u/6cyC5QBFXYoRkANyRUCgNmbYN7Eg1tL
         7uVg==
X-Gm-Message-State: ANoB5pm3OzIBsQ72AY6t7Av8F7Nvsv7OqppTCfUaWx/2HWfA1kUd9nyx
        5UoaTZtsV5oQdSwKdL7tR9inNA==
X-Google-Smtp-Source: AA0mqf4b8dhxFKi654kgglCu6s8zV8cG9HMZ8VgVKt4IMoJXJorkipUhvQF95RdZ7kC2ijMsn18ISw==
X-Received: by 2002:a05:651c:2005:b0:276:ffbf:2ee2 with SMTP id s5-20020a05651c200500b00276ffbf2ee2mr508193ljo.505.1668169557055;
        Fri, 11 Nov 2022 04:25:57 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g19-20020a2e3913000000b0026df5232c7fsm378101lja.42.2022.11.11.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:25:56 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc5
Date:   Fri, 11 Nov 2022 13:25:54 +0100
Message-Id: <20221111122554.112164-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v6.1-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc4

for you to fetch changes up to f002f45a00ee14214d96b18b9a555fe2c56afb20:

  mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA (2022-11-09 13:01:33 +0100)

----------------------------------------------------------------
MMC host:
 - cqhci: Provide helper for resetting both SDHCI and CQHCI
 - sdhci_am654: Fix reset for CQHCI
 - sdhci-brcmstb: Fix reset for CQHCI
 - sdhci-esdhc-imx: Fix reset for CQHCI
 - sdhci-esdhc-imx: Fixup support for MMC_CAP_8_BIT_DATA
 - sdhci-of-arasan: Fix reset for CQHCI
 - sdhci-tegra: Fix reset for CQHCI

----------------------------------------------------------------
Brian Norris (6):
      mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
      mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
      mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
      mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA

 drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
 drivers/mmc/host/sdhci-cqhci.h     | 24 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  7 ++++---
 drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
 drivers/mmc/host/sdhci-tegra.c     |  3 ++-
 drivers/mmc/host/sdhci_am654.c     |  7 ++++---
 6 files changed, 38 insertions(+), 9 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h
