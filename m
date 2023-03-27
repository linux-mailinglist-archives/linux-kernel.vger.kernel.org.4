Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E66CA680
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjC0NxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC0NxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:53:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BEB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679925185; x=1711461185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q0aw3R6eyNVabVWBk/6BbTOvpxSvBhHjFUEn9k6dIDM=;
  b=xvUdp+jYpXsTHxOgHVDqGVaygpvMs3zANInsQYJruaCpB0f0NpShyjG6
   kjKnTZJq3zgzvI0aUSaCgrOg44c+8SGZETo8XfFeRjtz96Ty+O2GL1nK4
   /Ue0f/ZNQKNdmT4LSi13rWj+RL4lmlADwxVfGjn3B6AMFA72o3feaLZsa
   myw+9JWu9ShXzN1PMQGy7OitD8lhDH+KkIFMMCoHIDpaKEincemUEjRtN
   rxvyNJPj1dALVcjRGgg5XeE+f/8HMuqH1+iYQr0OIdbY94kxu3eWv9uMK
   Xft+tXn51uARv+GQfIV/qHbRhTw8HWZVbRm+lMtzaDbg1amwKtpnOxWmi
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,294,1673938800"; 
   d="asc'?scan'208";a="207438968"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 06:53:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 06:53:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 06:52:58 -0700
Date:   Mon, 27 Mar 2023 15:04:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Message-ID: <267f5e37-2cfd-4833-a74c-bfc56fe3671c@spud>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b0IIy94NXv1sQNWD"
Content-Disposition: inline
In-Reply-To: <20230327115953.788244-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--b0IIy94NXv1sQNWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 01:59:49PM +0200, Pierre Gondois wrote:
> If 'this_leaf' is a L2 cache (or higher) and 'sib_leaf' is a L1 cache,
> the caches are detected as shared.
> Indeed, cache_leaves_are_shared() only checks the cache level of
> 'this_leaf' when 'sib_leaf''s cache level should also be checked.

nit: this commit message reads quite weirdly as there's a missing "do
foo" statement, followed by "also do bar".

>=20
> Also update the comment: the function is called when populating
> 'shared_cpu_map'.
>=20
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/cacheinfo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..4ca117574af1 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -38,11 +38,10 @@ static inline bool cache_leaves_are_shared(struct cac=
heinfo *this_leaf,
>  {
>  	/*
>  	 * For non DT/ACPI systems, assume unique level 1 caches,
> -	 * system-wide shared caches for all other levels. This will be used
> -	 * only if arch specific code has not populated shared_cpu_map
> +	 * system-wide shared caches for all other levels.
>  	 */
>  	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
> -		return !(this_leaf->level =3D=3D 1);
> +		return (this_leaf->level !=3D 1) || (sib_leaf->level !=3D 1);

So this is
Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers to check if the cach=
es are shared if available")
then?

Cheers,
Conor.

> =20
>  	if ((sib_leaf->attributes & CACHE_ID) &&
>  	    (this_leaf->attributes & CACHE_ID))
> --=20
> 2.25.1
>=20
>=20

--b0IIy94NXv1sQNWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCGiXwAKCRB4tDGHoIJi
0t/EAQDXe23dRWv4M0HrXDodpHLa9o3/okRxwNua4LZCvcOoRQD9EcPHWFt02qKp
clMayBcdu3gCTiSmliJnj8sLQ9YpLgI=
=G6Qk
-----END PGP SIGNATURE-----

--b0IIy94NXv1sQNWD--
