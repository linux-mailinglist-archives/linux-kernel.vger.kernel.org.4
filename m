Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C064879D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLIRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLIRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:18:58 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFE25EBD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:18:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C9B25320089C;
        Fri,  9 Dec 2022 12:18:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670606328; x=1670692728; bh=dEfh5fceHS
        /dIPa0JMjneiLCUxUdaRdY2u9HtGQhL0U=; b=a96rX5ylVA52bxlGY992K/wXvo
        8ChGFuBwFAFWkiqX+MLHX3U+YQoHjWYqycKcw3GlNFahTMlQksoGkYQZIExVlLkd
        iICjGxK6W2iAuMocu6y6jEeXJ+5S6XwotBuI8dw0jUlkMedxaklXmmCjjYL4OegQ
        jRF/AoH1+cbP3vRZ9mczznGLB2AVzRsa6Me9m8S16GjrZvbNbLNSp52mn89G0WNM
        Pytctbfe7o0nQpF7rydWOXKTXF8nU5ii/Un1kFGKGAae7qnSShjOH+bORb86uUaJ
        qIozfewfrhReN7/vhsPGL3J3xAyH4VjUret3Errt+LD/NBvFwSTKHgW6tBjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670606328; x=1670692728; bh=dEfh5fceHS/dI
        Pa0JMjneiLCUxUdaRdY2u9HtGQhL0U=; b=UNhj6ZOPhqfTJzlZNLLkbk8PyUHqg
        qqr6+1vzDcn4aBe6vzP742vJHGMpFXB+g09omtAXPVo4kUo7N9dNBva7MRYYK20i
        +PQKipQ0v+VQkTeZZZgBNcrwiH0znPMpwzHA0GEHpM4hJu1PnZMpFQvd0MMSQyrS
        QOMVRkiLlYGWYqhvx77vZdByNDLWWkHinSEkfLvgqqpQ9Qq9+D9yHi6ScuNkFjir
        smqfwNTCH+/hHP/RyzcSinrBKIVO+Xs9f5g4vK04vQV8zKgjvAuRg9fVo2xfYFvL
        au7Z7gk0azusjHmxQPara6GlWhZfkFe12BCGQYx0KQk33Uxbb8Sv/vfFQ==
X-ME-Sender: <xms:-G2TY0s-ZMYYMMfG4GhmxQKdHkAoRn5N4EeeS6Fi10Q24hrnjVhK4w>
    <xme:-G2TYxcEwEffYFvqGceo_w3RwCprmxo4quGi72qMPa3ftBpAE7Tm_913Di20mVmtO
    p50sukgwM9bJPLiQcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeehleefteehledvieeifeeftefhkedvheehudelteevieekhefhgefhveekffeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-G2TY_y_Ar9imEmFYdd9_-zoljQGV_BGMLbAFG2HCwfIHasl0WCwjg>
    <xmx:-G2TY3OS25XfyMEdemOimy2KmRcALvKttm6c7bkO-fvP6i1bYeQcTQ>
    <xmx:-G2TY09xWAzN5LFV4uTT34ZbRNzmQurFwLbEyB7-R1F-3LQqa-me_g>
    <xmx:-G2TYylZOWRROa-igPJE_X_Gm5BZ2WX_ON46AS1EN2i4CyKXu3F7zg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30532B60086; Fri,  9 Dec 2022 12:18:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
Date:   Fri, 09 Dec 2022 18:17:42 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] SoC updates for 6.2
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

The updates this time are overwhelmingly for dts files, even more so
than in most other releases, with exactly 1000 dts commits and only
180 for the rest. The largest set by a wide margin in for the Qualcomm
Snapdragon SoC family, which gains support for eight new SoC types.

Aside from Qualcomm files, it has been fairly quiet despite the
inclusion of DT and SoC driver updates for the risc-v and loongarch
architectures in addition to Arm.

Newly supported devices include the Apple M1 Pro/Max/Ultra based
workstations, The Sony Xperia 5 IV and 10 IV phones along with multiple
older models, a relatively small set of new single-board computers.

An huge update that I had prepared to remove most of the unused
legacy (pre-DT) 32-bit board files is not included here, I did not get
the enough testing done in time so this will have to wait for 6.3.

The most active developers by number of patches are:

    139 Krzysztof Kozlowski
     56 Dmitry Baryshkov
     50 Andrew Davis
     49 Konrad Dybcio
     32 Luca Weiss
     27 Thierry Reding
     26 Johan Hovold
     24 AngeloGioacchino Del Regno
     20 Lad Prabhakar
     20 Geert Uytterhoeven
     19 Marek Vasut
     18 Bryan O'Donoghue
     17 Marijn Suijten
     16 Marcel Ziswiler
     15 Peng Fan
     15 Manivannan Sadhasivam
     13 Robert Marko
     12 Pali Roh=C3=A1r
     11 Pierre Gondois
     11 Neil Armstrong

Diffstat:
   0.6% Documentation/devicetree/bindings/arm/
   0.1% Documentation/devicetree/bindings/cpufreq/
   0.2% Documentation/devicetree/bindings/gpu/host1x/
   0.1% Documentation/devicetree/bindings/iio/adc/
   0.5% Documentation/devicetree/bindings/memory-controllers/ddr/
   0.8% Documentation/devicetree/bindings/memory-controllers/
   5.0% Documentation/devicetree/bindings/pinctrl/
   0.2% Documentation/devicetree/bindings/pwm/
   0.1% Documentation/devicetree/bindings/soc/
   1.4% Documentation/devicetree/bindings/usb/
   0.3% Documentation/devicetree/bindings/
  16.6% arch/arm/boot/dts/
   0.1% arch/arm/mach-keystone/
   0.1% arch/arm/mach-omap2/
   0.4% arch/arm/mach-ux500/
   0.6% arch/arm/
   0.3% arch/arm64/boot/dts/allwinner/
   0.9% arch/arm64/boot/dts/amlogic/
   5.8% arch/arm64/boot/dts/apple/
   0.1% arch/arm64/boot/dts/arm/
   3.4% arch/arm64/boot/dts/freescale/
   1.0% arch/arm64/boot/dts/mediatek/
   0.8% arch/arm64/boot/dts/nvidia/
  31.3% arch/arm64/boot/dts/qcom/
   2.9% arch/arm64/boot/dts/renesas/
   5.6% arch/arm64/boot/dts/rockchip/
   3.4% arch/arm64/boot/dts/ti/
   0.2% arch/arm64/boot/dts/
   0.1% arch/riscv/boot/dts/microchip/
   0.1% arch/riscv/boot/dts/renesas/
   0.3% arch/riscv/boot/dts/starfive/
   0.6% drivers/firmware/tegra/
   0.2% drivers/memory/tegra/
   0.2% drivers/memory/
   0.1% drivers/of/unittest-data/
   0.1% drivers/of/
   0.1% drivers/soc/fsl/qe/
   0.3% drivers/soc/loongson/
   0.4% drivers/soc/mediatek/
   1.8% drivers/soc/qcom/
   0.3% drivers/soc/tegra/cbb/
   0.4% drivers/soc/tegra/fuse/
   2.2% drivers/soc/tegra/
   0.2% drivers/soc/
   0.2% drivers/
   0.2% include/dt-bindings/arm/
   1.7% include/dt-bindings/clock/
   0.5% include/dt-bindings/firmware/imx/
   0.2% include/dt-bindings/iio/
   0.8% include/dt-bindings/memory/
   0.2% include/dt-bindings/reset/
   3.1% include/soc/tegra/
   0.1% include/
 1078 files changed, 56482 insertions(+), 16591 deletions(-)
