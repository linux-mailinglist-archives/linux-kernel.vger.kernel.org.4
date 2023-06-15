Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D77731FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbjFOS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFOS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:43 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5812A7;
        Thu, 15 Jun 2023 11:29:42 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so8061301f8f.1;
        Thu, 15 Jun 2023 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853781; x=1689445781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8i3hO6Asw9z4pBJsjq1JNXvz4oP43/hziP/VGcJWDw=;
        b=NMaDZHnDQ3Z7ZmSAQTNabAZvQhaN6MlPLivFhypaF4Osrc9bPn8oStXT7dDFcwREbH
         spKHCOcDlCUls045W042NqKFqb0IXj88a5cWvjTuTFcPPEhJMj/MbrJY3aKstPJGGW7c
         ckz9ld2O1pSW5l0PqqcQnOieFPPbVmfQi8xhNLA90yDIPwTrcAXX5OIUw5AIgpNj84dq
         iPDOTe8j0bkzbF7i7D4gtgaNjB2Ark+pgNSMDCxSe6udXwKYvlcENirEIeeOsZ1dGDdd
         tJlIWm7Yfu+f4njbfV8ban3J9jteDFQMuhMZSYlqjS/vE2L+tl6l6fdJnRz3jLhYF6LY
         3crQ==
X-Gm-Message-State: AC+VfDxbjV+17RjI7JOn2IDkWmJNass3LA/ZHoHvSIopw7PZnT0RHSLR
        tqBV17pOKBLO02o52iUuT3c=
X-Google-Smtp-Source: ACHHUZ5bNKCVo0ONW/4FCdjDRxW3DorS7WwJat8TD6mIj0BzMMV2c0ZYkNZEQqcZAdMqee8pptpPRQ==
X-Received: by 2002:adf:f810:0:b0:30f:d32c:ed8e with SMTP id s16-20020adff810000000b0030fd32ced8emr4950226wrp.45.1686853781021;
        Thu, 15 Jun 2023 11:29:41 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:40 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH 0/6] Add Amlogic A311D2 and Khadas Vim4 Board Support
Date:   Thu, 15 Jun 2023 19:29:32 +0100
Message-ID: <20230615182938.18487-1-tanure@linux.com>
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

The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic
Meson T7 SoC family. This chip is not the same as A311D used in Vim3
board.

Work based on Khadas 5.4 branch:
https://github.com/khadas/linux/tree/khadas-vims-5.4.y

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

Lucas Tanure (6):
  dt-bindings: arm: amlogic: add Amlogic T7 based Khadas VIM4 bindings
  dt-bindings: clock: Bindings for Meson T7 clock controller
  clk: meson: t7: add peripheral clock controller
  dt-bindings: serial: amlogic, meson-uart: support T7
  tty: serial: meson: Added T7 SOC compatibility
  arm64: dts: meson-t7-a311d2-khadas-vim4: add initial device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |    7 +
 .../bindings/clock/amlogic,mesont7.yaml       |   69 +
 .../bindings/serial/amlogic,meson-uart.yaml   |    1 +
 arch/arm64/boot/dts/amlogic/Makefile          |    1 +
 .../amlogic/meson-t7-a311d2-khadas-vim4.dts   |  112 +
 arch/arm64/boot/dts/amlogic/meson-t7.dtsi     |  202 +
 drivers/clk/meson/Kconfig                     |   17 +
 drivers/clk/meson/Makefile                    |    1 +
 drivers/clk/meson/t7.c                        | 8014 +++++++++++++++++
 drivers/clk/meson/t7.h                        |  235 +
 drivers/tty/serial/meson_uart.c               |    4 +
 include/dt-bindings/clock/mesont7-clkc.h      |  487 +
 12 files changed, 9150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7.dtsi
 create mode 100644 drivers/clk/meson/t7.c
 create mode 100644 drivers/clk/meson/t7.h
 create mode 100644 include/dt-bindings/clock/mesont7-clkc.h

--
2.41.0

