Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B735F639E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiJFJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:28:52 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7D8FD5B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:28:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BA9BC58099D;
        Thu,  6 Oct 2022 05:28:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665048530; x=
        1665052130; bh=K9w3jufX62NB0nBJQyDY44OdTiqkmNBH9BNCuI8Jo8g=; b=M
        tchgGcc5ZQdboFWqp8CtuFgnghsZ7/U2HB5b/LjrqKRfX5GpWWp1XXnDOl3tu4IW
        ygagYEU4pb9q9XsHkefUhFwvu4kgwZjarnHAZBMDBZa8yhNvvithcRrqkkSdBqfe
        ZWIYylq1KIpT3Zw67YnoCizONZFhVTdN+hR3e51LYNh7GHd0llyxFExUU6HcNWJz
        l8OLXL66Zd2zltrOdKthRZ/Nl0I5ZoPoR1ZbHLY9bomhVTE47yIV28zUl9qCq3HW
        ddJoh0t1mYv5ToTI+HgvMebDExCc/wEG187o+YW9QbjNOlG2VM639qzJqSUyhwnm
        cS29B5EFX36MBmgqqT4fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1665048530; x=
        1665052130; bh=K9w3jufX62NB0nBJQyDY44OdTiqkmNBH9BNCuI8Jo8g=; b=b
        ZupR4GD/GYDm0ufAEbYYcI7H2urtlwocUMkbS+w1V1xJ6O6AaS6CgrQ91xCgbDQW
        yTm+ccTZzMy7hHb2mmUTDgf/VjZsGcm4takMZPXlUNLQdreWfaBKoJYBJEpxN8Zn
        n1qfo1SfInLkhMf65Y7yyRZ1m/QlVtvfziSkggilZdA8rpVuDmUJsbOwT0JJ8pQq
        EXnucuA7LfFxie/oSJRomTJXwZeNf2D0CQwEFTx8uR+yldhiOC0MbThPDgh+Cy2g
        hguMRvMZdBFJaE4dyYouDCFGwhrV1n6Bi2+fsyamko42LlNtRZ60bwW541exrkYk
        50lTpIRkV3aBaZP5GB7Yw==
X-ME-Sender: <xms:0p8-Yz2TR2b58QQZAW4glSIh-LnPGlmd96aE0y_RhC55DpJwnd4TMw>
    <xme:0p8-YyGb9MRB0IWvRAxaAGIBg9jgLlE0nPYFe5Rw4gl-8LbT98eIT1vrhjJuyr-k2
    QrcknnVZNlhJefY1vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:0p8-Yz4LUjciSwCST1pdTBRMmvSRUU3vL-4T1bsX6WSsgYDUbcKjzw>
    <xmx:0p8-Y43pE6oouvo7ToPV4nVm-mY8lV4YIkJunCZZIshZiUCBXnsdLA>
    <xmx:0p8-Y2Hjjh6BcuPSc7Hq0oTSbpsZ54CJUSkE4u5tPj8S5Je8-gPdXA>
    <xmx:0p8-Y4O5V7o7EyMjCOP2DgUzpBzmfPT-99MBbBvjBIZnUBjHKWX6NQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 53E6CB60086; Thu,  6 Oct 2022 05:28:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <6b71d4f8-cf80-460b-9b33-7366f5290b78@app.fastmail.com>
In-Reply-To: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
References: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:28:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: SoC code changes for 6.1
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc06=
3c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-s=
oc-6.1

for you to fetch changes up to ef2fb84c130b08ce2a05359c35bc4e9541712375:

  ARM: aspeed: Kconfig: Fix indentation (2022-09-28 22:33:55 +0200)

----------------------------------------------------------------
ARM: SoC code changes for 6.1

The main changes this time are for the organization of the Kconfig
files, introducing per-vendor top-level options on arm64 to match
those on arm32, and making the platform selection on arm32 more
uniform, in particular for the remaining StrongARM platforms that
still have a couple of special cases compared to the more recent
ones.

