Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76BA6D987C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjDFNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDFNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:45:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5844ED0;
        Thu,  6 Apr 2023 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680788703; x=1712324703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=66uzbHnTeg9KP22hFc1pTAbx1P429+J0tDm9ryOLR9k=;
  b=2h38trDB5Cm+bC0IAQ2g4gmjeaDeCNgwPmqL58Vtn8nNTPlW77E5/Zvt
   zqaYcRjsrxvwHtraIXcdVMwiAMBWVu0Z4OEh1rDeUmOarviGAN1rIHmLz
   s1Zt54W0GrElWid5dt5qT6WxEWs36GVtfw4nuioGn/fgpyKqL0vrqkKIc
   M25i00MfXeqS9/6Bug44oddS3S8DDK5+CYstMTK+KxIZff+S8XAYl6KVk
   +jIZt5fnEs7DOYsXPGXmUcOsR3/NBD4N2LwiaACMyhptZoggtbXWhHpVL
   8QQ67dHF+zYDc0bpMpGwsvaxZYXNvd07zQBft265UHw324Xvw3A9mGw1w
   w==;
X-IronPort-AV: E=Sophos;i="5.98,323,1673938800"; 
   d="asc'?scan'208";a="208461384"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2023 06:45:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 06:45:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Apr 2023 06:44:59 -0700
Date:   Thu, 6 Apr 2023 14:44:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v15 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230406-ducktail-reflex-4840315459f8@wendy>
References: <20230330071203.286972-1-conor.dooley@microchip.com>
 <20230330071203.286972-2-conor.dooley@microchip.com>
 <0b91dee7-6c1d-4a33-8235-8fd5d58b200e@spud>
 <ZC7GeXJbB9PAF0lb@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P2ywBvzo9kT8+ANN"
Content-Disposition: inline
In-Reply-To: <ZC7GeXJbB9PAF0lb@orome>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--P2ywBvzo9kT8+ANN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 03:17:45PM +0200, Thierry Reding wrote:
> On Sat, Apr 01, 2023 at 09:50:47PM +0100, Conor Dooley wrote:
> > On Thu, Mar 30, 2023 at 08:12:03AM +0100, Conor Dooley wrote:
> >=20
> > > +	/*
> > > +	 * Because 0xff is not a permitted value some error will seep into =
the
> > > +	 * calculation of prescale as prescale grows. Specifically, this er=
ror
> > > +	 * occurs where the remainder of the prescale calculation is less t=
han
> > > +	 * prescale.
> > > +	 * For small values of prescale, only a handful of values will need
> > > +	 * correction, but overall this applies to almost half of the valid
> > > +	 * values for tmp.
> > > +	 *
> > > +	 * To keep the algorithm's decision making consistent, this case is
> > > +	 * checked for and the simple solution is to, in these cases,
> > > +	 * decrement prescale and check that the resulting value of period_=
steps
> > > +	 * is valid.
> > > +	 *
> > > +	 * period_steps can be computed from prescale:
> > > +	 *                      period * clk_rate
> > > +	 * period_steps =3D ----------------------------- - 1
> > > +	 *                NSEC_PER_SEC * (prescale + 1)
> > > +	 *
> > > +	 */
> > > +	if (tmp % (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) < *prescale) {
> >=20
> > Hmm, looks like 32-bit doesn't like this modulus.
> > I pushed things out for LKP to test before sending as I felt I'd not be
> > allowed to do that operation, but got a build success email from it.
> > I'm not sure why the mail wasn't sent as a reply to this, but
> > <202304020410.A86IBNES-lkp@intel.com> complains:
> > pwm-microchip-core.c:(.text+0x20a): undefined reference to `__aeabi_uld=
ivmod'
> >=20
> > I know that tmp < 65536 at this point, so if the general approach is
> > fine, I can always cast it to a non 64-bit type without losing any
> > information.
>=20
> Since you already use some of the helpers from linux/math64.h, perhaps
> you can use something like div_u64_rem() here?

I had actually initially tried to do that, before I added changed the
calculation of prescale to use DIV64_U64_ROUND_UP():
| *prescale =3D DIV64_U64_ROUND_UP(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + 1) -=
 1;

I could I suppose add an additional:
| div_u64_rem(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX + 1, &remainder);

and then just use the value of remainder in the if statement.
Not the prettiest thing in the world I suppose, but should be 32-bit
safe...

Thanks for the suggestion, I'm just surprised that LKP didn't complain
when it built my tree...

--P2ywBvzo9kT8+ANN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC7MzAAKCRB4tDGHoIJi
0jooAP4mP43vuXbOMOXs2Y2/DPqSEe5azoc/PfplOVKQMqj2mgD/f19yx3/S/PIL
eL2ROUgUxGJ7Zm+dMCmMXk23o3v8RwA=
=MkqJ
-----END PGP SIGNATURE-----

--P2ywBvzo9kT8+ANN--
