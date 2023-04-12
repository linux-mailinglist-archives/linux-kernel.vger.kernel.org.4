Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE86DEB34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLFie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:38:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98853E54;
        Tue, 11 Apr 2023 22:38:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so2504384pjb.2;
        Tue, 11 Apr 2023 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277910; x=1683869910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ5EPk/rBwmvqFGrKEXFTIKV8AeokEWBFTZ+5E+TvM8=;
        b=m9YNYlw1mPpE7XoXE6NDimg/rubLCvWXBQ2s1Xol6+b4VutexD4sXRnxV17AxTZPGF
         p8QItnPfvf+Jcp+DN3fwV7ofWjObDZEmMupdY0mCMhlf+XAWVV8KlIZZMOxFNSNZjXgM
         IttVDYgOtEYTkowoQKhyNBOHy+d9qUJN41HojmMPBtS1Z5ARnkFhugjubUBP9X76z0rg
         arVdMAWNMrKfCeF74qNdSh9xMXYj/8g52IdyRs9/KLoqtHmLP8IfczTT2g+yFo583Wv/
         Skg6Q3R0i58BKVJ3WS4AaNClvhyjcAv74l/Fsr3koBfo845xJxsENg8Lj+LPoCqcOwjx
         IQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277910; x=1683869910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZ5EPk/rBwmvqFGrKEXFTIKV8AeokEWBFTZ+5E+TvM8=;
        b=5oBH/YoLwhdV5brjdLNJnE/MK7LPshCZ4mc8s2Wf5VmKtQfQLqLlOODKr94QV23ycA
         tVUwqLxAOjj/Rr5wLSsWT4HrDI6k1tTRvsvuwotH0n6ZjHWJTO0D53MZ7O1E04p9rqha
         Inojc1RVqyRDz5YbLy0Gy6ycJKa1fYXM3Q4uxPR8VM+wqmlV1WaKWF1VO5WQIzNUdkjt
         EK38AgsekkrbGgIXwphxvp4b5R+Q+5qXmFf3gVzdQi2Jlm4gHCQc0TfR6NwGvcQeZL5H
         9KUmjctBk3hlFgrJxOa1Jr50azDnzzNvD9dX20UjxEaOOrnhl+wFWNBtSnbLo5+2pOit
         Jrxg==
X-Gm-Message-State: AAQBX9cjCHRKpjE7ohTrOqM23Z/GIAV0a5VO0r4RrCrOETm7s77NDrj7
        DhbCuftig0I8aJYrRaw+6/0=
X-Google-Smtp-Source: AKy350Y8XmH9OnEK+rBhENYKrltXt0aylXxMwFjM2p9kyJHf7/ov97SakfILZf8y1VL5cZ425VXj1w==
X-Received: by 2002:a17:90a:ce07:b0:246:c097:6a17 with SMTP id f7-20020a17090ace0700b00246c0976a17mr1117410pju.24.1681277909845;
        Tue, 11 Apr 2023 22:38:29 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:29 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 00/12] Introduce Nuvoton ma35d1 SoC
Date:   Wed, 12 Apr 2023 05:38:12 +0000
Message-Id: <20230412053824.106-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This patchset adds initial support for the Nuvoton ma35d1 SoC, including
initial device tree, clock driver, reset driver, and serial driver.

This patchset cover letter is based from the initial support for Nuvoton
ma35d1 to keep tracking the version history.

This patchset had been applied to Linux kernel 6.3.0-rc6 and tested on the
Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

v7:
  - Fixed dts system-management node and compatible driver
  - move 'nuvoton,npcm-gcr.yaml' from 'binding/arm/nuvoton' to 'binding/soc/nuvoton'
  - In ma35d1.dtsi, create the soc node for ma35d1 SoC
  - Modify the issues found in serial driver
  - Modify the issues found in clock driver
  - Modify the IDs of reset driver to be contiguous numbers and use lookup table
    to find register offset and bit position.

v6:
  - Combine nuvoton,ma35d1-clk.yaml and nuvoton,ma35d1-clk.h into one patch
  - Combine nuvoton,ma35d1-reset.yaml and nuvoton,ma35d1-reset.h into one patch
  - rename Documentation/devicetree/bindings/arm/npcm directory as nuvoton
  - Remove patch for adding include/linux/mfd/ma35d1-sys.h as it's not required
  - Update dtsi & dts files and move board-specific nodes to dts
  - Modify reset driver
  - Modify serial driver, fix coding style issues
  - Modify clock driver, rewrite the PLL calculation functions

v5:
  - Add ARCH_NUVOTON to arm64 Kconfig
  - Add ARCH_NUVOTON to defconfig
  - Add the clock driver
  - Add the reset driver
  - Add the serial driver
  - Add us to the maintainer

v4:
  - patch 4/5 is a resend
  - Fixed dt_binding_check errors of nuvoton,ma35d1-clk.yaml
  - Modify ma35d1.dtsi
    1. Add a node hxt_24m
    2. Fixed the base address of gic node
    3. Add clocks and clock-names to clock node
  - Fixed borad binding mistakes of nuvoton.yaml

v3:
  - added patch 4/5 and 5/5
  - introduce CONFIG_ARCH_NUVOTON option
  - add initial bindings for Nuvoton Platform boards
  - fixed coding style problem of nuvoton,ma35d1-clk.h
  - added CAPLL to clock-controller node
  - modify the chosen node of ma35d1-evb.dts
  - modify clock yaml "clk-pll-mode" to "nuvoton,clk-pll-mode"

v2:
  - fixed dt_binding_check failed of nuvoton,ma35d1-clk.yaml

Jacky Huang (12):
  arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
  arm64: defconfig: Add support for Nuvoton MA35 family SoCs
  dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
  dt-bindings: reset: nuvoton: Document ma35d1 reset control
  dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
  dt-bindings: arm: Add initial bindings for Nuvoton platform
  dt-bindings: serial: Document ma35d1 uart controller
  arm64: dts: nuvoton: Add initial ma35d1 device tree
  clk: nuvoton: Add clock driver for ma35d1 clock controller
  reset: Add Nuvoton ma35d1 reset driver support
  tty: serial: Add Nuvoton ma35d1 serial driver support
  MAINTAINERS: Add entry for NUVOTON MA35

 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  |  30 +
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |   2 +-
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 ++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  46 +
 .../serial/nuvoton,ma35d1-serial.yaml         |  48 +
 .../nuvoton/nuvoton,npcm-gcr.yaml}            |   2 +-
 MAINTAINERS                                   |  13 +-
 arch/arm64/Kconfig.platforms                  |   9 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 232 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Kconfig                   |  19 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 134 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 315 ++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 897 ++++++++++++++++++
 drivers/clk/nuvoton/clk-ma35d1.h              | 123 +++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 255 +++++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 773 +++++++++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 +++
 29 files changed, 3466 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
 rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 drivers/clk/nuvoton/Kconfig
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
 create mode 100644 drivers/reset/reset-ma35d1.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.c
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

-- 
2.34.1

