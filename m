Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081B728161
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjFHNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjFHNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:30:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024E2132
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686231014; x=1717767014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xRCHu9T0SNcwau1xNUEoDXG1qFLF+M6n4DE3pzl7uUY=;
  b=RaUxgLRsAZQn2mqxALCsf9oLd6ohfWu/7i/nGixlR4oh3iJzzHX3uyWD
   YAshN/+xiVRSsUnf/QLmD2s5VdzY1ZYEDJ4rY7TBzVlZlgo1QZMgyESir
   YtzV8Fhc0WzV49MChs4s7drQADgzwj5qRe3RvQJaTMu3I5V7piTF/Fp/S
   1O0cUBTn+Uyk/G1xhi4L7EpudVQopyJhQHroWN+/oNbC4iGIuxRH+VfXd
   3TFw8DhLhi3yLWeUMj2llbgIpdZ4Ua0qUfaJk6/DDNxX3RuQIvedBdO8P
   yC+MNVVoICIQDXAGhJc2vl4/AjsIT5bGryrlpTgY/v1IFZrvFs4iEeExX
   g==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="asc'?scan'208";a="219430457"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2023 06:30:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 8 Jun 2023 06:30:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 8 Jun 2023 06:30:11 -0700
Date:   Thu, 8 Jun 2023 14:29:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <conor@kernel.org>,
        <daire.mcnamara@microchip.com>
Subject: Re: Potential issue with (or misunderstanding of) of_irq_get()
Message-ID: <20230608-corset-jackal-2e3ec4b6d509@wendy>
References: <20230519-unkempt-cartel-48efb4d8f0b4@wendy>
 <87wn11oo5o.wl-maz@kernel.org>
 <20230522-niece-vanish-a1ee36494ef0@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6qiw1K5MlCtTdKC"
Content-Disposition: inline
In-Reply-To: <20230522-niece-vanish-a1ee36494ef0@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--i6qiw1K5MlCtTdKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marc,

On Mon, May 22, 2023 at 12:56:30PM +0100, Conor Dooley wrote:
> On Sun, May 21, 2023 at 01:38:11PM +0100, Marc Zyngier wrote:
> > Yup. Now that you have disassociated yourself from the firmware-based
> > naming, you cannot use it to drive the mapping and sh*t happens. The
> > thing is, named fwnode are only there as a band-aid to be able to
> > designate objects that have no fwnode representation.
> >=20
> > And it goes downhill from there. My gut felling for this is that you
> > should try and build something that looks like this:
> >=20
> > - the mux exposes a single hierarchical domain that is directly
> >   connected to the PLIC.
> >=20
> > - the first 40 interrupt allocations are serviced by simply allocating
> >   a corresponding PLIC interrupt and configuring the mux to do its
> >   job.

> > - all the 28 other interrupts must be muxed onto a single PLIC. For
> >   these interrupts, you must make sure that the domain hierarchy gets
> >   truncated at the MUX level (see irq_domain_disconnect_hierarchy()
> >   for the gory details). They all get to be placed behind a chained
> >   interrupt handler, with their own irqchip ops.
>=20
> Yeah, so this I cannot do per se since there is one of these mux
> interrupts per GPIO controller. But it doesn't sound too difficult to
> extend that idea to 3 different interrupts. Famous last words.
>=20
> > That way, no repainting of fwnodes, no select/match complexity, and
> > must of the interrupts get to benefit from the hierarchical setup
> > (such as being able to set their affinity).
> >=20
> > Of course, all of this is assuming that the HW is able to deal with a
> > large number of interrupts muxed to a single one. If not, you may have
> > to use more that one of these, but the idea is the same.
> >=20
> > Thoughts?
>=20
> Well, I'll have to go poking at this hierarchy truncation function that
> you have pointed out & see how it works - but the idea all sounds doable
> and less cumbersome than what I have right now.
>=20
> Thanks for the pointers, I'll resurface with either a patchset or having
> designed myself into another corner.

Sounds like it may be the latter... The hierarchical stuff for the
direct interrupts is working well, so progress at least. I seem to
have gotten stuck with the non-direct/muxxed interrupts though.

My alloc() now looks like, for the direct interrupts:
static int mpfs_irq_mux_alloc(struct irq_domain *d, unsigned int virq,
				     unsigned int nr_irqs, void *arg)
{
	struct mpfs_irq_mux *priv =3D d->host_data;
	struct irq_fwspec *fwspec =3D arg;
	struct irq_fwspec parent_fwspec;
	int ret;

	pr_info("attempting to allocate\n");
	ret =3D mpfs_irq_mux_is_direct_get_mapping(priv, fwspec);
	if (ret =3D=3D -EINVAL) {
		irq_domain_disconnect_hierarchy(d, virq);
	}

	parent_fwspec.fwnode =3D d->parent->fwnode;
	parent_fwspec.param[0] =3D priv->parent_irqs[ret];
	parent_fwspec.param_count =3D 1;

	ret =3D irq_domain_alloc_irqs_parent(d, virq, 1, &parent_fwspec);
	if (ret)
		return ret;

	irq_domain_set_hwirq_and_chip(d, virq, fwspec->param[0],
				      &mpfs_irq_mux_irq_chip, priv);

	return 0;
}

and I am disconnecting the hierarchy as (I think) you suggested. (I'm
not entirely sure whether you suggested that I use it, or employ the
same principle.)

Where I am confused, after quite a lot of trial & error, is how to
actually configure the non-direct interrupts so that they are are using
another irqchip & interrupt handler. Since
irq_domain_disconnect_hierarchy()'s doc comment says that it should be
called in the alloc() callback, what functions I can use there are quite
limited by the lock that has been taken, and I've not been able to
figure out how to get it working. And anyway, fiddling with other
domains inside alloc() feels completely wrong to me.

Would you mind pointing out at which point of the driver or interrupt
registration process you think that the placing of the muxxed interrupts
"behind a chained interrupt handler, with their own irqchip ops" should
be done?

Thanks again,
Conor.

--i6qiw1K5MlCtTdKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIHXygAKCRB4tDGHoIJi
0qB3AQCV4pZa0DCijEeyBt8i7j1bJlNKYHArpgqyajkT7ahTTgEA6cy40kA0+9nw
1cQ79Q8glltHTb01/waD8J1k9ao71AQ=
=l/H4
-----END PGP SIGNATURE-----

--i6qiw1K5MlCtTdKC--
