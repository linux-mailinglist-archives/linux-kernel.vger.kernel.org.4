Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571AD74292D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF2PNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjF2PNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:13:34 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE971BD1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:13:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7B74A3200927;
        Thu, 29 Jun 2023 11:13:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1688051610; x=
        1688138010; bh=XeIvPk5ko2AMp3S+4HUOBL42jph3ztzXitHWLUGtnyo=; b=T
        47bABH4HuaPsYxVhK3Bnux5Iq2JUgC2eGv4dvL0Q4k+NMNu5f15LiaaWormh3iKO
        soRzQNAiv4nv1FJ4nNz35dQVLEOOCQbclraJnJBmM11McdMS4pkYGf9WVCIjwe6r
        NRZJzsEbqmEWkN6kqjprqe7NpHuRAgC1iJnBtBZlXTZAaAwKiz/MQpSYPfMR4v9o
        pJ+bxpZd+gzDvq0Tj9rwk1b9dQoZNFH9KfIRWObzAysoUb9E4BrhWz1VsAiAqJvt
        uGlerbis2CWPgJvY1qYrpmQ58c9HynI5aH3H4VBuUtBfxhQEYhDDJyVEgK5ORKb7
        k/XHFB5mD1yyl8ZcEdBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688051610; x=1688138010; bh=X
        eIvPk5ko2AMp3S+4HUOBL42jph3ztzXitHWLUGtnyo=; b=HJCB6rr4s1FFq/6G2
        NGJlhAO3bOeShRpCrNyO4GchqI3BZbdDtDYQvuXKL5uHUCTs9a6vSV+haRKk7Lhn
        L9U46/oHf7DbA4ql0GjoqckRvN+74QcqWbqkPEuwQYk7/y0BmuPTr2rvlY9CEsR9
        DbgTECWcXTiLR0dCA5Hrvje3yGCuXIhsOklpNk4ccoOSTT9wkCvRb/tURM5WJ+Qc
        o2Le8/dJKANgu3nVXBpj0vmT05UhNtRj6CXJRhEi1XlCjoBEAnwJaFo5faCEry1S
        mIJL+X6YlmNXlhX00nbcKfppCYmVXfE0J1Peru+5dCrm6hhec6a7+bljnY4Y4WDe
        msbpg==
X-ME-Sender: <xms:mZ-dZP21BbUcWVWtMctHpBKFR0xDDLGNqouLik4Q4Ydy0fZAFk-FWg>
    <xme:mZ-dZOHmIajaSKKFGyAAnpXzqba8ayZkJztoTNr1XLUHlkYUaAy5J-JKTN14S_5hc
    hCMEf6yUCPR-jQOUi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeehleefteehledvieeifeeftefhkedvheehudelteevieekhefhgefhveekffeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mZ-dZP7LqfhqH4_gxqvUkoja6NgegdsPEa1ub31T44ljN382EsyAag>
    <xmx:mZ-dZE17nQToPZkSQ6tGLI9EJewwigvs2_PNcdT-rFjexkbOWAkaEw>
    <xmx:mZ-dZCFyFCHu122QnwZqlTKzZOg_3D_1Ci72jutKwj0aZzB2biIe8A>
    <xmx:mp-dZEPDWSihYKBa7qaJICOI1WZ_ztRLqgp2uGO9ctpYKTQkeH9GKw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B880BB6008D; Thu, 29 Jun 2023 11:13:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:11:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 0/5] ARM: SoC tree changes for 6.5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the usual large number of devicetree updates, mostly for arm64
and a little bit of arm32 and riscv. The most notable contents this
time are the move of all 32-bit dts files into subdirectories, as it
was getting very much out of hand to have everything in one place.

Among the newly added hardware, the rv64 TH1520 and the three added
arm64/cortex-a35 based stm32mp2, ma35d1 and amlogic C3 are the
most notable.

Overall, there are 1132 non-merge changesets ion 74 branches, which
is large but not overly so. There were 214 individual contributors
this time, the and the most active ones by number of changesets are

    103 Krzysztof Kozlowski
     84 Nishanth Menon
     32 Konrad Dybcio
     30 Fabio Estevam
     29 Stephan Gerhold
     26 Michal Simek
     21 Linus Walleij
     21 Dmitry Baryshkov
     18 Rafa=C5=82 Mi=C5=82ecki
     18 AngeloGioacchino Del Regno
     17 Arnd Bergmann
     16 Neil Armstrong
     16 Kathiravan T
     15 Tony Lindgren
     14 Devi Priya
     14 Bhupesh Sharma
     13 Marek Vasut
     13 Luca Weiss
     13 Bjorn Andersson
     12 Thierry Reding
     12 Jacky Huang
     11 Robert Marko
     11 Oleksij Rempel
     11 Biju Das
     11 Bartosz Golaszewski
     11 Artur Weber

The diff/dirstat now shows the dts file modifications in their
new location, not including the changes of the actual merge:

   0.3% Documentation/devicetree/bindings/arm/
   0.4% Documentation/devicetree/bindings/clock/
   0.2% Documentation/devicetree/bindings/interrupt-controller/
   0.3% Documentation/devicetree/bindings/media/
   0.2% Documentation/devicetree/bindings/soc/
   0.7% Documentation/devicetree/bindings/
   0.4% Documentation/process/
   0.7% arch/arm/boot/dts/allwinner/
   1.1% arch/arm/boot/dts/broadcom/
   0.2% arch/arm/boot/dts/hisilicon/
   0.4% arch/arm/boot/dts/marvell/
   0.3% arch/arm/boot/dts/mediatek/
   0.4% arch/arm/boot/dts/microchip/
   1.7% arch/arm/boot/dts/nxp/imx/
   0.2% arch/arm/boot/dts/nxp/
   1.5% arch/arm/boot/dts/qcom/
   0.9% arch/arm/boot/dts/samsung/
   1.8% arch/arm/boot/dts/st/
   0.2% arch/arm/boot/dts/ti/keystone/
   4.9% arch/arm/boot/dts/ti/omap/
   3.3% arch/arm/boot/dts/
   0.8% arch/arm/mach-omap1/
   0.5% arch/arm/mach-omap2/
   0.6% arch/arm/
   3.6% arch/arm64/boot/dts/freescale/
   0.7% arch/arm64/boot/dts/hisilicon/
   3.2% arch/arm64/boot/dts/mediatek/
   0.4% arch/arm64/boot/dts/nuvoton/
   1.0% arch/arm64/boot/dts/nvidia/
  28.5% arch/arm64/boot/dts/qcom/
   1.1% arch/arm64/boot/dts/renesas/
   3.5% arch/arm64/boot/dts/rockchip/
   0.7% arch/arm64/boot/dts/st/
  15.1% arch/arm64/boot/dts/ti/
   1.1% arch/arm64/boot/dts/xilinx/
   0.4% arch/arm64/boot/dts/
   0.6% arch/riscv/boot/dts/thead/
   0.2% arch/
   2.9% drivers/clk/nuvoton/
   0.2% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/tegra/
   0.2% drivers/input/touchscreen/
   0.9% drivers/memory/tegra/
   0.2% drivers/memory/
   4.5% drivers/pinctrl/stm32/
   0.7% drivers/reset/
   0.5% drivers/soc/mediatek/
   0.7% drivers/soc/qcom/
   0.4% drivers/soc/rockchip/
   0.5% drivers/soc/ti/
   0.2% drivers/soc/
   0.7% drivers/
   0.9% include/dt-bindings/clock/
   0.2% include/dt-bindings/reset/
   0.5% include/linux/
   0.2% include/
