Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DFD70BC85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjEVL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjEVL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:57:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F6DC;
        Mon, 22 May 2023 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684756617; x=1716292617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxbMUs2FLvDTNnlAd5iDR+gmKnsx/CUf5wKyvRFvGwQ=;
  b=BBGOkHm1eXCjnZJ+gmHvbs09wy6J+Z+1vJr0XZSrbdR75QTnfgXExNUB
   qvhaYt+bOtpDFD990xG9VSzyzB61RuP0bIRAz7NmWNMjoEpbCaW8cHdx7
   wMGwMCd8QdDEDIbEx5ruskH9oKhTTmjdcVePT8sCQ5GTuXjA7ui7bLuek
   o3ZfGZ6AFpIAkA0PWjsOxEPq5n21rVc7mRASMADAmd6q1LQwb5VxtCyAJ
   0rVTulxvjC4xywxF1rLoFCfl/9qVdYwDRHV9hVvWJKtfyKFr3isTTbIBg
   X1b56tRAt31gPAuSZQRd3ZxmTxmj+0sM80WgvTXwCY2uIMIaN/2sfBNDL
   A==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="asc'?scan'208";a="212452514"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 04:56:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 04:56:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 04:56:52 -0700
Date:   Mon, 22 May 2023 12:56:30 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor@kernel.org>, <daire.mcnamara@microchip.com>
Subject: Re: Potential issue with (or misunderstanding of) of_irq_get()
Message-ID: <20230522-niece-vanish-a1ee36494ef0@wendy>
References: <20230519-unkempt-cartel-48efb4d8f0b4@wendy>
 <87wn11oo5o.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5FOFm+pvNQkBQGp"
Content-Disposition: inline
In-Reply-To: <87wn11oo5o.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--l5FOFm+pvNQkBQGp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marc,

Thanks for taking a look.

On Sun, May 21, 2023 at 01:38:11PM +0100, Marc Zyngier wrote:
> On Fri, 19 May 2023 12:02:47 +0100, Conor Dooley <conor.dooley@microchip.=
com> wrote:
> > I've run into an issue with of_irq_get() while writing an irqchip driver
> > and I was hoping that by posting about it I might get some guidance as
> > to whether I just doing something fundamentally wrong in my code, or
> > if the specific case was just an oversight.
> >=20
> > I've been trying to solve the issue that I pointed out here:
> > https://lore.kernel.org/linux-gpio/23a69be6-96d3-1c28-f1aa-555e38ff991e=
@microchip.com/
> >=20
> > To spare reading that, the TL;DR is that the SoC has 3 GPIO controllers,
> > with 14, 24 and 32 GPIOs each. All 68 can be used for interrupts.
> > The PLIC only has 41 interrupts for GPIOs, so there's a bit of extra RTL
> > sitting between the GPIO controllers and the PLIC, that is runtime
> > configurable, deciding whether an GPIO gets a PLIC interrupt of its
> > own or shares an interrupt with other GPIOs from the same GPIO controll=
er.
> >=20
> > Since the interrupt router/mux is not part of the GPIO controller block=
s,
> > I have written a driver for the it & changed the representation in the =
DT
> > to the below. For each of the 41 interrupts "consumed" by the driver
> > bound to the irqmux node, I have created a domain.
>=20
> In general, this feels a wee bit wrong.
>=20
> From what I understand of the HW, it is expected that most of the GPIO
> interrupt will be directly associated with a PLIC interrupt in an 1:1
> fashion (only 68 - 41 + 1 =3D 28 interrupts will be muxed). So 40 GPIOs
> could have a chance of being directly assigned to a PLIC input without
> any muxing.

Not quite.
Firstly, I made a silly maths mistake, and 14 + 24 + 32 is not 68.
There are 70 GPIOs on this SoC.

Probably more important though is that there are 3 mux interrupts
though, not only 1, so the "40 GPIOs" becomes 38. It's also the source
of some of the complexity in what I wrote, since each of the GPIO
controller's has a different interrupt that the non direct connections
go to.

There's a bit that "scared" me further on down, that I think came out of
this assumption.

> If you start allocating a domain per interrupt, you end-up actively
> preventing the use of hierarchical domains, and you don't really
> benefit from what the mux HW can do for you.

Honestly, I'm happy with being able to use more than 32 of the GPIOs for
interrupts. Setting affinity etc is a nice bonus on top of working in
the first place.

> > In my irqchip's select callback I check the struct irq_fwspec's param[0]
> > to determine which domain is actually responsible for it.
>=20
> Huh. In general, if you want to resort to 'select', you're doing
> something that is a bit iffy.

Aye, given the lack of other select callbacks, I figured I was going
down a potentially dodgy path.

