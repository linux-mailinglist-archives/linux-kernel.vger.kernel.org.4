Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDB676CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAVMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:11:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188418176
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:11:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so8510117wrq.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kh46BGaZm1ibq11ENZTVqU06WU/GK9n967GcDHPrdfA=;
        b=k+DtXHztRgpF2710aOjM4E7UGk5NdggwvA8I3z9p47iO7tDNk3mddSaA/IPqUwTobq
         iP77U4TAFS4Hxjrq4Uxi4rH3P3mwz4SAlolkbEZCbhRbSiAtEUjGDiOHiHWUA4PAKUZZ
         EcVpR125Vh3KYmzfCiytDNerZdvGIgjION9oyevaAosx4WSXBeBFV6FVDChkVlgNm1VJ
         A73m+7ybSGd2pNXWOlzLdFtV+I4oRwiS14A8IKD578CtrkmGtEm/1mysWU7oqvEv7XAD
         cBHPZSfLe5dJYz6G3hu5ZWif69bRpc+Wl68IM2+nda3yJ/Z6VX/F9un7qNV+mDYGdBjC
         QuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh46BGaZm1ibq11ENZTVqU06WU/GK9n967GcDHPrdfA=;
        b=E3r6Cr7url28sOElQX+47NC79EChKCfy87pGp7xZzbRBp9M7KwXfw1ko0VMMzWKus/
         dcb3rJIuktrubMJ7xLkwdtucUgns3RfzgTex8SJ1vT+GYN/k+z/d/jUA9STU6IaqDkJX
         AppIJoUZi4zTb1xSHDhKMiO5KxWEreshg9s1EhzrgAeReiaX3ESQfn9HynFLy5jlfNsA
         aJef/9SWVefC9i5nTUmrdOB14r+DmwPQYk1YCZTdElb26YDzQN4qPXyYp4Ywju1bPM8Y
         b8fQsdva4Y1o2rHDJrZsCAPElF6V6xWXKf7dlGpjdBELQbvP3tyt0osbt9uBp1q9gBsp
         Vjdw==
X-Gm-Message-State: AFqh2krMWfHwwdNyDbXKs/hHo6idagixKTbnjkWVQYydW1LFfyVniSBr
        05C+0aJ1W1torGm7F/ogDw/5xQ==
X-Google-Smtp-Source: AMrXdXtEr9vi6vNmJ9qvCPQIZKzcjE0HxnAvvYszmwahQQLXGJ/d647l3d36TaU6H83uzVK0/xredQ==
X-Received: by 2002:a5d:570b:0:b0:277:2e27:61e7 with SMTP id a11-20020a5d570b000000b002772e2761e7mr18303769wrv.17.1674389493491;
        Sun, 22 Jan 2023 04:11:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t12-20020adff60c000000b0024274a5db0asm2019072wrp.2.2023.01.22.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 04:11:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.3
Date:   Sun, 22 Jan 2023 13:11:29 +0100
Message-Id: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.3

for you to fetch changes up to 4fd1a0e496cb81e939c55143fc81c2be130099c4:

  Merge branch 'for-v6.3/renesas-rpc-if' into mem-ctrl-next (2023-01-22 13:05:21 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.3

1. TI Emif: simplify device_get_match_data().
2. Renesas RPC IF: Few fixes (missing address set in manual mode;
   decouple driver's private data structure from other drivers; unbind
   and rebind due to triggering managed resources allocation from other
   drivers) and bigger rework around improved runtime Power Management.

----------------------------------------------------------------
Geert Uytterhoeven (6):
      memory: renesas-rpc-if: Split-off private data from struct rpcif
      memory: renesas-rpc-if: Move resource acquisition to .probe()
      memory: renesas-rpc-if: Always use dev in rpcif_probe()
      memory: renesas-rpc-if: Improve Runtime PM handling
      memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
      memory: renesas-rpc-if: Remove Runtime PM wrappers

JaimeLiao (1):
      memory: renesas-rpc-if: Fix missing setting address

Krzysztof Kozlowski (1):
      Merge branch 'for-v6.3/renesas-rpc-if' into mem-ctrl-next

ye xingchen (1):
      memory: ti-emif-pm: Use device_get_match_data() to simplify the code

 drivers/memory/renesas-rpc-if.c | 153 ++++++++++++++++++++++++++--------------
 drivers/memory/ti-emif-pm.c     |   7 +-
 drivers/mtd/hyperbus/rpc-if.c   |  18 ++---
 drivers/spi/spi-rpc-if.c        |  14 ++--
 include/memory/renesas-rpc-if.h |  34 ++-------
 5 files changed, 120 insertions(+), 106 deletions(-)
