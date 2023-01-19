Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA3673097
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjASEvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASEvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:51:15 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF727C868;
        Wed, 18 Jan 2023 20:45:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2E52F32002D8;
        Wed, 18 Jan 2023 23:44:58 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 23:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674103497; x=1674189897; bh=RA62djbRjH
        AtR5eYDGCg3s9PgydQzyaEPXFw3P5ADCE=; b=bQ1Lex1biSOsg9sZ0oCG32YJjg
        ymUiX5FA89IlkUP0WnP4Mqbfg3cRGRfDMd/Q9HMHxZyPeveH/z8DNzb9Y2JyciS9
        PbR458V7YzwoRUwih89rXDzIQeadvmjl4laV/9igg04WSdFxrnnOafzF1oehvDhV
        0XayKr4JLT10lkAZu7NShyxFpzhNgRANVRnvZBuZpCszrKLwIWYebsJyx6jGy5lr
        zkVjlgVd103/d/Z3i2laAkK2x0leJjXwsw5Wf+dzjJ3jK4CiVCz+0qPuE158uMq7
        cWkgoFDu0cNjnseoQ+eeu9L4IPa6Le4Uc5xvVu8zdwPvQ9mUCD0aB3zHWiQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674103497; x=1674189897; bh=RA62djbRjHAtR5eYDGCg3s9PgydQ
        zyaEPXFw3P5ADCE=; b=gH4TLQKqQ3ouj/hKJKXkuCBSaYp1Utvr1tqT5JHO8dAS
        LqMSLpW0Q1IiOhP11OGXZnGtFt6/CNcATiaWIEajheAAQqh/+sVZC1mKFZyV6Gfr
        1zJShEs48+Id9p6LgF4Hv78ghevwRh/72pA3tZGN3pq9BF2LRG/kyuF1A+LofmL4
        7oTrKkLV9/3vOJdY6eCabQcLB3OyzxsRmSreTHRKUCYT7vOqzXzafdg15xpCH/x3
        0/+9NGh8xLdxaLeVwGSCyyqZKgHswU9a/IVf4B2mLGdH3fp2uWzroVajfJ8toLIG
        XD+wjySvyoz7fvaZ5PVyU+V9eszLfmriVqQKpz7i2g==
X-ME-Sender: <xms:yMrIY7pCyXxUMOvaDKg2BAcTqICUraG38J-Nrpj3Jqt5QjSlu4Tu_w>
    <xme:yMrIY1qhEgvdxItp5fbsmCTEN1D2vbWb98Gg8GxGhXwrFWABp7HZHQV3cPqpLhGPC
    OvL8Qv3UAAvNOjnZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:yMrIY4PnPTa0pI2mk7ylIXFS6WM5xsFnHxvupr09IJ7xciQy9a-poQ>
    <xmx:yMrIY-6wAgKJPmeYq1fdu5mkCyeb74PoPwTI_8bMlCnagMBn9b8N2A>
    <xmx:yMrIY67txgF_3CsmtcEk9pWkopnv4Fg3GzuNDnu2P2ykVK1LxhHxAg>
    <xmx:ycrIY_pByLB2jT-LFgxAD3ro1NLEN5i3aZT12bkvkjM1hHQvuvnyIw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A40C61700089; Wed, 18 Jan 2023 23:44:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <9a82d30a-c8ca-47fb-a976-f7f4d99cefec@app.fastmail.com>
In-Reply-To: <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
 <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
Date:   Thu, 19 Jan 2023 15:14:36 +1030
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
Subject: Re: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation, lowercase
 hex
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
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - drop redundant blank lines,
>  - use lowercase hex.
>
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>  .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--

For the Aspeed change:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
