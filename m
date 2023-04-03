Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0E6D4D52
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:14:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94A10FC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:14:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so119512099edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680538470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4L3DXDw+rPCXmzKTDiK+3ai07bE4enDVUdfQ3XZnOM=;
        b=JDRoUWbIVadBNxnsD8FFYLW7AuITxTUXwX3xdwX6RNSAYEyIQ+biBbpCkF16oaq9bQ
         416XY92YW9cDZp7Gk4OjNG+ilJvXUDf6cv0GJvKmnrvjPnYqmeHJ8FmoC+0Z/v/kqPil
         XmsuGa5brUm3IZl4+AX9zex8XYTNVM4+hgS8185zv6oCDVXN3T9P3lrertndNPsWpu54
         Le42lby9c0nCmgKXGoANFbRn9n0UZWNR2iclkD2c7GGUrd10NW3326TuyoWOXFABQNL1
         1AvtkCx9I2yLc5mzYwpuhzQEXiu0EpowEHDC8jQYKpyfcbzHLPCrLagU2wpj4GdbpsOz
         0hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4L3DXDw+rPCXmzKTDiK+3ai07bE4enDVUdfQ3XZnOM=;
        b=glAeKJp9hSmjWmVR7O01cn8kviVl42pOq/Pd27rwEuTp2KRMVz+rdc8kEMXS3v+pLt
         9JNnzhbg+ZXs8teuD07WSxOKcNc6lctHs07WMMjPFprDhIBjYeNU/cFul668wamNfKOH
         dJmq1ZwLkHPpmJ065o4fkqun4KVP9iRLBgVREEmNlWvrIzT0nILjwsxHvxAehBvYwE3Y
         y2HvYTd+TdMp/NuVINn2s/2GKTxocjIb5f2L2iNvEJytgeI6dT9SRBuKiJzusiQKQW7Y
         7hDDMYp67aWR7kI1ISjCI8oM3RGVOAbLnJvT8Qj8WH+Ir8/J7pQvxH2egxvgy7ukfEgC
         21yw==
X-Gm-Message-State: AAQBX9fJflHisizyxyVbQNFlTMYo3IB5yLtHyKO3ltbTVvN4x1QTtTK0
        2fcQEv80qdXdq7U9mRV/pGciGsE7P4HAYiY/aQU=
X-Google-Smtp-Source: AKy350Z3xCJXIC+Hli76zppu9pCredWqfD5VdWlKk07M12aYUrThxhmHTTPbZfExtPuGaP2tIhW6Zg==
X-Received: by 2002:a17:907:3e93:b0:947:793d:b5c4 with SMTP id hs19-20020a1709073e9300b00947793db5c4mr16523759ejc.64.1680538470292;
        Mon, 03 Apr 2023 09:14:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906825800b008bc8ad41646sm4725234ejx.157.2023.04.03.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:14:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.4
Date:   Mon,  3 Apr 2023 18:14:27 +0200
Message-Id: <20230403161427.328128-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.4

for you to fetch changes up to 69d170c4c28ba0490bd42630cc09d7e1834bbb3d:

  dt-bindings: memory-controller: Drop unneeded quotes (2023-03-31 21:53:15 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.4

1. STM32 FMC2: allow using driver on all STM32MP SoCs.
2. Cleanups:
   - Atmel EBI: use preferred of_property_present() API.
   - Tegra210 MC: drop redundant variable initialization.
   - Drop redundant quotes in Devicetree bindings.
   - Remove MODULE_LICENSE in non-modules (several drivers).

----------------------------------------------------------------
Christophe Kerello (1):
      memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of MACH_STM32MP157

Diogo Ivo (1):
      memory: tegra: remove redundant variable initialization

Nick Alcock (2):
      memory: tegra: remove MODULE_LICENSE in non-modules
      memory: remove MODULE_LICENSE in non-modules

Rob Herring (2):
      memory: atmel-ebi: Use of_property_present() for testing DT property presence
      dt-bindings: memory-controller: Drop unneeded quotes

 .../devicetree/bindings/memory-controllers/renesas,dbsc.yaml        | 4 ++--
 .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml      | 2 +-
 .../bindings/memory-controllers/samsung,exynos5422-dmc.yaml         | 6 +++---
 drivers/memory/Kconfig                                              | 2 +-
 drivers/memory/atmel-ebi.c                                          | 2 +-
 drivers/memory/bt1-l2-ctl.c                                         | 1 -
 drivers/memory/da8xx-ddrctl.c                                       | 1 -
 drivers/memory/fsl_ifc.c                                            | 1 -
 drivers/memory/mvebu-devbus.c                                       | 1 -
 drivers/memory/tegra/mc.c                                           | 1 -
 drivers/memory/tegra/tegra186-emc.c                                 | 1 -
 drivers/memory/tegra/tegra210-emc-table.c                           | 2 --
 12 files changed, 8 insertions(+), 16 deletions(-)
