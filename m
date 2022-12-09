Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0A64879F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLIRT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLIRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:19:41 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FDC18B03
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:19:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2286E3200916;
        Fri,  9 Dec 2022 12:19:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670606378; x=
        1670692778; bh=WMh0atwWtRwdirolYUfL96TY8u3PLU91dpI4dYz4yEQ=; b=K
        bYjb2wT+JCwrofrDLcgQeCM+OUaOmhohkuo8iCLAUSFC46OjrmZb9f07bTQ9Bc1U
        YKGHrqfK2amLEuRp7v16R8GMRgxKQ33FXxnjQDG81ZOL85oW7niDatQLrqJXkYWq
        Ef2K6Q6vphh4Vf1CXohSapr/vzpFzH+KhWuwzOoz40N0vKHTC8ZDQpYFlXDYWIqh
        upkQ5eGj4MIYog8vFrzJ8aja76NEl9a+5x/Bt31whZyovIbPUnXuX/KXwj2SSSfE
        fN/DlamgTaWEP9GYZViBUDbjxfxNqwrqnjVsd59s2gvUtMLjeNBPpubknyXoRmWJ
        irAMp/lKtviea3kqk8FVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670606378; x=
        1670692778; bh=WMh0atwWtRwdirolYUfL96TY8u3PLU91dpI4dYz4yEQ=; b=B
        ruXVFxYU8CiXPTTtnDNifygBvfHG2zCm+7rfF8U2EivmWTXPplg3BMh4yLjdg2Rl
        yEuJHWmhuelPx/wsq2ICtpNESOL794W5jAyo0Q/TMGJs30jQuCIZOsRJf21iQ4Wa
        1zHgl46HLvHtvGYg1B15OAM3jdUDQ1vussFHBVc+RMklR5wx7CBUNMAmFa+f82xC
        uXJBgjBeErvwsYKOcm08YBn7DyEW59glr5cLLGTbSf2PX6AVYJ3O4HHSrX3CWZ2p
        Pp3CitfHKWavX49WS3t21+HElZMqBP8z+LOzaAoSDi+kOSBzDx8H651s633l2rE/
        XhiTCapaF3dlaK79Tn9YA==
X-ME-Sender: <xms:Km6TY7GkoY41XBE2UnS2Mdrf5wCdikLL5YhhvJ3VTvyUU38MXVAF8A>
    <xme:Km6TY4VB7I34FyuWEuuCgMuRD8_QwtMRGqxHjepFBi5Na9vc2NuH9XCbM1fMVnRw5
    Vb9Zu-rFiVAnRbPn_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Km6TY9K7cWRkUEuuF5SSj717JzY3TupjVGH_AndsEJN7lpIfXrK4gg>
    <xmx:Km6TY5EQp3mY53yCF1Sa4r8n60YOHBwnI5bJL09vnxROnQkpk7EvAw>
    <xmx:Km6TYxUY9CSaihiJbx-Qn6tnH-j8Czrzo-s6Etrf0uXGGhzYTJE8lQ>
    <xmx:Km6TYwc9HwGp7Nq6oBnfmzKwuQROMPYyMA7vFIIXzTGsUKhAgodsAg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 817E4B60086; Fri,  9 Dec 2022 12:19:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <4a5121a4-9b3a-45d3-934b-f24ec3a222f5@app.fastmail.com>
In-Reply-To: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
Date:   Fri, 09 Dec 2022 18:19:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] SoC: arm defconfig updates for 6.2
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a=
740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.2

for you to fetch changes up to 93b8c91e4cdb520b67ffc4513a7d6232f1037d9b:

  Merge tag 'qcom-arm64-defconfig-for-6.2-2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/qcom/linux into arm/defconfig (2022-12-07 22:10:=
05 +0100)

----------------------------------------------------------------
SoC: arm defconfig updates for 6.2

This contains the ususal arm and arm64 updates to defconfig
files, enabling newly added drivers and adapting the files to
Kconfig changes, in particular for qualcomm, microchip, and
nxp SoC platforms.

