Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FAB5B3BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIIPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIIPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32974895EB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:31:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so2254859ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qqz7LHKRHVaoBiZoiumJLitP17O6Oint8yglVlrai4s=;
        b=PSpFpfjKN2y/TrOsKNxcmdgd+5wXlNhYGsbAqWLPETGjp4CDScRHLyqVZ5wL6BU42t
         +h0PkVRBFgZ8/9Uz74k8hYYg7XkVGGmm9/eGijvPyEX8MV6hd1lbUNDem3G4rFuui78A
         JrJrlU0E+XPAxRnwzvGJ5yLggMgpHPpycOwxeWww45DVJGvjEM6u8hsz0N7kKtomErvt
         6158pRR9MglwLw0z3pHXP8F7FA7duWG2lsyhzHayP7M/n6vVs0s1DSc5U/EPS5gq2Sb/
         HZ2XOCYy1s2GYfZRQnlk/bvIPvEfH5W0mE0WoITMF+X8f2rb4JrxKaPRK9QCdBmGp+EH
         BC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qqz7LHKRHVaoBiZoiumJLitP17O6Oint8yglVlrai4s=;
        b=F+V1m8/880LuVKiMd49hC2RPIDWj8VjeJinDi8suP8j96ZCnEJ0qsSeounR0TFLKhn
         uOezsAWtgbwS86jrA3T5OWLvkdRxDs9YbJMavMJPoNXikbLE6qEV424Pxj7sHqx3zxhj
         QxUU9ckWGsEgs7npV/4XG+KOwXgaVIFvDuNxgdI4sxdWFZ3Xbdq580DwpGEcEx8VR2lb
         nALBZoytYw+HU7ub5cd8YaN0sMeqZQKQuAkfB0xTZ5LCwrjAFsYd7eGX96lDAnFmmqb3
         Y7uuqSOWr67zghwDDtuKCovKbUG9c38R0hTgiRFAOeGyaR6fOOvzxYKbGWwP78AxIE6R
         uILQ==
X-Gm-Message-State: ACgBeo3UAOZr9bYG2M6ryaLiPLhVa7D1w7lDD07jZEktBRHJchwLSjdw
        1rignGcp22r6zKeZNiRv0P51DA==
X-Google-Smtp-Source: AA6agR6jeR9XLXaOttj2Wp7lcRgPEsrFlZ8hWAwELjUJ5ux5burtC8n4cUVGvnuyBFny/FoBEhCV8w==
X-Received: by 2002:a2e:1f12:0:b0:261:962d:26a1 with SMTP id f18-20020a2e1f12000000b00261962d26a1mr4350368ljf.521.1662737447264;
        Fri, 09 Sep 2022 08:30:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0026ac3fedd20sm117314ljr.86.2022.09.09.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:30:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/4] memory: brcm for v6.1
Date:   Fri,  9 Sep 2022 17:30:36 +0200
Message-Id: <20220909153037.824092-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
References: <20220909153037.824092-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Topic branch.

Best regards,
Krzysztof


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-brcm-6.1

for you to fetch changes up to a4be90ff7a7d22a5a781ed2bb3c2d4b2f535a515:

  memory: brcmstb_memc: Add Broadcom STB memory controller driver (2022-08-18 09:11:45 +0300)

----------------------------------------------------------------
Memory controller drivers for v6.1 - Broadcom

Add support for the Broadcom STB memory controller (BRCMSTB_MEMC).

----------------------------------------------------------------
Florian Fainelli (3):
      dt-bindings: memory-controller: Document Broadcom STB MEMC
      Documentation: sysfs: Document Broadcom STB memc sysfs knobs
      memory: brcmstb_memc: Add Broadcom STB memory controller driver

 .../ABI/testing/sysfs-platform-brcmstb-memc        |  15 +
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |  11 +-
 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |  52 ++++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/brcmstb_memc.c                      | 301 +++++++++++++++++++++
 6 files changed, 380 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c
