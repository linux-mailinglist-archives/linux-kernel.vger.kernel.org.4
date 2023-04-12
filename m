Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B06DF33D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDLL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDLL2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959C10CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681298859; x=1712834859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDyuP7DLDyLD4QmBfhGRvYB8dXBwYkzlt25c8j7l4Uw=;
  b=hGRCSWhbbXTz+OiETzJXKgh14bY8vhtVz8d6FtVmPkSUAMk6W3w9l+iq
   6syZWuI1P1f+YEiT7Lc1Xd0t9P4gs2TqvYv2akxs2UIIOTSkGtun/yjpS
   KImLzBjBDYVuUXDR08mTdw8sxf4/jHiFeBdwlrq/2lJpepcgd0eFfOcej
   ZZviLfQNoHBB5/yMb9pUYmrncVJSOP8TbmvCnaKYyXtKNUbICMnI6w6/7
   bjgLmhh39oXY8wRXLJxaNJPgTTPkz7CEjdZy9Knoyb2+JSJT9Wy64G3nA
   DAIMEKMcm+VvFVHUuwGdAjtlvz391N5X/irvj0aZX3y7BQwn2oDfE0a3N
   A==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="asc'?scan'208";a="206132970"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 04:27:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 04:27:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 04:27:35 -0700
Date:   Wed, 12 Apr 2023 12:27:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/3] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Message-ID: <20230412-viewpoint-refutable-a31f3657093c@wendy>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TxP6jbqp2Noyq/6j"
Content-Disposition: inline
In-Reply-To: <20230412071809.12670-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TxP6jbqp2Noyq/6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 09:18:04AM +0200, Pierre Gondois wrote:
> If 'this_leaf' is a L2 cache (or higher) and 'sib_leaf' is a L1 cache,
> the caches are detected as shared. Indeed, cache_leaves_are_shared()
> only checks the cache level of 'this_leaf' when 'sib_leaf''s cache
> level should also be checked.

I have to say, I'm a wee bit confused reading this patch - although it's
likely that I have just confused myself here.

The comment reads "For non DT/ACPI systems, assume unique level 1 caches,
system-wide shared caches for all other levels".
Does this mean all level 1 caches are unique & all level N caches are
shared with all other level N caches, but not with level M caches?
(M !=3D N; M, N > 1)

Is this patches goal to make sure that if this_leaf is level 2 and
sib_leaf is level 1 that these are not detected as shared, since level
one caches are meant to be unique?

The previous logic checked only this_leaf's level, and declared things
shared if this_leaf is not a level 1 cache.
What happens here if this_leaf->level =3D=3D 1 and sib_leaf->level =3D=3D 2?
That'll be detected as shared, in a contradiction of the comment above
it, no?

As you never state the actual problem with the current code, I'm not
entirely sure if I am making a fool of myself or not here.

Probably making a fool, that's par for the course ;)

Thanks,
Conor.

>=20
> Check 'sib_leaf->level'. Also update the comment as the function is
> called when populating 'shared_cpu_map'.
>=20
> Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers to check if the ca=
ches are shared if available")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/base/cacheinfo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f3903d002819..e7ad6aba5f97 100644
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
> =20
>  	if ((sib_leaf->attributes & CACHE_ID) &&
>  	    (this_leaf->attributes & CACHE_ID))
> --=20
> 2.25.1
>=20

--TxP6jbqp2Noyq/6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDaVlwAKCRB4tDGHoIJi
0vlYAQCLqvq+uMBoR0N2q8+4nb65PSmluNSv6iuRNZndWXy2uwEAiBYcYyQU/Z1/
xkZbq6Jq0GdftQdYt64xX8ClVpQSwgs=
=W/Et
-----END PGP SIGNATURE-----

--TxP6jbqp2Noyq/6j--