I also did a cleanup of the old Footbridge platform, which was
the last holdout for the phys_to_dma()/dma_to_phys() interface
that is now completely gone from arm32, completing work started
by Christoph Hellwig.

----------------------------------------------------------------
Arnd Bergmann (15):
      ARM: remove obsolete Makefile.boot infrastructure
      ARM: simplify machdirs/platdirs handling
      ARM: Kconfig: clean up platform selection
      ARM: fix XIP_KERNEL dependencies
      ARM: make ARCH_MULTIPLATFORM user-visible
      ARM: footbridge: remove addin mode
      ARM: footbridge: remove leftover from personal-server
      ARM: footbridge: move isa-dma support into footbridge
      ARM: footbridge: remove custom DMA address handling
      Merge tag 'arm-soc/for-6.1/maintainers' of https://github.com/Broa=
dcom/stblinux into arm/soc
      Merge branch 'footbridge/cleanup' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/soc/soc into arm/soc
      Merge branch 'arm-multiplatform-cleanup' of https://git.kernel.org=
/pub/scm/linux/kernel/git/soc/soc into arm/soc
      ARM: disallow PCI with MMU=3Dn again
      Merge tag 'renesas-arm-soc-for-v6.1-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into arm/soc
      ARM: orion: fix include path

Florian Fainelli (2):
      arm64: Kconfig.platforms: Re-organized Broadcom menu
      arm64: Kconfig.platforms: Group NXP platforms together

Gaosheng Cui (1):
      ARM: s3c: remove orphan declarations from arch/arm/mach-s3c/devs.h

Geert Uytterhoeven (2):
      ARM: Drop CMDLINE_FORCE dependency on !ARCH_MULTIPLATFORM
      ARM: Drop CMDLINE_* dependency on ATAGS

Juerg Haefliger (1):
      ARM: aspeed: Kconfig: Fix indentation

Lad Prabhakar (2):
      arm64: renesas: Drop selecting SOC_BUS
      ARM: shmobile: Drop selecting SOC_BUS

Uwe Kleine-K=C3=B6nig (1):
      pxa: Drop if with an always false condition

William Zhang (1):
      MAINTAINERS: Add BCM4908 maintainer to BCMBCA entry

 MAINTAINERS                                        |   1 +
 arch/arm/Kconfig                                   | 135 +++++---------=
