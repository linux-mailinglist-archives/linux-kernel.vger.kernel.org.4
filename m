Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8C70F188
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjEXIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjEXIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:55:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91F8E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:55:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so8543701fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684918535; x=1687510535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xY75exFFc4pLe253DwACRmicg541kJJKSeJfAcbzZL4=;
        b=cR4OOaDYF9vBD0ac6I93hzlAoNYHVBnRsa0e0anqL18v7B+r/OvCvXTJFHJRkxSFXl
         4QT1SA7ehERodfK/74U/QrYANGs+MlJoSOB+mXquHN+jVWlSNoJVFgA0M0oH4ghPD55e
         ZLYsvymofq9MMWRnDgG+zIQf28GQzfTw66EkDOpIjhHixzPLwNNR5f8DrXMDxba2Soc7
         ru+t0ri/Z0hnvOeHQraBkv9y8m/g33NeWvHGWRZzAG11lIO6xIkyjwYgc5qFbmbyUXY8
         r2siW9ez3fU6JbxXwtfWOfcP6uXanw0ET4XUW1EDap6H2d7VuEMhDOauM/8ufy1Xxt2t
         iLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918535; x=1687510535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY75exFFc4pLe253DwACRmicg541kJJKSeJfAcbzZL4=;
        b=LbpEfEMbyA5QdR8euLZtMFVLl8gNCuggz0RFPV2yAuN+4Ym36949TVCHSgeP2zrc5i
         s5FThksmxpNp5bWkq0tE0GebcLq+nGnslwWN/lOxN2ZVUt5i05dKzNd1Y69BsG0cHBF/
         ZbN9yIaNfyNZoxs0q98ELzDhNpysCgnrbi3KeWuiKdjGt85a1v9C78qEkRkwBWD914Jt
         QfkOPr82iydwkfNN5odIhW0tGrxGJCwkRVPS7CFWAMKVFFT7O//dwK+LSDIy3fr1dqd5
         t8cCTWiSB7MUl1VLBeCfoGonSMROQ47BrptGO5OF/svEZTlS6dRkaotDx7eSQh5SSZIG
         ndEw==
X-Gm-Message-State: AC+VfDwbVEnldeyO4t/n8499oK/LjNt5Lqpv3eh2g59GFKVy6aRDR4E+
        PzKpHbSZvectOS1aiW4Afu3ptQ==
X-Google-Smtp-Source: ACHHUZ7w8HrOshJTCZsj04zG70rWFL7ybf7IddSv+nrCIeK32BlN9QJ687mEFidwEq24Oirv2NxajA==
X-Received: by 2002:ac2:46fc:0:b0:4f3:9a2c:589e with SMTP id q28-20020ac246fc000000b004f39a2c589emr4929567lfo.24.1684918535422;
        Wed, 24 May 2023 01:55:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b004f1477cf8a7sm1622811lfc.115.2023.05.24.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:55:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.4-rc4
Date:   Wed, 24 May 2023 10:55:33 +0200
Message-Id: <20230524085533.124092-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.4-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1

for you to fetch changes up to 81dce1490e28439c3cd8a8650b862a712f3061ba:

  mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works (2023-05-09 11:55:02 +0200)

----------------------------------------------------------------
MMC core:
 - Fix error propagation for the non-block-device I/O paths

MMC host:
 - sdhci-cadence: Fix an error path during probe
 - sdhci-esdhc-imx: Fix support for the "no-mmc-hs400" DT property

----------------------------------------------------------------
Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Christophe JAILLET (1):
      mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

 drivers/mmc/core/block.c           |  5 +++++
 drivers/mmc/host/sdhci-cadence.c   |  8 +++++---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)
