Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0061F742
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiKGPLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiKGPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:11:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A91E3D4;
        Mon,  7 Nov 2022 07:11:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E5EBB81219;
        Mon,  7 Nov 2022 15:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D5C433D6;
        Mon,  7 Nov 2022 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667833875;
        bh=wVgLPr5v//yG11ovNQ85JwEVr3YQFb/RyVao7hWCqlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+0FY/orTZt8mOb9jO02zZqXQwJgbcIqcYmXk5XODvNm+QnTru0kqiwIgZzaEb2yr
         9uvDsafbDYZ01c2d00etldMGUDc1+dUoRrbFmBhB1N0OgKexApvC2ihASE52yjy17S
         Lsrae0+c0CNWW5+llsspm0oIcF55qpxyF7NGLJ0nXjE5JAehXOUn3LqSvqHved8SRL
         WZLO3njMrB5bVHxGYdg5+WK661dy1GDviEhzfDKFjKg4FcqnWV4JhylF2jpCqN2W0M
         YKMBEkMrKHeGxQ/+EHwhvg6xcKoqSfufHleq5vjKgtjXBnIeZ9FwwsBR6Z3xuJI31x
         kXzAi1jwTAmMw==
Date:   Mon, 7 Nov 2022 15:11:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 3/8] arm64/sysreg: Convert SPE registers to automatic
 generation
Message-ID: <Y2kgC9QlBwvXTLe6@sirena.org.uk>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-3-87682f78caac@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2G3Dfetw2HrPyugm"
Content-Disposition: inline
In-Reply-To: <20220825-arm-spe-v8-7-v3-3-87682f78caac@kernel.org>
X-Cookie: Minimum charge for booths.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2G3Dfetw2HrPyugm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 10:55:03AM -0500, Rob Herring wrote:

> Convert all the SPE register defines to automatic generation. No
> functional changes.
>=20
> New registers and fields for SPEv1.2 are added with the conversion.
>=20
> Some of the PMBSR MSS field defines are kept as the automatic generation
> has no way to create multiple names for the same register bits. The
> meaning of the MSS field depends on other bits.

Reviewed-by: Mark Brown <broonie@kernel.org>

> +Sysreg	PMSNEVFR_EL1	3	0	9	9	1
> +Field	63:0	E
> +EndSysreg

JFTR as noted last time this looks nothing like the spec but is clearly
a sensible interpretation.

I do note that one advantage of doing this register by register rather
than en masse is that it makes it a lot easier to avoid re-reviewing the
same register...

--2G3Dfetw2HrPyugm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNpIAoACgkQJNaLcl1U
h9DvBgf9EuKrsvAgMvRabqAgl2mo979wY3OQJcNNexlQAPguIlNJOpjdL2Dvko0o
oHza2RbBfzmfHVQEMoiqbN+VUN9QxV7jgiP/50FrhH3G5oADAMRfYY6ubrg6STfw
1/KlPkOiDj02yrS3S4rqH8gBbJ+OKWmxqFT2mINdB14b50FiSJ2++nKphUYHsS0D
IRzNoBLllDsd+NqlXoQ4ma12NpJPOCpF+UOnIha7ersIgXxzrWyNQEkw48uWyg+g
xjMyRJZvZW59hE4HPXl/6EypHNrnIBlAVzX+JE3vnep7cn5Y0STit5s53L7kkTsD
B9N0R8ar/bOBI7vJMDHmI7qHigyuew==
=WP8T
-----END PGP SIGNATURE-----

--2G3Dfetw2HrPyugm--
