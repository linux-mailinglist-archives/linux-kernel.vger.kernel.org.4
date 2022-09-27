Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A975ECF60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiI0Vid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI0Via (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:38:30 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E342107DD6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:38:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6B8FF580B68;
        Tue, 27 Sep 2022 17:38:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 17:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1664314704; x=1664318304; bh=zvol/GHM5c6R7Ut0JXbmy+UmAuDUUDOhOAP
        i+O/Y+vQ=; b=j2HrporFekUvjGjgxKPv4UyBGubxTW/Xpmieh+l9FZvNadQYUdO
        e5svWcHjmitpJpIZEvH1lLkLGOVdlwV+UNbCeOHPkKtFAkjks62l+LIqNGaljeXL
        WK8ySOnl59ODmjvlVX9ezgcxDfMrg2AqRz1y+MOjwBlENVDK13K+9dNaqL4lWLe5
        0OK9a8/uwonk9RLCjLzbuVJlvbDGp5LK41IYVpVSy6H02a1u18mpu9h5VnPjtS5c
        QPSIA7xaBXaoYgKXXbXy7zAtf4MyYq/GMaXslHn5cjN2Hjr+MPC2ElKLolhi7T0j
        a+qWcfctT/4sBaL1Y48owaVXmkdYarWm0zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664314704; x=
        1664318304; bh=zvol/GHM5c6R7Ut0JXbmy+UmAuDUUDOhOAPi+O/Y+vQ=; b=I
        C53jPTyHdE4gcelJNYcSbgX417kn6avKeCITHZpSZM8GqxSNGtKzHdiZAgyxutHv
        BK5D/1222viVTIX7Cf+z+NYWhWiP5kq3+5hrSc1EaALsifraB7nh6W348zXVcxf+
        Jnu9Ju8b+KzoP+3VPcT3UN0foFZFxqRt5+2WY+1ang2/gIS3loa4SqRSFvk/YYJI
        SqgsGWC1E9ryefFyyM4u7TaR4et/FmdcsuhVX40bHz3viF/W20rseV9vcvnFFfcw
        1fXLPExCMP5BB9xkWbG3UDeDYkqPOyL0oHBHroFRaOaJVNL3Hh/JVPX24hrBmQj5
        zZ/LM5ejEPNh8aYXnqQZw==
X-ME-Sender: <xms:T20zYxhCTRYfUQ6WbF7fM4ydKMvZ9ZTygbgOzRnmaEBs2hKPfa67OQ>
    <xme:T20zY2DQXO6XT253DXu00B5S_y0ogPMmiKP-oWeiEUbqoDkAIrfDwnJl-MxmzI-VP
    ZCSlqf3WISICLge4DU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepueehudefffejkeduhedtvedvuddugeffgeefleeuhfethfeuuefhueetfefgkeev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhpvghngh
    huthhrohhnihigrdguvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:T20zYxFRmzCKvG8zNRJisJsIshLy230C2MFoIlDTBw0WkGl_xagp3A>
    <xmx:T20zY2Q2hvsEE6iJ9R1CNlSWovgZCCT6WtqPwu6EeXb-5Pb1B2YaOw>
    <xmx:T20zY-zEdsVERVhN94PUuHbjbREBu_yjhglwS2l6rT0azrwtO-8d-A>
    <xmx:T20zYzoq4NsPDYFIB3Ze5C-LH3fPtChiyflNfNpBPQrP87t7jyoEww>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 98AF4B60089; Tue, 27 Sep 2022 17:38:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <74c1ce25-e6c9-430a-bc03-e1acab0cb818@www.fastmail.com>
Date:   Tue, 27 Sep 2022 23:37:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.0-rc7
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git soc-fixes-6.0-rc7

for you to fetch changes up to 7bea67a994300c7dff827d1eb2344c180d1ffd93:

  ARM: dts: integrator: Fix DMA ranges (2022-09-26 23:05:58 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.0-rc7

This should be the last set of bugfixes in the SoC tree:

 - Two fixes for Arm integrator, dealing with a regression caused
   by invalid DT properties combined with a change in dma address
   translation, and missing device_type annotations on the PCI
   bus.

 - Fixes for drivers/reset/, addressing bugs in i.MX8MP, Sparx5 and
   NPCM8XX platforms.

 - Bjorn Andersson's email address changes in the MAINTAINERS file

 - Multiple minor fixes to Qualcomm dts files, and a change to the
   remoteproc firmware filename that did not match the actual
   path in the linux-firmware package.

 - Minor code fixes for the Allwinner/sunxi SRAM driver, and the
   broadcom STB Bus Interface Unit driver

 - A build fix for the sunplus sp7021 platform

 - Two dts fixes for TI OMAP family SoCs, addressing an extraneous
   usb4 device node and an incorrect DMA handle.

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'omap-for-6.0/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'arm-soc/for-6.0/drivers-fixes-v2' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'sunxi-drivers-fixes-for-6.0-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.0' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'reset-fixes-for-v6.0' of git://git.pengutronix.de/pza/linux into arm/fixes

Bhupesh Sharma (1):
      arm64: dts: qcom: sm8150: Fix fastrpc iommu values

Bjorn Andersson (1):
      MAINTAINERS: Update Bjorn's email address

Florian Fainelli (1):
      soc: bcm: brcmstb: biuctrl: Avoid double of_node_put()

Johan Hovold (2):
      arm64: dts: qcom: sc7280: move USB wakeup-source property
      arm64: dts: qcom: sm8350: fix UFS PHY serdes size

Linus Walleij (2):
      ARM: dts: integrator: Tag PCI host with device_type
      ARM: dts: integrator: Fix DMA ranges

Manivannan Sadhasivam (1):
      arm64: dts: qcom: sc8280xp-x13s: Update firmware location

Michael Walle (1):
      reset: microchip-sparx5: issue a reset on startup

Randy Dunlap (1):
      ARM: sunplus: fix serial console kconfig and build problems

Richard Zhu (1):
      reset: imx7: Fix the iMX8MP PCIe PHY PERST support

Romain Naour (1):
      ARM: dts: am5748: keep usb4_tm disabled

Samuel Holland (4):
      soc: sunxi: sram: Actually claim SRAM regions
      soc: sunxi: sram: Prevent the driver from being unbound
      soc: sunxi: sram: Fix probe function ordering issues
      soc: sunxi: sram: Fix debugfs info for A64 SRAM C

Steev Klimaszewski (1):
      arm64: dts: qcom: thinkpad-x13s: Fix firmware location

Tomer Maimon (1):
      reset: npcm: fix iprst2 and iprst4 setting

Tony Lindgren (1):
      Merge branch 'am5748-fix' into fixes

YuTong Chang (1):
      ARM: dts: am33xx: Fix MMCHS0 dma properties

 .mailmap                                           |  3 +++
 MAINTAINERS                                        | 12 +++++------
 arch/arm/boot/dts/am33xx-l4.dtsi                   |  3 +--
 arch/arm/boot/dts/am5748.dtsi                      |  4 ++++
 arch/arm/boot/dts/integratorap-im-pd1.dts          |  1 +
 arch/arm/boot/dts/integratorap.dts                 |  9 ++++----
 arch/arm/mach-sunplus/Kconfig                      |  4 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  3 ++-
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 24 ++++++++--------------
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  2 +-
 drivers/reset/reset-imx7.c                         |  1 +
 drivers/reset/reset-microchip-sparx5.c             | 22 +++++++++++++++-----
 drivers/reset/reset-npcm.c                         |  2 +-
 drivers/soc/bcm/brcmstb/biuctrl.c                  |  1 -
 drivers/soc/sunxi/sunxi_sram.c                     | 23 +++++++++------------
 16 files changed, 64 insertions(+), 54 deletions(-)
