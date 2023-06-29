Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC047742960
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjF2PUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjF2PUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:20:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A3AA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:20:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 511233200942;
        Thu, 29 Jun 2023 11:20:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688052035; x=1688138435; bh=h1
        KzWUFCfdkMiGLdEB29IRUks+r+vBUUZez515MHM4w=; b=O+QlKS7Ymtf+RIbpYz
        gEMWXvumSFGOysWDndD507XDRegpl69XE4poxPlysD0IFL86dg6zIwa+jM3eQ9vl
        UnqzwfiRxF2g+xiid2tngSqcwePOVPP2iXNarL9XQnnOA4PSrVPBlyNJOPbq81sP
        t43YROiQUD2FuME1Cowh3B4uVgSM4dYugVNqSQbg1lGFBiRxbof/RS7KT/aG9VrZ
        cxM1+aJkRrbvSnqbAMpbKMebLDrqwJgTJcgi1jXtoch9Zv2g4OoBEKXcB83uCzag
        XYNXfMYhjDfZnkDy1+mPzHN1OBVxX4W3Pa/KtLHkSKsJFwXNIKm+cMO2NYe36ZzK
        Hopw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688052035; x=1688138435; bh=h1KzWUFCfdkMi
        GLdEB29IRUks+r+vBUUZez515MHM4w=; b=jV3iH26n6qIeWezgu7JYqVZZj2ItV
        24aGqcJ3ZAHgXI7LAeBUjDQxVDWxUU4y3BZb9+xjjMqXJ1+Gev+sXi3s56Nux0PK
        +tiZxySNkKBxpgUJsiP1HYbZRXEwuNn1JmIHHpQOSbpWJH1VP71LxfZF0n0Ui9RZ
        8h10GoQY1AfG7LksW3Mkj4Y4tt7uiydJfVDWV52BTY5jhG+orrWytovjD/2xuKvD
        xmAGyaVoNrjDazbzEM+D/NpGr1M0CQMFRrsCBTaE+avO9P+9PJPqI4ydEUo72h83
        IQGwNCQZ0/EFfBr5X7TLgddJB8isZ01flUIn8+Nz9U9rtzM4N7rREGvsQ==
X-ME-Sender: <xms:Q6GdZEcW4fU5en690K-Of9GBbhpE_Uh_u8HctR76nnd8RBL-znD_Ug>
    <xme:Q6GdZGNiRE6JPtn4l1ZVmhxFnbkh0r4GJoVA8eMGb9tRVzG7Flt40-687ld54HdJf
    n3r_21hMZiqMD0KqGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Q6GdZFguJ0gukFLH0oaP5-pNz6XREjAcVFK7mwFVYRhsIJdO7YVbww>
    <xmx:Q6GdZJ83VTrelhhqRhisdLgM3DFVtNE3OFSRU04cDOmz7G4RK7IPNw>
    <xmx:Q6GdZAtNGctat-zw_BcA95Cka0MqvM1RCDnv-JeBPejx7X1qCJ21bg>
    <xmx:Q6GdZNX32VhRB9I5Yt-BQ3RWOJnc6zQtkoEFmdaxzZ0gj9q4hz3Oug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A3180B60086; Thu, 29 Jun 2023 11:20:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8b809904-4514-47f1-9a49-93d1ebdc70e1@app.fastmail.com>
