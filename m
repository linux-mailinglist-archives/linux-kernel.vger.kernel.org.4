Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C698965FE4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAFJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjAFJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:47:38 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF943E78
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:47:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 01FD93200A63;
        Fri,  6 Jan 2023 04:47:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 06 Jan 2023 04:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672998451; x=1673084851; bh=Mc1WzgtQQE
        rVxeUu7QQ2qSPSNPLCAOfkbYy/vHY72xA=; b=NQL7QC1spLN1v1Z0AA9nDOweoS
        JcPeK5c2ETuO3a2Oa3oQoI0RlyzpIDrf5eicghD8sGnF5/WNLi4O+eFcA+YQ+pfB
        6PJcnEKvExKdMCRZn68Ro0yPYeMMRaEUxGQ0h9apWEML4SSXVmp9k9+NjiMIJYB3
        X/W16mUUcCrJ8VBJjI98C1HfzTs3iQXg/XVohwFgVvgKBAkZTuQ5kaX1SIUurH12
        VnFiXZOINYXSrMT4vHFJle8Rng+EIT8pHeNfw+BfqQU7Hv2wqL+O+y89vN3EgyDX
        Iy3nbspqXiXo4WMAtmsEEuvetKtcJvM1LOJn1wK4TvxnAMH32nynT+5x/k4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672998451; x=1673084851; bh=Mc1WzgtQQErVxeUu7QQ2qSPSNPLC
        AOfkbYy/vHY72xA=; b=sFiTkn7Ps4yTnA5aDa1neSkOcLHvfxRpmB+W2n+CehdH
        QxNg+qWE4DHLisKplaRrW8ETTPER+FgRzgToSfaXS2u19awzLum7de9WG6Dj76Qj
        UeN+Udt+YhUSofZxgmz7DE/M7SZyaf3/gs1N5nLSmyz+uRj+te0i5/0/Q/Zbu9Yg
        4pkJx6keWhp74CCtbTYpujrhXFor3J/dxxNGdO7UKSMkCwyuGhVdpv+N7R8nBttX
        iM+KyWin3uHydA0Lnj6X4b+EpcuHxQYKD1o+d4+8JMlbxGGQ4eFQBfZyYBDfLyez
        tM4eG34n96WUml83SNUWuKoSpNXXSPKBUEkOQ550RQ==
X-ME-Sender: <xms:Mu63YyLYCW5ppTnKnJ5zQPPqlXlZ9zMd1R1m2A0qMkrSsl-wbM-u5w>
    <xme:Mu63Y6KurbVPFsL3ToYDlwrlqp7t0NPSGTjTemDyIM6gxjRzXoQfCwbYSLSO2OQ13
    eJZZvl-g3-ob3LFA54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Mu63Yys_kdacWTuqS82we2kNUxDWapWb4r0A6nHNJbjNziBhV41rZA>
    <xmx:Mu63Y3bzH6WgcrF_pj61vD2ba8X6kUweI899P7Jbvd8lSMTAUPxMiQ>
    <xmx:Mu63Y5ZxYgRoFhMMNMNqpygblTkNzxrLhi79ERe5HwF5ltAlKQuRMQ>
    <xmx:M-63Y3zI7vzNA7-Td_YqjNKxfTCqKkMDLCH7YO9hW5TjB2eGk1QiMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1BDE7B60086; Fri,  6 Jan 2023 04:47:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
In-Reply-To: <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
 <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
Date:   Fri, 06 Jan 2023 10:47:09 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Richard Purdie" <richard.purdie@linuxfoundation.org>,
        "Dmitry Baryshkov" <dbaryshkov@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ales Bardorfer" <ales@i-tech.si>,
        "Ales Snuparek" <snuparek@atlas.cz>,
        "Alex Osborne" <ato@meshy.org>,
        "Alex Osborne" <bobofdoom@gmail.com>,
        "Dirk Opfer" <dirk@opfer-online.de>, "Ian Molton" <spyro@f2s.com>,
        "Lennert Buytenhek" <kernel@wantstofly.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Michael Petchkovsky" <mkpetch@internode.on.net>,
        "Nick Bane" <nick@cecomputing.co.uk>,
        "Paul Parsons" <lost.distance@yahoo.com>,
        "Philipp Zabel" <philipp.zabel@gmail.com>,
        "Sergey Lapin" <slapin@ossfans.org>,
        "Tomas Cech" <sleep_walker@suse.cz>,
        "Linus Walleij" <linusw@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023, at 23:45, Richard Purdie wrote:
> On Thu, 2023-01-05 at 23:16 +0100, Arnd Bergmann wrote:
>> On Thu, Jan 5, 2023, at 18:05, Richard Purdie wrote:
>> > On Thu, 2023-01-05 at 17:50 +0200, Dmitry Baryshkov wrote:
>> 
>> In the long run, I expect we will remove all the remaining
>> legacy boardfiles and only keep the DT support. Ideally
>> if someone is motivated to convert spitz to DT, supporting
>> corgi the same way is also easy.
>
> Personally, I'm not that interested in tosa (or poodle/collie).
>
> The other zaurus devices are interesting for me as I know the platform,
> they have qemu emulation, there are set of devices which are similar
> but also have differences and there were one of the original targets
> for OpenEmbedded and Yocto Project. I did quite a bit of work to get
> one kernel which could run on multiple devices, as best you could at
> the time! I'd actually forgotten about the qemu emulation.
>
> There is a need for better automated testing around DT in OE/YP and
> this is making me wonder about a few potential ideas.

Ok

> Is there any conversion to DT you can easily point at as an example of
> the kinds of changes needed?

Robert Jarzmik and Daniel Mack worked on the conversion of the
PXA platform to DT. Daniel contributed the port for Raumfeld,
which should be complete, while Robert worked on more driver
conversions and mentioned[1] that he had converted additional
boards in the past but did not merge it upstream. They
can probably point you to whatever is missing. I would expect
the generic PXA drivers (spi, mmc, nand, i2c, audio, fb, gpio,
keypad) to  basically work work a correct DT description,
while the machine specific drivers (scoop and pcmcia mainly)
will need DT support in the driver.

In addition, Linus Walleij and Marc Zyngier have both expressed
interest in keeping sa1100 (h3600, collie, assabet, jornada720)
alive, but those don't have any DT support yet and require
much more work. Also note that while you can now build a kernel
that includes support for all little-endian ARMv4T and ARMv5
machines, StrongARM machine still require a separate kernel
build.

     Arnd

[1] https://lore.kernel.org/all/803778517.2279639.1667493436959.JavaMail.open-xchange@opme11oxm02aub.pom.fr.intraorange/
