Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D033F6741CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjASTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjASS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:59:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651894C87;
        Thu, 19 Jan 2023 10:59:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1980158wmc.1;
        Thu, 19 Jan 2023 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zctZ2DfOPnSiD7ZptxyzEXDvaTUy3vq5hDZIJ2ooBA=;
        b=My6BTbzil3RwSeY6SKZ8mEjCQLPA8sVElBsVAqSRdZSqB0wHVzqey9b9QAb8ih0ulw
         Rj59HIWe0fERei0NJSXTJUMhIaQtCA90vgaADnLEMjX60IstGO1Ibm9lga94MIW//wQb
         aBVkX6eQ5mlg28k8QzgMo6G7qUsdyhn79L2UPVhu/lol11tIl4//vjUR27yWYgzZoJ0L
         0tDY3/ZJcfkpSFfvM2FRnFI8n5cr2cIQCFS/LztDvnxA+kxW206mI1oE5AUOH4CbZAEp
         FjpMQtYOsIBX4nm7quPN0/Hx5L9yMb73F9a1CynoUADVlWTsM2UgVdN2GucKAqHdSl8P
         2CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zctZ2DfOPnSiD7ZptxyzEXDvaTUy3vq5hDZIJ2ooBA=;
        b=SFyVQ3SLgE3KUrY1cAO1EsGoi0Z2j9YS/TaopF4ADaWHdSi0Y1OnfwFcFCccdYtXHd
         ldLaInq4MOnt+h2HQugyqV4BNBKHRKPt409lhMbA5RaFHChbbn+EjrOicxNX8tEor55b
         FC3rrTZNI3iMl+LRQjf9zlqgs81hsjB+XJJ5i9cFyo3sDqyqT/tXuMXUBYnqGAx/D2KH
         ajLAXBMMMgyAuHUErUqgk6tb2FZnQPYrB/V1CAbXQPUwk8TYUheEjM4fM+PzO9Nm+iBn
         IxTFUsBlsOsQMLgaTW0N+b2hA7t1L+zi+cgAfnkkuMg4MUQiKSURu0O4puwlX8/SMbq2
         f1KQ==
X-Gm-Message-State: AFqh2koMi0AqRBfxXYGgznvKfEPZkKCtGIQvJhngE5cfoHPkyr4DwJ5s
        UfV8gdeuzLmPBu5M/MRwNns8XqZugE4=
X-Google-Smtp-Source: AMrXdXvwGx3rijOtSmLzSWCy6TFXUhQR1BI7Fx77MhzLOOjjgleAtnn2wM96S08SIOPNQ/8C+OufGA==
X-Received: by 2002:a05:600c:ccf:b0:3db:f34:e9e0 with SMTP id fk15-20020a05600c0ccf00b003db0f34e9e0mr8086140wmb.35.1674154738190;
        Thu, 19 Jan 2023 10:58:58 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003daf6e3bc2fsm7757544wmq.1.2023.01.19.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:58:57 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support for Samsung Galaxy S5 (Exynos)
Date:   Thu, 19 Jan 2023 20:58:42 +0200
Message-Id: <20230119185848.156502-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Galaxy S5 (Exynos) is a mobile phone released in 2014.
It has an Exynos5422 platform. This version of Galaxy S5 is only
capable of 3G communication using the Intel modem, while the
LTE version of the device (klte) has a Qualcomm Snapdragon SoC.

Currently, internal eMMC, USB, regulators on a PMIC, and touchscreen
are enabled in the device-tree.

It also has the following peripherals:

- 5" 1080p S6E3FA2 DSI display,
- Cypress StreetFighter touch buttons,
- Broadcom BCM4354 wireless connectivity module,
- Intel XMM6360 3G modem,
- STM32F401 serving as a sensor hub,
- Validify Solutions VFS61 series fingerprint sensor,
- Lattice ICE401M FPGA as an IRDA controller,
- Maxim MAX86900 heart rate sensor,
- NXP PN547 NFC controller,
- Wolfson WM5110 Audio DSP,
- Broadcom BCM4753 GPS radio,
- Maxim MAX77804 PMIC,
- Silicon Image SII8240 MHL controller,
- TI LP5562 LED driver


Markuss Broks (2):
  Documentation: devicetree: bindings: Add compatible for Samsung Galaxy
    S5 (Exynos)
  arm: dts: Add device-tree for Samsung Galaxy S5 (Exynos)

 .../bindings/arm/samsung/samsung-boards.yaml  |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts  | 676 ++++++++++++++++++
 3 files changed, 678 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-samsung-k3g.dts

-- 
2.39.0

