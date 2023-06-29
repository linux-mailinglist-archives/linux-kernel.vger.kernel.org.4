Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFB74211E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjF2HfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjF2HeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:24 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E772D7D;
        Thu, 29 Jun 2023 00:34:23 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso319980a12.2;
        Thu, 29 Jun 2023 00:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024061; x=1690616061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rif8333vFODJ+ZtIJl2mdLq4SmOl1BT5+ld0NPLKn6E=;
        b=eoJBMXdyGpUnanQPl81SIFaY13a+p8Gz3o60xl/L2YtHEGni8lTxGXCvZ/0fJYsjbz
         RZakFEGjKRN9/IQHSDjrsDho5snzrzF1SwHrVhFJ0fG7LLc1NUub3rhiDvKQXQQliYqd
         q2Ss7gWmzJy3UyHbBJueWBglkczfWkoZaqRxJyreJCDe2TC5JYgTtgqBP22go/BetoIB
         s49MSd0wi49pCvXitTvYTGvLSHe9Q5np7Ud5iP/1bVw/wBShYvWcbniNAJ8DxPIR+4IO
         DtG+C9OYpPxQKYs7c3P0PNVY7B9ldKlvqaLebV5L9fyi6EH5yemp3ENGa53yiokitWW3
         mxdg==
X-Gm-Message-State: AC+VfDwFe4iebwzf/lR95rtYDJIbG6KB/zS9q+YhQiluioQ3Mt1HZNHw
        RawAVfqFaCfEhvdV3wd8xKQ=
X-Google-Smtp-Source: ACHHUZ4/3jnZwWO5KJgttycbpIu/mlo3hiu1rv2BbfxFKwx5r5WS7JaU2JXRhKzXqDd+tg8BrAta6Q==
X-Received: by 2002:aa7:c7d7:0:b0:518:7437:bd9f with SMTP id o23-20020aa7c7d7000000b005187437bd9fmr26625569eds.24.1688024061407;
        Thu, 29 Jun 2023 00:34:21 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm5453716edb.39.2023.06.29.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:34:20 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v7 0/4] Add Amlogic A311D2 and Khadas Vim4 Board Support
Date:   Thu, 29 Jun 2023 08:34:15 +0100
Message-ID: <20230629073419.207886-1-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 family.
This chip is not the same as A311D used in Vim3 board.

Work based on Khadas 5.4 branch:
https://github.com/khadas/linux/tree/khadas-vims-5.4.y

The current status is Vim4 board booting to emergency shell via uart.

Board Features:
- 8GB LPDDR4X 2016MHz
- 32GB eMMC 5.1 storage
- 32MB SPI flash
- 10/100/1000 Base-T Ethernet
- AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
- HDMI 2.1 video
- HDMI Input
- 1x USB 2.0 + 1x USB 3.0 ports
- 1x USB-C (power) with USB 2.0 OTG
- 3x LED's (1x red, 1x blue, 1x white)
- 3x buttons (power, function, reset)
- M2 socket with PCIe, USB, ADC & I2C
- 40pin GPIO Header
- 1x micro SD card slot

Changes Since v6:
 - Move Uart clock to amlogic-t7-a311d2-khadas-vim4 dts
 - Fix GIC_CPU_MASK_SIMPLE
 - Lowercase uart label

Changes Since v5:
 - Remove meson as T7 its not a meson chip
 - Change Uart Document descript to S4 compatibles

Changes Since v4:
 - Use S4 instead of G12a for uart fallback
 - Add OF_EARLYCON_DECLARE for T7 uart

Changes Since v3:
 - Fix issues with "amlogic,meson-t7-uart" documentation

Changes Since v2:
 - Add "amlogic,meson-t7-uart" documentation

Changes Since v1:
 - Drop the T7 clock driver as it is not needed for serial boot. It will
 later use the S4 clock
 driver as S4 and  T7 seems to be similar chips.
 - Use "arm,gic-400" for interrupt controller to fix dtb_check
 - Remove CPU node properties not needed for serial boot
 - Move UART node to apb4 node
 - Drop T7 UART compatible line and use S4 uart
 - Use psci V1 instead of 0.2, it works, but I can't verify is correct
 as the datasheet I have
 doesn't contain that information.
 - Remove compatible from meson-t7.dtsi, move it to vim4 board dts
 - Add memory node with 8GB. Not sure about this one, works without,
 but doesn't detect 8GB
 - Use defines for GIC_CPU_MASK_SIMPLE, IRQ_TYPE_LEVEL_LOW,
 IRQ_TYPE_LEVEL_HIGH instead of hardcoded values

Lucas Tanure (4):
  dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
  dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
  tty: serial: meson: Add a earlycon for the T7 SoC
  arm64: dts: amlogic-t7-a311d2-khadas-vim4: add initial device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |   7 +
 .../bindings/serial/amlogic,meson-uart.yaml   |   4 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  54 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 155 ++++++++++++++++++
 drivers/tty/serial/meson_uart.c               |   2 +
 6 files changed, 223 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi

--
2.41.0

