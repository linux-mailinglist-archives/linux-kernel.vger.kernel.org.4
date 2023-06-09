Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957AD72A6AA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFIXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjFIXTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:19:54 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02E2D74;
        Fri,  9 Jun 2023 16:19:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F38FD320090C;
        Fri,  9 Jun 2023 19:19:49 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 09 Jun 2023 19:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686352789; x=1686439189; bh=tM
        mYHIDjBqJKDccW2yNNVtw4vNAo2LIKf8v53tnNtqU=; b=X4PTZzoH3iGrrVTNtV
        nhJ/GIyb/+bCPohzNetpXMJTh9hlF4mV9KAhOFyO8FGeH70usdmfmO3tCqSwl1b3
        GGBTnb806f0IWQAwo4/hSny+AOauDF/LyoBEDS739jKz4qcZMhrFzEljpKmh47Fc
        36MLiH8Zp2gdWOh9rWcN1lHKDUW2eCJvLyrACIENOeOqlwag1dVJ4qVcmeZm78EX
        HzEullvXa1bbJKCngw+AIpbRhQjl6FhIM1d5D797ZzaLRW5Jlyv0HmPAnB0hK7qe
        1Xw5fjIje4NviO5PdDf2DAVwg2a/nk+mi9idfGYPtdkagkwSmbqb2A8gniSAM/vk
        yEOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686352789; x=1686439189; bh=tMmYHIDjBqJKD
        ccW2yNNVtw4vNAo2LIKf8v53tnNtqU=; b=d8uSvn6R4ktoKCUQpQ/E5FRc/4ifB
        MIMxNdBNR/sLpTyDEmAxObUxukv2u0qQEWn4eJzw+sL+/K9dOdVp/oHwW2ZTpySI
        hDRa48/7ms/B+m6DD1Ac+JwYdooFvC5B7HeMj92f1jYjEJSRszAvDO6zEA2yFlaa
        fcxY8VSH0n/Yrs0AGH4WXmb8w6molmWqhy2dQ3nVEg+lV+FZch6pXmbBz1UgqQDK
        uQNF5ptIj6qhQ5NfeIE7O26zaD8vrMtoCSuDFmk4KsB85RwKFbtVZMS73dG6P2kt
        NZWen4Fa0rCT5UmOu67xhH3q4nLKhmyoBicbhMbxpYA7HKXUuYC0xu8hw==
X-ME-Sender: <xms:lLODZCa8Zf0KsY8GW8HHb1GMOLGhtOA6t6hVWIYWvOk5-iK3Ryp4XA>
    <xme:lLODZFZcWfoKa8I6c-LhlDikpwHcDXLrQJsFd-Ra3S6sRV4Za8WyrLvnJpI2lcZzb
    iM995um_XKFBbRaRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:lLODZM_sqYsK0L437TC1lo4edRi6Yxzcodj7PHrHsQzkWYwx3kiEUQ>
    <xmx:lLODZEo60zelKocOz8RXjUV7UFFdA_KkGXeNuy4IWDhaYvOBx40Ong>
    <xmx:lLODZNoRyq9j5WUBUEsn4oIm_vi_S2P_JLEhKym-fR-lQvEKQhndDQ>
    <xmx:lbODZBenee8DWDfphkM1MGgGHudjwWCdLBSrvc5ZGOn1m5sJDzijNw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 44ECA1700089; Fri,  9 Jun 2023 19:19:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <778e2930-1678-45bb-a01e-21bf321fb6d8@betaapp.fastmail.com>
In-Reply-To: <20230609140729.64799-1-krzysztof.kozlowski@linaro.org>
References: <20230609140729.64799-1-krzysztof.kozlowski@linaro.org>
Date:   Sat, 10 Jun 2023 08:49:27 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Corey Minyard" <minyard@acm.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        openipmi-developer@lists.sourceforge.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: drop unneeded quotes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2023, at 23:37, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml  | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git 
> a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml 
> b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> index 4ff6fabfcb30..129e32c4c774 100644
> --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> @@ -41,7 +41,7 @@ properties:
>        - description: STR register
> 
>    aspeed,lpc-io-reg:
> -    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 1
>      maxItems: 2
>      description: |
> @@ -50,7 +50,7 @@ properties:
>        status address may be optionally provided.
> 
>    aspeed,lpc-interrupts:
> -    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 2
>      maxItems: 2
>      description: |
> @@ -63,12 +63,12 @@ properties:
> 
>    kcs_chan:
>      deprecated: true
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description: The LPC channel number in the controller
> 
>    kcs_addr:
>      deprecated: true
> -    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description: The host CPU IO map address
> 
>  required:
> -- 
> 2.34.1
