Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216C633D57
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiKVNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiKVNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:16:12 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450402793F;
        Tue, 22 Nov 2022 05:16:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8BF7D58045D;
        Tue, 22 Nov 2022 08:16:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 08:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669122967; x=1669130167; bh=Fsuy/mZZ5T
        5z+jQhn8xTVdY1LMGSEK1rG+fURdRPHdE=; b=WHL0dDUY9huUqeJ3XElkRvY99G
        5KKp34kqvZzwAXdz3qWSTP8dkduKL4X6BZrHOUjjKhHFrbnOafMSX40l9hgSvGYd
        llKjD8KuxUZ5LhSSdvGWRtY2Gnl4Egjxhnw7US/YqRHdhR/w9SCtA3p4WqeD6aH5
        qd37+5xOqS25Lbv7SM5hRwV1HCbUtrXMUJR55HsgtZWEkXEZg8Ph4IbmSnyFoYZ/
        OJQN2VQJETBIKGVKNzY2YutaJoXd6ze/IfpET6/cIPNPO3S4n2OKfphnRGHb0UL+
        X+d73WODat2vuPj8if2mWEGkOdbZM0JeHRjf9SSlw5mTA2Gd9BPmzw4OMTmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669122967; x=1669130167; bh=Fsuy/mZZ5T5z+jQhn8xTVdY1LMGS
        EK1rG+fURdRPHdE=; b=qHd2V94U8jhBOKm1F7zG+lP/0ILwVHOalPWyK84pceBd
        UChe3Mf4j27Hui5G+5GS29eMaylydiIUnLzfbXHH0I21p1BH+8dAuVHfI8suGZY0
        PgrRJKZb4aogD3REueoucsglMtfXJ/jT5OfK+2wwZo6U+ADoTNYirlm6Y8/NFUe0
        R0qt/VLUqmbvopkmPdgQJR5SMcFBbGGX3gdtbGg5IHZjYKyhxUXZDxOHnB/fE5+Z
        Lp+PYcph9ac+hcCx38TM75RZtbPrR9mWdv7ICcEfyuCTwBW6IqsiddfjmdTnm3E/
        w3iCi1e7ozKZUqqDPCl/jJi9iTtnR28ICXUrEyFjcg==
X-ME-Sender: <xms:lct8Y2KIz5BbdA7Y0eEPA5En7mn2GEt8jhrByQ2yONAtxwh01FB3Fw>
    <xme:lct8Y-I5MxsZRT8j4kyxa66PaWA8bZo1UDUarFGnwFhGlIRqB3GbWf0W-b6a65IfS
    2jI0XJkXWLQySxPhaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lct8Y2sJieowFyuaIn7MFFzTsfhKZmpFGTW0srEMHdPs_irOCAEXzw>
    <xmx:lct8Y7aQVrgFCgyf3CmQdlDJJ2Iry5NEwXwRZZmmPhiafTvZFVsMdw>
    <xmx:lct8Y9bl6rpaXksVoY01AWgzzkjax4Tu3vysj6w-KHPP3DDLO44xbQ>
    <xmx:l8t8YxL9v1HssDbcgzDPEdxXDokY03uaja4qBZkPqf9YxCXxT44WGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C95B5B60098; Tue, 22 Nov 2022 08:16:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <024e0a68-bb79-4e2e-84f8-f44afb759cdd@app.fastmail.com>
In-Reply-To: <20221122125244.175295-1-tudor.ambarus@microchip.com>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
Date:   Tue, 22 Nov 2022 14:15:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        "Mark Brown" <broonie@kernel.org>, qyousef@layalina.io,
        "Atish Patra" <atishp@atishpatra.org>,
        "Anup Patel" <anup@brainfault.org>, tkhai@ya.ru,
        quic_abhinavk@quicinc.com, vasily.averin@linux.dev,
        baolin.wang@linux.alibaba.com, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        pratyush@kernel.org, "Michael Walle" <michael@walle.cc>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022, at 13:52, Tudor Ambarus wrote:
> My professional email will change and the microchip one will bounce after
> mid-november of 2022.
>
> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
> author mentions, and add an entry in the .mailmap file.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

I can take this through the fixes branch of the SoC tree if that
works for everyone. Alternatively, I can take only the MAINTAINERS
and .mailmap bits and expect the other changes to get merged
by the devicetree and crypto maintainers for 6.2.

      Arnd

> ---
>  .mailmap                                               |  1 +
>  .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
>  .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
>  MAINTAINERS                                            | 10 +++++-----
>  drivers/crypto/atmel-ecc.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.h                             |  2 +-
>  10 files changed, 16 insertions(+), 15 deletions(-)
>
