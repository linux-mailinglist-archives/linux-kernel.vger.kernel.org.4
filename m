Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB474B3C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGGPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjGGPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:09:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8DA268B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:09:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f954d7309fso2522746e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688742561; x=1691334561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vrdg0BN8YeBPDc9Z9UP3CnoTFMFzGJE30KoHXN+rRA=;
        b=sFjOsKeMEC/86xCtbSTI4Tawd1k3QfcsXGfWApGBL1x19uMmxtfKUPkPuG8FFNDM2S
         OpZ0fLCttpFipoo5Ezw88q1vgRSIQDKvd96Ur4da02dF7cWUYX9ZyB2uOu/zQlmkprpD
         PpIZ3ecFS44Ww7k/DjogXpUrAg3q3L1HeGeAJ4O15de+T5rEdVOYADNPxEEDRl+QGAMH
         dtG8hloMLzjYezyL1eamIPX+3OKgGcy2m6wL01nD53203aJC6W3vtYxwqHdgmEwyoCvV
         mdy2wF4ECDye1arJb4I3o62REe66ZPU0j1r/ySNGNUP73hEMtql2OR/lt9FrmrNZLwWM
         XM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742561; x=1691334561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vrdg0BN8YeBPDc9Z9UP3CnoTFMFzGJE30KoHXN+rRA=;
        b=aDD9pYsVTrOGIaME32tN//atA3bLe0/exv0ByKq3lIZQR+BdKE/+/z+Z//AYt4MyW6
         bX8XSXCSlU0Mu+dbnHO6B4VipEqWefvGv/ovO3eR4A1C+124I7gEbIif5JCmQo0virrf
         fktKP18/pScE92f5YcXZxonYArpQ8AWfxhcmC4V8l0Ey3b5Vldieo+kx+1Gt8l83gGeX
         p05fHRwxsRLvO/hfQ7SR9V3BP+SzopcPUF99yu1ooV0gXYX9cpOfPToDQ5hXI62WJWKW
         BU/4NY/bTFUlzKnxq6HPzDVq5vvXd6BgV6+oyOmOoLEhzxm6YHxmchcuREJ4a7BqWFhx
         e6IQ==
X-Gm-Message-State: ABy/qLYapWC8d4vvnoRJ62X7i5mmXrIBQ9vNAdw4HqjIgNkvRhtkx7bL
        kAGBm+LH3GltL+ZsS+odv4rxhA==
X-Google-Smtp-Source: APBJJlHUCfOsWmEr/nU2X4bUtXexNSuTsdr3Fo86I7TLAV/FuqEMGf0Lzv4Rf+oayoRyWWpP60NnuA==
X-Received: by 2002:a05:6512:2251:b0:4f9:5807:aba7 with SMTP id i17-20020a056512225100b004f95807aba7mr3390088lfu.27.1688742560970;
        Fri, 07 Jul 2023 08:09:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v25-20020ac25619000000b004fb745fd22fsm716004lfd.32.2023.07.07.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:09:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.5-rc1
Date:   Fri,  7 Jul 2023 17:09:19 +0200
Message-Id: <20230707150919.724185-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v6.5-rc1. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e55e5df193d247a38a5e1ac65a5316a0adcc22fa:

  csky: fix up lock_mm_and_find_vma() conversion (2023-06-29 23:34:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-2

for you to fetch changes up to fa700d73494abbd343c47c6f54837c9874c61bbe:

  mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card" (2023-06-30 14:06:51 +0200)

----------------------------------------------------------------
MMC core:
 - Fix regression of detection of eMMC/SD/SDIO cards

----------------------------------------------------------------
Ulf Hansson (1):
      mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card"

 drivers/mmc/core/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)
