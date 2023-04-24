Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264336ED675
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjDXVBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXVBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:01:22 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276596181
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:01:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 949CE5C0117;
        Mon, 24 Apr 2023 17:01:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 17:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682370077; x=1682456477; bh=/G
        URxhdpCG1z4jHQxnEY6gfAv57kgC9Jto1e70+jDyw=; b=XPnbdunJ5YRVByQ7z4
        KOzVWZTU1HdUBZiJA2/M2vWuFeKSDrU9t+oLjGa6qLheF+/G0E0XQ2wfCz+rZSr5
        59LVbhbn7+xhy4vgnoK7X580gyjmwfQcXpH8DfGRHOTJU6/E9184LbEIVvDvtwzE
        ndf8PQ4oU6BSAmdEpWIVKcnSCqQaFDXu/GHf1n0ejnPV/tOJ6qdUSTHHmN0lko+g
        odl2dtGvL9nKeMe+6dHHLNR/jn9meOWYIdAn2J6MP9J7QDTOCJH4+xmboEAnPv4y
        O5A8OWfOSAh/8WAPjAmkA/KRjmoeGm9Uz4fKR8X+3WeN8WELFuG55JYu2o5oyALF
        Tjaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682370077; x=1682456477; bh=/GURxhdpCG1z4
        jHQxnEY6gfAv57kgC9Jto1e70+jDyw=; b=EyCDITrG+TcgixzJzZ2fnMtljCHVw
        gY15la7MP+xW2ens6K173HgLEtXqYG7tgw3cZRT+pjkDFZbSU7C7j3MIZawbds5d
        BW6xR2BnHZ+24BEdDNMmyD5m3/k/9eS55vMDVqdICBMlUe1eVQ/zqK4fsHJbPxuC
        fMV8Tjn9Po+n4kzlA6kH3MjqMRc7+CyoYzRh0HYuDY/C20NWABGCUjrZO0KxV6Qf
        PHAo/pCTC1jtHYmCPI9VTTAEa2hVYh07pAd9hewzZdQu38n0xYkw3mFHKLT3hV7l
        g2F38p24WN3J2gmwQmAsbmkwQFrS5Xb24dFRTQNwt0EkFuZuf/rl4E+dA==
X-ME-Sender: <xms:He5GZBvdNAikfpwfaBkYRIZ9adCIdo--aUvtOv1J9Bzy_Xy73xf99g>
    <xme:He5GZKeCAoTFthVso0-NOdKe3WBkzLhrtH8S9OWaW1Hx3BBg56EteqgeEC90X5hRb
    QPAt5xumxz7SSoYZyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:He5GZEwDyLHpykzdPnzFxOT-SZtE9TZmzQzx3ON3tvyrHT_TI7Wi1w>
    <xmx:He5GZIMbE5z2BuUttlcPnh-5Ius6lRNRiQpNL6EFu9NApbZy4P4TlA>
    <xmx:He5GZB8t4tEpo79IQ48tflhT_L4NJZpcigTdEyGyo7tzGZl_hTnNoQ>
    <xmx:He5GZDn00m7sPTiD9MYcSbGKJkoitDBVSFodbJRNv6Y5373HjRmnTA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 36E61B60086; Mon, 24 Apr 2023 17:01:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <01f461fa-e2b8-4e69-a7a3-94db842b2f72@app.fastmail.com>
In-Reply-To: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
Date:   Mon, 24 Apr 2023 23:00:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM: SoC defconfig updates for 6.4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.4

for you to fetch changes up to 2c25b94f881cf9389001cc08b1232a8099b3f8bf:

  ARM: config: Update Vexpress defconfig (2023-04-18 16:05:04 +0200)

----------------------------------------------------------------
ARM: SoC defconfig updates for 6.4

Most of the changes just enable additional device drivers that
were added or that are often used on major platforms.

The virtconfig added last time now disables additional drivers
to shrink kernels for virtual machines.

