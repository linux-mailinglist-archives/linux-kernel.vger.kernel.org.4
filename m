Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704586BD1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCPOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:06:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D311EFEB;
        Thu, 16 Mar 2023 07:06:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 967935C0183;
        Thu, 16 Mar 2023 10:06:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678975584; x=1679061984; bh=KH
        KZXwWX3HDPPdF2HBzm7dMQaqdnN/EoTUEQ7VDQcFo=; b=o9a3qPtgOBbIWi+vbn
        mo3i5NEzcbNrQp3P552ieGB/ntbcoSbfu0FT8eTwiIUGugS+9GSShBYfFuMMB7sw
        X6z7T/VZ/kT5kp1s5+PBEwWj+8lPuUt2JfWwsh+JcC5Box5HhY7Jd6xNF4aPyG67
        kaJzu6eiWUZHpeMwgHLBF1LGJ0QGopK8ZPKQ9aJQTxqxlJfxOz5JmxIbYxHSOGYk
        XMqbRizyWCi02jsq1O5BxmMuJyEBPo3ZMs3+L69aaYk8KRfhCwkd1UaCdU+synrZ
        No6qVib4NhfZssyTQqxXsA5Ch4zpHtuGGYbDS7OKvSf1wejI3HaEywVSF8xA1K+R
        jlkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678975584; x=1679061984; bh=KHKZXwWX3HDPP
        dF2HBzm7dMQaqdnN/EoTUEQ7VDQcFo=; b=JFNrqyfmLFvUp0Vspwv+deQQb1ff/
        DAvRhtGC0g9osljc1xYuJhDJyZHLM8ppDLKjBaogZmmsJpEPokgiRbQqr/GqFJJj
        0Cm3VKKpIPs59lShsh/vcLxWBc26yiITGCLWhfQlOq6XnxBAUvWInz7tTS5x/Z1H
        PFgx0ux/3D0l2HgcGEJEQrHl98/kPROmhgeWfjG28FM6kB0lZqM338bVFJJOSCDv
        amd8LUvYlkSN/MG4FhXMtopPRq0EaD/NqjmIOvVuF+FsgeuOOVoPW2XD5e6QJ0gt
        w6JPeOqBCmykaEhJ5xFCzm+yKNs0lh/geW5KlXFTr5egFxmRctNZGsQ6Q==
X-ME-Sender: <xms:XyITZIZNoSZJehJSZ1GdYdIykqe2aunRPJpy2sb516YpD1uJXqzX7Q>
    <xme:XyITZDaC0lF8Hm6r21ackxpi53q6cMCPefNmpBE4I-7xKAzvVWwL1OopiKXgSQNbh
    2kqqQEnAdXL20a-VBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepieekieffueduhfelhfduleeggfeftdeutdejvefhueegudefheeiieejffek
    vedtnecuffhomhgrihhnpehnuhhvohhtohhnrdgtohhmpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:XyITZC9NxsxHHcDGt0cJHEkG_xk18xIbBdVnuvrxyQestch8POJifg>
    <xmx:XyITZCqD_odw1vsluuASxL1BJs9pSkGcFX-6e02o_xsA6ZOH_mRP6g>
    <xmx:XyITZDpZMSQ2TWPZVEihDjbBCsEFWV6iCalM-e9uwtr0lhFMXsX3vw>
    <xmx:YCITZBhsAo0xOkJkGtOlwmnNgL-9pWNrHACGvf9ZudyQkm-29zuo8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D28EB60086; Thu, 16 Mar 2023 10:06:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
Date:   Thu, 16 Mar 2023 15:05:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> This patchset adds initial support for the Nuvoton ma35d1 SoC, including
> initial device tree, clock driver, reset driver, and serial driver.
>
> This patchset cover letter is based from the initial support for Nuvoton
> ma35d1 to keep tracking the version history.
>
> This patchset had been applied to Linux kernel 6.3-rc2 and tested on the
> Nuvoton ma35d1 SOM evaluation board.
>
> (ma35d1 information: 
> https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
> MA35D1 porting on linux-5.10.y can be found at: 
> https://github.com/OpenNuvoton/MPU-Family

Hi Jacky,

Thanks a lot for your submission. I saw this presented at
EmbeddedWorld yesterday and asked about mainline Linux
support, but did not expect to see the patches this soon ;-)

The easiest process for getting the series merged is to
have me add it the entire series to the SoC tree after the
individual drivers have been reviewed by the respective
subsystem maintainers that are already on Cc here. When
the review is complete, you can add soc@kernel.org to Cc,
so they show up in patchwork, or alternatively send a pull
request for a git tree to that address. Until then, you
can add my own email address to Cc so I can follow the
reviews.

After the initial merge, the normal method for additional
device drivers is to have them sent for inclusion to the
subsystem maintainers. The soc tree and soc@kernel.org address
is then only used for changes in arch/arm64, i.e. updates
to the dts files, Kconfig, defconfig and MAINTAINERS, 
as well as the drivers/soc and drivers/firmware directories,
if you have anything in there.

If you have any additional questions about the process,
feel free to also ask me.

     Arnd