In-Reply-To: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
References: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:20:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/5] ARM: New SoC support for 6.5
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 076c74c592cabe4a47537fe5205b5b678bed010d:

  ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx (2023-06-08 12:08:54 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-newsoc-6.5

for you to fetch changes up to f50a000b42195a0e0d22c34c16b7c488b22063a2:

  clk: nuvoton: Use clk_parent_data instead of string for parent clock (2023-06-22 17:02:50 +0200)

----------------------------------------------------------------
ARM: New SoC support for 6.5

There are two new SoC families this time, and both appear fairly similar:
The Nuvoton MA35D1 and the STMicroelectronics STM32MP2 are both dual-core
Cortex-A35 based chips for the low-power industrial embedded market,
and they mark the first 64-bit product in a widely used family of 32-bit
Arm MCUs and SoCs.

The way into the kernel is completely different here: The team at ST has
a long history of working upstream with their STM32MP1 and other SoCs,
and they produced a complete port to arm64 together with the initial
announcement. Nuvoton also has multiple SoC product lines with current
or previous upstream support, but those are maintained by third parties
and are unrelated. The patch series from Nuvoton's Jacky Huang had to
go through many revisisions to get to this point and is still missing
a few drivers including the serial port for the moment.

The branch contains the devicetree files as well as all the code changes,
in order to have something that can be tested standalone.

----------------------------------------------------------------
Alexandre Torgue (9):
      dt-bindings: pinctrl: stm32: support for stm32mp257 and additional packages
      pinctrl: stm32: add stm32mp257 pinctrl support
      arm64: introduce STM32 family on Armv8 architecture
      arm64: dts: st: introduce stm32mp25 SoCs family
      arm64: dts: st: introduce stm32mp25 pinctrl files
      dt-bindings: stm32: document stm32mp257f-ev1 board
      arm64: dts: st: add stm32mp257f-ev1 board support
      arm64: defconfig: enable ARCH_STM32 and STM32 serial driver
      MAINTAINERS: add entry for ARM/STM32 ARCHITECTURE

Arnd Bergmann (3):
      Merge branch 'nuvoton/ma35d1' into soc/newsoc
      Merge tag 'stm32-mp25-for-v6.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into soc/newsoc
      remoteproc: stm32: use correct format strings on 64-bit

Conor Dooley (1):
      Documentation/process: add soc maintainer handbook

Geert Uytterhoeven (1):
      reset: RESET_NUVOTON_MA35D1 should depend on ARCH_MA35

Jacky Huang (12):
      arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
      arm64: defconfig: Add support for Nuvoton MA35 family SoCs
      dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
      dt-bindings: reset: nuvoton: Document ma35d1 reset control
      dt-bindings: arm: Add initial bindings for Nuvoton platform
      dt-bindings: serial: Document ma35d1 uart controller
      arm64: dts: nuvoton: Add initial ma35d1 device tree
      clk: nuvoton: Add clock driver for ma35d1 clock controller
      reset: Add Nuvoton ma35d1 reset driver support
      clk: nuvoton: Add clk-ma35d1.h for driver extern functions
      clk: nuvoton: Update all constant hex values to lowercase
      clk: nuvoton: Use clk_parent_data instead of string for parent clock

Patrick Delaunay (1):
      dt-bindings: stm32: add st,stm32mp25-syscfg compatible for syscon

---
The stm32mp2 changes are based on a the stm32mp1 changes in the soc-dt-6.4
tag, so I regenerated this diffstat manually:

 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml       |   30 +
 .../{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml}  |    2 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |    7 +-
 .../devicetree/bindings/arm/stm32/stm32.yaml       |    6 +
 .../bindings/clock/nuvoton,ma35d1-clk.yaml         |   63 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |    4 +-
 .../bindings/reset/nuvoton,ma35d1-reset.yaml       |   45 +
 .../bindings/serial/nuvoton,ma35d1-serial.yaml     |   48 +
 .../nuvoton/nuvoton,npcm-gcr.yaml}                 |    2 +-
 Documentation/process/maintainer-handbooks.rst     |    3 +-
 Documentation/process/maintainer-soc.rst           |  177 ++
 MAINTAINERS                                        |   15 +-
 arch/arm64/Kconfig.platforms                       |   22 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/nuvoton/Makefile               |    2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts    |   56 +
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts    |   56 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi            |  234 ++
 arch/arm64/boot/dts/st/Makefile                    |    2 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi      |   38 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |  279 +++
 arch/arm64/boot/dts/st/stm32mp253.dtsi             |   23 +
 arch/arm64/boot/dts/st/stm32mp255.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp257.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   50 +
 arch/arm64/boot/dts/st/stm32mp25xc.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp25xf.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi  |   83 +
 arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi  |   71 +
 arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi  |   71 +
 arch/arm64/configs/defconfig                       |    4 +
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/nuvoton/Kconfig                        |   19 +
 drivers/clk/nuvoton/Makefile                       |    4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c           |  132 +
 drivers/clk/nuvoton/clk-ma35d1-pll.c               |  360 +++
 drivers/clk/nuvoton/clk-ma35d1.c                   | 1059 ++++++++
 drivers/clk/nuvoton/clk-ma35d1.h                   |   18 +
 drivers/pinctrl/stm32/Kconfig                      |    6 +
 drivers/pinctrl/stm32/Makefile                     |    1 +
 drivers/pinctrl/stm32/pinctrl-stm32.h              |    3 +
 drivers/pinctrl/stm32/pinctrl-stm32mp257.c         | 2581 ++++++++++++++++++++
 drivers/remoteproc/Kconfig                         |    2 +-
 drivers/remoteproc/stm32_rproc.c                   |    6 +-
 drivers/reset/Kconfig                              |    7 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-ma35d1.c                       |  235 ++
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h     |  253 ++
 include/dt-bindings/pinctrl/stm32-pinfunc.h        |    3 +
 include/dt-bindings/reset/nuvoton,ma35d1-reset.h   |  108 +
 51 files changed, 6216 insertions(+), 12 deletions(-)
 242 files changed, 9115 insertions(+), 2034 deletions(-)
 delete mode 100644 Documentation/block/request.rst
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
 rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
 create mode 100644 Documentation/process/maintainer-soc.rst
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 arch/arm64/boot/dts/st/Makefile
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp251.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp253.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp255.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp257.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xc.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xf.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxai-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxak-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp25xxal-pinctrl.dtsi
 create mode 100644 drivers/clk/nuvoton/Kconfig
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp257.c
 create mode 100644 drivers/reset/reset-ma35d1.c
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h
