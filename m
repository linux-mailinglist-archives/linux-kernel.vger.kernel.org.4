Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3685B566C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiILIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiILIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:37:21 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB849140BA;
        Mon, 12 Sep 2022 01:37:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 8B2F72B0585E;
        Mon, 12 Sep 2022 04:37:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 12 Sep 2022 04:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662971829; x=1662975429; bh=RdLio0pc/E
        NN4ewPOc9rzjrx4VYTSYkA6SVq58Q3ZCA=; b=iSQp1F/D0DFbleYdFyI2mM5/qD
        ojWI8CGixfGHNtyFehArww/FhO/ElreqgRxYknQ2IWqqlI8FLRlUePdSm6TZU3er
        EOt2Sas0lP77Duzzu54f3FoxQJY0dzNLXGE3cqXxpQMMG6VzcOw1F0T5ovlJ84Fw
        0PEQQJSAuZHxuqINSvz/NuZ5PHjEcl70Mb5RvPm3pxGb99PQP3i2bPCzaxPgM3CL
        4/61xYr/+EXaNqKB5yya65ylJm+dtamCAR/eS9ZknKgQLJqttifU/CZhZNu+e8N4
        6ZhT0CUH4TmaBX6/w2WlTDllOZAwYn5yTq5dsxs28yHFJDsA4ZqmtFerQfbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662971829; x=1662975429; bh=RdLio0pc/ENN4ewPOc9rzjrx4VYT
        SYkA6SVq58Q3ZCA=; b=gz4qVxslAeCYgckRWKIJ0QhQBBxvVk4fjymsCY45j5/s
        oP10co0jRAkGAMO/k44Z3BJkdu1O4YbZr4Mhs0YMpY3QHzk0DXPVgFWy+STLC9vU
        MfkoggKfy/ev+pENuuqrZClZPytwLLbzGaF9nUzUwRsyfCozajN1R+rbjPov28yU
        NlKwvHBqku6WVEa2NiGIA8TqTB921nK5FKPG8vgKphOySemL+8KLBXLIziBx2ott
        bycba4aFdPgIQyzUlPEGQy4w4B9bDtnAIqH9EaVsCgdLxZ1oKJklfkn7QageyETg
        XdDITPpSxZ2AtReNfUeVjh5atBzy1jzrV3RFfyiHzg==
X-ME-Sender: <xms:tO8eYy2SKbpIFYeBB6613zmmUCT5A10hy1goW3APBp9uSqd_UMQ_4Q>
    <xme:tO8eY1HHeayPWexj_zalxDSNCAOoZvKblj08JH3Mc5x2DpSSq96OnOggVwYLwxrCF
    DMUTIfnQhFRRGL8Be0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tO8eY677-Mzw8_HKQkk8mUB7UttthZ5Xredvfe6vZV4vo026fQleEA>
    <xmx:tO8eYz3pbCUIDLnzeFM5rh1z9uVXpSvj6aLkG8iv45Ra8Q2MnzI6Qg>
    <xmx:tO8eY1Hha-_yi4xDC7U75E8j6gm2OZ4wAYM8tEXR5LeAkrrtA3MXLQ>
    <xmx:te8eY67cg191h9gJiDpKf6OTrrIROQ4ltl9IElIsgDEZiRl62ADhUvrhPRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3F8DB60089; Mon, 12 Sep 2022 04:37:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <a8d5db25-9191-4af0-b9e0-77fb75493a7f@www.fastmail.com>
In-Reply-To: <20220912071511.1385-7-hayashi.kunihiko@socionext.com>
References: <20220912071511.1385-1-hayashi.kunihiko@socionext.com>
 <20220912071511.1385-7-hayashi.kunihiko@socionext.com>
Date:   Mon, 12 Sep 2022 10:36:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        soc@kernel.org, "Olof Johansson" <olof@lixom.net>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ARM: dts: uniphier: Add ahci controller and glue layer
 nodes for PXs2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022, at 9:15 AM, Kunihiko Hayashi wrote:
> Add ahci controller and glue layer nodes including reset and phy.
> This supports for PXs2 and the boards without PXs2 vodka board that
> doesn't implement any SATA connectors.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +		ahci: ahci@65600000 {
> +			compatible = "socionext,uniphier-pxs2-ahci",
> +				     "generic-ahci";
> +			status = "disabled";
> +			reg = <0x65600000 0x10000>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sys_clk 28>;
> +			resets = <&sys_rst 28>, <&ahci_rst 0>;
> +			ports-implemented = <1>;
> +			phys = <&ahci_phy>;
> +		};
> +
> +		ahci-glue@65700000 {
> +			compatible = "socionext,uniphier-pxs2-ahci-glue",
> +				     "simple-mfd";

Here as well, the "ahci-glue" name seems rather unusual for a node
name. What does it actually do, and why is this not just part of
the sata node?

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x65700000 0x100>;
> +
> +			ahci_rst: reset@0 {
> +				compatible = "socionext,uniphier-pxs2-ahci-reset";

I think the node name here should be "reset-controller@0".

> +
> +			ahci_phy: phy@10 {
> +				compatible = "socionext,uniphier-pxs2-ahci-phy";

and "sata-phy@10" here.

       Arnd
