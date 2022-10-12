Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255885FC16E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJLHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLHvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9852564E0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748FD61452
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1627C433C1;
        Wed, 12 Oct 2022 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665561111;
        bh=UXhkkQ4MVDfaNPAPLmIXIH0sALSXdfSP/Izku8psacE=;
        h=From:To:Cc:Subject:Date:From;
        b=IyyvwzAkL048bUiAUEKHbKRGtEapFy8aUh1TdlB6W+e0IoC8WDnJCaxZr6747Xf0O
         ivw0MV05ssJPo3jOhMJ88PquYRPm/dqdu6x/PfItI0mgCtYUiJnkgPKSoU5E0/YWmn
         DxYLyL8i0IKMPAvfaTun6r2iEzcjuNActXUxo0/6z2fZehse5hEnYIou84Q3aODF3t
         6o0DKPiNbZQxkPdUpSB3Kw6P7jesl/J8g61TwS3UO6IGGggm9LGO2d8o5cY/aExtZN
         NYE1bsQbAUJhnLqtEXj++zrNK9SRkCd+F35qRPapeTPAZAQ2J6QH9/0TKv5JGMkGdU
         +nNIxRDgZ/b8w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oiWWr-00Fzb1-JU;
        Wed, 12 Oct 2022 08:51:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Colin King <colin.i.king@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 6.1, take #1
Date:   Wed, 12 Oct 2022 08:51:25 +0100
Message-Id: <20221012075125.1244143-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, colin.i.king@gmail.com, Frank.Li@nxp.com, geert+renesas@glider.be, vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here are 3 irqchip fixes for 6.1, addressing a couple of issues found
in the newly merged IMX-MU driver, as well as one for the ls-extirq
driver. Nothing exciting.

Please pull,

	M.

The following changes since commit 732d69c80cb04a587d9ec2935bcb63989e66eb92:

  Merge branch irq/misc-6.1 into irq/irqchip-next (2022-09-29 17:21:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.1-1

for you to fetch changes up to 6c9f7434159b96231f5b27ab938f4766e3586b48:

  irqchip: IMX_MU_MSI should depend on ARCH_MXC (2022-10-12 08:43:59 +0100)

----------------------------------------------------------------
irqchip fixes for 6.1, take #1

- Fix IMX-MU Kconfig, keeping it private to IMX

- Fix a register offset for the same IMX-MU driver

- Fix the ls-extirq irqchip driver that would use the wrong
  flavour of spinlocks

----------------------------------------------------------------
Frank Li (1):
      irqchip/imx-mu-msi: Fix wrong register offset for 8ulp

Geert Uytterhoeven (1):
      irqchip: IMX_MU_MSI should depend on ARCH_MXC

Vladimir Oltean (1):
      irqchip/ls-extirq: Fix invalid wait context by avoiding to use regmap

 drivers/irqchip/Kconfig          |  7 ++--
 drivers/irqchip/irq-imx-mu-msi.c |  2 +-
 drivers/irqchip/irq-ls-extirq.c  | 87 +++++++++++++++++++++++++++++-----------
 3 files changed, 68 insertions(+), 28 deletions(-)
