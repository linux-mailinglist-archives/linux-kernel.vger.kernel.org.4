Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA39640246
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLBIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiLBIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:35:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59124BF91A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:33:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so6340304lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVzvAUcs+pe9QgxoA/HnlnK/S+641sb2KvL8G5I/JNY=;
        b=i7PEmYYkzgLRz6PZ8y/HBf+T54YBa+jmIpzZ/dncYFG/jAr0a05Ok7iVbnWNERg+yz
         p1jQqtMHQnPzh7q/FTDWuxtBXGha7LRAKydy1FBoxxEP6+cVpDb73FOlkzcfj23Ht8Rq
         v9VAKc+sq7kfq6xX885Eu/CX5yeVppI8dXXTpMIqxVanbKLTumcqV3/oK8EYivag3/oy
         Uty6rKfWdGSScZ8e/6HY9pqTqfsfEphu0tJ4v770M+niW/1uQAhMkniVVN6XDSbYORBA
         FbHOoZU66XWh9KIpk844UJ1Fr0FOMsT5+DNMmfgRAsxVMppmYS2Owl/OqXlrIY2Qdfn6
         zFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVzvAUcs+pe9QgxoA/HnlnK/S+641sb2KvL8G5I/JNY=;
        b=r8VfigFbDdXc2w6zj22lwY0yFuFevUuHbwpwKIUPEmtkSWf/o5o9+OPTXchjCN9rBc
         8Y6LOPES90EMivNYNvwEjmHAZ31Nc0F+9L0cVXhX3+J1PkzLKH1yOx+a7PhPdXs6IsaC
         IKTAlLCp3xJhtoMaY08D2KC+lOVzlk8sDbuj0saiqgo15AfucOlJ1foB14B+yO5kg8zY
         SWeS9d3A7c8wPkBOjA9grgSXpXYIkJBmurjhIOEN5T5/e6G34KtJ1PFjPgle2l3e6m7c
         nNKnY6IT8O8KWExGqhwThhRDuPVKdHishtfkT5z+U0ENuysItrV7m5wAGcdGx59ggX25
         bRdw==
X-Gm-Message-State: ANoB5pl5EL7tH50WMmZQlnURIUBZAmDiiwhFxmYvrzuEgWnC/efZzmxa
        yATpVNl9XFFZB8UhYbeVso84HDsNAhMAe9sAhq0=
X-Google-Smtp-Source: AA0mqf6IoHRI5SGuUrPmvfzVcaSe27jWfxi92PQYNR/yCBomfHy+oXIL1a+61mCpztE45BogZoufSA==
X-Received: by 2002:ac2:43d8:0:b0:4ab:7f8d:472 with SMTP id u24-20020ac243d8000000b004ab7f8d0472mr9137lfl.65.1669970005181;
        Fri, 02 Dec 2022 00:33:25 -0800 (PST)
Received: from uffe-XPS13.. ([148.122.187.2])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b00499cf3e3edcsm939326lfc.296.2022.12.02.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:33:24 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc7
Date:   Fri,  2 Dec 2022 09:33:10 +0100
Message-Id: <20221202083310.136427-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.1-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 222cfa0118aa68687ace74aab8fdf77ce8fbd7e6:

  mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put() (2022-11-16 17:00:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5-2

for you to fetch changes up to dd30dcfa7a74a06f8dcdab260d8d5adf32f17333:

  mmc: sdhci-sprd: Fix no reset data and command after voltage switch (2022-12-01 11:28:39 +0100)

----------------------------------------------------------------
MMC core:
 - Fix ambiguous TRIM and DISCARD args
 - Fix removal of debugfs file for mmc_test

MMC host:
 - mtk-sd: Add missing clk_disable_unprepare() in an error path
 - sdhci: Fix I/O voltage switch delay for UHS-I SD cards
 - sdhci-esdhc-imx: Fix CQHCI exit halt state check
 - sdhci-sprd: Fix voltage switch

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix voltage switch delay

Christian Löhle (1):
      mmc: core: Fix ambiguous TRIM and DISCARD arg

Gaosheng Cui (1):
      mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse()

Sebastian Falbesoner (1):
      mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix no reset data and command after voltage switch

Ye Bin (1):
      mmc: mmc_test: Fix removal of debugfs file

 drivers/mmc/core/core.c            |  9 ++++--
 drivers/mmc/core/mmc_test.c        |  3 +-
 drivers/mmc/host/mtk-sd.c          |  6 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
 drivers/mmc/host/sdhci-sprd.c      |  4 ++-
 drivers/mmc/host/sdhci.c           | 61 +++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h           |  2 ++
 include/linux/mmc/mmc.h            |  2 +-
 8 files changed, 72 insertions(+), 17 deletions(-)
