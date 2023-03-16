Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8686BD281
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCPOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjCPOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:39:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A96A9CA;
        Thu, 16 Mar 2023 07:39:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8956F5C0136;
        Thu, 16 Mar 2023 10:39:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678977544; x=1679063944; bh=Ly
        wxQrCgwYjKZzXeVwn0sCF/Lgka04CKpVkqQG6mO+A=; b=Ym1l+jl5TYozoRAqod
        f2Ve9BZ/BR+WVZS+LZ03RDb7awiW2rLJaNFO/OE//1udk8SPRVx8xL5NIJwQYBFR
        PrtTxGRtkQv9cP270Vw4nYim+h0cb6SIr3o8GBUjFkfzmpjNJAGaW9PpBSmj7nC3
        rNFP15qN6v/MkbvcPboM0TJRk+n6HrVfrFdtxlat0gHKz4bV5+24A7LShSxWFsRb
        ZoTU9Wu6k4tgvOh58aygAeGsbf4SEZjcAnI3Vibnw9ODKa34LBffuyw0UfSC3LR2
        oVXGeRk1QKIGnSh0oUyYmYo3NlaiaGvu9QWA1T5CorWhQ422seic8YpZEDQDBx1S
        Plhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678977544; x=1679063944; bh=LywxQrCgwYjKZ
        zXeVwn0sCF/Lgka04CKpVkqQG6mO+A=; b=pn6GyqZO80baDzXqBduhrUKGASC4/
        MrzgDYLpCCJ2QVKX3AamSJGkg60o0Nmktdkn2vpxlgBfiJNRh9vGO/155kzBn9T1
        eTrouqA6eHTDUbwwD5MhBW45En6d+wp3zZqhdDQMqpDa5pZ2qPqkZMQkly4f67ay
        NbetlMv38+eKMM8ZIQaA7BeWa8d60DQA4UzPNPaEJZrmdQx2LXbCIhroLdKn8EPO
        KLvtQsNi/a+3fgpOGTLCPSC1DXkP1uZ0zhOjCRZsQzTpM0I8RipLpddt3eKBCXFb
        nRAIRIwPmnfDm4jfT28eMrflCh+5jXBrN9GWCBG9leoAOzeHl148b4ZJQ==
X-ME-Sender: <xms:ByoTZGVx2STYeQb_VcyoeCJsgx83KIwL6MUDBi_co_wAm1sRw3FzQw>
    <xme:ByoTZCkiiHM8Jf6sr1qjGpFhBbI6AbwMlfcl9RPTXfSpQAn2oFQMz2ix5ah5xS7qF
    P-q-Tln8hs9Sc3SwdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ByoTZKa504JELULDQbLXgryL0U6UYMql2afYnHBdcD_DpNlojjQcdQ>
    <xmx:ByoTZNWb3Eo2TNOQaCQqj3-k_fiGuLLqY4Irwg8ZPykFqSx3t_AfXA>
    <xmx:ByoTZAl8j64xAXXAjeOKAXAdEOxHQv1ihIHoQeIGKb8Y34PD4_fSEg>
    <xmx:CCoTZPcvGVAP4p8j8Z5uHX9GrOdP2C9awN5dzarz4af6vuRcTodalw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A99DEB60086; Thu, 16 Mar 2023 10:39:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <d56ec914-c2e4-427d-abc4-a290f3467937@app.fastmail.com>
In-Reply-To: <20230315072902.9298-16-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-16-ychuang570808@gmail.com>
Date:   Thu, 16 Mar 2023 15:38:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Avi Fishman" <avifishman70@gmail.com>,
        "Tali Perry" <tali.perry1@gmail.com>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Patrick Venture" <venture@google.com>,
        "Nancy Yuen" <yuenn@google.com>,
        "Benjamin Fair" <benjaminfair@google.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 15/15] MAINTAINERS: Add entry for NUVOTON MA35
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, at 08:29, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Add entry for Nuvton ma35d1 maintainer and files
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

> +F:	Documentation/devicetree/bindings/*/*nuvoton*
> +F:	arch/arm64/boot/dts/nuvoton/

This clashes with the existing entry for NPCM, so
contributors can easily get confused about where
to send their dts patches.

I don't have a good solution here, but maybe you can
discuss this with the npcm maintainers (added to Cc)
to see how they would like to handle this.

For me, the easiest way would be to have a single
maintainer send me all the patches for both ma35d1
and npcm, but that may not be practical for you.

> +F:	drivers/*/*/*ma35d1*
> +F:	drivers/*/*ma35d1*
> +F:	include/dt-bindings/*/*ma35d1*
> +F:	include/linux/mfd/ma35d1-sys.h

I would replace these with a single line

K:    ma35d1

that should have the same effect.

     Arnd
