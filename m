Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34A67AB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAYIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAYIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:08:22 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319E46733;
        Wed, 25 Jan 2023 00:08:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E47623200961;
        Wed, 25 Jan 2023 03:08:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 03:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674634097; x=1674720497; bh=8DJTpXByBP
        HrfsqMbJyZG5Oa0YHr8WBMwvW/C9sBIMA=; b=R8DYioSCULAYEFrMEQZ5tWfDBd
        4GbBvD7LL2yqzKz9bOIeIoV/ad4OlyB4uN3vr58BIsdIVVLwJYHsbBp6L392GNhv
        oFpyIYTOL1+kq0v7MQ9XtfFT5Y474zanIlkNHThxfpMDrXFpkir+U3oOGvBWJetE
        DlsFTt4sf2VowIuX9uA6k3L+rMep0uAoOvZzndTM1nIoBaGWAoWglih9t4JplLu5
        uWH7B/7QMQmNp85rDT3DvQBFVnrTNKhjJyS90tDvXeeLLopXKB5PbILQLfDjbBS9
        gKXz0+ET/dywvJ57O+5vgYJiXlRd9KG0JBVN7f0OzNWtdFoXoYbaw0HC196Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674634097; x=1674720497; bh=8DJTpXByBPHrfsqMbJyZG5Oa0YHr
        8WBMwvW/C9sBIMA=; b=Up+VcH1SmO8K4j3FANlN/i9+XJHNW0yoxSXy47H57ncN
        yWcRO33t7ZhsXDMLJJxptk12jCw9ZEnWXapZne+DGwTCuKKrNJBmHET9U3VgJ3Xd
        wIVkGQzb9SBEZzu9TkeMQSe8CvFzO0xp9MCcJazPdYutHymSUVnl/TIZUPUwDpAH
        NPocdXXfCGsGV/5GwO9psL7qu2iGS0AZrenpoYLRlHd4VmbPNUfyMBmSiITWWYDD
        1b7XQiVGJamOMqIiXj9B4qrPcUEkSNrJ3ivXl4bvxiIvDN0/OfZz/40R9/fLeC5l
        OeFCNqyPRxPGUuQZU//Riele61UamqdQ8xBYeldUvg==
X-ME-Sender: <xms:cOPQY_nCuAwzBnUF4KTBiQC3YU32XOR3G5eRXymIuk1mZv1_OG9BkQ>
    <xme:cOPQYy3WWF2UByWSYVYulr_QTPjcriCluRuy27vvf42ufCkvd3WHq-QYGxcli8ssc
    7NlqzkYCVHoFuIM4rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cOPQY1r3G_4gi0Jn91WdLgKYKs_-6OhPnv11UFEd_314SvBfhw_VbQ>
    <xmx:cOPQY3mZ_qm9uGqF2lsnXUTpTpt2bPz7UKLjtM_rbsxd1NcjV_uAzQ>
    <xmx:cOPQY93SGcX_5wRWDstEgghM3-IlT0RfyAn7iCducnsgt3fwhnhHZQ>
    <xmx:cePQY6lFCETUCoe3YZyDplJ9hPAbMXDjx36n2hMRHtuSVAxHfN3MDQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB120B60086; Wed, 25 Jan 2023 03:08:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <e9b0338e-3b2f-4b54-8547-ab8babf7c0e1@app.fastmail.com>
In-Reply-To: <20230113160651.51201-2-nick.hawkins@hpe.com>
References: <20230113160651.51201-1-nick.hawkins@hpe.com>
 <20230113160651.51201-2-nick.hawkins@hpe.com>
Date:   Wed, 25 Jan 2023 09:07:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>, soc@kernel.org
Cc:     "Guenter Roeck" <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Russell King" <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] ARM: dts: add GXP Support for fans and SPI
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

On Fri, Jan 13, 2023, at 17:06, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Reorganize the base address of AHB to accommodate the SPI and fan driver
> register requirements. Add the hpe,gxp-spifi and hpe,gxp-fan-ctrl
> compatibles. Add comments to make the register range more clear.

The changelog describes three separate things, which usually means
you should split up the patch into three smaller ones to make
it easier to review.

It sounds like the third one is no longer part of the patch anyway.

> @@ -52,76 +52,102 @@
>  			cache-level = <2>;
>  		};
> 
> -		ahb@c0000000 {
> +		ahb@80000000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
> +			ranges = <0x0 0x80000000 0xf000000>,
> +				<0x40000000 0xc0000000 0x40000000>;

In the changelog text for the first patch that moves the
ranges down, it would make sense to describe why this specific
move is done. "to accommodate the SPI and fan driver
register requirements" does not actually tell me why it was
first thought that the bus starts at 0xc0000000 but now starts
at 0x80000000 and has a weird hole.

Please explain how you determined the location of the hole and
the 0x80000000 offset. Are these from the datasheet, from
the hardware design or did you make them up because you thought
this is what I want?

>  			dma-ranges;

Having a 1:1 translation for DMA addresses is actually an indication
that the MMIO addresses on the bus might also be directly
mapped, rather than offset: If AHB addresses 0x0-0x80000000
refer to the local MMIO registers, there is no more room
for addressing RAM in the same addresses.

> -			vic1: interrupt-controller@80f00000 {
> +			vic1: interrupt-controller@f00000 {
>  				compatible = "arm,pl192-vic";
> -				reg = <0x80f00000 0x1000>;
> +				reg = <0xf00000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};

Since you said that the earlier version of this was broken,
it would also make sense to split this bit out into a separate
bugfix patch, or at least describe it in the changelog text.

       Arnd
