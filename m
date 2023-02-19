Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3162769C030
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBSMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:36:49 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0721E10257;
        Sun, 19 Feb 2023 04:36:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2127832000D9;
        Sun, 19 Feb 2023 07:36:45 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 19 Feb 2023 07:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1676810204; x=1676896604; bh=dQ
        HYQiUC3rK1Tk9ToEOCzWhq7C7C8mrinV1UbDHRWOw=; b=Gh0F6m1mWS9gqpKYhh
        NfTUbMzOWFxbOnzAPvbQ/f9n6SdJoBBTrl01zCgjWjFwgXB+oTl4N7rZlFl1pl04
        0Wo+S5HXycooUsxpTYezHx8HpR14pgkhFwU+NNmnxA6N7lNHYGzmYiSwprUt4EjE
        I/3ERhY4IA9qxatauf9QYcYvpapiNTeZXknuHemeuZOLwI4hTFivg4BFtJGtntW7
        VAN8H3iKMbT3hNdFF7y0LMbqucFac6lyBGwFOvhPoxUc3+p8MegLPpCjDYY0HbZ6
        WPT7IKq6JFzRHr9ugi5ysxHCsktMLmhgNYPkARajtdSEwzP7O5AsBvB4MUtNldIM
        edZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676810204; x=1676896604; bh=dQHYQiUC3rK1Tk9ToEOCzWhq7C7C
        8mrinV1UbDHRWOw=; b=mRv6O+2uKIzV80nzsJPaB37VvG1QqK7ORuJnpaOQwxWa
        11hg+VQwZNFpeIbnOwvIRqPyKt3GW5ryDpAzckNteLPAiDUrTKaKP91KFY+mz+NL
        ypwy30sKWMHfCcGNa5tPSuUfNb4/tMFLvENsZH6w2BrSOYJstdRtxomFdi/90nUQ
        CDq8kJk/ap4c4xeZdfPeMBV2VThxappTORQGyyHcSrggfubPtl+3h/ZoWIf+0O9R
        qCNH2HlLvIc94HY1TrpMSGLllQ1RehuDyPMw22iVWVDZfoTsPSbTHrUZj9rArXF2
        Txk72C9eAXBQLb6oMsAG98Vsvsy/ZQmOa5FVbXHdoA==
X-ME-Sender: <xms:2xfyY0pMRhC4_H_-QMWjlLo4pb1w6xOzzTVFq-fQsQFmNTRLnRi4FQ>
    <xme:2xfyY6oTp965_ELY1dfyDoMGDLIiAlgt4U32ZlY2-xzMd3_ia2_RqxYO0BCw41ckw
    WyWfuG3U5jCA3l-oGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:2xfyY5Nz5mxom1BuTUVqsKI_iGto7wd0hJ7dJfT8MQApJemAQdBNkA>
    <xmx:2xfyY76zXLS8U5BLYxRZVnmwswhygHQYfti2VTafcTSTevbz5Q683g>
    <xmx:2xfyYz4AYchonIPduP1e5DlLFXi0UMBKG7MJ4mrKlXJ2f6gsFJOF2A>
    <xmx:3BfyY2bcBHJpAurSz2i4ujzwWVqcvBn92OQBJITGI6iB-Uw3bWDZCw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01900A6007C; Sun, 19 Feb 2023 07:36:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <8303bbae-2f98-49fb-8fd6-550ecb272bae@app.fastmail.com>
In-Reply-To: <20230202-asahi-t8112-dt-v2-16-22926a283d92@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-16-22926a283d92@jannau.net>
Date:   Sun, 19 Feb 2023 13:36:22 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Mark Kettenis" <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] arm64: dts: apple: t8112: Initial t8112 (M2) device trees
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Feb 14, 2023, at 12:03, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
>
> This adds device trees for the following devices:
>  - Macbook Air (M2, 2022)
>  - Macbook Pro 13" (M2, 2022)
>  - Mac mini (M2, 2023)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/Makefile        |    3 +
>  arch/arm64/boot/dts/apple/t8112-j413.dts  |   63 ++
>  arch/arm64/boot/dts/apple/t8112-j473.dts  |   54 ++
>  arch/arm64/boot/dts/apple/t8112-j493.dts  |   52 ++
>  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
>  arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi      |  912 +++++++++++++++++++++++
>  7 files changed, 2306 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/Makefile 
> b/arch/arm64/boot/dts/apple/Makefile
> index 5a7506ff5ea3..aec5e29cdfb7 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
> +dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
> diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts 
> b/arch/arm64/boot/dts/apple/t8112-j413.dts
> new file mode 100644
> index 000000000000..9e758edeaa82
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple MacBook Air (M2, 2022)
> + *
> + * target-type: J413
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;
> +
> +#include "t8112.dtsi"
> +#include "t8112-jxxx.dtsi"
> +
> +/ {
> +	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
> +	model = "Apple MacBook Air (13-inch, M2, 2022)";
> +
> +	aliases {
> +		bluetooth0 = &bluetooth0;
> +		wifi0 = &wifi0;
> +	};
> +};
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +&port00 {
> +	bus-range = <1 1>;
> +	wifi0: wifi@0,0 {
> +		compatible = "pci14e4,4433";

I'm not sure how these pci compatibles are usually handled. Do they have to
be added to the dt-bindings Documentation as well or is it fine to just have them
here since they're not really used to match anything?

Otherwise this looks good to me,

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Best,


Sven