-------
 arch/arm/Kconfig.debug                             |   8 +-
 arch/arm/Makefile                                  |  40 ++----
 arch/arm/boot/Makefile                             |  27 ++---
 arch/arm/boot/bootp/Makefile                       |  35 +++++-
 arch/arm/configs/assabet_defconfig                 |   2 +
 arch/arm/configs/badge4_defconfig                  |   2 +
 arch/arm/configs/cerfcube_defconfig                |   2 +
 arch/arm/configs/collie_defconfig                  |   2 +
 arch/arm/configs/footbridge_defconfig              |   2 +
 arch/arm/configs/h3600_defconfig                   |   2 +
 arch/arm/configs/hackkit_defconfig                 |   2 +
 arch/arm/configs/jornada720_defconfig              |   2 +
 arch/arm/configs/lart_defconfig                    |   2 +
 arch/arm/configs/neponset_defconfig                |   2 +
 arch/arm/configs/netwinder_defconfig               |   2 +
 arch/arm/configs/pleb_defconfig                    |   2 +
 arch/arm/configs/rpc_defconfig                     |   2 +
 arch/arm/configs/shannon_defconfig                 |   2 +
 arch/arm/configs/simpad_defconfig                  |   2 +
 arch/arm/include/asm/dma-direct.h                  |   1 -
 arch/arm/include/asm/dma.h                         |   2 +-
 arch/arm/include/asm/hardware/dec21285.h           |  20 ++-
 arch/arm/include/asm/mach/dma.h                    |   5 -
 arch/arm/include/asm/memory.h                      |  11 --
 arch/arm/kernel/Makefile                           |   1 -
 arch/arm/kernel/devtree.c                          |   2 -
 arch/arm/mach-aspeed/Kconfig                       |  14 +--
 arch/arm/mach-at91/Makefile.boot                   |   4 -
 arch/arm/mach-davinci/Makefile.boot                |   8 --
 arch/arm/mach-dove/Makefile                        |   2 +-
 arch/arm/mach-dove/Makefile.boot                   |   4 -
 arch/arm/mach-ep93xx/Makefile.boot                 |   2 -
 arch/arm/mach-footbridge/Kconfig                   |  48 +++-----
 arch/arm/mach-footbridge/Makefile                  |   5 +-
 arch/arm/mach-footbridge/Makefile.boot             |   5 -
 arch/arm/mach-footbridge/common.c                  |  79 +-----------
 arch/arm/mach-footbridge/dc21285.c                 |  80 ++++++------
 arch/arm/{kernel =3D> mach-footbridge}/dma-isa.c     |  11 +-
 arch/arm/mach-footbridge/dma.c                     |  58 ---------
 arch/arm/mach-footbridge/include/mach/dma-direct.h |   8 --
 arch/arm/mach-footbridge/include/mach/isa-dma.h    |  14 +--
 arch/arm/mach-footbridge/include/mach/memory.h     |  31 -----
 arch/arm/mach-footbridge/isa.c                     |  14 +--
 arch/arm/mach-imx/Kconfig                          |   2 +-
 arch/arm/mach-imx/Makefile.boot                    |   0
 arch/arm/mach-iop32x/Makefile.boot                 |   4 -
 arch/arm/mach-lpc18xx/Makefile.boot                |   4 -
 arch/arm/mach-lpc32xx/Makefile.boot                |   4 -
 arch/arm/mach-mv78xx0/Makefile                     |   2 +-
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-nspire/Kconfig                       |   2 +-
 arch/arm/mach-omap1/Makefile.boot                  |   4 -
 arch/arm/mach-orion5x/Makefile                     |   2 +-
 arch/arm/mach-rpc/Kconfig                          |  21 ++++
 arch/arm/mach-rpc/Makefile.boot                    |   5 -
 arch/arm/mach-s3c/Makefile.boot                    |   9 --
 arch/arm/mach-s3c/devs.h                           |   2 -
 arch/arm/mach-sa1100/Kconfig                       |  25 +++-
 arch/arm/mach-sa1100/Makefile.boot                 |   9 --
 arch/arm/mach-shmobile/Kconfig                     |   1 -
 arch/arm/mach-stm32/Makefile.boot                  |   4 -
 arch/arm/mach-versatile/Makefile.boot              |   4 -
 arch/arm/mach-vt8500/Makefile.boot                 |   4 -
 arch/arm/plat-orion/Makefile                       |   2 +-
 arch/arm64/Kconfig.platforms                       |  53 +++++---
 drivers/soc/pxa/ssp.c                              |   6 +-
 drivers/tty/serial/21285.c                         |   3 -
 69 files changed, 294 insertions(+), 585 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-direct.h
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-davinci/Makefile.boot
 delete mode 100644 arch/arm/mach-dove/Makefile.boot
 delete mode 100644 arch/arm/mach-ep93xx/Makefile.boot
 delete mode 100644 arch/arm/mach-footbridge/Makefile.boot
 rename arch/arm/{kernel =3D> mach-footbridge}/dma-isa.c (95%)
 delete mode 100644 arch/arm/mach-footbridge/dma.c
 delete mode 100644 arch/arm/mach-footbridge/include/mach/dma-direct.h
 delete mode 100644 arch/arm/mach-imx/Makefile.boot
 delete mode 100644 arch/arm/mach-iop32x/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc32xx/Makefile.boot
 delete mode 100644 arch/arm/mach-omap1/Makefile.boot
 create mode 100644 arch/arm/mach-rpc/Kconfig
 delete mode 100644 arch/arm/mach-rpc/Makefile.boot
 delete mode 100644 arch/arm/mach-s3c/Makefile.boot
 delete mode 100644 arch/arm/mach-sa1100/Makefile.boot
 delete mode 100644 arch/arm/mach-stm32/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-vt8500/Makefile.boot
