Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E178679FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjAXRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjAXRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:15:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B367298E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:15:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB1461300
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8C1C433D2;
        Tue, 24 Jan 2023 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674580524;
        bh=wKvlYv5MLbM587ZQe0pRKBkwTxNoL4bwXuRQfuT4NHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj3luYUncno5jJfr6SLoF+rwSBiURG6vl3iGXneH6Ok87J4XZRkSxK4vnshRFb7e6
         +Bm4a7DddIRBDhYEsR6RAb+0mYODt+MJTOlKIhAH/GHlpoJ1JMGYh228NApZi2yxJw
         EXiPj1hr0jQ4yLgv9A8TnCOpmfv02cQdQ2S7mouJnG3Q1R2Jv4+jA7bsSnLVxEDuZn
         tAE9M4jarmrhU+QMxBJ7OxeXA1iyuQ8RWu4K97UsFN1KL0qBB1/lCnvfDsBB/DQdxn
         MtPwH8fmSQmVtsJWSGOMmXEgM1wwySnamv/dUXWTbOtTr45AzJZymGoQgf8C49zV5v
         nwpKQcdW6rFrg==
Date:   Tue, 24 Jan 2023 17:15:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dan Carpenter <error27@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next v2 2/3] cacheinfo: Make default
 acpi_get_cache_info() return an error
Message-ID: <Y9ASJiKjIhpMk/8n@spud>
References: <20230124154053.355376-1-pierre.gondois@arm.com>
 <20230124154053.355376-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SHrM4lZTmcwll7Yv"
Content-Disposition: inline
In-Reply-To: <20230124154053.355376-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SHrM4lZTmcwll7Yv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 04:40:47PM +0100, Pierre Gondois wrote:
> commit bd500361a937 ("ACPI: PPTT: Update acpi_find_last_cache_level()
> to acpi_get_cache_info()")
> updates the prototype of acpi_get_cache_info(). The cache 'levels'
> is update through a pointer and not the return value of the function.
>=20
> If CONFIG_ACPI_PPTT is not defined, acpi_get_cache_info() doesn't
> update its *levels and *split_levels parameters and returns 0.
> This can lead to a faulty behaviour.
>=20
> Make acpi_get_cache_info() return an error code if CONFIG_ACPI_PPTT
> is not defined.
> Also,
>=20
> In init_cache_level(), if no PPTT is present or CONFIG_ACPI_PPTT is
> not defined, instead of aborting if acpi_get_cache_info() returns an
> error code, just continue. This allows to try fetching the cache
> information from clidr_el1.

Again, dunno jack about clidr_el1. But the change here seems sane once
more? I was going to suggest throwing away ret entirely and just
initialising fw_level to zero, since the function inside
acpi_get_cache_level() that actually modifies it comes after the last
error return anyway - but that probably would just leave you exposed to
a change in the core code that doesn't also update the callsites.
Plus this looks more deliberate IMO. On that basis, LGTM.

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  arch/arm64/kernel/cacheinfo.c | 2 +-
>  include/linux/cacheinfo.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index d3fe9542c370..bf348b8d321f 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -59,7 +59,7 @@ int init_cache_level(unsigned int cpu)
>  	} else {
>  		ret =3D acpi_get_cache_info(cpu, &fw_level, NULL);
>  		if (ret < 0)
> -			return ret;
> +			fw_level =3D 0;
>  	}
> =20
>  	if (fw_level < 0)
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index dfef57077cd0..908e19d17f49 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -100,7 +100,7 @@ static inline
>  int acpi_get_cache_info(unsigned int cpu,
>  			unsigned int *levels, unsigned int *split_levels)
>  {
> -	return 0;
> +	return -ENOENT;
>  }
>  #else
>  int acpi_get_cache_info(unsigned int cpu,
> --=20
> 2.25.1
>=20

--SHrM4lZTmcwll7Yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9ASJgAKCRB4tDGHoIJi
0kCAAPwM3UDd3wrW0Ki90PSY0KOZP5nvSwQFHugxZ9qRKiq+rgEA8Ps9R0lLiliq
mzMeShNEiuc5jE9G3Fkdi+l/pLHCAgA=
=42pH
-----END PGP SIGNATURE-----

--SHrM4lZTmcwll7Yv--
