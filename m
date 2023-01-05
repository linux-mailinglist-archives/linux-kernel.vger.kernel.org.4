Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBA65F690
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjAEWQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbjAEWQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:16:41 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D77FD07
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:16:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6B9C732004ED;
        Thu,  5 Jan 2023 17:16:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 17:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672956995; x=
        1673043395; bh=vVO/D8xGiDzrKrNIV5CkxTBZbQ2bOm94JRvfupvfVjk=; b=M
        v3Wz1UsnDegQ7wIykoD6UunAhvQKgYIp65iI9scpSgEJgvf6QOZv50q88ACmDvvr
        JhWjsc38OxwsakCtDKEK5tGt8/kJ4w9dXNFQd/CtJslcTMKLYFXZjCNOBCJV4ERT
        eLeKIT+n67TWd5T2AK5k9qX13bC6IGx6EMXQPBrdfHnjbXYK8OFj1Hk4K2n1hYiI
        ZTuhklx0B7p12SydD+hjyW05lmk0GT0w/51aYzLOF5GVxXsW9BK1vMSH1WEnWUfY
        7V/xt2D6E48cc7jdU1ecKjpBXDUYGpIbpaeQi+iQBvFnW5g+iT+h6BQt4DCJZHxL
        REKgF35jYgUqYBPmRUCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672956995; x=
        1673043395; bh=vVO/D8xGiDzrKrNIV5CkxTBZbQ2bOm94JRvfupvfVjk=; b=Z
        rBT0aplkavSRcsQCaQvNx9y05Eapi6FJb40BnP8WsvbF4ihvz3SS2Ekgglgw1AJK
        vNBQihGdQ6JYmE9qjk/2l9YS3gGtAdtSCdRSZSCsA/nya6uifdF8gtSC9CANskcc
        vRCFFg5eoCyj8zV/fzGnKuipFki8svBIB+qmWc1aoN0WdUc4ApOf+LODt3zynVCR
        7M7NvRzpHGqsukevTQYzkRwgTZwQ5syFMzEOh/bnhWhG7VC9mPg36+JUko2q8iOu
        o0YcdTXQSVejA7AO4s772d/AB/TZa4eGZ9nBB6uP9w4GpZD0OeqSZAuFzdMIqcNF
        D9Qpo7fpEc8IC9xMnqEXw==
X-ME-Sender: <xms:QUy3Y7wUrHlDOTPKQHnnmc0ES4_yIjTXEkakkEtNcY_kWkSxxM4n3g>
    <xme:QUy3YzTYK9Z8dBeYmS_V2UdJYjvJWbD_VY8qrD0v4qPh7FBx4fgeBu6j59fsDnwfW
    lrwM-tV4qsGD_1DqiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QUy3Y1UeOvQ5IyfuuldsMLzCMFm-rHOUIoGHwRyjxoxleneQOloMDA>
    <xmx:QUy3Y1i0PiUOF3RU3SllbULKCTpxGGA0uPuf-jnrBNwtbC-7fTzvyw>
    <xmx:QUy3Y9CdHf-SRoWUf_aXPD9gFginqdpZ9uB9g4PJ7l3WnxE-fnc02g>
    <xmx:Q0y3Y8WQ6_XzWInlftCu1v0Ngn8LQrGxdHU5TOjzoFk1VHO1qdO_nw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 33F87B60086; Thu,  5 Jan 2023 17:16:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com>
In-Reply-To: <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
Date:   Thu, 05 Jan 2023 23:16:10 +0100
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
        "Tomas Cech" <sleep_walker@suse.cz>
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

On Thu, Jan 5, 2023, at 18:05, Richard Purdie wrote:
> On Thu, 2023-01-05 at 17:50 +0200, Dmitry Baryshkov wrote:
>> =D1=87=D1=82, 5 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 15:46, Arnd B=
ergmann <arnd@kernel.org>:
>> >=20
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >=20
>> > The majority of all pxa board files has not been touched in a long =
time,
>> > and no users have spoken up in favor of keeping them around. This l=
eaves
>> > only support for the platforms that were already converted to DT, as
>> > well as the gumstix and spitz/akita/borzoi machines that work in qe=
mu
>> > and can still be converted to DT later.
>>=20
>> Well, tosa also works in qemu.
>> Nevertheless:
>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> I'm kind of sad to see corgi at this point but it isn't really
> surprising. The hardware is old/slow and likely not used by many
> anymore, things have moved on and the systems ended up being heavily
> kernel size footprint limited.
>
> I'd just note that corgi (and shepherd/husky) are strongly related to
> spitz/akita/borzoi, the difference is basically pxa25x vs pxa27x
> processor and pin changes. We chose just to emulate one set in qemu but
> the others would be relatively trivial.
>
> tosa and poodle have much less in common with the other Zaurus devices.
>
> I guess what I'm saying is that if spitz is remaining it might make
> sense to have corgi with it.

Ok, good to know, thanks for the background.

The way we came up with the list of unused boards is to
assume they are all unused unless someone asked for it
to be kept around for this time, for pretty much any reason.
I probably forgot to have you on the Cc list when we discussed
this in the past.

IIRC, nobody specifically asked about keeping either
the corgi or the spitz series, the reason for keeping it
was to have at least one handheld platform with qemu
support remain for testing, but I don't see a reason
for keeping more than one of them.

If you feel like we should keep tosa or corgi and ask
again next year, we could do that, but reworking the series
to keep tosa around would have additional side-effects
on the tmio-mmc driver that can otherwise get cleaned
up quite a bit.

In the long run, I expect we will remove all the remaining
legacy boardfiles and only keep the DT support. Ideally
if someone is motivated to convert spitz to DT, supporting
corgi the same way is also easy.

      Arnd
