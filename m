Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9780760F451
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiJ0KC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiJ0KCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:02:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3525F9;
        Thu, 27 Oct 2022 03:01:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3076B5C005D;
        Thu, 27 Oct 2022 06:01:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 27 Oct 2022 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666864896; x=1666951296; bh=pTBzfiN/cq
        I+EVfvkMRfCsSejur5V8CXYx516yzh4es=; b=aUOiwPaqkUKJD8hhYho+/FBKXb
        e6q+I8bNaTT0Fl+aVy6FB8X1+G6gZohBFErwvNbaC0aNhA4bJQKIWD9WLO8mshTd
        5fLKZo0otbn9s06Q/0G0LSjw+Zx7uh8sQXMvHIICrlfzJsCey7S6KZWsQPTe37j9
        gmeZ9PM+dE7FFs/q08Nt4RfEad29ir5tbBs+pOSQPIyinuhVtCJceLuNTVVYRnYo
        LGwtoz65DdtUhrtjau5LeBvjWjlOtEghZAE/mMkhkmi3bWKmZ9mtO1wcUV/x9FQU
        rXncviExNTv8pDiDeTctuJXgejG9Wg/yZGjaJ/HudrBcZemlQFK0cb9is0SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666864896; x=1666951296; bh=pTBzfiN/cqI+EVfvkMRfCsSejur5
        V8CXYx516yzh4es=; b=OOjBnih++8fORBivy53qXkJqmjwqAnEbRvQ40zoR8w1q
        lOLXfDCXQcncHJKVTsMZjX6lbwG/Sj7WsRH86vF1+jIWhJw69mnMRuMn+qiAdh3O
        HID55Vw18iaShQXDNkjFNe/rF+jqDIb6TRgWh1iGc+t8BodHuvgN9GkhnK3fZzk1
        7wa9VAo1ba3VX1AN4YC9/ggYsAS5nuLD0PtthODxdiv91sW4ttzEUsSc6VzNiwL2
        33b3KEd+BtI9BCuF5o22RCEvq+DaZjlGVyTX5le+JwLULipNfiroie7gN3r0PUvx
        /5arUiHXpd1YS77vrzCZQHoamv925ePpZ8LVgi89yg==
X-ME-Sender: <xms:_1ZaY2TzLXyy5mUwLPqwbHlANQFMxqIgDtRloyTeOX5duOOT8eMl0w>
    <xme:_1ZaY7yVYoj2dEtKGNKM2zvSSVSQWBoYGBYkvDba45aSdUGqkVyA51SWORQOUNmjo
    1nzT6ZXsj_pIWTpmVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_1ZaYz0BMa2_0jXdCd2AMv56ubehlrnNxFIWBWadE2Flw-xDAA5FIg>
    <xmx:_1ZaYyDBGRSGaEqxitJJIdavseHCgsvWZbnEXjfH5U9eBBEhOe0pOg>
    <xmx:_1ZaY_i-PbgroUhPi2WValG2kM_Qo0IFCdFqa_WChhsjgRMN2OElYg>
    <xmx:AFdaY6X5Tliil6Nyuk2luN2WMwdEEZqAg5crqlHnqQF522VpGfv7Nw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7BCB2B60089; Thu, 27 Oct 2022 06:01:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <b3c4f9ec-ba8e-4af1-b347-e07b06530d6c@app.fastmail.com>
In-Reply-To: <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
References: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
 <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
Date:   Thu, 27 Oct 2022 12:01:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Masami Hiramatsu" <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: uniphier: Add NX1 SoC and boards support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022, at 06:51, Kunihiko Hayashi wrote:
> Initial version of devicetree sources for NX1 SoC and boards.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Can you add more information here? When new SoCs get added, I
usually provide more than this in my own pull requests sending
the patches to Linus, so please add some background here, such as:

- is this a new SoC, or or something that has been around for a while
  and only now gets upstreamed?

- What is the target market for this SoC? Are there any products
  one can buy with it?

- What type of CPU cores does it use, or any other noteworthy
  IP blocks that are relevant for its purpose?

> +			usb_hsphy0: hs-phy@200 {
> +				compatible = "socionext,uniphier-nx1-usb3-hsphy";
> +				reg = <0x200 0x10>;

> +			usb_ssphy0: ss-phy@300 {
> +				compatible = "socionext,uniphier-nx1-usb3-ssphy";
> +				reg = <0x300 0x10>;

I think these are usually just named 'phy@' instead of 'hs-phy@'

> +			ranges =
> +			/* downstream I/O */
> +				<0x81000000 0 0x00000000 0x0ffe0000 0 0x00010000>,
> +			/* non-prefetchable memory */
> +				<0x82000000 0 0x20000000 0x04200000 0 0x0bde0000>;

200MB of memory space is rather small, is there no 64-bit range?

> +			#interrupt-cells = <1>;
> +			interrupt-names = "dma", "msi";
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
> +					<0 0 0 2 &pcie_intc 1>,	/* INTB */
> +					<0 0 0 3 &pcie_intc 2>,	/* INTC */
> +					<0 0 0 4 &pcie_intc 3>;	/* INTD */
> +			phy-names = "pcie-phy";
> +			phys = <&pcie_phy>;
> +
> +			pcie_intc: legacy-interrupt-controller {
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};

Shouldn't there be an "msi-map" or "msi-parent" property pointing at
the GIC?

   Arnd
