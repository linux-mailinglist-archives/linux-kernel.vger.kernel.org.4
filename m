Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC1706614
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjEQLFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEQLFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:05:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F412691;
        Wed, 17 May 2023 04:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684321494; x=1715857494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2C53q37nasETW8R0y62vJQzUer3lCIfLyK7Hf9/7k8=;
  b=axX8PbLpY9PsCKFDzZNUFo/vEuC91gM+29zbxdq5GSxrvk/en9g2ap/T
   QYr/az5gn598UL2VgilXah8J2eRmEAIid3mtNAXSBs4OWeGPLOqp9KT3i
   imwaz3MGavyD9glOS4eMG9R6LLkP83y7mLhxyFszw0KXTj3UsVziFX+nb
   Cgft0b9Zt5lBgZ89f7SumfxLIoZiLv6sx0xr03r1OMt2vH6JLERatA1s1
   coaqkhTPOJJK+sYXaxQEQCMYDUWtx3PeMWHrHqxyuxSujxWvVod3aBowp
   eSNBVdAMprB4mZPCiwogQ6Sa/Qv1aHkkbXArmL68bs1qLVAxLffw9EB3P
   w==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="asc'?scan'208";a="215862137"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 03:57:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 03:57:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 03:57:35 -0700
Date:   Wed, 17 May 2023 11:57:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v17 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230517-sinner-remember-a5f6b86194ab@wendy>
References: <20230421-neurology-trapezoid-b4fa29923a23@wendy>
 <20230421-sleek-bottom-88b867f56609@wendy>
 <20230517102030.b4nyo2dmpfl7v7fk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wz8/6k7ZC8Bn65VB"
Content-Disposition: inline
In-Reply-To: <20230517102030.b4nyo2dmpfl7v7fk@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--wz8/6k7ZC8Bn65VB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:20:30PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Conor,
>=20
> I found one remaining issue:
>=20
> On Fri, Apr 21, 2023 at 10:27:09AM +0100, Conor Dooley wrote:
> > +static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 =
clk_rate,
> > +				   u8 prescale, u8 period_steps)
> > +{
> > +	u64 duty_steps, tmp;
> > +
> > +	/*
> > +	 * Calculate the duty cycle in multiples of the prescaled period:
> > +	 * duty_steps =3D duty_in_ns / step_in_ns
> > +	 * step_in_ns =3D (prescale * NSEC_PER_SEC) / clk_rate
> > +	 * The code below is rearranged slightly to only divide once.
> > +	 */
> > +	tmp =3D (prescale + 1) * NSEC_PER_SEC;
>=20
> If prescale > 4 this overflows on 32bit archs, doesn't it?

Ooh, I think you are right.

> (I think prescale + 1 is promoted to unsigned int, then the
> multiplication is done and only then the range is extended to u64.

I'll respin with an explicit cast.

Thanks,
Conor.

--wz8/6k7ZC8Bn65VB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGSzCgAKCRB4tDGHoIJi
0hR/AQCX5o1i7KOyi7nlg0yPqhSWIWjpqh9ysAtfM1Ro3HafgwD4+ygsDH16bb3k
qDc8pgBDgXVyZ+OhNF7rK7RJvQMNDA==
=7JAi
-----END PGP SIGNATURE-----

--wz8/6k7ZC8Bn65VB--
