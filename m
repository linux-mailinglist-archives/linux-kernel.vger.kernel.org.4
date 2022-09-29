Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F245EF44E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiI2L3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiI2L3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C221F9DA;
        Thu, 29 Sep 2022 04:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 634C9B8246E;
        Thu, 29 Sep 2022 11:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0FC433C1;
        Thu, 29 Sep 2022 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664450984;
        bh=l123fFiBTIIG4boLDnbP/+WIQ9sZsWaaiSayKBcLVOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBS3qMl5DfZttE6IC6rRN5KGZ8vZ+D5sS1bFYD4+5l/bmW/OUaI6+y255j/KAtizm
         /3juX6wMkr6lljUrivGbGHyzd7h+DrSuYwclOfGbYxmxj6os/44ZBOKosBVMgKGnJe
         SyJ1S7Lv9uFsUugR2xyIhXU0cv6SOuHJBLWWwNMdrgeS2wAVtwUYlghGrUdLb3XUkO
         +gI0eOY8/MhgmEC9sGl5IxQEPo/aV4E31suHK/zxqZJglhSSyIG6yvaynPkdpCauPj
         6melQBWdqOEUVtPr/2vVwszdGvEsmd/FtnfQM/OXNuHIIkbtXrMfL/Ltj8Y3nR2FQZ
         x5JSEIJKkMoPw==
Date:   Thu, 29 Sep 2022 12:29:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 1/7] arm64/perf: Add BRBE registers and fields
Message-ID: <YzWBokiO1KSZNtcl@sirena.org.uk>
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
 <20220929075857.158358-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+2mhFxwV4YkUyQZR"
Content-Disposition: inline
In-Reply-To: <20220929075857.158358-2-anshuman.khandual@arm.com>
X-Cookie: Last week's pet, this week's special.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+2mhFxwV4YkUyQZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 01:28:51PM +0530, Anshuman Khandual wrote:

Thanks for doing this work - I did spot a few small issues though.

>  /* id_aa64dfr0 */
> +#define ID_AA64DFR0_BRBE_SHIFT		52
>  #define ID_AA64DFR0_MTPMU_SHIFT		48
>  #define ID_AA64DFR0_TRBE_SHIFT		44
>  #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
> @@ -848,6 +952,9 @@
>  #define ID_AA64DFR0_PMSVER_8_2		0x1
>  #define ID_AA64DFR0_PMSVER_8_3		0x2
> =20
> +#define ID_AA64DFR0_BRBE		0x1
> +#define ID_AA64DFR0_BRBE_V1P1		0x2
> +
>  #define ID_DFR0_PERFMON_SHIFT		24
> =20
>  #define ID_DFR0_PERFMON_8_0		0x3

This is already done in -next as a result of ID_AA64DFR0_EL1 being
converted, the enumberation define comes out as
ID_AA64DFR0_EL1_BRBE_BRBE_V1P1.

> +# This is just a dummy register declaration to get all common field mask=
s and
> +# shifts for accessing given BRBINF contents.
> +Sysreg	BRBINF_EL1	2	1	8	0	0
> +Res0	63:47
> +Field	46	CCU
> +Field	45:32	CC
> +Res0	31:18
> +Field	17	LASTFAILED
> +Field	16	TX

According to DDI0487I.a bit 16 is called T not TX.

> +Res0	15:14
> +Enum	13:8		TYPE

It's probably worth noting in the comment the issue with Enums here
that's meaning you're not using a SysregFields - I'm not sure what
people will think of this but providing a definition using the ID for
the 0th register does seem expedient.

> +Enum	7:6	EL
> +	0b00	EL0
> +	0b01	EL1
> +	0b10	EL2
> +EndEnum

According to DDI0487I.a 0b11 has the value EL3 (when FEAT_BRBEv1p1).

> +Sysreg	BRBCR_EL1	2	1	9	0	0
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9
> +Field	8 	FZP
> +Field	7	ZERO

According to DDI0487I.a bit 7 is Res0.

> +Field	2	ZERO1

According to DDI0487I.a bit 2 is Res0.

> +Sysreg	BRBFCR_EL1	2	1	9	0	1

> +Field	16	ENL

Accoding to DDI0487I.a this is EnI (ie, an L not an I).

> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0

> +Field	16	TX

According to DDI0487I.a this is T not TX.

> +Enum	7:6	EL
> +	0b00	EL0
> +	0b01	EL1
> +	0b10	EL2
> +EndEnum

According to DDI0487I.a 0b11 has the value EL3 (when FEAT_BRBEv1p1).

--+2mhFxwV4YkUyQZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM1gaEACgkQJNaLcl1U
h9AzPQf/dKcgs3a4B6Rec99BaeLxdCQFO3kmp8lU70mA29eD1BiGJGeLYm3D1Xzw
+624rLJnWzTq9pWuVSrjwHCWFqy5VvgznRFGBj8gDw0HrWfVlg3kEJKcnidZob2q
vX9m4OywI+r2UgwYDzwqDPysfQF98uBTRnaYvJkPGrWVQv+wfkVikvue8J11nx7J
POxF0yrVxS+AiwXhJqnS093X5EItOpcf13/f51bToSOaAuTETn2fpO04QfB/+S5y
w3bapIibWTUVr17fEgLpQiRL6k20Jy9iS2/jnzkW2JzmdpKDANVAiDD4UqeYIDa9
TTP8FGWTPKgLsn88f91bWIc8S3aSZQ==
=KmN6
-----END PGP SIGNATURE-----

--+2mhFxwV4YkUyQZR--
