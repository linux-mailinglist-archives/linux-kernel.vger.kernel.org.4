Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5F6619B3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjAHVGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjAHVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:05:42 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F42D12D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:05:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B30B93200902;
        Sun,  8 Jan 2023 16:05:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 08 Jan 2023 16:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1673211935; x=
        1673298335; bh=pUPs+EkCFiCPXYcQoKQVXsqro1oCfJTpGNmhzqFvsCE=; b=b
        4RYkep8eFUnwHzuX0jJBFm5yZwZ2laJhH2iBe7+CsYKIYLCO/SCjO0NiNisgnU1J
        u4287rWOEyAaFQApd4n8fq4FeboJZSPEW/uhPPg4F8Yjqaf7IQzQgVq9SoQ+Uw9Q
        UgQcJAm1i6FQlJAxv/3xP3HLvpopzx1zt+rJ/N7VG+sKaJCc642cmL5OiTU4CmOC
        MypQDSvWzGivAWTa4y/XDvLQbC67A2cG+wew4G2O1w8Rj2/9FcZYcEtK/QI34vu1
        b+jVg7b9mx8gzpUa1VyeAtqvh8HJ0Eyek6h9YbfwOny7PB1A6w48USKN4R1jcco0
        8fETYKfE3vmFc8iibGUgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673211935; x=
        1673298335; bh=pUPs+EkCFiCPXYcQoKQVXsqro1oCfJTpGNmhzqFvsCE=; b=g
        lfyPUrPGZ1Uwu4SN32xkOFUHQNIFFiTHBvK4nkTAgAQ4jWORLyvtG+t2U82D4DBz
        jdKcvxiDmkn7O0QdgMeM0JN2+cYex6Qni5LdkO+NQlpU7D/5+gcQd54NViGscR0o
        0xo5MJ0pFLBZb9fYHBkgh7njdWfkQmPTMOuBfEyGR7sfJxGfjsocWH4WsrMWOG7e
        28VDgYrNyn3cOo876xIxC9bNZmCfhT7EA2g85DEg+ehmzJsbUxl0gnD2z3HsDtff
        Npus1Jfh7vLbW0exL5dxGWoy2+/pXJnI2130zkb2rBOsaA73F61re0t2zJVY6/YJ
        wF5EUsut9ZO1VIoV/9cjg==
X-ME-Sender: <xms:HTC7Y_CEW_uLvaJKC2FhCQuRVnL6B40-M1CrpxJ6FqaodMKwvie1mA>
    <xme:HTC7Y1hWnTRhS5wRAswFRRHz1r1V2nUHKG43sqTpMJSvATQtWUYglKUdpFNK4CaK6
    lSFSsAy0mopaW-OD1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HTC7Y6krEaOyr_AHOikq6Us76cEY1eRpKHj_CsfIZSylHfNVOj2pDg>
    <xmx:HTC7YxzZOO5MHKFM4LYl6IskqMh1bnG3JMT46jFpoHwWo74FxPb7cQ>
    <xmx:HTC7Y0RdVysJLL7pm7P6-i7JymW0VK4BWMEc1F0tIuV6w6KPV4AFcw>
    <xmx:HzC7Y8JasOtAv4M6ztagNAaQjnd0pStOm1Rs7gGO6s5P-42PD9dHWw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95AE3B60086; Sun,  8 Jan 2023 16:05:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7a57b319-a774-4f97-af06-fe1a637a45ce@app.fastmail.com>
In-Reply-To: <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
 <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com>
 <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
Date:   Sun, 08 Jan 2023 22:05:14 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Baryshkov" <dbaryshkov@gmail.com>
Cc:     "Richard Purdie" <richard.purdie@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023, at 11:06, Dmitry Baryshkov wrote:
> =D0=BF=D1=82, 6 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 11:47, Arnd Be=
rgmann <arnd@arndb.de>:
>> > Is there any conversion to DT you can easily point at as an example=
 of
>> > the kinds of changes needed?
>>
>> Robert Jarzmik and Daniel Mack worked on the conversion of the
>> PXA platform to DT. Daniel contributed the port for Raumfeld,
>> which should be complete, while Robert worked on more driver
>> conversions and mentioned[1] that he had converted additional
>> boards in the past but did not merge it upstream. They
>> can probably point you to whatever is missing. I would expect
>> the generic PXA drivers (spi, mmc, nand, i2c, audio, fb, gpio,
>> keypad) to  basically work work a correct DT description,
>> while the machine specific drivers (scoop and pcmcia mainly)
>> will need DT support in the driver.
>>
>> In addition, Linus Walleij and Marc Zyngier have both expressed
>> interest in keeping sa1100 (h3600, collie, assabet, jornada720)
>> alive, but those don't have any DT support yet and require
>> much more work. Also note that while you can now build a kernel
>> that includes support for all little-endian ARMv4T and ARMv5
>> machines, StrongARM machine still require a separate kernel
>> build.
>
> I looked into converting collie to use DT several years ago. The major
> problem was not in the StrongARM itself , but rather in the locomo
> (platform-specific ASIC) and PCMCIA. Unfortunately I abandoned that
> work ages ago. RMK didn't seem to be very interested, if I remember
> correclty.

At least locomo and sa1111 are both private to mach-sa1100
now and no longer shared with pxa, so this should get
a little easier. When I had last looking into cleaning up
sa1100, my impression was that the main work would be converting
most of the drivers to use dynamic resources instead of
hardcoded addresses and interrupts. Looking at locomo again,
my feeling is that this could remain largely unchanged,
as the locomo downstream drivers (led, keyboard, lcd)
are already abstracted enough and locomo itself can
just be an mfd or soc driver.

> I suspect that the platforms might need to be rebootstrapped from the
> ground up. This sounds like a fun project for the next Connect demo :D
>
> BTW: collie is also supported by the qemu (in fact at some point I
> mostly used qemu for debugging collie). I don't think that the LCD
> emulation works, but the rest should be mostly good.

Good to know about the LCD. The qemu support was clearly a
strong reason for keeping this machine vs the others.

     Arnd