> > That's all working nicely & I was doing some cleanup before submitting,
> > when I noticed that debugfs complained about the fact that I had several
> > domains hanging off the same of device_node:
> > debugfs: File ':soc:interrupt-controller@20002054' in directory 'domain=
s' already present!
> > debugfs: File ':soc:interrupt-controller@20002054' in directory 'domain=
s' already present!
>=20
> Of course. You get 41 domains with all the same node...

Aye, it is obvious in hindsight ;)

> > To get around that, I tried to switch to creating fwnodes instead,
> > one for each domain:
> >=20
> > 	for (; i < MPFS_MUX_NUM_IRQS; i++) {
> > 		priv->irqchip_data[i].output_hwirq =3D i;
> >=20
> > 		priv->irqchip_data[i].irq =3D irq_of_parse_and_map(node, i);
> >=20
> > 		fwnode =3D irq_domain_alloc_named_id_fwnode("mpfs-irq-mux", i);
> >=20
> > 		domain =3D irq_domain_create_linear(fwnode, MPFS_MAX_IRQS_PER_GPIO,
> > 						  &mpfs_irq_mux_nondirect_domain_ops,
> > 						  &priv->irqchip_data[i]);
> >=20
> > 		irq_set_chained_handler_and_data(priv->irqchip_data[i].irq,
> > 						 mpfs_irq_mux_nondirect_handler,
> > 						 &priv->irqchip_data[i]);
> > 	}
> >=20
> > That's grand for debugfs, but I then ran into a problem that made me fe=
el
> > I had designed myself into an incorrect corner.
>=20
> Yup. Now that you have disassociated yourself from the firmware-based
> naming, you cannot use it to drive the mapping and sh*t happens. The
> thing is, named fwnode are only there as a band-aid to be able to
> designate objects that have no fwnode representation.
>=20
> And it goes downhill from there. My gut felling for this is that you
> should try and build something that looks like this:
>=20
> - the mux exposes a single hierarchical domain that is directly
>   connected to the PLIC.
>=20
> - the first 40 interrupt allocations are serviced by simply allocating
>   a corresponding PLIC interrupt and configuring the mux to do its
>   job.

So you say "first" here and "configuring the mux to do its job" - this
scares me a little as the mux cannot be used to map arbitrary GPIOs to
arbitrary PLIC interrupts.
All it can do is pick which one of either GPIO2 or GPIO0/1 gets to use
the corresponding direct connection. For example, if bit 0 in the
control register is cleared, GPIO0's 0th GPIO gets the direct connection
& GPIO2's 0th GPIO gets muxed into the GPIO2 non-direct interrupt.
Ditto for bit 1, 2 etc. From bit 14 onwards, s/GPIO0/GPIO1/.

I'm not sure if your "first" here was temporal, IOW "for the first 40
interrupts you allocate, use a direct connection". If it was, then
that's not a possibility.

I'd also rather not edit the mux based on what Linux wants, since there
could well be some other program running in AMP on other cores that
would not appreciate it changing underneath its feet. I don't think that
makes things any more/less easy though, since temporal is already not
possible.

> - all the 28 other interrupts must be muxed onto a single PLIC. For
>   these interrupts, you must make sure that the domain hierarchy gets
>   truncated at the MUX level (see irq_domain_disconnect_hierarchy()
>   for the gory details). They all get to be placed behind a chained
>   interrupt handler, with their own irqchip ops.

Yeah, so this I cannot do per se since there is one of these mux
interrupts per GPIO controller. But it doesn't sound too difficult to
extend that idea to 3 different interrupts. Famous last words.

> That way, no repainting of fwnodes, no select/match complexity, and
> must of the interrupts get to benefit from the hierarchical setup
> (such as being able to set their affinity).
>=20
> Of course, all of this is assuming that the HW is able to deal with a
> large number of interrupts muxed to a single one. If not, you may have
> to use more that one of these, but the idea is the same.
>=20
> Thoughts?

Well, I'll have to go poking at this hierarchy truncation function that
you have pointed out & see how it works - but the idea all sounds doable
and less cumbersome than what I have right now.

Thanks for the pointers, I'll resurface with either a patchset or having
designed myself into another corner.

Conor.

--l5FOFm+pvNQkBQGp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGtYbgAKCRB4tDGHoIJi
0rGQAQDCHYGFVLhupXjisyYSXpWFMXJB0hlv8+ed8pCBDjnEcQEAwiueQciX4JJM
wXD3xGyPRwDDJc60s6TBgZ3kyyoQOQw=
=87Zm
-----END PGP SIGNATURE-----

--l5FOFm+pvNQkBQGp--
