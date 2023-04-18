Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FD6E65DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjDRN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjDRN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:27:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47714444;
        Tue, 18 Apr 2023 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681824453; x=1713360453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h3pmULgxsGgcQmyEbQYZ4K3bPzzzsFUw346+3srF8A0=;
  b=NTIYGC8ZDg1Kmy8qRm/HQVl4xJDhdZvNm93sdZ/+ptj9gGEfKVUnucyA
   x8dgBi+1yWJL7p0/++wNmVAbourbeS70MLgsn9upTjLB039esV7JmuYa9
   sTVr4N4f7rymEG2Gp3hNZN3lYkooQUB0C8oy+NJaeD0CCouDq+4iIygaC
   wHvcoF89jmhARgloGB9vcnvqOaqHI0lNab9ilLAt93kwjlAGBgHVOcMcZ
   usk7pz1J/5XRqFBATtgSq/p8Vx9Cvy6nbekXOvBlWWa7ftA+uV29Mnnyp
   2UPPzDP9uRHpJOlM8cKPUHKIyLQMwpS7CpNk2SYW4fXxv3ILMcflJDmNK
   g==;
X-IronPort-AV: E=Sophos;i="5.99,207,1677567600"; 
   d="asc'?scan'208";a="207069346"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Apr 2023 06:27:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Apr 2023 06:27:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 18 Apr 2023 06:27:25 -0700
Date:   Tue, 18 Apr 2023 14:27:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v16 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230418-octagon-epilepsy-4d8516f91145@wendy>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
 <20230411-bronzing-crust-d302408a1259@wendy>
 <20230411105547.ypkktubgfx4jfen3@pengutronix.de>
 <20230411-ligament-wagon-6c8cacb966e8@wendy>
 <20230411162554.4tl2z2tcbfg5hb7e@pengutronix.de>
 <20230418-armhole-cartwheel-cee37778a840@wendy>
 <20230418130837.zfueixeuxrallhtc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FFx3KsBRxu5dYLgW"
Content-Disposition: inline
In-Reply-To: <20230418130837.zfueixeuxrallhtc@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FFx3KsBRxu5dYLgW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 03:08:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Apr 18, 2023 at 12:27:33PM +0100, Conor Dooley wrote:
> > On Tue, Apr 11, 2023 at 06:25:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:


> I don't understand what you wanna say here. If tmp =3D 256 my suggestion
> is to pick prescale =3D 0 and period_steps =3D 254. Then
>=20
> 	 (prescale + 1) * (period_steps + 1) =E2=89=A4 tmp
>=20
> and period_steps is big enough to ensure a a finegrained choice for the
> duty_cycle.
>=20
> > That's then gonna give us one of the broken configurations from the
> > limitations.
> >=20
> > tmp =3D 257
> >=20
> > *prescale =3D 257 // (254 + 1) - 1
> >           =E2=89=88 0
> >=20
> > *prescale =3D 257 // (prescale + 1) - 1
> >           =3D 257 / (0 + 1) - 1
> > 	  =3D 256
> > 	  =3D 0 (registers are 8-bit)
>=20
> I think you mean s/prescale/period_steps/ in the second part, but that's
> not what I meant. I meant to suggest:

I did, yeah!

> 	*prescale =3D tmp / (MCHPCOREPWM_PERIOD_STEPS_MAX + 1) - 1
> 	period_steps =3D MCHPCOREPWM_PERIOD_STEPS_MAX =3D 254
>=20
> > I'm quite obviously missing something that you may think is obvious
> > here, but is not immediately clear to me.
>=20
> That would be an explanation, yes. :-)

Right, it makes a lot more sense now. Definitely was not clear to me
that that was what you were suggesting.
I'm not sure that disallowing tmp < 255 is something I want to do
though, as this is mainly used as a "soft" IP core in the FPGA fabric,
the clock provided to it may not be particularly high.
Probably not the end of the world though, once added to the limitations.

The implemented period is also going to be quite a ways off with this
method (compared to the method I have been using until now) - although
it is of course far simpler.
You're the PWM expert and are suggesting it, so maybe I should just shut
up and go do it...

--FFx3KsBRxu5dYLgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD6arQAKCRB4tDGHoIJi
0jl7AP9Ls13dfGN0ABcy+W/U0p3z6cT9QynfIh7jhcaBycLNvwEAsdfE/cj9Szpd
Tt229kUYqmnCZQVkwDtsIEp56dGU6g4=
=olu/
-----END PGP SIGNATURE-----

--FFx3KsBRxu5dYLgW--
