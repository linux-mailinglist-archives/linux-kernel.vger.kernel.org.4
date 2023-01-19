Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316266730E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjASFAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASE7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:59:51 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271E252BB;
        Wed, 18 Jan 2023 20:54:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4732E3200933;
        Wed, 18 Jan 2023 23:54:14 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 23:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674104053; x=1674190453; bh=Jp0nEIifZi
        HOJSvV20z7BP6fpn/Kau5COB1QREBO070=; b=MUTjYaga/VCVR8wOIxvTD1adQB
        bVcsOamVjgMrs5qSWExP21qadvS9tslA8kaK8PAv1FY/Ij+tKRK4qMo/AkgwDK4u
        +Egl+gmfZqsMV7bp+XfiZybdaBEKaPRO9xomqyOIi0rZrUMLuUT7Lz9xr3OMMRvr
        WOcmHZVaDGAsYPVTh8VH/DEv8EmBtdKXnrgdt141UDjJIqFZZWJh/8WvaCFM6Rw3
        K8rrIgzZFIWll7Q8TjYbSjpzmNJKqqeklTpZAL57RjU+vYBHXNx+zq25vqpvFXG8
        mxFDlhr4IDsFMYzYFVBfOU38Ro7U3V/XGqGnnF4EBHvMktipbUfTiY73XyGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674104053; x=1674190453; bh=Jp0nEIifZiHOJSvV20z7BP6fpn/K
        au5COB1QREBO070=; b=Q52GecV34my9RM50i4VjcIWg/PrSmrWYotOymHrXZiyQ
        VHgeG2VvTiQD5hf6H8K2Ug2TVQhUQdbMzfGPs2WDeOUbjjUtk7ZC3FU7g6U7pm10
        sOQt57lRcqImb454oTPbUCyqG6QweAJfGVw/Ms0iczG7rylZwDkQbv28kEu8fw2x
        CN+pqnWIa895VWyzaiyb+CfEGWBJIYtduX9QiuhkaRVL32fme9CmuuKWRM4A0X93
        hMBgFKlQsCaJ1HHV8X7MS0eH1iqmThckugzVf1mD9aajNyFnJUljp9iYDAD1/Cyd
        EfQN5wgL9dF3KyR3Z1iXLxbPMR+91z+iar22sJH7Bg==
X-ME-Sender: <xms:9czIY6kWaYeYw_FKjA7Nl7poJpuOj4scvZKNgvQWSRcttVOaIlC0GQ>
    <xme:9czIYx2Y3Msp27EujWGe4TaFxUvoTP9gxq-_jT6sfZOTDYijUAZUD-tlvYYzE9tqB
    IHD23qA3o33QjBZWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:9czIY4oqs1Uo2gRCmXk67fJ8llPsqDtXBwE7XqNCwaNyPfo-DgNM4Q>
    <xmx:9czIY-mEnJ0P4Vqa60Ko5f3Hofzf5pgIN3gYWvf368x1UkzE1KD3Yw>
    <xmx:9czIY42xHYz1PSscl1louZ3dhQXg6D_yYEuGVx7UM6aJ5wr_7QE2kQ>
    <xmx:9czIY2m5I1IcHq89PeACGhMtafkHrE2oynuAdpnu6dTpWzSUSMEe4Q>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 183811700089; Wed, 18 Jan 2023 23:54:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <47290046-59a2-4bf0-8af0-3a7b4304deb3@app.fastmail.com>
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Date:   Thu, 19 Jan 2023 15:23:52 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Kamal Dasu" <kdasu.kdev@gmail.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>, "Han Xu" <han.xu@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        "Yogesh Gaur" <yogeshgaur.83@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Li-hao Kuo" <lhjeff911@gmail.com>,
        "Michal Simek" <michal.simek@xilinx.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        =?UTF-8?Q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        "Vaishnav Achath" <vaishnav.a@ti.com>,
        "Parshuram Thombare" <pthombar@cadence.com>,
        "Leilk Liu" <leilk.liu@mediatek.com>,
        "Gabor Juhos" <juhosg@openwrt.org>,
        "Bert Vermeulen" <bert@biot.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Marek Vasut" <marex@denx.de>,
        "Birger Koblitz" <mail@birger-koblitz.de>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Anson Huang" <Anson.Huang@nxp.com>,
        "Chris Packham" <chris.packham@alliedtelesis.co.nz>,
        "Kuldeep Singh" <singh.kuldeep87k@gmail.com>,
        "Pragnesh Patel" <pragnesh.patel@sifive.com>,
        "Christophe Kerello" <christophe.kerello@foss.st.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "Erwan Leray" <erwan.leray@foss.st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@foss.st.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Jan 2023, at 04:09, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
>  .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-

For the Aspeed change:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
