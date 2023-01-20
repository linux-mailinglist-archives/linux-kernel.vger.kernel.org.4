Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661726747F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjATAWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjATAWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:22:34 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1BA3179;
        Thu, 19 Jan 2023 16:22:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D90C95C00AB;
        Thu, 19 Jan 2023 19:22:24 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 19:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674174144; x=1674260544; bh=UBJx3MEhhS
        kS0nTq6+EY3mTxrBySnKyRU7xD/0Tfmoo=; b=vIttYy5PVlBJ4QNzYxEQkxhiuw
        /8RRTaMcX7A602EtZwiiSVKmVY2RRRmcw4TvEmRoiTWgl0vX5nDQcI/XePKIdblZ
        28fonX59Oq5CJR2ugH7pUGuxkBWzOWQJIbytFoULBqnHCDf21td28k9xVdApm44c
        aWr+e42i8rERfYdwQ0VEqDHuusQSOQfLFOr69XNrYH5CyUag1oKZKMfT0pX0VOpf
        Vip+eOXbVR6Wsf5Z3C9UKlfwq3iGvx1kQN0aeCYc0vu7Na3H+zTG25qZIiMhFED2
        L7Ao1CfdqEw9h/wyFL7t5LUVzKE+dHSkFMzg1wz5YOH6kbvXZvgKzwgLxuEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674174144; x=1674260544; bh=UBJx3MEhhSkS0nTq6+EY3mTxrByS
        nKyRU7xD/0Tfmoo=; b=V42GuWCNsjvWBlc/91lfeCktWm4s5RDB/u9PkFAh7vza
        DJct3dl7kiAsK99SUkoAfALpUUP3TOP6kYBRDkbPA24pXisY3RaVUAwcBqGgpXEg
        tAnAe0Ho2WCLCSk00Nwp5YCvBN8krSesjVL0/J9WBmoKXmSV9plO5OnbwDL7/XA6
        VQcE+xIX5M654OO+AAPZ6VmxqRxTpRb3Ynn1s1KXmL7jLlqRJR2H7wHZAd6eg6cH
        OhpSY8MNmXgwLdMQlQYOxk7MsLg9t+7De+ScpIyeIAY5729PyP3nht+Y+jagwHfS
        RipwyhCA2qv49n7bXHULZCeqE+vyaSK7NUcUah+CUg==
X-ME-Sender: <xms:wN7JY6CcoH-cjTbeF_tFUgydp0UvZ2XShiQjwCcd1dg19liTK_f9Lw>
    <xme:wN7JY0iMkA87oV97Dtgq6XTupd0k4z1qvz7UGiSfFL_nYgkd7MnnoBb9tlsOFlhX5
    3TAI42-ByvnC_T0pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeeffeejgfefieetueeffeeiiedthffghefhtdffveegudegffduuddt
    hfelleeludenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruh
X-ME-Proxy: <xmx:wN7JY9nCVDg2s3Dfzj5oEpmhYPH_gN9CCYcu6eQYuOQq5EA9Tuv8wQ>
    <xmx:wN7JY4xYFTZ5fVhV-zB2IB2NS-KqTJnySYuaFawaiLjApoarPrAuYQ>
    <xmx:wN7JY_Q_-HmUYxx3qGVHPKxpYpzuODHITCj7hENHBaxBtwLA0i1q5w>
    <xmx:wN7JY9MKBJYPG-U4JPerKJskV3ecnO4cGUmWTTou9oB6l6mu0C8eqQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 024D21700090; Thu, 19 Jan 2023 19:22:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a8be2b47-b0e9-4a28-8c32-81b9af81299e@app.fastmail.com>
In-Reply-To: <20230119174714.1486042-2-eajames@linux.ibm.com>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
 <20230119174714.1486042-2-eajames@linux.ibm.com>
Date:   Fri, 20 Jan 2023 10:52:03 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        "Alistair Popple" <alistair@popple.id.au>,
        linux-kernel@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: fsi: Document the IBM I2C Responder virtual FSI
 master
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



On Fri, 20 Jan 2023, at 04:17, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/fsi/ibm,i2cr.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
>
> diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml 
> b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
> new file mode 100644
> index 000000000000..929ca10988f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/ibm,i2cr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM I2C Responder virtual FSI master
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |
> +  This binding describes an I2C device called the I2C Responder 
> (I2CR). The
> +  I2CR translates commands sent over I2C bus to FSI CFAM reads and 
> writes or
> +  SCOM operations. The CFAM access means that the I2CR can act as an 
> FSI
> +  master.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,i2cr


I think this should be a bit more descriptive and at least mention that
it's FSI-related, e.g. `ibm,fsi-i2cr`? Thoughts?

> +
> +   reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      i2cr@20 {
> +        compatible = "ibm,i2cr";

Change this in accordance with the above.

Andrew
