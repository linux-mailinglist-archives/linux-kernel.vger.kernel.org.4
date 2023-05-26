Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF2712EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbjEZVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZVIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:08:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98488DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:08:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 359245C01A5;
        Fri, 26 May 2023 17:08:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 26 May 2023 17:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685135290; x=1685221690; bh=ECPyVaZOAEStC3XwXXG6BZy67
        SJsmVHS+6AfMaO1w/U=; b=WNF1nr2V0gmQsW0RXkmHDfbRPWdL8S4UQ1Iq13rMG
        akCGVv58TMRcYg2T2el1bFlOopZ8JNqEYkgWZhQxF8sMwtSN02cLK2Nhsd/NjDBK
        5z7R8sJuOQ+Cdh6J9NLoldZlHeQDicA8igkNsxNxdVnoIpULJhhFYFc2c5wi8fC7
        wVLz9VqExNuj6UYRsJVfvKnSEvRHKc0bJUzVIr0BMT2XAaxfSIhyf0QNNFPtUjK9
        h+4lwQwXwFrzkG5MmRVWA8+DzOvRN49NxtgPc0aJ3Ghl5BEsltR+WRsIEXn+AAoW
        QHFqh0F9O1ueWX9++AamHQ/sT6zqh1Mog/Otz0pBDXUcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685135290; x=1685221690; bh=ECPyVaZOAEStC3XwXXG6BZy67SJsmVHS+6A
        fMaO1w/U=; b=DTZZu9UVnU7VvzNR+o3LO2DH6yVPmflh62K7kQ/EuenZkOsu6tG
        +oRr4Pp705NGIhPlrtFHNElP06IYq8F97E85Wb5NRSpChtOAz+ggqLbzellD/0KD
        BBMT2nkpSnnkDYa+FhL5TZhsxzWGFYTUROlT5y2UF74//KO7tvQunAkvH32zbi7W
        5SxXaYxmghNQ1u3B5vrd/cdzEQycOJl3BxFXQdFCrIcQYw8tbpouzojSoZzpLblv
        8o21IQwKZrEgvNqp8/7ixzfeutFrXsVVx8fcz+4ewhkRdR4kkZLPjn6nBhqZByNd
        d7ZAVQrr3KZNCFmDaP1i9s12LCc1Ixdrklw==
X-ME-Sender: <xms:uh9xZOa4AW0vwu1JJs1H1hBHU2iYJ8zCbimN9XAFA-bTlI370zHtqQ>
    <xme:uh9xZBZ62CXOzhGChHQnwL_BdkdziUVlhxS0uqgLqcYoq_c8gTP_vAudzZt_M3wJH
    hYhZGRzZePFEZ5tPTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpedtlefhkedvvdethfeuteekheettddvveeltdffhfejudffheelieelheevjeej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:uh9xZI8XhDK0YzAj_ss0p7ZGsiEv9QrAHz5p46WHug0RjruxynvBeg>
    <xmx:uh9xZAruHy6Wgw3KLYb7ic5Bb057vCKAxDh7NRtb446nXJg2yirPww>
    <xmx:uh9xZJoa8axWMKHaCcqx-UGhprE4YYKgqa3JksEdVZxmCVUYHRCDAA>
    <xmx:uh9xZKDwvn_3_7nFjw5HEodcx_kLgMWlde8dNeT0nN1O3m65w02pWA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 00335B60086; Fri, 26 May 2023 17:08:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <f2765dec-e4e0-4b56-b3a5-2f7fc9114b87@app.fastmail.com>
Date:   Fri, 26 May 2023 23:07:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.4-1

for you to fetch changes up to abf5422e821f0f321e95cb728f013f143ca4655c:

  Merge tag 'ffa-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes (2023-05-26 16:49:15 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.4

There have not been a lot of fixes for for the soc tree in 6.4, but
these have been sitting here for too long.

For the devicetree side, there is one minor warning fix for vexpress,
the rest all all for the the NXP i.MX platforms: SoC specific bugfixes
for the iMX8 clocks and its USB-3.0 gadget device, as well as board
specific fixes for regulators and the phy on some of the i.MX boards.

The microchip risc-v and arm32 maintainers now also add a shared
maintainer file entry for the arm64 parts.

The remaining fixes are all for firmware drivers, addressing mistakes in
the optee, scmi and ff-a firmware driver implementation, mostly in the
error handling code, incorrect use of the alloc_workqueue() interface in
SCMI, and compatibility with corner cases of the firmware implementation.

----------------------------------------------------------------
Adam Ford (2):
      arm64: dts: imx8mn: Fix video clock parents
      arm64: dts: imx8mp: Fix video clock parents

Alexander Stein (1):
      ARM: dts: imx6qdl-mba6: Add missing pvcie-supply regulator

Andrejs Cainikovs (1):
      arm64: dts: colibri-imx8x: delete adc1 and dsp

Arnd Bergmann (5):
      Merge tag 'optee-async-notif-fix-for-v6.3' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'juno-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-fix-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'imx-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'ffa-fixes-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes

Christoph Niedermaier (1):
      ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 and 3

Conor Dooley (1):
      MAINTAINERS: update arm64 Microchip entries

Emanuele Ghidoli (3):
      arm64: dts: colibri-imx8x: fix eval board pin configuration
      arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval board
      arm64: dts: colibri-imx8x: fix iris pinctrl configuration

Etienne Carriere (1):
      optee: fix uninited async notif value

Frank Li (2):
      dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type
      arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super speed

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: fix PHY detection bug by adding deassert delay

Krzysztof Kozlowski (2):
      ARM: dts: vexpress: add missing cache properties
      arm64: dts: arm: add missing cache properties

Sudeep Holla (4):
      firmware: arm_ffa: Check if ffa_driver remove is present before executing
      firmware: arm_ffa: Fix usage of partition info get count flag
      firmware: arm_ffa: Fix FFA device names for logical partitions
      firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors

Tejun Heo (1):
      firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation

 .../devicetree/bindings/usb/cdns,usb3.yaml         |  2 +-
 MAINTAINERS                                        | 12 ++++++++--
 arch/arm/boot/dts/imx6qdl-mba6.dtsi                |  1 +
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi           |  7 ++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  1 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |  1 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |  1 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |  1 +
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  1 +
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |  8 ++++++-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          | 28 ++++++++++++----------
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          | 25 +++++++------------
 .../boot/dts/freescale/imx8x-colibri-eval-v3.dtsi  |  6 +++++
 .../boot/dts/freescale/imx8x-colibri-iris.dtsi     |  3 +--
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   | 14 ++++++-----
 drivers/firmware/arm_ffa/bus.c                     | 19 +++++++++++----
 drivers/firmware/arm_ffa/driver.c                  |  9 ++++++-
 drivers/firmware/arm_scmi/raw_mode.c               |  2 +-
 drivers/tee/optee/smc_abi.c                        |  4 +++-
 include/linux/arm_ffa.h                            |  1 +
 20 files changed, 98 insertions(+), 48 deletions(-)
