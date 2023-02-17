Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B618869B1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:22:45 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BEB6EF0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:22:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 554E15C00BC;
        Fri, 17 Feb 2023 12:22:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Feb 2023 12:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1676654562; x=1676740962; bh=8Xaj3pj9yaVAHO5eYkDPSbZ6Fhl9zjVVpnG
        MMHrHXcQ=; b=PVBNjd84hQ2n2eTyXVECKNUScWxFEHuQe9hkuXyGw7BtOLX6Xmr
        IhHk/732M9RXbGKjhZIY3QWt1K+UkDMnx/xxhMH54yojNdn3X1j1ID4tY1HW32Hx
        WnUgUBqIq1katIJeomMgbdXltJVU/SJHYuTz1Oz3UUNpX6b4VIbaFA5RWmf0U5VS
        hKZvsblsz8pkaEC9RW6lnoqRaAfQ35w+Jd2lCj0NolX2rHuvzDpLrrW/AEE1Knco
        ir69ERksuMEB4nBcy2U+TR48marImPviZO0HMR0p1fXHn9FEygDfr6mSIYhdGY6D
        XqEIULGr3CeYlmbefnp0qEZR0xO63xN4Eiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676654562; x=
        1676740962; bh=8Xaj3pj9yaVAHO5eYkDPSbZ6Fhl9zjVVpnGMMHrHXcQ=; b=r
        80tLsbK1cia8joNh1oe3aw4pAqjca3TgqD0BkWZZ9ddMXCGFNvCrNSaQ6VhV7yRJ
        Qwx6q/ZHtNIJuIybcy7SUDkqPtN+VQnGDEjz6nDEXBvPIMy5KR67ae5KfqxTJQuN
        GR4zLpUhUeg+NBr2buUV2KkbZwtUqrIG3c2U5u2K2OZnO8v5AUs3Z8AkKvOML42g
        yAOt8IanhJ5vHk9uacmD8OnMJQL0N3eS+MACgJwpJ0SxvDSMdSVtBzhQ3TD3c7Ep
        NBOTyrfrn+nTlOON/W2F3sdA4yAgB1Aqp6sLy678HTk6YCrqdCTIG5afJu+w0u0V
        a5st+I7MN/dtnHDOPEdAw==
X-ME-Sender: <xms:4rfvYxr7xbUWmdsbxP9OXwoFbsIZXe9RfAqFlBvtHTAfe9nrc2f2jQ>
    <xme:4rfvYzpi05Soob-t8DfHi0u4IfCGvEXXtM9ntyJberWY3Zwf9RQSbCrhHKiiuWedK
    b99bmW-RlLnrL6gZGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepuefhffffvdekhfeivdfhtdfhueevtdffhfehjeeifeekgeeguedugeefhedufffg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4rfvY-NGGRkhWoGB_25FONV6hlV1I_lBrM-aavqrsTU_JeKaHRPFQg>
    <xmx:4rfvY86Mmt0_IUHUS72g1PUbFvre1Rpj9stx3TTFtc9WCihuWoJRJg>
    <xmx:4rfvYw7MeuM2ebDPuJdWAZYDrf669zcp9qRiTE4fxir51iCa8d62qg>
    <xmx:4rfvY-QjffU4j1ozwP67clYLfoN6sPIcrIm7dBcwJqXinwuOiwF8qg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 036BEB60089; Fri, 17 Feb 2023 12:22:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
Date:   Fri, 17 Feb 2023 18:21:01 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 0/4] ARM and RISC-V SoC changes for 6.3
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another large merge window for the SoC tree with 1365
non-merge changesets. The two main portions of this are a massive
update on 64-bit Qualcomm SoC support and a cleanup of dead code
for 32-bit platforms. 

The cleanup contains a number of driver (removal) patches for
other subsystems, which will cause some minor merge conflicts
against changes to the removed drivers, but those were hard to
avoid without having the cleanup span multiple merge windows.

I'm sending these early since I'll have a few days off at the
beginning of next week, but I'm postponing the "drivers" branch
for the moment as there is still an open problem that I hope
to see resolved first.

The most active developers by number of changes were:

    208 Krzysztof Kozlowski
    103 Arnd Bergmann
     82 Konrad Dybcio
     61 Dmitry Baryshkov
     42 Neil Armstrong
     29 Marek Vasut
     27 Cristian Marussi
     27 AngeloGioacchino Del Regno
     22 Luca Weiss
     20 Jagan Teki
     20 Bjorn Andersson
     19 Samuel Holland
     17 Marijn Suijten
     16 Abel Vesa
     15 Geert Uytterhoeven
     14 Lin, Meng-Bo
     14 Johan Hovold
     13 Bryan O'Donoghue
     12 Christian Hewitt
     11 Nancy.Lin

$ git diff --dirstat=0.5
   1.1% Documentation/devicetree/bindings/
   0.7% Documentation/
   4.5% arch/arm/boot/dts/
   1.5% arch/arm/configs/
   0.9% arch/arm/mach-cns3xxx/
   4.2% arch/arm/mach-davinci/
   1.1% arch/arm/mach-iop32x/
   2.3% arch/arm/mach-mmp/
   2.4% arch/arm/mach-omap1/
   0.7% arch/arm/mach-omap2/
   0.8% arch/arm/mach-orion5x/
  13.5% arch/arm/mach-pxa/
  10.1% arch/arm/mach-s3c/
   1.1% arch/arm/mach-sa1100/
   0.5% arch/arm/
   0.8% arch/arm64/boot/dts/amlogic/
   1.1% arch/arm64/boot/dts/freescale/
   1.1% arch/arm64/boot/dts/mediatek/
   2.0% arch/arm64/boot/dts/nvidia/
  10.3% arch/arm64/boot/dts/qcom/
   0.7% arch/arm64/boot/dts/renesas/
   3.2% arch/arm64/boot/dts/rockchip/
   1.6% arch/arm64/boot/dts/ti/
   0.7% arch/riscv/boot/dts/allwinner/
   0.5% arch/
   0.9% drivers/clk/samsung/
   0.9% drivers/cpufreq/
   0.6% drivers/dma/
   1.5% drivers/firmware/arm_scmi/
   0.5% drivers/input/touchscreen/
   1.4% drivers/interconnect/qcom/
   2.4% drivers/media/platform/ti/davinci/
   1.2% drivers/mfd/
   0.8% drivers/mmc/host/
   1.3% drivers/power/supply/
   0.8% drivers/soc/mediatek/
   0.5% drivers/soc/qcom/
   0.5% drivers/soc/
   3.0% drivers/staging/media/deprecated/vpfe_capture/
   1.5% drivers/usb/gadget/udc/
   0.6% drivers/usb/phy/
   2.3% drivers/video/fbdev/
   3.5% drivers/
   0.5% include/dt-bindings/
   1.1% include/linux/
   0.5% include/
   1.5% sound/soc/pxa/
   1.7% sound/soc/samsung/
   0.5% sound/soc/
 1975 files changed, 88552 insertions(+), 174681 deletions(-)
