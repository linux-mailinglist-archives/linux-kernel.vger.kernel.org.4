Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC7679FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjAXRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjAXRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:19:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449C4AA59
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:19:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C4260FCA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D5C433EF;
        Tue, 24 Jan 2023 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674580753;
        bh=1kQ5c/1mRBqMRVTbC6270y6arGlgEmeq3utuZc9QgSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmjhljOmw5u9T3x+D8TrUWIbGxAbtg2dVVYGPIcvJO6u8BOPVNGm5Rb2cW8LXTRLG
         o4w2h0oSRLtPDJVCTrM7ysldwN/zXs8bYgQn4QA4oZi2AzBva4UR+UqVSXRCDt7Wk1
         6IG9MEy5ZSO9rhR1DEJLYj7UX6ejd+PL4f0IEwaRVSeQwRq+DSas881i/+LUSCa0qB
         ngW3rLaIKlfaBmFtyakuLFtbg9fZ9OhCz2q9R8udI5ChO4Kg/taWbFELmZHaOqoa7N
         zyTy8eRXQvR1XpY539/nQhu0hfrxvvyYs3T1qIfixo+DecCUUBI0BfrNIAc098kiGE
         Qk+xIz+Szc9bQ==
Date:   Tue, 24 Jan 2023 17:19:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dan Carpenter <error27@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next v2 1/3] cacheinfo: Initialize variables in
 fetch_cache_info()
Message-ID: <Y9ATCzWu/YjbZPVE@spud>
References: <20230124154053.355376-1-pierre.gondois@arm.com>
 <20230124154053.355376-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kd7w2DvTOd3+8EZQ"
Content-Disposition: inline
In-Reply-To: <20230124154053.355376-2-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kd7w2DvTOd3+8EZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 04:40:46PM +0100, Pierre Gondois wrote:
> Set potentially uninitialized variables to 0. This is particularly
> relevant when CONFIG_ACPI_PPTT is not set.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202301052307.JYt1GWaJ-lkp@intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/Y86iruJPuwNN7rZw@kili/
> Fixes: 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the quick respin Pierre :)

> ---
>  drivers/base/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 418a18acc8f9..f6573c335f4c 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -424,7 +424,7 @@ int allocate_cache_info(int cpu)
>  int fetch_cache_info(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci;
> -	unsigned int levels, split_levels;
> +	unsigned int levels =3D 0, split_levels =3D 0;
>  	int ret;
> =20
>  	if (acpi_disabled) {
> --=20
> 2.25.1
>=20

--kd7w2DvTOd3+8EZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9ATCwAKCRB4tDGHoIJi
0vWLAQDb8fExDpV5Pof5v1hotbkUozRcMazBZEbDrpWMXOreWwEAvP0piCG5cSbq
hiv1bz87YuZPDSOtf1K9/+oY8R/h6wo=
=i0NU
-----END PGP SIGNATURE-----

--kd7w2DvTOd3+8EZQ--
