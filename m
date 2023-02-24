Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93A6A1B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBXLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBXLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:06:58 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2948E35;
        Fri, 24 Feb 2023 03:05:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D035D3200934;
        Fri, 24 Feb 2023 06:04:07 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Fri, 24 Feb 2023 06:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677236647; x=1677323047; bh=IG
        jti/89eaSBQeG7/CdUKqs9RGevFuI+4y4uzM+W77g=; b=YA+4c+VUpFw/eJ/p3d
        +BYrAL9ijyiKTZVzmR/dW4O6/0M5HgRtTJk3KbRWPltEjx4VJSe11uLvMVdcxLGw
        ZzmxqQV5y80Mf//+1Lh881tU6Ae8ixBLcfqzN3Zgk54T4rp6wgL4q0ZEgTp14CDW
        /XS4v22TKokay8kQnrvYgrvOfV6j+3l16ZjWRnPZWJokwLXTQaGd9LYgnqPLoav7
        9aBQWQR05Wq33+okmg06c/2BKFijN/BIZNOz0AY0i/6NJNWxg6ZAOS5p4Z1T0p5Z
        6bFkoNfuHupLEDJv7TNETcMrHTvHU7h88vHOw6A8iyNLJwQZq7geEwGpmGWNustu
        fBuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677236647; x=1677323047; bh=IGjti/89eaSBQeG7/CdUKqs9RGev
        FuI+4y4uzM+W77g=; b=gQwuR6vByiIvt3FSH/MHek54M5V2v+ItpvV43/F/S8Pw
        dZNWNEGYt3FxF8RImXuX0CmJynJ4o3UMMnQSSm3Tlu8ONEDx7D55/Bo3Gp3gls5d
        8wv2aVI4hy2VvEXDB2002u3lY9bBcGUFAhP6snJx777cLfXi/1Auo51Zw3K7M4OQ
        tfBkP5HKpbfeJ7GLVfk1tlWhAMPgrgdg+kedIxpKAfNZe4tt5PZudoFYUVv7Btza
        jQTg6UnwzTCzH9ifZRyo1glBUWwss7a5LIClZNYsbSBiOBDQEv4m2r8fvt48q+Tp
        nKpLJfEf3sqdwa2csmIRih1MM946n8HSAGgpx1P/dA==
X-ME-Sender: <xms:ppn4Y7ghKHD68D9HYsdHq8TB9vyPNzAeYStolC_PZFOuFCMRzXiajg>
    <xme:ppn4Y4DH97yJvFggoal3C88y_nm2Jz5z8pLgQCHgSP4u3gdhglwnKz3b1LG-M63xU
    AfnCSYLEoMJGPaKlPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekfedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepfeegudfghfejvdffgffgkeetuddtteeuheduiedtgfdufedvudeitddv
    leeivdfgnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgv
    thgvrhdruggvvh
X-ME-Proxy: <xmx:ppn4Y7FJHfRgcX4UhAW5fRBb_6WI8pu4GlgIio60wDLydhhRBNb0xQ>
    <xmx:ppn4Y4TSvPL3JwmnZWw5r6_pKAzq4PJML_sLNvBPX8Vxyc5OeJ-87w>
    <xmx:ppn4Y4z-e8UWNF9A-ggLg-pAc1YZoMFI0chraCXGeLEUD1G0VlQqIg>
    <xmx:p5n4Y0ecexx7F5f_gyjVLJUsZd5JDIn6oL5p2wym_49JegatXOhY9A>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 51FDDA60082; Fri, 24 Feb 2023 06:04:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <e26318db-77b1-4876-8a40-f707d11b5857@app.fastmail.com>
In-Reply-To: <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
Date:   Fri, 24 Feb 2023 12:03:45 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, "Henrik Rydberg" <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2 controller
 bindings.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Feb 24, 2023, at 11:20, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Add bindings for touchscreen controllers attached using the Z2 protocol.
> Those are present in most Apple devices.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../input/touchscreen/apple,z2-touchscreen.yaml    | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git 
> a/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml 
> b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
> new file mode 100644
> index 000000000000..695594494b1e
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: 
> http://devicetree.org/schemas/input/touchscreen/apple,z2-touchscreen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple touchscreens attached using the Z2 protocol.
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +description: A series of touschscreen controllers used in Apple 
> products.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: apple,z2-touchscreen
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  cs-gpios:
> +    maxItems: 1
> +
> +  firmware-name:
> +    maxItems: 1
> +
> +  apple,z2-device-name:
> +    description: The name to be used for the input device
> +    $ref: /schemas/types.yaml#/definitions/string

Now that I thought about this again after the brief discussion we already had:
Do we even need to specify the device name? Is there any reason we can't just
always use something like "Apple Z2 TouchBar"?



Best,


Sven
