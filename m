Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7474296C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2PXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjF2PXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:23:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165330EF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:23:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id EC6DE3200905;
        Thu, 29 Jun 2023 11:23:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688052182; x=1688138582; bh=k3
        y023L2+HLrN0+wxOQ3ndaGyRDKGKPIMKVbeyqnFTg=; b=LEan1GEE23w2wAvQNH
        zSUetYPYH4wDi7bFOBebhAST38OcRzNflwxFH8L5jz+wcuZVPKo4bJnNkmcAoLZR
        ot2sBw+0UY7TmStJxgd1Jhx/We+B+LLwB+Jh+JtJUtH75i+yqZy2cdusEPAtIe33
        16pbkQeMCgWlCHgG/Bc3jb0GdZ1zBFpBXoWfe/NqDgMqzCj864zCy0/7D6QP1tsH
        L8eIIRGjEhqlVy0IMqs6UYWRCUjK70c1Ss8i2Kba2saAOoFO4QFrluiudJz6Habn
        UXcZSYSUZFYzffJ73vmRoS+L/KYi09515bfvJG6XNPZvAn6IlokG6sWy6TcsXsOg
        HgMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688052182; x=1688138582; bh=k3y023L2+HLrN
        0+wxOQ3ndaGyRDKGKPIMKVbeyqnFTg=; b=AxYo8qEVWbaewqTgoXy7qjsATlldY
        lLQZh0IJVfcIYKHA9DHRf3R95YwftK0XfcM+nK3AhYIDhdtiw0cqsBqkMA9rPxMQ
        1wVZxh8iyhxbCPe4oZmWIjP8A0GiDt7UltRlrBFJyZv/H/9liLy6eZG4D6uMP+ue
        9oL4O3J+ulEZAsR8ilm8bqSW6ahnpQJeqbZ/W/e6rU7cn9rNYy4+52mrMvaSYByg
        luXKHCOryWDeWOhUswtwNwocNmQCScvnXWnlb9OIU8R8rCN1X4TtOzE5fCPiYuYy
        PlljMXfD2P6MFELBXv38/xK/j7EpBrmNnXHLVKgvyK9QWbwCpa5OLR6oA==
X-ME-Sender: <xms:1qGdZDRbVdKPA_8rqaKQgPwmrmGRHcS8rWzC8Mx9nSgNJUmwPuShjw>
    <xme:1qGdZEypLrLFsorRrKe_KFPqThUKSPrHp9wUs9LpSGg9LjqPH4-SmdfUKFtrTDWLc
    ANYXDOsCQ6WZwG6q4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1qGdZI21aLu2GQqPbSkDy0Ve1IRoyJizx4TNxeOFB4AQqwFygccUhg>
    <xmx:1qGdZDBnkcdbx2pJ0v0EICi69VB0bY1FVhaHeOwCgcm1-GDxTf2wrA>
    <xmx:1qGdZMjTIZjTuwOVYgwkfzXqhdSlcgV5-1eWq2qqcBK32VtDFd84gw>
    <xmx:1qGdZIYoHN4sDgjjCk6m9biN1Tt3rK8goYHuaW3BhpZ7ASG1axe9mA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 552D4B60086; Thu, 29 Jun 2023 11:23:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <850b11a6-4f23-41dd-ac14-d8663683d1f6@app.fastmail.com>
In-Reply-To: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
References: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:22:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 4/5] ARM: SoC defconfig changes for 6.5
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.5

for you to fetch changes up to 2b24391767ae6897dff6eeb521f01d495bc27b55:

  arm64: defconfig: Enable Rockchip I2S TDM and ES8316 drivers (2023-06-21 15:04:01 +0200)

----------------------------------------------------------------
ARM: SoC defconfig changes for 6.5

The arm64 defconfig file gets the usual updates to enable addition
device drivers as well as the sparx5 and realtek SoC platforms.

For arm32, there are only a couple of cleanup patches for imx,
renesas and rockchips.

----------------------------------------------------------------
Adam Ford (1):
      arm64: defconfig: Enable video capture drivers on imx8mm/imx8mn

Alexandre Mergnat (2):
      arm64: defconfig: enable MT6357 regulator
      arm64: defconfig: enable Mediatek PMIC key

Arnd Bergmann (7):
      Merge tag 'renesas-arm-defconfig-for-v6.5-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.5-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'imx-defconfig-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.5-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.5' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'v6.4-next-defconfig' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into soc/defconfig

Bartosz Golaszewski (1):
      arm64: defconfig: enable the SA8775P GPUCC driver

Biju Das (1):
      arm64: defconfig: Enable Renesas MTU3a counter config

Cristian Ciocaltea (1):
      arm64: defconfig: Enable Rockchip I2S TDM and ES8316 drivers

Devi Priya (1):
      arm64: defconfig: Enable ipq6018 apss clock and PLL controller

Dhruva Gole (1):
      arm64: defconfig: Enable UBIFS

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Remove firmware loader helper
      arm64: defconfig: Enable the TI SN65DSI83 driver

Francesco Dolcini (1):
      arm64: defconfig: enable drivers for Verdin AM62

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v6.4-rc1

Konrad Dybcio (1):
      arm64: defconfig: Build SM6115 display and GPU clock controller drivers

Krzysztof Kozlowski (1):
      arm64: defconfig: Enable ARCH_SPARX5 and ARCH_REALTEK

Neil Armstrong (1):
      arm64: defconfig: enable FSA4480 driver as module

Otavio Salvador (1):
      ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config

Sebastian Reichel (2):
      ARM: multi_v7_defconfig: update MFD_RK808 name
      arm64: defconfig: update RK8XX MFD config

Srinivas Kandagatla (1):
      arm64: defconfig: Enable sc828x0xp lpasscc clock controller

Vladimir Zapolskiy (4):
      arm64: defconfig: Build MSM power manager driver
      arm64: defconfig: Build Global Clock Controller driver for QCM2290
      arm64: defconfig: Build interconnect driver for QCM2290
      arm64: defconfig: Build display clock controller driver for QCM2290

 arch/arm/configs/imx_v6_v7_defconfig |  3 ---
 arch/arm/configs/multi_v7_defconfig  |  2 +-
 arch/arm/configs/shmobile_defconfig  |  3 +--
 arch/arm64/configs/defconfig         | 32 +++++++++++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 7 deletions(-)
