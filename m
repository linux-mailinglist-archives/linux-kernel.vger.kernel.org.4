Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD595BAD48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiIPMVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiIPMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF07B08A8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so3259883wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dF72m7KrdimfS7GHUBTDYOHCGMGUiN/89ZHcjz/LfhQ=;
        b=FkLYyLdYF5oafat2zG9jS43r89Rkz8Ll3QzJDimI6YKT+S5aqCqgyQEBk4A2EQPrH/
         5o/oLT+cfTGWtMSmKdV/Y7OPX9S6pZ+PQEIYjH7ULuf7AKjcO9Yt7eF/w4OZKPlwSSKk
         vWURi8F+nbodqjvsIydn4qufMTJMRfJ1gb1fYzUyrnLSAdBGsjlJ0bcwjy5u1AY50WWD
         EFYcdFIJQaJSy3eSt0CXnPpn/BkfomK4s9itYVO/ZiN4tMqE6e4Pk/bvE9W2Vq+1mRxI
         2x3agaFjiDGuEThC/n10QxVM5yjrwwVKaiVxI37dBxo1OKsTtp1R3+U2bqXfCgrlxE6r
         h5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dF72m7KrdimfS7GHUBTDYOHCGMGUiN/89ZHcjz/LfhQ=;
        b=zJC3SJU4UZRdAJSGHC2VPlNumwNP7ZV/GXYrJfON8Jko2RQ01D2VzuhqDjFy8d+Ywk
         d4AGvfHSeM9PpdtrICPLIVZfaLAnSIbOPQnpAsfKpV7C1cirgNnalTus8FMtbnjOoejg
         AR7h3GUG+dx7pzG/7V5q1JWDe80A3QqlwRTIdT0gfdQoCUmMaswa87nC0Jt0n1BBxClg
         dwlBG6AFXMAlupvNSGIcjwbFR3OdgEFiZhGX1QW9vzToq191wkr2miwnuwrDgkT12L6a
         9ldC85kwE/t+fEDaZthd4acGx2t+SaJhHmoKC0iMLdjN1eu181uHeqs2HuMHp0pYTTwH
         aqUQ==
X-Gm-Message-State: ACrzQf24tHdeRseUGEooMimAk2rk2zP/zeigceXsnkXWFxwiUPKjESTB
        5QHfga2PDOaKlKJ9WUk1UIz/Mg==
X-Google-Smtp-Source: AMsMyM4TcI3gOkZxDJZdsIN3awAwLcdcFm/yXTDOyL5UAJz8kt607DReTVHpClZIqcbbnDGBCug+aQ==
X-Received: by 2002:a5d:47c3:0:b0:22a:2e9f:b839 with SMTP id o3-20020a5d47c3000000b0022a2e9fb839mr2791693wrc.72.1663330865338;
        Fri, 16 Sep 2022 05:21:05 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/13] nvmem: patches(set 1) for 6.1
Date:   Fri, 16 Sep 2022 13:20:47 +0100
Message-Id: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 6.1, which includes

- Cleanups to Kconfig and Makefile for consistency reasons, which also
  updates some defconfig
- new lan9662 nvmem provider
- new u-boot-env nvmem provider to handle u-boot environment variables.
- support for sm6115, ipq8064, sdm630 in qfprom nvmem provider.
- mt8188 support in mediatek nvmem provider
- few cleanups in core to handing error cases for dev_set_name.
- few minor updates to u-boot-env provider. 

Can you please queue them up for 6.1.

Thanks,
Srini

Gaosheng Cui (1):
  nvmem: core: add error handling for dev_set_name

Horatiu Vultur (2):
  dt-bindings: lan9662-otpc: document Lan9662 OTPC
  nvmem: lan9662-otp: add support

Iskren Chernev (1):
  dt-bindings: nvmem: Add SoC compatible for sm6115

Johnson Wang (1):
  dt-bindings: nvmem: mediatek: efuse: Add support for MT8188

Kenneth Lee (1):
  nvmem: brcm_nvram: Use kzalloc for allocating only one element

Krzysztof Kozlowski (1):
  dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles

Rafał Miłecki (6):
  nvmem: add driver handling U-Boot environment variables
  mtd: allow getting MTD device associated with a specific DT node
  nvmem: prefix all symbols with NVMEM_
  nvmem: sort config symbols alphabetically
  nvmem: u-boot-env: find Device Tree nodes for NVMEM cells
  nvmem: u-boot-env: fix crc32 casting type

 .../bindings/nvmem/mediatek,efuse.yaml        |   1 +
 .../nvmem/microchip,lan9662-otpc.yaml         |  45 +++
 .../bindings/nvmem/qcom,qfprom.yaml           |   3 +
 MAINTAINERS                                   |   1 +
 arch/arm/configs/multi_v7_defconfig           |   6 +-
 arch/arm/configs/qcom_defconfig               |   2 +-
 arch/arm64/configs/defconfig                  |  10 +-
 arch/mips/configs/ci20_defconfig              |   2 +-
 drivers/cpufreq/Kconfig.arm                   |   2 +-
 drivers/mtd/mtdcore.c                         |  28 ++
 drivers/nvmem/Kconfig                         | 313 ++++++++++--------
 drivers/nvmem/Makefile                        | 120 +++----
 drivers/nvmem/brcm_nvram.c                    |   2 +-
 drivers/nvmem/core.c                          |  12 +-
 drivers/nvmem/lan9662-otpc.c                  | 222 +++++++++++++
 drivers/nvmem/u-boot-env.c                    | 219 ++++++++++++
 drivers/soc/mediatek/Kconfig                  |   2 +-
 drivers/thermal/qcom/Kconfig                  |   2 +-
 include/linux/mtd/mtd.h                       |   1 +
 19 files changed, 773 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
 create mode 100644 drivers/nvmem/lan9662-otpc.c
 create mode 100644 drivers/nvmem/u-boot-env.c

-- 
2.25.1

