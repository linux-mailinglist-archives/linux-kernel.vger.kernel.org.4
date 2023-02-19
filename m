Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44D69C055
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBSNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBSNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:24:10 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A67E3B4;
        Sun, 19 Feb 2023 05:24:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E512132001AB;
        Sun, 19 Feb 2023 08:24:07 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 19 Feb 2023 08:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1676813047; x=1676899447; bh=Sx
        b+ubfVbqkBOmXuqwRNHyVNLwmK74w5WtqI6UvOxBY=; b=SpBl85OtSZgx/f28JU
        Y9epUJSaLwZ0bx/KCsZWctgFowWTr9ELWrmhqxqKPFc3GJhSDHzr47Z+0d4wxj8H
        8yJNN+woWJyhJ0j0C+8Ggo4GrU3eXbLfXDykh1tYTGp0/pRC130sdO0R8Eqpur2d
        s3GXI2aA/vCuw5uxQ1XDynhs5wi/VT6QGZCkDRZhRZ3jxJBo9hgxugyamuIW0uRl
        iLMYB9653rzLrcXjGiI9b5YjVYsImchbMyhCNUn8uV9rl5i46q/U9lJvGQcfhMpK
        EVqKOW/9M85gXnkKPfqRVuWtmsLX2mpZgQeCMG7/F6lDcykgr4kaVxfqsSP1RdRk
        u4+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676813047; x=1676899447; bh=Sxb+ubfVbqkBOmXuqwRNHyVNLwmK
        74w5WtqI6UvOxBY=; b=cVN9Nx46rX66KVhRLNNvY+IwndBxkx/HmXFNOVlrI8Kw
        vH+2/towQ8mzYhLIPH9AvRAVtofVrj6QtCb6l7LiYUYzbvL1DAB1iSn7+o9KeVE+
        IyTMfOO95flOZuJjRCK7U9LhU1OFrEE/jIfPfr+CPUU0q1ozh9K4uNo9RF1o5tU0
        IfkMvWdz8Gg+GOqQ+HIxLuzFypud/VV/oVoKKCartjV9qJuKE8QszAlFzbatHUa3
        VgLEjCIJi1tv33USTnLqGUGVMhXrjNfhPsoh7SqsCVCuyjLmNUxxhwWZ4g+9Lt2T
        JWlphs7oGerIaKTQVfiHjWfEDwMQ8DLEnHOpVHkx7Q==
X-ME-Sender: <xms:9yLyY28sEFwcRzbBwHuGoUy7csnrfFaof998A5fkqTv0zXl0RdHb1w>
    <xme:9yLyY2vBGDt-d7fiAjtzEdnP4CGX9dPzcHkcyq1QtSVHLObPFmeWZjyxFL8RzoIXR
    -JplV97P3OyJdlJ6GM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejfedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9yLyY8DUVHeD34TZK85LAatQiMbg7gUNMi0k45EyMOsK24b499uJvQ>
    <xmx:9yLyY-eBJuwcG5R59BfavQnB1B9AIdM2_mBcv4Z2eN-PxSNiYL7srQ>
    <xmx:9yLyY7OdUnRU5q5bjGSm93KLiDXCOkWfmexsDozsA95iZKWg7Sh7EA>
    <xmx:9yLyY2d8sekswG4Bh11m78DePIEYHtsSj0JXJtRBDgD27KejasHQcA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4915EA6007C; Sun, 19 Feb 2023 08:24:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <30ac9cb8-075b-47df-a459-e6c0bfb7853a@app.fastmail.com>
In-Reply-To: <20230219132208.GA32724@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-16-22926a283d92@jannau.net>
 <8303bbae-2f98-49fb-8fd6-550ecb272bae@app.fastmail.com>
 <20230219132208.GA32724@jannau.net>
Date:   Sun, 19 Feb 2023 14:23:47 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Mark Kettenis" <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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



On Sun, Feb 19, 2023, at 14:22, Janne Grunau wrote:
> On 2023-02-19 13:36:22 +0100, Sven Peter wrote:
>> Hi,
>> 
>> 
>> On Tue, Feb 14, 2023, at 12:03, Janne Grunau wrote:
>> > From: Hector Martin <marcan@marcan.st>
>> >
>> > This adds device trees for the following devices:
>> >  - Macbook Air (M2, 2022)
>> >  - Macbook Pro 13" (M2, 2022)
>> >  - Mac mini (M2, 2023)
>> >
>> > Signed-off-by: Hector Martin <marcan@marcan.st>
>> > Co-developed-by: Janne Grunau <j@jannau.net>
>> > Signed-off-by: Janne Grunau <j@jannau.net>
>> > ---
>> >  arch/arm64/boot/dts/apple/Makefile        |    3 +
>> >  arch/arm64/boot/dts/apple/t8112-j413.dts  |   63 ++
>> >  arch/arm64/boot/dts/apple/t8112-j473.dts  |   54 ++
>> >  arch/arm64/boot/dts/apple/t8112-j493.dts  |   52 ++
>> >  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi |   81 ++
>> >  arch/arm64/boot/dts/apple/t8112-pmgr.dtsi | 1141 +++++++++++++++++++++++++++++
>> >  arch/arm64/boot/dts/apple/t8112.dtsi      |  912 +++++++++++++++++++++++
>> >  7 files changed, 2306 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/apple/Makefile 
>> > b/arch/arm64/boot/dts/apple/Makefile
>> > index 5a7506ff5ea3..aec5e29cdfb7 100644
>> > --- a/arch/arm64/boot/dts/apple/Makefile
>> > +++ b/arch/arm64/boot/dts/apple/Makefile
>> > @@ -10,3 +10,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
>> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
>> >  dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
>> >  dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
>> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
>> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
>> > +dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
>> > diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts 
>> > b/arch/arm64/boot/dts/apple/t8112-j413.dts
>> > new file mode 100644
>> > index 000000000000..9e758edeaa82
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
>> > @@ -0,0 +1,63 @@
>> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> > +/*
>> > + * Apple MacBook Air (M2, 2022)
>> > + *
>> > + * target-type: J413
>> > + *
>> > + * Copyright The Asahi Linux Contributors
>> > + */
>> > +
>> > +/dts-v1/;
>> > +
>> > +#include "t8112.dtsi"
>> > +#include "t8112-jxxx.dtsi"
>> > +
>> > +/ {
>> > +	compatible = "apple,j413", "apple,t8112", "apple,arm-platform";
>> > +	model = "Apple MacBook Air (13-inch, M2, 2022)";
>> > +
>> > +	aliases {
>> > +		bluetooth0 = &bluetooth0;
>> > +		wifi0 = &wifi0;
>> > +	};
>> > +};
>> > +
>> > +/*
>> > + * Force the bus number assignments so that we can declare some of the
>> > + * on-board devices and properties that are populated by the bootloader
>> > + * (such as MAC addresses).
>> > + */
>> > +&port00 {
>> > +	bus-range = <1 1>;
>> > +	wifi0: wifi@0,0 {
>> > +		compatible = "pci14e4,4433";
>> 
>> I'm not sure how these pci compatibles are usually handled. Do they have to
>> be added to the dt-bindings Documentation as well or is it fine to just have them
>> here since they're not really used to match anything?
>
> I suppose they have to be added (at least for dtb validation) but 
> "pci14e4,4433" is already in net/wireless/brcm,bcm4329-fmac.yaml.  Added 
> via e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties 
> & chips").

Oh, true, I somehow missed that.

Best,

Sven
