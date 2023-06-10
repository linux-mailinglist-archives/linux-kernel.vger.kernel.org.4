Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EF72A99F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjFJHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjFJHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:00:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE73A9E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:00:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 795E25C010C;
        Sat, 10 Jun 2023 03:00:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 10 Jun 2023 03:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686380445; x=1686466845; bh=bBDDispcgSV0hO0NOCEpZweDg
        CzEsC0QVGbJWBHue1E=; b=lXtVgunuu+32yZJXTHbEZg9hSCBE1tYiirBNxqOmm
        PBTWYz1JWp2uPnrAZ36tgTJTnS4FRJeE+9TAUKmi10VjLyHGG+Cm6QJCgYNm/D+4
        4NZFJ2NbS4GrR8hEwIq2amvHWBbRRYvWsgKeiGn1cJSYyjCUeFh2qz8cg3cX1c+W
        ez0uWFthLbTWb9/LVcodOfuMylIkbMy4k5N5fNoSlMp3PBd8X6D+rehzN60Bix5J
        oYY6FJ5uHkyH9Ux8qPVpyks0Y9ISJtMcbge0y35SRwtKTjV6iaFYvSwpQd3XCH7T
        V3pY8/5+9vh99CR2VdMs8beyeMzL8L+FDtPgJgao3pnvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686380445; x=1686466845; bh=bBDDispcgSV0hO0NOCEpZweDgCzEsC0QVGb
        JWBHue1E=; b=CmzPRqUeuPW2mPc+WJ9ppJta0K7e4+50gfxzIo1dHDKT9zF1S/n
        O0HL6HGh6AicpnU+tWwhgjNaTW4ZEoaJkJoO5uO8ghc6LR5ZAece/3uasiY98May
        r++QaD3R/PVoie2gwgDW55geqNFSWHeS/Pbo0lwpdmUOAKonQM0fQoBa+NTaUS/b
        AUlNCGAga/BkBVnjMGxt0SAUuQHPN5+cyNMPDAvLOu+iNWnlNHDue2ncrkCktViX
        i5HdZ6iebZB1dbUOkk0Dqn4m+5pUqLP8gQvunZ5BhK6I3cDe9K85ubvyV/TN9qhb
        sexm0kqmuRqSc0k4SPyu3eSmclg1lRPEIqQ==
X-ME-Sender: <xms:nR-EZKDg9JT1aaAWpUB7bbBbBlY4O51xZx_37H-DyGLlTOsFxgjycg>
    <xme:nR-EZEiAiYmAvNl9YbPazQoG7OUPec_8g0GnB7dn8X20BJhjHxy6aTmfx16XVP11F
    sz4_EgAyl_g6AyFjk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpedtlefhkedvvdethfeuteekheettddvveeltdffhfejudffheelieelheevjeej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:nR-EZNmmjML3IGfvw4sc30Us5bIpdb61rkfrLcRLA9Yvy0Gtm8oR0w>
    <xmx:nR-EZIxsuXYzT9Uxo7duy5lHmp1lVIo6_LybOUMaFPsR-nGwtHJTCg>
    <xmx:nR-EZPTDzNmdPpGqXW2WYoEFh5hjdGLWpApmA1Ln6Xi7m-2FUJavYg>
    <xmx:nR-EZGL95DfVGRGTlSmYu6-5ahzXxhDuUhJVAi83iExPlS2JAv59iQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0EA80B60086; Sat, 10 Jun 2023 03:00:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <ea181a04-d093-4c1b-bd87-01036d301567@app.fastmail.com>
Date:   Sat, 10 Jun 2023 09:00:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.4, part 2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.4-2

for you to fetch changes up to 5cdd5ec176544a3f5b18591577cfab2fcdc13c79:

  Merge tag 'imx-fixes-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes (2023-06-09 14:15:27 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.4, part 2

Most of the changes this time are for the Qualcomm Snapdragon platforms.

There are bug fixes for error handling in Qualcomm icc-bwmon, rpmh-rsc,
ramp_controller and rmtfs driver as well as the AMD tee firmware
driver and a missing initialization in the Arm ff-a firmware driver.
The Qualcomm RPMh and EDAC drivers need some rework to work correctly
on all supported chips.

The DT fixes include:

 - i.MX8 fixes for gpio, pinmux and clock settings

 - ADS touchscreen gpio polarity settings in several machines

 - Address dtb warnings for caches, panel and input-enable
   properties on Qualcomm platforms

 - Incorrect data on qualcomm platforms fir SA8155P power domains,
   SM8550 LLCC, SC7180-lite SDRAM frequencies and SM8550 soundwire.

 -  Remoteproc firmware paths are corrected for Sony Xperia 10 IV.

----------------------------------------------------------------
Abel Vesa (1):
      soc: qcom: Rename ice to qcom_ice to avoid module name conflict

Adam Ford (1):
      arm64: dts: imx8mn-beacon: Fix SPI CS pinmux

