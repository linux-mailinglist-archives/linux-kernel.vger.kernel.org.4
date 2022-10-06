Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9825F6388
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJFJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJFJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:22:35 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155498CB2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:22:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7A0385809F4;
        Thu,  6 Oct 2022 05:22:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665048144; x=1665051744; bh=29UDqV5vYg
        sI+WWZHeC9KRtscHTUXdUaQr8Wyq+BuTM=; b=jFmHrol8f3LoVS64fTQrjxd6eR
        QF73JAg12vaOCVsxcJ4d654MaJJ7gQZTr67xxvzuBMNXO+4ZE3UUbDYRbfJ5C2EH
        ihg2ZYs+fnZj9ZMkQIStbRuXdGSeloLuDN9fzss+JxYJVl1bUD4VdUCt3OTCodvY
        5o3HfZTyuxnoaFCVbiY2dVD4PeSgCIB4vqLnVxpaDontY2o6v7bp/xcaHzAte5ar
        b8Xd5o8chPVRA3ES/kMSu1pz3pyJd3mRnnrGToBKQ6ZbdqWwe0b/YlYIw0fVbII6
        zGdTjXfwYHQ6FCiyz5NJX/xVuggUUnn/mXYA6k77bOMfN82z6VzOO/Pwto+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1665048144; x=1665051744; bh=29UDqV5vYgsI+
        WWZHeC9KRtscHTUXdUaQr8Wyq+BuTM=; b=slX5ZrTQyCd4D8HDiMtoqP52saxn2
        FaP1AXtoyKoquTXQXwiaRgipc1Ic0TQQVE4oO7BXHNYznxgo78mbQA/vZQyAwDwV
        BhjQF0MKXVFTOLL6VXiqivjRixVC+xUPsLxifjnvZ68wUuj6zDMSqbe8bMpNeauG
        LeCM+FWJeZxdmO/uFnj7KsKHZOK1FBfukbvnUAZlyqMyyzRRw4sIge9/vkn5Aev+
        E/0OzjcsUKx8p37jey48WOyYOiqQtuPSr+YI5sOVGs+dKyViGgRtddgFOLf+Q76Q
        BINhLwAkvN+P2vFt8+TxGdTy+cdBFSEJI8iecm6rL5af35JaFEgk5e/3w==
X-ME-Sender: <xms:UJ4-Yx98En902q9MUo2TFJUpZHRJxQwHkoTQoeSZZdgXM-hUWm2ISg>
    <xme:UJ4-Y1vP7Ewds0xcWuNl8BxOCpzQLGULTHr03-F2V62Uvf6JH53i_0NhBEtdAIQqZ
    hFKINnZOTaWZMy2nwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefheelfeetheelvdeiieeffeethfekvdehheduleetveeikeehhfeghfevkeff
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UJ4-Y_BjZIynMiDN274RApzIqpkY0k-x8qRQHvNWNgmIR-4tGW187A>
    <xmx:UJ4-Y1eZq37Djk8wKbYkOdmGdfAbD-AG0-yNVcf-Tc0FUgH66vjRGw>
    <xmx:UJ4-Y2M4TCXhnBcchGCJNhSk_k7Aosh3PoEsF3oXtgxuwg8lHitZYQ>
    <xmx:UJ4-Y43YRTbjKRImF0fz6QSLilAZaKRP5UoSa5p1NHdahUNTl1-xQA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 33BC2B60086; Thu,  6 Oct 2022 05:22:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:22:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM SoC updates for 6.1
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

Hi Linus,

This merge window is a again a little quieter for us, with 838 non-merge
changesets including fewer noteworthy updates in the devicetree files, b=
ut a
little more activity in SoC specific drivers than usual. The interesting
changes are back to overwhelmingly for 64-bit platforms, which is of
course the expected trend.

The top contributors by number of patches this time are:
     88 Krzysztof Kozlowski
     37 Peng Fan
     30 Arnd Bergmann
     27 Geert Uytterhoeven
     20 Dmitry Baryshkov
     19 Kunihiko Hayashi
     18 Marcel Ziswiler
     16 Pali Roh=C3=A1r
     16 AngeloGioacchino Del Regno
     15 Lad Prabhakar
     14 Johan Hovold
     13 Tinghan Shen
     13 Joel Stanley
     12 Srinivasa Rao Mandadapu
     12 Li Yang
     11 Wolfram Sang
     11 Sudeep Holla
     11 Jagan Teki
     11 Frieder Schrempf
     10 Tim Harvey
     10 Robert Marko

The overall dirstat looks like
   0.9% Documentation/devicetree/bindings/arm/
   0.3% Documentation/devicetree/bindings/clock/
   0.4% Documentation/devicetree/bindings/firmware/
   0.3% Documentation/devicetree/bindings/media/
   0.7% Documentation/devicetree/bindings/memory-controllers/
   0.3% Documentation/devicetree/bindings/net/
   0.5% Documentation/devicetree/bindings/power/
   0.6% Documentation/devicetree/bindings/soc/imx/
   0.3% Documentation/devicetree/bindings/sram/
   0.2% Documentation/
  14.4% arch/arm/boot/dts/
   0.3% arch/arm/configs/
   0.8% arch/arm/mach-footbridge/
   2.0% arch/arm/
   0.3% arch/arm64/boot/dts/allwinner/
   1.6% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/broadcom/bcmbca/
   0.2% arch/arm64/boot/dts/exynos/
  11.5% arch/arm64/boot/dts/freescale/
   0.6% arch/arm64/boot/dts/marvell/
   7.2% arch/arm64/boot/dts/mediatek/
   3.9% arch/arm64/boot/dts/nvidia/
  10.4% arch/arm64/boot/dts/qcom/
   5.1% arch/arm64/boot/dts/renesas/
   8.1% arch/arm64/boot/dts/rockchip/
   1.0% arch/arm64/boot/dts/socionext/
   2.7% arch/arm64/boot/dts/ti/
   0.2% drivers/bus/
   0.3% drivers/firmware/arm_ffa/
   0.3% drivers/firmware/psci/
   1.3% drivers/memory/
   1.9% drivers/soc/imx/
   1.1% drivers/soc/mediatek/
   2.4% drivers/soc/qcom/
   0.6% drivers/soc/rockchip/
  12.0% drivers/soc/tegra/cbb/
   0.2% drivers/soc/tegra/
   0.3% drivers/soc/
   0.3% drivers/
   0.8% include/dt-bindings/clock/
   0.2% include/dt-bindings/power/
   0.2% include/linux/soc/
   0.4% include/
 798 files changed, 36028 insertions(+), 6182 deletions(-)
