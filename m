Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795763178F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKUAYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:24:20 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915C20F47;
        Sun, 20 Nov 2022 16:24:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 16D9032004ED;
        Sun, 20 Nov 2022 19:24:16 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Sun, 20 Nov 2022 19:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668990255; x=
        1669076655; bh=Lbw5JJiVpIzdsblo48QNaa3IzJ+C15i2ix45QhyZJas=; b=M
        fDcu3Z5uw/5YgxWBYMyTE/sg4SXjkZwuaaGURh7wb7UZ2KHni+uyNQsUGY/s3Bn8
        GQz5mKgA1oFce7mfQuHL/nxSAarNkO6XMEQ1/v9CEZERw5jVGjkdohm1I/TdpgzM
        EXppbKYuJjV4TDEk+N2Z21OC056WaWf1094f8FpxnNS1jOmvYDUAUUBmwRdpb7ZV
        5wWkzUAmBjdeuKoGwm1BiiK6TfwdEiCqLMHlubRCElV/aYhOCrNVq32wS3nycyMj
        gxkkhOAGcygaxYH5y0OTerLwefavXOB5Xn7yuFYnDwamJX+L/kwWCJWPFfOWXO/b
        D07IPewoR8XcmiADog4TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668990255; x=
        1669076655; bh=Lbw5JJiVpIzdsblo48QNaa3IzJ+C15i2ix45QhyZJas=; b=I
        a4xkDUmxNNO92Ux+hW3sFRn8L0GVi8pxYoRg8705AOtfQHFVKFf8Lsloi8JWJF2m
        XtWn1Penq8Tqxcr5y/cz9hvMU2DyMXP7CiWY1ao9v5TVp3xK3XiRIx13acgs85g1
        6xe7pHkQhKzavDqnjcoJBhc68K3GN3J4owhdZeCp+gDANpp7oqgcK5FzGa6OzK9s
        m70OlME/ehV8OyabYTxgrw5aj3CZXjdB32BKDMNUDF2pCyRdUVbdBtBRZjJXR9wn
        dR9+ENzG8TvZkbKImgd35uosP+wn2LfHebH9DKfiiVERp4JAwcfKbAbW7cXPY48/
        ctOl3OJ+heFqCi1k6EZwA==
X-ME-Sender: <xms:L8V6Y8koyv7VTAvIKtuafYYbfSYhDLN-RAt0XlyFudTZALI0nM0FnQ>
    <xme:L8V6Y70P-kvkMU4j-QZ5-dCq3Q4qgc-JxChW8dbcbfaVLtv6cPShgJvRO5-va3QgY
    vpEKdmvmJM1RoBwOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpefgieeitedtleekheffveeiteegjeegffevfefhffekvddufeduvdev
    jeegheehveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:L8V6Y6rZOGMHAMACrLHlugLWH3PDrN0DhSuoI2crGl5-KsjdRn_xPQ>
    <xmx:L8V6Y4nVXqy9M-hFL6LriOhgSVzXlJU76Z6wA7CfPT9aNmgWdDV47g>
    <xmx:L8V6Y63FyXyJ1iyN2nxfTzhhgvO-xVNqtjXnjQ9k9OohDCFloOoCqA>
    <xmx:L8V6Y4xq6MB3MJ1xUdli5QHfrzQ2oE-kKxElk92es6Le93-LtfofKg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B8D6170040C; Sun, 20 Nov 2022 19:24:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b7ee82ac-1e64-45d9-8b30-5b697e36ad1f@app.fastmail.com>
In-Reply-To: <20220905145555.674800-1-etienne.carriere@linaro.org>
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
Date:   Mon, 21 Nov 2022 10:53:53 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Etienne Carriere" <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        "Stephen Warren" <swarren@nvidia.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3] dt-binding: gpio: publish binding IDs under dual license
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Sep 2022, at 00:25, Etienne Carriere wrote:
> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-2-Clause license terms. This change allows this GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
>
> All contributors to gpio.h file in copy.
>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

Apologies for the delay, it took me a bit to find the right people to ta=
lk to.

Andrew
