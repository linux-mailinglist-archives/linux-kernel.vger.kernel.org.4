Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26FE62F162
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbiKRJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbiKRJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:38:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2E18B31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:38:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so7387655lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUs/U8UWXwIGlb1bQsandtxXOXMS30Tnukg59tTXU5Q=;
        b=ZdhOkn3L3kPE7CBaKjCupDBlfZMCp9a0Lvp4vsOZtcrklNAo1Md6k+iTqPlz0qDATS
         MbAp1PuUGUhmExf8y40RpSvPb1LFrP0ahEQWrXSR1xr2AFHhZj6XmD4n+l1aesVFhDFq
         tBwTUNnzTCAu5KDxsRHV9Y/mAbwizoBO3T5/zknHrdFlLGPjC8kJLFVhzd53EMVQeyUV
         ZEnBKASMDqG6iytbDYyHWj3K/Frk0GtaltIlWC9Mm1VM68O5fhe/XyGMXTieiU3Jh+lC
         nBQS8pGgY/oTaptTn8RVOjJVbN8ktSAGA6IQS1TqgKEKYMEG+6cIcdGH6Gu7BG7LB095
         icOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUs/U8UWXwIGlb1bQsandtxXOXMS30Tnukg59tTXU5Q=;
        b=BLxabdGUwoIeF9Z/yK3gF1jLLIu8/RIrxqLknJaZL0d9fC07v1rx4rrd/V7ldu8oCp
         vABzgiihYYdDWCot3mBCZSsi0vO1DSF9sIu4cUE7SBkpk8O8LK1M5eTKF8Nq8jwfMj28
         4nanQwU+n4tCPr0HaTOIdCxA0GEetA5Oz2rp5TMkVk0cysX12eu2MDXXaIu+9hB8wHrj
         CS2SPfbJ5NeX4FNx6xYmrBLHef3irYUp/XReaB5Rb5gTqLL47coZgjMLePpKX1P5MvEC
         YR9RUDjvOgIHd79bD+iOIVxekddVE7j22/jD3P8vA+2Mnwv/3LcE9CtLEbBhqDV2cau+
         w+Vw==
X-Gm-Message-State: ANoB5pmCl13DDXb6DqRgv7PgF5aJNlwXO0YEdQMq0xiKmpFCDgsyXlTI
        hr3DhMwX1fn/qVJrge+qTrPUHg==
X-Google-Smtp-Source: AA0mqf6HjyGvjYUtFqHO189lE4mjHUGDPygUNLppsV/Hq5lAX2L4dUwtZscsa9UntInpsDWxmwVyaw==
X-Received: by 2002:a05:6512:1594:b0:4ac:a453:7cc with SMTP id bp20-20020a056512159400b004aca45307ccmr2102606lfb.226.1668764321661;
        Fri, 18 Nov 2022 01:38:41 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id bf8-20020a056512258800b00492b0d23d24sm591329lfb.247.2022.11.18.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:38:40 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc6
Date:   Fri, 18 Nov 2022 10:38:39 +0100
Message-Id: <20221118093839.6361-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v6.1-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5

for you to fetch changes up to 222cfa0118aa68687ace74aab8fdf77ce8fbd7e6:

  mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put() (2022-11-16 17:00:39 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup VDD/VMMC voltage-range negotiation

MMC host:
 - sdhci-pci: Fix memory leak by adding a missing pci_dev_put()
 - sdhci-pci-o2micro: Fix card detect by tuning the debounce timeout

----------------------------------------------------------------
Chevron Li (1):
      mmc: sdhci-pci-o2micro: fix card detect fail issue caused by CD# debounce timeout

Xiongfeng Wang (1):
      mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put()

Yann Gautier (1):
      mmc: core: properly select voltage range without power cycle

 drivers/mmc/core/core.c              | 8 +++++++-
 drivers/mmc/host/sdhci-pci-core.c    | 2 ++
 drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)
