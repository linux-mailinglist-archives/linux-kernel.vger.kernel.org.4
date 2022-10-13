Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245F75FDC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJMONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJMONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:13:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B850B80
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:13:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m19so2678276lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4+2YBnku99YzzIsQ7nejlO8E//x75qWW99ifL1XicY=;
        b=b756TPkB0v/sj7TeR9iEobafqj/mqe52e96i9Uo4mVUlEpArfd3BFuonxZdSWTfQwm
         1WbF7BJanZBo+0xFo2kaxw4PUr9Hzzns1PquChY53JCehRqvqQab4lBFlVZKm7onlC5i
         tKVyN4e0Rz3ATQwuUPC8yZg42ChnA0e5o0xi1RalBsvWPHtwQJezxoXAa9jCK/U4UwLt
         CwoKouPo4uMFNvcIMYFjTb+DpQO5BkYc985o4jnfY/NSFwVL4iVMJsa5DJXgf1X5x0ZW
         ZVBols6++HXNbvWG0hMn8vA+21XBafFyQwOOw0g/DYOd3HNfKxzrmRLCmrADNQ25bXG+
         kd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4+2YBnku99YzzIsQ7nejlO8E//x75qWW99ifL1XicY=;
        b=GVld0HT+z27mVF2liMLLlfXI9JQEDkWnDiidbhIM+D5WRzcuOETab3vAV1AlBh3PzP
         peG4xQ90eE3lWjuaMZYcouaOvrZOFX48W/2EdIILEN4WPvTIQamD6kP1J1hW41tfjjBR
         N4Q9Sx2TCvyabrYbRtaVIwka55gHQpCfBEvFft6120SNNxg1MoOU7UkQiVvlmEZBndvp
         kWHcUqecXBJGiZcjhDfeGmHE2CCkKNXkRh4t4LAjIa/GQvyPpm/TwWaakXe3B+RZgPf7
         Me4RdW5GUqhrIu0aM1X+3gYttfr1CWljJ93bwyY5C3Eb96F4C58ASgCqVe1aPJHF4MgQ
         EsmQ==
X-Gm-Message-State: ACrzQf3+kmGXjVLTr/w6h7Ei6Q5PZihF/U5QHsnNLJ92BiEPMjGhu9kF
        J0syf1AW3SqOQIarTKGV2shuJg==
X-Google-Smtp-Source: AMsMyM6Pwh1Vdyx2Zh+wARiDcb8ZqJ7C5Df2hJuUaCeicB0JWCCxDRazlI+TpOb8KVWbyRSGKH9N9A==
X-Received: by 2002:a05:6512:2256:b0:4a2:7e9a:576d with SMTP id i22-20020a056512225600b004a27e9a576dmr12571054lfu.58.1665670416386;
        Thu, 13 Oct 2022 07:13:36 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v5-20020ac258e5000000b0049473593f2csm415121lfo.182.2022.10.13.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 07:13:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc1
Date:   Thu, 13 Oct 2022 16:13:34 +0200
Message-Id: <20221013141334.511005-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v6.1-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 833477fce7a14d43ae4c07f8ddc32fa5119471a2:

  Merge tag 'sound-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2022-10-05 12:02:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-2

for you to fetch changes up to 6e141772e6465f937458b35ddcfd0a981b6f5280:

  mmc: sdhci-sprd: Fix minimum clock limit (2022-10-11 15:48:51 +0200)

----------------------------------------------------------------
MMC core:
 - Add SD card quirk for broken discard

MMC host:
 - renesas_sdhi: Fix clock rounding errors
 - sdhci-sprd: Fix minimum clock limit to detect cards
 - sdhci-tegra: Use actual clock rate for SW tuning correction

----------------------------------------------------------------
Avri Altman (1):
      mmc: core: Add SD card quirk for broken discard

Biju Das (1):
      mmc: renesas_sdhi: Fix rounding errors

Prathamesh Shete (1):
      mmc: sdhci-tegra: Use actual clock rate for SW tuning correction

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix minimum clock limit

 drivers/mmc/core/block.c             |  6 +++++-
 drivers/mmc/core/card.h              |  6 ++++++
 drivers/mmc/core/quirks.h            |  6 ++++++
 drivers/mmc/host/renesas_sdhi_core.c | 21 ++++++++++++++++++---
 drivers/mmc/host/sdhci-sprd.c        |  2 +-
 drivers/mmc/host/sdhci-tegra.c       |  2 +-
 include/linux/mmc/card.h             |  1 +
 7 files changed, 38 insertions(+), 6 deletions(-)
