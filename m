Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8DF6E0B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjDMKZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDMKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:25:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8E1BDA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681381551; x=1712917551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d6JkhJi3GMEJETeLt5/QwiarVzJRP85qpRFbz9J6gCU=;
  b=vMHv2FaciUmkn1vu+sfN31hxTAYDuCGD159kL/jgV/nA2cL37seGvwTv
   4F+pr9/46XFfSJTiPV14jevd2Z4fw1htUbtRMGMnmJfw4r0swBXbkG9wP
   dyhkTM9IMduS2omNPmH4l1vzLtOMPKbnX8lUvfGXNGFWAK9VoLMEEuGNO
   AplcLH11d37KoTTQ+8LNbST46HJWShpRp2tuod2yMrvpBxCZtd8r82C01
   tIM/qu3JbOc2XJJnJiUFRwcZ7taAvOFmJ2GSLKf/a2dhlzhCwx8gunVPR
   YnY4fGftjk/mF9Hym7n5rZpozO9TDHdwWZmxrviBcovWJHYr5tWw6dE2J
   g==;
X-IronPort-AV: E=Sophos;i="5.98,341,1673938800"; 
   d="asc'?scan'208";a="220709105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 03:25:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 03:25:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 03:25:48 -0700
Date:   Thu, 13 Apr 2023 11:25:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>, Conor Dooley <conor@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 3/4] arch_topology: Remove early cacheinfo error
 message
Message-ID: <20230413-craving-frying-59031194587e@wendy>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-4-pierre.gondois@arm.com>
 <20230413-prudishly-unruly-090f5297fd54@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NuMYozQbxtD4g1AB"
Content-Disposition: inline
In-Reply-To: <20230413-prudishly-unruly-090f5297fd54@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NuMYozQbxtD4g1AB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:02:49AM +0100, Conor Dooley wrote:
> On Thu, Apr 13, 2023 at 11:14:33AM +0200, Pierre Gondois wrote:
> > fetch_cache_info() tries to get the number of cache leaves/levels
> > for each CPU in order to pre-allocate memory for cacheinfo struct.
> > Allocating this memory later triggers a:
> >   'BUG: sleeping function called from invalid context'
> > in PREEMPT_RT kernels.
> >=20
> > If there is no cache related information available in DT or ACPI,
> > fetch_cache_info() fails and an error message is printed:
> >   'Early cacheinfo failed, ret =3D ...'
> >=20
> > Not having cache information should be a valid configuration.
> > Remove the error message if fetch_cache_info() fails.
> >=20
> > Suggested-by: Conor Dooley <conor@kernel.org>
>=20
> Not that it really matters for suggested-by, and there's no way really
> for you to know, but the corporate overlords prefer:
> s/conor@kernel.org/conor.dooley@microchip.com/
>=20
> > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@=
spud/
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index b1c1dd38ab01..1f071eaede5b 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -843,10 +843,8 @@ void __init init_cpu_topology(void)
> > =20
> >  	for_each_possible_cpu(cpu) {
> >  		ret =3D fetch_cache_info(cpu);
> > -		if (ret) {
> > -			pr_err("Early cacheinfo failed, ret =3D %d\n", ret);
>=20
> Hmm do you really want to remove the print altogether? This can fail
> with -EINVAL and -ENOMEM too, so should we just check for
> | if (ret && ret !=3D -ENOENT)
> instead, since in the other cases it really did fail?

To save Sudeep (potentially) waiting for me when you resubmit, with that
change:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--NuMYozQbxtD4g1AB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDfYnAAKCRB4tDGHoIJi
0nCwAP9e/l8OWTM6GRkGSd3WYkQ98acDHJfajdQxbnSWhfQ/igD/W5RJ/6hdRCqc
17eqZzM0ihZNHC5RNuUIvkW81Vr5XgE=
=ZGoq
-----END PGP SIGNATURE-----

--NuMYozQbxtD4g1AB--
