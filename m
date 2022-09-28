Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4B5ED817
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiI1IqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiI1Ipg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:45:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE815CF4A6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:41:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a10so13625886ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jk2vF+C/PYJ42SVsy2QF4XFOq1DXTDUxrUF6AO/yW7U=;
        b=lIKu1EN4OWGnM29CBNLA/1X5h0xICvCoscT2+T3tqTuVA0oosZaKkDXXbXgK2G+hTT
         Lplar5z1FJKfA8KKnOED+Jr5NR3U35+8AZgUcrDnvzcQdZxVP1cG6EV05mQTQCbFhbWy
         kWrNLrpwnPASththyluide+4rr4kvwf/Iaez+0gy+NefskY7qLK6PhQ8WLJ/vAQVMc77
         wwug436n03vnt5g34HBt5lm/p4uEH7fcTEGqwN1L2/SRSz5VDsWVc5Lcyc8B69egFzLX
         r5HxTrvzxOjAE/FnVpG/O2fncLKWzq68RdoQo0WjXHySq322PlI1RFFFNdGGILuCRkJ6
         TIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jk2vF+C/PYJ42SVsy2QF4XFOq1DXTDUxrUF6AO/yW7U=;
        b=hkwqEG2/havGhf5xl1zLtSOwFMYeoT0zHneYN8GejqLlBRWkFGunJHAv7awwM6TOoN
         EFJb58dR41xAr3mwAnt7TtsC+nQ2o+Ul0i/qi6HtWFGgDcflqCq8dFVW4VDGBOzaDJR1
         AzP+3m6RDKarEbkPGDdRpxy7E6L16+OG9Fnbx8zviS6WqCsKIbMF755Lwz1v/nyMdMH9
         j5xkuEJcc5MHJJFl9DAozIV9X6FEJqa3Wu85b5vDVALDiXh9bNYDvFeqZXegQPGfEXVS
         M07TDDF4bcrbCgMs1jJppCabJ17HMIyYiNWoNM++F5m6cRmy4pzVES1SKedT6IHYoT8o
         FYDA==
X-Gm-Message-State: ACrzQf0F6aYvIekQC6XaCluDAvIH2CHCL1lDRU/PvAYEV4zjHIlBvhmq
        flUObMwp+J7vjvd8EweBvE6SQQ==
X-Google-Smtp-Source: AMsMyM49M8Msk9MQDgBkWE2CZgxPSt7DVLA4PMayk1HvSFFNzGKmGNAXijvzGcsxcOz4KAHx8nVaCQ==
X-Received: by 2002:a2e:7309:0:b0:26c:3db7:8fe2 with SMTP id o9-20020a2e7309000000b0026c3db78fe2mr10859978ljc.387.1664354515092;
        Wed, 28 Sep 2022 01:41:55 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512074600b004948b667d95sm409700lfs.265.2022.09.28.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:41:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] MMC + ARM_SCMI fixes for v6.0-rc8
Date:   Wed, 28 Sep 2022 10:41:52 +0200
Message-Id: <20220928084152.245040-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.0-rc8. This time there is
also a fix for the ARM SCMI firmware driver, which has been acked by Sudeep
Holla, the maintainer.

As usual, more details about the highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc5

for you to fetch changes up to e7afa79a3b35a27a046a2139f8b20bd6b98155c2:

  mmc: hsq: Fix data stomping during mmc recovery (2022-09-27 12:38:29 +0200)

----------------------------------------------------------------
MMC core:
 - Terminate infinite loop in SD-UHS voltage switch

MMC host:
 - hsq: Fix kernel crash in the recovery path
 - moxart: Fix bus width configurations
 - sdhci: Fix kernel panic for cqe irq

ARM_SCMI:
 - Fixup clock management by reverting "firmware: arm_scmi: Add clock
   management to the SCMI power domain"

----------------------------------------------------------------
Brian Norris (1):
      mmc: core: Terminate infinite loop in SD-UHS voltage switch

Sergei Antonov (1):
      mmc: moxart: fix 4-bit bus width and remove 8-bit bus width

Ulf Hansson (1):
      Revert "firmware: arm_scmi: Add clock management to the SCMI power domain"

Wenchao Chen (2):
      mmc: sdhci: Fix host->cmd is null
      mmc: hsq: Fix data stomping during mmc recovery

 drivers/firmware/arm_scmi/scmi_pm_domain.c | 26 --------------------------
 drivers/mmc/core/sd.c                      |  3 ++-
 drivers/mmc/host/mmc_hsq.c                 |  2 +-
 drivers/mmc/host/moxart-mmc.c              | 17 +++--------------
 drivers/mmc/host/sdhci.c                   |  4 ++--
 5 files changed, 8 insertions(+), 44 deletions(-)
