Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D496676AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbjALOed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbjALOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:33:43 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF555AC55;
        Thu, 12 Jan 2023 06:25:15 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A7CC23200923;
        Thu, 12 Jan 2023 09:25:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 09:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673533512; x=1673619912; bh=zd2a00NEe4
        +bDxczc+Ry0ob6zOWTcbtiiMyZcdFcU0w=; b=YGNxNqkRDCogME/TIrJwOFu+Aw
        KREFfDsPOtB+pMQXTRSOjSADpBtRnn7ra9dThQy9nYwC5yaFT1k3aZoi1r0cw8k+
        tZtQBFckNDlZiYSPEjFu22B1zw3L8alU9JbOhL2cROrmsh2p6L75WEvDRpGOlgd2
        0Oe0Oh6/0kUY1aVj2noXhURTil8Q8TZiK64DpyY7HOtLraktXAnQF2cQNIub/Fd+
        TBLb7phal05/bJz7ZEvhP6cNFIDtQbD0Ifa7+IUKdSYBrlIu+O75PMLYYnO341zD
        VmwdYG9nyS06eac4RqrejbcNIO6da7iyTziQCz+EZuoMtNT3oUn/hPg7TlXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673533512; x=1673619912; bh=zd2a00NEe4+bDxczc+Ry0ob6zOWT
        cbtiiMyZcdFcU0w=; b=lvKLryXdOqdEofsFsgIJQHOGktZeXc6Az43dxqpjOy4o
        AffAcHAPxJ0T5mqZ46mKeyrq78/6Dc3K0kLAPr9ElHiyu+h78rtMrtkUNr5Kr6dj
        GAmBZvUfhKZgbcfDoG9khuNbZ6S+OHA7stvHly/frsr3kr+KKfBBpk8twcj8W2UZ
        S3rWWH/zrYnfFQA9xKiP6r6yWFHUERBHkAJX72Q/9hLou0QzOCcUgeQcqhzU5VoI
        DyDNOvUqTentQ0QcgBG8kDfJrIelN2jzDdQnpaQFtSS2k9t9AbRdtJBAF8ONQo6P
        9hSfp0kKE4X+diUWCs14nZNTtR+ib4YGVMUz0T/euA==
X-ME-Sender: <xms:RxjAY2-gAMTQkme3l1_1vUzceEGq89VRd3miCOPsXW-AfkRe0R5ARw>
    <xme:RxjAY2slsnRZE7VDPM4gfQgGCfPJH0cLwE7mmlWVRHb-xTJR-2pyWS86LMm3K9wJ7
    Wp7mggCGcmA-_Y7huo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefgudfg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RxjAY8BofP2iwlr4WsTRUE3GFTIilbevoETcx1AdLHUD0DpcEl2baw>
    <xmx:RxjAY-eF-AmA_kcO6TRy-o70WLcT3DX1-vMFSqtmLyNUVWXbG0nJIQ>
    <xmx:RxjAY7NRVoYzjn-7RIfz09uKphRe7p3VSBb53XcRHtHlvy3ElmXcZA>
    <xmx:SBjAY8G2EH6syEFGmLuK_5FPcRgYYbtaUDEmOfbvtGp86NqBKeGo_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CFB53B60086; Thu, 12 Jan 2023 09:25:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
In-Reply-To: <20230103203654.59322-4-nick.hawkins@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
Date:   Thu, 12 Jan 2023 15:24:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Russell King" <linux@armlinux.org.uk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023, at 21:36, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Reorganize the base address of AHB to accommodate the SPI and fan driver
> register requirements. Add the hpe,gxp-spifi and hpe,gxp-fan-ctrl
> compatibles. Add comments to make the register range more clear.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>

> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi 
> b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..b73b22a93716 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Device Tree file for HPE GXP
> + * Device Tree for HPE
>   */
> 
>  /dts-v1/;
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
> +			ranges = <0x0 0x80000000 0xf000000>, /* 0x80000000 - 0x8f000000 */
> +				 <0x40000000 0xc0000000 0x7fffffff>; /* 0xc0000000 - 0xffffffff */

I'm a bit confused by the change in the mappings: are you
sure this all the same ahb bus and not two separate buses?

The comment for the second range looks wrong to me, as
you define a 2GB (minus one byte) sized mapping but the
comment only lists a 1GB (including the last byte) mapping.

I would expect that the original 0x30000000 (including the
last byte) was correct here.

> -			vic1: interrupt-controller@80f00000 {
> +			vic1: interrupt-controller@f00000 { /* 0x80f00000 */

This is not the same address as before. I'm also not sure the
comment is helpful here.

    Arnd
