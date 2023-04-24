Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7156ED673
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDXU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:59:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB8C6181
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:59:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CA5065C0077;
        Mon, 24 Apr 2023 16:59:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 16:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682369989; x=1682456389; bh=n8Mo0Pbe5OdCqzALogFB6jll7EteYUdsR7k
        Zmbp2m4o=; b=ctj0169M3b05Mfa6gRT9RRAlIqgPbxuHPF9ZAS553w5jof7hSPU
        c5kgaKBDuk68emzGEeqZvUygl66/0RQqII54xAjo56/vQubTyNlM7Uq18Ru8F82F
        E399zSrLA4Gk5aRM0NpfVxUZYn8CiFT9QW5HktjH3UBzxA3wsyrLo4vqA3AkQeUi
        Mgagyr2d9U0IcwMWnO5q7aEQnnWKdXHMXiqS9SD4p/AwzvPjL0yT7mO/wu4JXd1l
        kgy+Selu1Ya+o990Ddbung/UOFTMMY+eOSJDiRN8EdjCk5bTbVQmPkdEg3XhQacf
        qvat7VVHEI3p9cjZBJ3hB0g+wCp+JK748Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682369989; x=1682456389; bh=n8Mo0Pbe5OdCqzALogFB6jll7EteYUdsR7k
        Zmbp2m4o=; b=fTjJsvCWx4sCO4qZXERDvnEN0Fsv7AMR31qJaI5KGaEgGPDbaJA
        hCfesRLLwr3KEj2I898XTFufDreCdoSlEtkmkMopAYOS7dCyGnKPsoewG6Fittg+
        PS0BsjYkGUhWbEvn+4kf6Kiuq6/B35+2/7GBIkkHMtmNEsidSQwhqVjQ1ryUTfA5
        j3M7LrrxBrEEAcBnUq9bqYaZZtnQKZx4OXYU5f7wlFA087BQi2HnkgCDyfT1ZaVG
        GSvCaXNFY+wpYz1RkDNi2zrW+HWAvFg42VKMOWDt1FfmD2jT5DlmAy4c1cbopAYE
        GbCWSm3vwaqwFZoALrY1xqXbyfb5gOEk2SQ==
X-ME-Sender: <xms:xe1GZEdms3VZdRmNmR4UEmDbjKL0u1GJtoTMB3z9w9sfqpSfR_Ad4w>
    <xme:xe1GZGNysG5Js3-WdOsOxcR14TZrp7NWu2CIIXnpl8JHVulB8DOPKrtJGkuSFH6n-
    Wi2toNMjyNGiJm7H8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekhfehtedvtefhjeekiefghedtffeiveeffeetffetjeffheelhfdt
    ueevjeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xe1GZFj-ieyAPh-KrwHV-iVvIOCic8WhAc5mnl5KoCu4cUmzNbR1mQ>
    <xmx:xe1GZJ_HR7_JhOLdQyfvaU54iq7vooQ_M6gz3HgL8auDPKceSCfEVQ>
    <xmx:xe1GZAudwBMXC_64hnYwBdV77JVPbcq9Tc5_jfUBCdX0N67TUQJcYA>
    <xmx:xe1GZNWHjvPrHUGgstSUtbTkM3tNwhfnFIC8mmRtXiAy6isuRkjafQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8C8CCB60086; Mon, 24 Apr 2023 16:59:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <c7193321-21ff-4ac8-9aa2-27e18ef24236@app.fastmail.com>
In-Reply-To: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
Date:   Mon, 24 Apr 2023 22:59:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: SoC changes for 6.4
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af=
326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-a=
rm-6.4

for you to fetch changes up to bd2c0c4452eea00e22c4008d8e64e58fa73857e5:

  Merge tag 'mvebu-arm64-6.4-1' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/gclement/mvebu into soc/arm (2023-04-18 17:04:44 +0200)

----------------------------------------------------------------
ARM: SoC changes for 6.4

The Oxford Semiconductor OX810/OX820 "oxnas" platform gets retired
after the ARM11MPcore processor keeps causing problems in certain corner
cases. OX820 was the only remaining SoC with this core after CNS3xxx got
retired, and its driver support for never completely merged upstream. The
Arm "Realview" reference platform still supports ARM11MPCore in principl=
e,
but this was never a product, and the CPU support will get cleaned up
later on.

Another series updates the mv78xx0 platform, which has been similarly
neglected for a while, but should work properly again now.

The other changes are minor cleanups across platforms, mostly converting
code to more modern interfaces for DT nodes and removing some more code
as a follow-up to the large-scale platform removal in linux-6.3.

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'omap-for-v6.4/cleanup-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'omap-for-v6.4/omap1-signed' of git://git.kernel.org/pub=
/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'samsung-soc-6.4' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux into soc/arm
      Merge tag 'imx-soc-6.4' of git://git.kernel.org/pub/scm/linux/kern=
el/git/shawnguo/linux into soc/arm
      Merge tag 'renesas-arm-soc-for-v6.4-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/arm
      Merge tag 'arm-soc/for-6.4/soc' of https://github.com/Broadcom/stb=
linux into soc/arm
      Merge tag 'mvebu-arm64-6.4-1' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/arm

Jeremy J. Peper (4):
      ARM: mv78xx0: adjust init logic for ts-wxl to reflect single core =
