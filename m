Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83476487A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLIRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLIRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:20:27 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFE2EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:20:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5C093320090C;
        Fri,  9 Dec 2022 12:20:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670606425; x=1670692825; bh=S6n3+92phS
        riW5IJgU6qkLeUckJ6rE5IY/sxC2TcWdw=; b=SaMMIDY+Kqqf4UEGxr2vHWonpE
        Cpm9Qr9SoGVplbduanDI00Eom4zkyZWEU/T0vOJjDz57nqKDmanZHKMthDPEjrIf
        ralOvaBvvpxLwmLCrxZb/Ondd++afU8Jprrj/T02qMGO1EwcWINfhHg6Cq1hBmff
        QIv+5H+b2tnyfQWQmo8Cb5SJonEKGgEGTxQGt9IlrI+NJ9/sgjBTERB7U35nSMIz
        1Qbnh44F1R/ZADAq/6w7hfaLoJKIP7Oe15sgO7WhlZUJtuxQydOyRMthKSTVlagn
        gBPzFpPlvW/GrJ2qiDp+afsGqXyB1rGbvHYEuC7m6VZQJOpKPOnGrI6/VHuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670606425; x=1670692825; bh=S6n3+92phSriW5IJgU6qkLeUckJ6
        rE5IY/sxC2TcWdw=; b=u5aGvc8pfx7KCZ3lvbn8/LWvpUU4kodUdfLbVv4JZltg
        Q5L4PS7KFpMRjh6mqq+3L74kgfXCepgrByPAqcL/Os6Sy5iFzH9GppTLApPv9u0i
        exbohzFam1d8dq7bkwfeh8VZ4RHE6U0HR0aQPsN6OuvYWsXktjAUGuX4iqeijhsx
        jBq85NXOJWTUCgslrRGuc4qLYIj5I0XNk4kLe4k/65/d5x9zGucB3OV7HnXaDTbg
        96f6CnqsnGKhncqhcxs61i5xspmxCZ8kCKSGvhWPDBxtFGnZR7FuoRByZvgowlyx
        lDOuAE7PIndc/Ohgw6NiEk85hR4KuAYIaazITr871w==
X-ME-Sender: <xms:WW6TYzHuOi3jsUff-LpN-W2kCc-uGui5PtGww7dXONJ9fGW_2JMpIQ>
    <xme:WW6TYwWNOY9qoUYL8w68JS-IfnHyh4r-dW0fawtzvc_skKmj4Ld_b1RfNLmDcTsbV
    amW4AkUYcKD40hIZ3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WW6TY1LhL_7eUWCWd52dpLG-oX0FPcEQyWIvMz7kMCcyZR4PnJiR9w>
    <xmx:WW6TYxEITleL3aCHuaQFzK_c4_dYmzMbpR6bYVNCTxFa6DYOo8G9bA>
    <xmx:WW6TY5V5aLHqIbOps8THZuMUKX1j5ODVA7_V7qyT7uy-njWXIS9-hg>
    <xmx:WW6TY4ek3YyJObHplFuNXg7JWbqPOu25dqyMlyON4D2fpqeTHXBs_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C293DB60086; Fri,  9 Dec 2022 12:20:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <4f256035-0959-4c00-a263-6720139c6a7d@app.fastmail.com>
In-Reply-To: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
Date:   Fri, 09 Dec 2022 18:20:05 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] SoC code updates for 6.2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-6.2

for you to fetch changes up to 8b7f4dd73879598ac6876753732e158055d8b671:

  Merge tag 'ti-keystone-soc-for-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into arm/soc (2022-11-23 13:05:06 +0100)

----------------------------------------------------------------
SoC code updates for 6.2

This time there are only fairly minor cleanups across the i.MX, ixp4xx,
ux500 and renesas platforms. The only notable update is a change to
the keystone2 platform to switch switch it over to standard PSCI SMP
bringup, which apparently was present in the shipped firmware almost
from the start.

----------------------------------------------------------------
Andrew Davis (1):
      ARM: keystone: Replace platform SMP with PSCI

Arnd Bergmann (6):
      Merge tag 'ux500-soc-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/soc
      Merge tag 'renesas-arm-soc-for-v6.2-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/soc
      Merge tag 'ixp4xx-for-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/soc
      Merge tag 'imx-soc-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/soc
      Merge tag 'renesas-riscv-soc-for-v6.2-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/soc
      Merge tag 'ti-keystone-soc-for-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into arm/soc

Christoph Niedermaier (1):
      MAINTAINERS: Add DHCOR to the DH electronic i.MX6 board support

Geert Uytterhoeven (2):
      ARM: mxs: Remove unneeded #include <linux/pinctrl/consumer.h>
      ARM: imx3: Remove unneeded #include <linux/pinctrl/machine.h>

Jason A. Donenfeld (1):
      ARM: ux500: do not directly dereference __iomem

Lad Prabhakar (4):
      soc: renesas: Kconfig: Explicitly select GPIOLIB and PINCTRL config under SOC_RENESAS
      ARM: shmobile: Drop selecting GPIOLIB and PINCTRL
      arm64: renesas: Drop selecting GPIOLIB and PINCTRL
      riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option

Linus Walleij (3):
      ARM: ux500: Drop unused register file
      ARM: ixp4xx: Remove unused static map
      ARM: ixp4xx: Remove unused debug iomap

Lukas Bulwahn (1):
      MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to ixp4xx clean-up

wangjianli (1):
      arm/mach-ux500: fix repeated words in comments

 MAINTAINERS                       |   5 +-
 arch/arm/mach-imx/mm-imx3.c       |   1 -
 arch/arm/mach-ixp4xx/ixp4xx-of.c  |  42 --------
 arch/arm/mach-keystone/Makefile   |   4 +-
 arch/arm/mach-keystone/keystone.c |   2 -
 arch/arm/mach-keystone/keystone.h |   5 -
 arch/arm/mach-keystone/platsmp.c  |  41 --------
 arch/arm/mach-keystone/smc.S      |  26 -----
 arch/arm/mach-mxs/mach-mxs.c      |   1 -
 arch/arm/mach-shmobile/Kconfig    |   2 -
 arch/arm/mach-ux500/cpu-db8500.c  |   1 -
 arch/arm/mach-ux500/db8500-regs.h | 195 --------------------------------------
 arch/arm/mach-ux500/platsmp.c     |   2 -
 arch/arm/mach-ux500/pm.c          |   4 +-
 arch/arm64/Kconfig.platforms      |   2 -
 arch/riscv/Kconfig.socs           |   5 +
 drivers/soc/renesas/Kconfig       |   2 +
 drivers/soc/ux500/ux500-soc-id.c  |  10 +-
 18 files changed, 15 insertions(+), 335 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/platsmp.c
 delete mode 100644 arch/arm/mach-keystone/smc.S
 delete mode 100644 arch/arm/mach-ux500/db8500-regs.h
