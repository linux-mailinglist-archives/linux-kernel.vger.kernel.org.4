Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD17701F92
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjENUp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjENUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:45:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36516E48;
        Sun, 14 May 2023 13:45:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A2F015C00A7;
        Sun, 14 May 2023 16:45:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 May 2023 16:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684097120; x=1684183520; bh=/W41ffXeloPR/6oAM7Le1tM72U7sJeoRvVy
        Iao3+j0w=; b=Woi6DWGoOZf+nEIDss62CuAIIQqTsXJhVv/n8ECAK0sItur73ND
        fPQ6th2BitC2rOs8BW2Mo6PsM5efjmcI1pecs5ay/GzydCqC/th66F8TXayLsPck
        2GL0jDMzzkMcKFcqiRUHMZ6dBUWov6yjm4oLbqwS/Y9tI/cF+fDpKAXlPRQYLaG1
        Tzj+oHAuF6hWMARJsOL2Gm5PsqM/hull7Yg6J+xzR210Qsod9Kyeb6v6MD+M28ev
        Ow89aUIyFeBMSbbPgvmKsjn33FuHu9zuo8kGKt2wqLugXtj2RqFFqrgBQtmXjbKA
        NardQ8jFqSslVPh3uxOKz5a0BqTm/NQ/i0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684097120; x=1684183520; bh=/W41ffXeloPR/6oAM7Le1tM72U7sJeoRvVy
        Iao3+j0w=; b=jeS6TL+toYtP0Nh2UjwigOoHlJNo+riDbPR0ZSiZ0Q3sitfLtK6
        TLdV1ypXcSBZtz7Ubq5LKsEULNnMH9s8Is9s4hEIPsP2unZmWRvA3KP3/K9EbUVm
        7L+xz+a84RFF6ZZZ5SKw/4sAzmEmx6R95H0euaEy7GPzeHJGZ24Zu23Q02LrJ65r
        QmRxiOIFsnqabNNjZFuJ1iMetlPNtIAYVHh9iomoXZhQz3hHZjaf9WGpLcvG4CbU
        vmprXMswx4mktceaJMpcLVaRkKOPn50gz1B4LhNLkcNYopiaSlWpBxBGz7CeHT1R
        yOjETxrXO0fTPW0VU2X1a9o1j6lxO5TShBw==
X-ME-Sender: <xms:X0hhZPm7bn_B7WDnULJLgflM-C6fcTomynsCXT1njgO_QwkFv7I5lg>
    <xme:X0hhZC3biT4xjZKiqbwICopoDublU7gXvI61P2rbAGugWFBPiXsusiTGgwJjCwWYd
    aQ44HzhurE4jELPtUI>
X-ME-Received: <xmr:X0hhZFoYeYaMX71iocIVZf6BYkDpFA2zxczH3ivJfdUwMyl-9X4qidBDjZg3D5BVCXX6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehhedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:X0hhZHmmS9EpnJNsJQn56GdGDwXanyMjGfGx0gKJDujtTlADVVkafQ>
    <xmx:X0hhZN1blrajML1i7ZWqoysqmNLu7lICN6wfm_qkRu0pcOL_Ws5z5A>
    <xmx:X0hhZGtHMKt7XsdcE7Jy3p1notWFJl6fRw2jrxEaGXcVcnMPS6CZ3w>
    <xmx:YEhhZF-ezGJdC8k8rUrgNOU9YcO01EdZu-9drinqcZMH-znI72vguw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 16:45:18 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Use raw spinlock for gic_lock
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230514135601.5irhslf6tdv4tk5z@mobilestation>
Date:   Sun, 14 May 2023 21:45:06 +0100
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B793C674-2122-4464-A23D-1FDC450E9631@flygoat.com>
References: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
 <20230424103156.66753-3-jiaxun.yang@flygoat.com>
 <20230514135601.5irhslf6tdv4tk5z@mobilestation>
To:     Serge Semin <fancer.lancer@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8814=E6=97=A5 14:56=EF=BC=8CSerge Semin =
<fancer.lancer@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Apr 24, 2023 at 11:31:56AM +0100, Jiaxun Yang wrote:
>> Since we may hold gic_lock in hardirq context, use raw spinlock
>> makes more sense given that it is for low-level interrupt handling
>> routine and the critical section is small.
>>=20
>> Fixes BUG:
>>=20
>> [    0.426106] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [    0.426257] [ BUG: Invalid wait context ]
>> [    0.426422] 6.3.0-rc7-next-20230421-dirty #54 Not tainted
>> [    0.426638] -----------------------------
>> [    0.426766] swapper/0/1 is trying to lock:
>> [    0.426954] ffffffff8104e7b8 (gic_lock){....}-{3:3}, at: =
gic_set_type+0x30/08
>>=20
>> Fixes: 95150ae8b330 ("irqchip: mips-gic: Implement irq_set_type =
callback")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> LGTM especially in the RT-patch context. Feel free to add:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>=20
> Please see a tiny nitpick below.
>=20
>> ---
>> drivers/irqchip/irq-mips-gic.c | 30 +++++++++++++++---------------
>> 1 file changed, 15 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/irqchip/irq-mips-gic.c =
b/drivers/irqchip/irq-mips-gic.c
>> index b568d55ef7c5..6d5ecc10a870 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -50,7 +50,7 @@ void __iomem *mips_gic_base;
>>=20
>> static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], =
pcpu_masks);
>>=20
>> -static DEFINE_SPINLOCK(gic_lock);
>> +static DEFINE_RAW_SPINLOCK(gic_lock);
>> static struct irq_domain *gic_irq_domain;
>> static int gic_shared_intrs;
>> static unsigned int gic_cpu_pin;
>> @@ -210,7 +210,7 @@ static int gic_set_type(struct irq_data *d, =
unsigned int type)
>>=20
>> irq =3D GIC_HWIRQ_TO_SHARED(d->hwirq);
>>=20
>=20
>> - spin_lock_irqsave(&gic_lock, flags);
>> + raw_spin_lock_irqsave(&gic_lock, flags);
>=20
> AFAICS this call can be moved way down to be after the switch-case
> block.

Thanks for the suggestion :-)

Since it actually reduced critical section I think it should not be =
included in this patch which
Cced stable.

I=E2=80=99ll fix that in a new patch.

Thanks
- Jiaxun

>=20
> -Serge(y)
>=20

