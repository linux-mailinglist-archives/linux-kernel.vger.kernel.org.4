Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102655F2BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJCIhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJCIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:37:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF27183B4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:10:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y100so12948538ede.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=77DQW3lsofQQZnwFkOSE0jlhaIOSR4ZhDsIQytSJOII=;
        b=m49J/G2VqOQiRmROweFuYDGFPT7u+OwT6ePg4e+sgGCz81USX+C/ryBf3dTanLStbb
         MuBqBxrPV1ZrETAq+9zYJMw6aCXO/o5idY9nE0Bz7uo5jm/YiNONNcW4zAEi3awBf+K4
         K54ql3FylCtnoMTp98BSkpMU3czLkraNBot3doE71ARS16lRKxq6WxUqvPtnS1jAVXoZ
         HfdmPfYc+6mprt5inhAjGoRaowd/C6z1Qp2h/1DMYKT6Kb8dSyqFxxgYkU5Qa/hv1bv7
         uwZcwLXttWWMr3tsGwcIogLfIi6sAQTS8JV/2+tQmaY/FMa+4Mo+ByCfzDyLdEv03GZ8
         a6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=77DQW3lsofQQZnwFkOSE0jlhaIOSR4ZhDsIQytSJOII=;
        b=hXE8urgt0vIcXs2q4z4gnafk8uVnZ4vTeUC/EANoN/IQYxaQjzD0sZgGjL3Uc46trY
         KSILdVWgJ/Ge5TF8Fc6eKSYpYXYDL87nZ0LUoxdmv+OLFToFBA1A8vIZAnd9QjcLqHt+
         RsniGDq7tB2gP/3Vamp8T1jrRdQurIcL5wOXid2gxJ4I7LUbs8JcNfr4pJAsUIHSuMYE
         QCsmQTehfPeVFLndmgLxP9yTVpR0mf77VIlff/gN8QLI17WX82cKO4gTDgUBEEz2i9/H
         gto5aZerGDL0KRLxruuejdGRtg2zuTtgMxWC+VAH5b0Qp/9hlzTm10bkP0FVicJtBuvs
         Q6ug==
X-Gm-Message-State: ACrzQf1srbFd8yu0qq1rc6+/M/P0p9DLgYIRjGDWpOKNCCKaQ0Bwnpxx
        WwBdlAyEWN0kzt8rvg/+UlkpM92AF1XyQw==
X-Google-Smtp-Source: AMsMyM6qceEYubm9CXUHhRWKO97jTt1fHDzHiVVhvvvXLjxHA5bZC4Jiy7begCXZ60W2LAc8Rfi0lA==
X-Received: by 2002:a2e:a9a9:0:b0:261:bf5a:8ff3 with SMTP id x41-20020a2ea9a9000000b00261bf5a8ff3mr5926333ljq.252.1664782361354;
        Mon, 03 Oct 2022 00:32:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b0048b26d4bb64sm1357833lfb.40.2022.10.03.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 00:32:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: late (3rd) for v6.1
Date:   Mon,  3 Oct 2022 09:32:37 +0200
Message-Id: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
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

Hi,

Late pull for v6.1 with minor stuff - cleanups and bindings fix.

Best regards,
Krzysztof


The following changes since commit 5514acb0dd030356e628cdd88b266efaa0a22315:

  dt-bindings: memory: snps,dw-umctl2-ddrc: Extend schema with IRQs/resets/clocks props (2022-09-21 20:34:58 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.1-3

for you to fetch changes up to 56efd6435c6890a3a38a33d192a0f9d5c835a24b:

  memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code (2022-09-28 09:30:23 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.1, part 3

1. STM32 FMC2: correct in bindings the name of property for address
   setup duration. The DTS and driver were already using proper name,
   so it is only alignment of bindings with real usage.
2. Tegra MC: simplify with DEFINE_SHOW_ATTRIBUTE.

----------------------------------------------------------------
Liu Shixin (4):
      memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code

Marek Vasut (1):
      dt-bindings: memory-controller: st,stm32: Fix st,fmc2_ebi-cs-write-address-setup-ns

 .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml    |  2 +-
 drivers/memory/tegra/tegra186-emc.c                       | 15 +--------------
 drivers/memory/tegra/tegra20-emc.c                        | 15 +--------------
 drivers/memory/tegra/tegra210-emc-core.c                  | 15 +--------------
 drivers/memory/tegra/tegra30-emc.c                        | 15 +--------------
 5 files changed, 5 insertions(+), 57 deletions(-)