The obsolete oxnas_v6_defconfig file is removed in turn.

----------------------------------------------------------------
Abel Vesa (1):
      arm64: defconfig: Enable QCOM eUSB2 SNPS PHY and repeater

Alexandre Torgue (1):
      ARM: multi_v7_defconfig: Add OPTEE support

Alistair Francis (1):
      ARM: imx_v6_v7_defconfig: Enable rohm,bd71815

Arnd Bergmann (5):
      Merge tag 'renesas-arm-defconfig-for-v6.4-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.4' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'tegra-for-6.4-arm64-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/defconfig

Bartosz Golaszewski (1):
      arm64: defconfig: enable building the nvmem-reboot-mode module

Besar Wicaksono (1):
      arm64: defconfig: Enable ARM CoreSight PMU driver

Bhavya Kapoor (3):
      arm64: defconfig: Enable CAN PHY transceiver driver
      arm64: defconfig: Enable TI TSCADC driver
      arm64: defconfig: Enable TI ADC driver

Devi Priya (1):
      arm64: defconfig: Enable IPQ9574 SoC base configs

Fabio Estevam (3):
      arm64: defconfig: Enable i.MX93 ADC support
      ARM: imx_v6_v7_defconfig: Select CONFIG_DRM_I2C_NXP_TDA998X
      ARM: imx_v4_v5_defconfig: Build CONFIG_IMX_SDMA as module

Geert Uytterhoeven (3):
      ARM: shmobile: defconfig: Refresh for v6.3-rc1
      ARM: multi_v7_defconfig: Enable additional support for RZ/N1 platforms
      arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller support

Jai Luthra (1):
      arm64: defconfig: Enable audio drivers for AM62-SK

Kamlesh Gurudasani (2):
      arm64: defconfig: Enable crypto test module
      arm64: defconfig: Enable security accelerator driver for TI K3 SoCs

Kathiravan T (1):
      arm64: defconfig: Enable IPQ5332 SoC base configs

Krzysztof Kozlowski (1):
      arm64: defconfig: enable Qualcomm pin controller drivers

Kuninori Morimoto (1):
      arm64: defconfig: Enable DA7213 Codec

Linus Walleij (2):
      ARM: configs: Update U8500 defconfig
      ARM: config: Update Vexpress defconfig

Mark Brown (1):
      arm64: virtconfig: Further shrink the config

Neil Armstrong (3):
      arm64: defconfig: add PMIC GLINK modules
      ARM: configs: remove oxnas_v6_defconfig
      arm64: defconfig: remove duplicate TYPEC_UCSI & QCOM_PMIC_GLINK

Nishanth Menon (1):
      arm64: defconfig: Enable drivers for BeaglePlay

Petr Vorel (2):
      arm64: defconfig: Switch msm8996 clk drivers to module
      arm64: defconfig: Enable qcom msm899{4,8} clk drivers

Ryan Roberts (1):
      arm64: defconfig: Enable Virtio RNG driver as built in

Stefan Wahren (1):
      ARM: imx_v6_v7_defconfig: Enable Tarragon peripheral drivers

Wolfram Sang (1):
      arm64: defconfig: Disable R-Car H3 ES1.*

 arch/arm/configs/imx_v4_v5_defconfig |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig | 12 +++++
 arch/arm/configs/multi_v7_defconfig  |  8 ++++
 arch/arm/configs/oxnas_v6_defconfig  | 92 ------------------------------------
 arch/arm/configs/shmobile_defconfig  |  2 +
 arch/arm/configs/u8500_defconfig     | 10 ++--
 arch/arm/configs/vexpress_defconfig  |  4 +-
 arch/arm64/configs/defconfig         | 46 +++++++++++++++++-
 arch/arm64/configs/virt.config       | 21 ++++++++
 9 files changed, 97 insertions(+), 100 deletions(-)
 delete mode 100644 arch/arm/configs/oxnas_v6_defconfig