dev
      ARM: mv78xx0: set the correct driver for the i2c RTC
      ARM: mv78xx0: add code to enable XOR and CRYPTO engines on mv78xx0
      ARM: mv78xx0: fix entries for gpios, buttons and usb ports

Jilin Yuan (1):
      ARM: OMAP2+: fix repeated words in comments

Jinpeng Cui (1):
      ARM: omap1: remove redundant variables err

Juerg Haefliger (1):
      ARM: omap1: Kconfig: Fix indentation

Kenneth Lee (1):
      ARM: OMAP2+: hwmod: Use kzalloc for allocating only one element

Lukas Bulwahn (4):
      ARM: mmp: remove obsolete config USB_EHCI_MV_U2O
      ARM: spear: remove obsolete config MACH_SPEAR600
      ARM: mstar: remove unused config MACH_MERCURY
      ARM: OMAP2+: remove obsolete config OMAP3_SDRC_AC_TIMING

Neil Armstrong (1):
      ARM: oxnas: remove OXNAS support

Oleksij Rempel (2):
      ARM: imx6q: skip ethernet refclock reconfiguration if enet_clk_ref=
 is present
      ARM: mach-imx: imx6ul: remove not optional ethernet refclock overw=
rite

Rob Herring (10):
      ARM: exynos: Use of_property_read_bool() for boolean properties
      ARM: mxs: Use of_property_present() for testing DT property presen=
ce
      ARM: imx: Use of_property_read_bool() for boolean properties
      ARM: EXYNOS: Use of_address_to_resource()
      ARM: bcm: Use of_address_to_resource()
      ARM: OMAP2+: Use of_property_read_bool() for boolean properties
      ARM: OMAP2+: Use of_address_to_resource()
      ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU node 'reg'
      ARM: pxa: Use of_property_read_bool() for boolean properties
      soc: fsl: Use of_property_present() for testing DT property presen=
ce

Thomas Wei=C3=9Fschuh (1):
      firmware: turris-mox-rwtm: make kobj_type structure constant

Uwe Kleine-K=C3=B6nig (1):
      ARM: Convert to platform remove callback returning void

ye xingchen (1):
      ARM: OMAP2+: Remove the unneeded result variable

 arch/arm/Kconfig                          |  2 -
 arch/arm/Makefile                         |  1 -
 arch/arm/common/locomo.c                  |  6 +-
 arch/arm/common/sa1111.c                  |  6 +-
 arch/arm/common/scoop.c                   |  6 +-
 arch/arm/mach-bcm/bcm_kona_smc.c          | 23 ++------
 arch/arm/mach-exynos/exynos.c             |  8 ++-
 arch/arm/mach-exynos/suspend.c            |  2 +-
 arch/arm/mach-imx/gpc.c                   |  2 +-
 arch/arm/mach-imx/mach-imx6q.c            | 10 +++-
 arch/arm/mach-imx/mach-imx6ul.c           | 20 -------
 arch/arm/mach-imx/mmdc.c                  |  5 +-
 arch/arm/mach-mmp/Kconfig                 |  6 --
 arch/arm/mach-mstar/Kconfig               |  7 ---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 82 +++++++++++++++++-------=
--
 arch/arm/mach-mv78xx0/common.c            | 23 ++++++++
 arch/arm/mach-mv78xx0/common.h            |  2 +
 arch/arm/mach-mv78xx0/mv78xx0.h           | 10 ++++
 arch/arm/mach-mv78xx0/pcie.c              |  2 +-
 arch/arm/mach-mxs/mach-mxs.c              |  2 +-
 arch/arm/mach-omap1/Kconfig               |  2 +-
 arch/arm/mach-omap1/board-ams-delta.c     |  6 +-
 arch/arm/mach-omap1/omap-dma.c            |  6 +-
 arch/arm/mach-omap2/Kconfig               | 11 ----
 arch/arm/mach-omap2/cm33xx.c              |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c          | 23 ++++----
 arch/arm/mach-omap2/pm33xx-core.c         |  6 +-
 arch/arm/mach-oxnas/Kconfig               | 38 ------------
 arch/arm/mach-oxnas/Makefile              |  2 -
 arch/arm/mach-oxnas/headsmp.S             | 23 --------
 arch/arm/mach-oxnas/platsmp.c             | 96 ------------------------=
-------
 arch/arm/mach-pxa/irq.c                   |  3 +-
 arch/arm/mach-pxa/sharpsl_pm.c            |  6 +-
 arch/arm/mach-sa1100/jornada720_ssp.c     |  5 +-
 arch/arm/mach-sa1100/neponset.c           |  6 +-
 arch/arm/mach-shmobile/platsmp-apmu.c     | 36 ++++++------
 arch/arm/mach-spear/Kconfig               |  6 --
 drivers/firmware/turris-mox-rwtm.c        |  2 +-
 drivers/soc/fsl/qbman/dpaa_sys.c          |  8 +--
 39 files changed, 167 insertions(+), 345 deletions(-)
 delete mode 100644 arch/arm/mach-oxnas/Kconfig
 delete mode 100644 arch/arm/mach-oxnas/Makefile
 delete mode 100644 arch/arm/mach-oxnas/headsmp.S
 delete mode 100644 arch/arm/mach-oxnas/platsmp.c