----------------------------------------------------------------
Alexander Stein (1):
      arm64: defconfig: Add Renesas 9-series PCIe clock generator

Alistair Francis (2):
      ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
      ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen

Arnd Bergmann (11):
      Merge tag 'at91-defconfig-6.2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/at91/linux into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.2-tag1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/defconfig
      Merge tag 'renesas-riscv-defconfig-for-v6.2-tag1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/defconfig
      Merge tag 'tegra-for-6.2-arm64-defconfig' of git://git.kernel.org/=
pub/scm/linux/kernel/git/tegra/linux into arm/defconfig
      Merge tag 'imx-defconfig-6.2' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/shawnguo/linux into arm/defconfig
      Merge tag 'v6.1-next-defconfig' of https://git.kernel.org/pub/scm/=
linux/kernel/git/matthias.bgg/linux into arm/defconfig
      Merge tag 'ti-k3-config-for-v6.2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/ti/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.2' of https://git.kernel.org=
/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig
      Merge tag 'qcom-defconfig-for-6.2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into arm/defconfig
      Merge tag 'at91-defconfig-6.2-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/at91/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.2-2' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig

Bhupesh Sharma (3):
      arm64: defconfig: Enable Qualcomm QCE crypto
      arm64: defconfig: Enable Qualcomm SM6115 / SM4250 GCC and Pinctrl
      arm64: defconfig: Enable Qualcomm SM6115 / SM4250 GCC and Pinctrl

Claudiu Beznea (3):
      ARM: configs: at91: sama7: use make savedefconfig
      ARM: configs: at91: sama7: add config for microchip otpc
      ARM: configs: at91: sama7: add config for thermal management

Dipen Patel (1):
      arm64: defconfig: Enable HTE config

Eugen Hristev (2):
      ARM: configs: sama5/7: switch to new MICROCHIP_ISC driver
      ARM: configs: multi_v7: switch to new MICROCHIP_ISC driver

Fabrice Gasnier (1):
      ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as modules

Jon Hunter (1):
      arm64: defconfig: Enable Tegra186 timer support

Kory Maincent (2):
      arm: configs: spear6xx: Refresh defconfig
      arm: configs: spear6xx: Enable PL110 display controller

Krzysztof Kozlowski (3):
      ARM: qcom_defconfig: enable rest of ARMv7 SoCs pinctrl drivers
      arm64: defconfig: enable rest of Qualcomm ARMv8 SoCs pinctrl drive=
rs
      arm64: defconfig: build-in Qualcomm SC7180 and SM8450 interconnects

Lad Prabhakar (1):
      riscv: configs: defconfig: Enable Renesas RZ/Five SoC

Marcel Ziswiler (3):
      arm64: defconfig: enable snvs lpgpr support
      arm64: defconfig: enable i.mx 8m plus specific interconnect support
      ARM: imx_v6_v7_defconfig: Enable USB GPIO extcon support

N=C3=ADcolas F. R. A. Prado (1):
      arm64: defconfig: Enable missing configs for mt8183-jacuzzi-juniper

Rahul T R (1):
      arm64: defconfig: Enable TI_TFP410 DVI bridge

Sameer Pujar (2):
      arm64: defconfig: Enable couple of audio codecs
      arm64: defconfig: Enable SND_ALOOP

Yoshihiro Shimoda (1):
      arm64: defconfig: Enable Renesas R-Car S4-8 Spider Ethernet devices

 arch/arm/configs/imx_v6_v7_defconfig |  5 +++++
 arch/arm/configs/multi_v7_defconfig  |  8 ++++---
 arch/arm/configs/qcom_defconfig      |  5 +++++
 arch/arm/configs/sama5_defconfig     |  2 +-
 arch/arm/configs/sama7_defconfig     | 11 ++++++---
 arch/arm/configs/spear6xx_defconfig  |  7 ++----
 arch/arm64/configs/defconfig         | 43 +++++++++++++++++++++++++++++=
++++---
 arch/riscv/configs/defconfig         |  3 +++
 8 files changed, 69 insertions(+), 15 deletions(-)
