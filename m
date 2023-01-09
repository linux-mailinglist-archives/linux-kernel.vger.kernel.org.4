Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC34662943
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjAIPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjAIPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:03:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E91D0E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:03:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so13424423lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw0Nabwis8nZFJhL3dT5aarZI1LrhYRX+Cvdj6bBSXY=;
        b=Ph0KeMW9SdSz5EEupchb6zMNlMrk+LwhbzEukR97CnovrcQtWZObFSK6xHcmGZzfj4
         vYQeTFjLm6YtIDVONeLhi10jrZC4KJbqS050DDOppOf3fT1lYg2qtIeqoeEb9YBvGPxe
         EiFsL0pv5eil1RF75TYXTJIq8NtH0/ZZ8/MiN30vrG3PWKaF7pfPZxv9NTrAfbDGCOB1
         4jkRDSReI86V+pKTvvLmg3HOdXB2n2TRkFCtTxG2Xoa/2DyHN3lytLasB72G5A0jX7mh
         MgGu7FNTf6YfHpRpKEJj0pi1zCROeP/wUYrg7xGOvEy5xmC+j5of3IacyyVev82RqQnp
         MCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw0Nabwis8nZFJhL3dT5aarZI1LrhYRX+Cvdj6bBSXY=;
        b=txPrsjR32bVusR24OPMsmRYxcQe08+eqWezewDitONwwCTJSj+Jyk3TQDxf/a49nq4
         79DCZiCPgnqmqTKVrIlDrZw1q69q7ySZibtGqxcFI0ENdoKpTBsoxA0e8kn7jmAICTMQ
         VHkg9CDynFVml22wLnQhwr7bvfILKGghBvpbjQqk0Bj10alGZMh2P6pHrPy2pFHDawaS
         6ENhhBIceff3X9JoKRK+uio/ZoDiSTsJ7V0iKLAtNCqqWIqP99uJ1KBOvkSPagV15JA4
         Gv4TOzRLHlVfjOyvVKU+TalP2JLciPdT8NuNm+o7vy3P5bJiz2plETm/66x4cyGw2erf
         SaMA==
X-Gm-Message-State: AFqh2kpHrOAO65eEgZBQi7ZNmGAF+LN1wedyk7aXega8AaGVbdMxSLE8
        iyaAipbxW4CkRox4pjb67bILNw==
X-Google-Smtp-Source: AMrXdXt56g+/SbNOrq1lyMbVPkBMyV0C2TXhgpSaj8ud3LwBAMryXyBCIp7wPikUmVCbKZ+efHmQ4w==
X-Received: by 2002:a05:6512:20d0:b0:4b5:88e4:2ba4 with SMTP id u16-20020a05651220d000b004b588e42ba4mr15866201lfr.15.1673276605590;
        Mon, 09 Jan 2023 07:03:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm2956202wmc.6.2023.01.09.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:03:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: fixes: Fixes for v6.2
Date:   Mon,  9 Jan 2023 16:03:22 +0100
Message-Id: <20230109150322.329614-1-krzysztof.kozlowski@linaro.org>
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

One thing broken in merge window, few commits for older issues.

Best regards,
Krzysztof


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-fixes-6.2

for you to fetch changes up to cb8fd6f75775165390ededea8799b60d93d9fe3e:

  memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe() (2022-12-27 09:54:32 +0100)

----------------------------------------------------------------
Memory controller drivers - fixes for v6.2

Broken in v6.2:
1. OMAP GPMC: do not fail if "gpmc,wait-pin" optional property
   (introduced for v6.2) is missing.

Broken earlier:
1. Tegra MC: Drop SID override programming as it is handled by
   bootloader and doing it in the kernel can cause unexpected results.
2. Atmel SDRAMC, MVEBU devbus: Add missing clock unprepare/disable in
   exit and error paths.

----------------------------------------------------------------
Ashish Mhetre (1):
      memory: tegra: Remove clients SID override programming

Benedikt Niedermayr (1):
      memory: omap-gpmc: fix wait pin validation

Gaosheng Cui (2):
      memory: atmel-sdramc: Fix missing clk_disable_unprepare in atmel_ramc_probe()
      memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe()

 drivers/memory/atmel-sdramc.c   |  6 ++----
 drivers/memory/mvebu-devbus.c   |  3 +--
 drivers/memory/omap-gpmc.c      |  3 ++-
 drivers/memory/tegra/tegra186.c | 36 ------------------------------------
 4 files changed, 5 insertions(+), 43 deletions(-)