Arnd Bergmann (7):
      Merge tag 'qcom-dts-fixes-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-driver-fixes-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'at91-fixes-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes
      Merge tag 'ffa-fix-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'amdtee-fix-for-v6.5' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'imx-fixes-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes

Balint Dobszay (1):
      firmware: arm_ffa: Set handle field to zero in memory descriptor

Bjorn Andersson (3):
      arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
      Merge branch '20230411-topic-hanaau-v2-1-fd3d70844b31@linaro.org' into arm64-fixes-for-6.4
      Merge branch '20230411-topic-hanaau-v2-1-fd3d70844b31@linaro.org' into drivers-fixes-for-6.4

Christophe JAILLET (1):
      soc: qcom: ramp_controller: Fix an error handling path in qcom_ramp_controller_probe()

Claudiu Beznea (2):
      ARM: at91: pm: fix imbalanced reference counter for ethernet devices
      ARM: dts: at91: sama7g5ek: fix debounce delay property for shdwc

Dan Carpenter (1):
      soc: qcom: rmtfs: Fix error code in probe()

Douglas Anderson (1):
      arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards

Konrad Dybcio (6):
      arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths
      dt-bindings: power: qcom,rpmpd: Add SA8155P
      arm64: dts: qcom: Split out SA8155P and use correct RPMh power domains
      soc: qcom: rpmhpd: Add SA8155P power domains
      dt-bindings: cache: qcom,llcc: Fix SM8550 description
      arm64: dts: qcom: sm8550: Use the correct LLCC register scheme

Krzysztof Kozlowski (15):
      soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
      soc: qcom: rpmh-rsc: drop redundant unsigned >=0 comparision
      arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom: sc8280xp: remove superfluous "input-enable""
      arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW
      arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
      arm64: dts: qcom: sm8250-xiaomi-elish-boe: fix panel compatible
      arm64: dts: qcom: sm8250-xiaomi-elish-csot: fix panel compatible
      ARM: dts: qcom: apq8026: remove superfluous "input-enable"
      ARM: dts: qcom: mdm9615: remove superfluous "input-enable"
      ARM: dts: qcom: msm8974: remove superfluous "input-enable"
      arm64: dts: qcom: fix indentation
      arm64: dts: qcom: use decimal for cache level
      arm64: dts: qcom: add missing cache properties
      ARM: dts: qcom: add missing cache properties
      arm64: dts: qcom: sm8550: use uint16 for Soundwire interval

Linus Walleij (1):
      ARM: dts: Fix erroneous ADS touchscreen polarities

Manivannan Sadhasivam (2):
      EDAC/qcom: Remove superfluous return variable assignment in qcom_llcc_core_setup()
      EDAC/qcom: Get rid of hardcoded register offsets

Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

Shenwei Wang (2):
      arm64: dts: imx8qm-mek: correct GPIOs for USDHC2 CD and WP signals
      arm64: dts: imx8-ss-dma: assign default clock rate for lpuarts

 .../devicetree/bindings/cache/qcom,llcc.yaml       |   1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   1 +
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts    |   2 -
 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts |   1 -
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts        |   3 -
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   1 +
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |   1 -
 arch/arm/boot/dts/qcom-msm8660.dtsi                |   1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi                |   1 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   2 -
 .../boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi   |   1 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   1 +
 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts |   1 -
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts |   4 -
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts |   1 -
 arch/arm/mach-at91/pm.c                            |  20 ++--
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |   8 ++
 .../dts/freescale/imx8mn-beacon-baseboard.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |   4 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   3 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   3 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |   2 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   2 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   2 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   2 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |  10 ++
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts           |   2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi              |  40 +++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |  20 ++++
 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi          |   8 ++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   9 ++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |   2 -
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |   2 -
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   9 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  18 +++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |  20 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  13 ++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   9 ++
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  |   4 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  52 ++++++---
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  13 ++-
 .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts      |   2 +-
 .../boot/dts/qcom/sm8250-xiaomi-elish-csot.dts     |   2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  61 ++++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  61 ++++++-----
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  26 ++++-
 drivers/edac/qcom_edac.c                           | 118 ++++++++++-----------
 drivers/firmware/arm_ffa/driver.c                  |   1 +
 drivers/soc/qcom/Makefile                          |   3 +-
 drivers/soc/qcom/icc-bwmon.c                       |   4 +-
 drivers/soc/qcom/ramp_controller.c                 |   2 +-
 drivers/soc/qcom/rmtfs_mem.c                       |   1 +
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +-
 drivers/soc/qcom/rpmhpd.c                          |  16 +++
 drivers/tee/amdtee/amdtee_if.h                     |  10 +-
 drivers/tee/amdtee/call.c                          |  30 +++---
 include/dt-bindings/power/qcom-rpmpd.h             |   9 ++
 include/linux/soc/qcom/llcc-qcom.h                 |   6 --
 82 files changed, 479 insertions(+), 226 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8155p.dtsi
