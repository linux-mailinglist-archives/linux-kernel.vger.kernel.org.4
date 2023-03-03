Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036536A9C8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCCQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCCQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:59:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE32AF774;
        Fri,  3 Mar 2023 08:59:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68ACEB81991;
        Fri,  3 Mar 2023 16:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B200C433D2;
        Fri,  3 Mar 2023 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677862739;
        bh=z0SfoQpwZEfIQgXPO1rQgO6UNErYjmoidz6DFukMqtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjlCgeWiwHNlbeEnXmtpsFTVV2C4SIz9hsbYHcmuxM52cLHlpccEHteOnEj/JNyPc
         HXC/cjBOnnZWo8qMLUYrSlqAXaI0NdxQg83IVTq385Vq8tvSnWAkXs68g+ewYlFJsC
         e2KMQq1s2YVPIDrQagmV2R5VNYk2vVKcTYc+7ekR+EMZ7TZpXuCIf5B0RBxhE1KMpQ
         c5FPkRt8h+iKINzxK3yUgzVCoj4Y+iYP6NaTXKSThyRoGHKszWqQrPiARX1O4G+eOc
         Cl7TcF94nVg45zsXkJRU8U2Q4pt89ozeO7RnRI/sjH+T9vpKtXFXSkocBctIVEv6Nk
         Yebh9LFCxe1OQ==
Date:   Fri, 3 Mar 2023 16:58:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 11/20] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <fdb52973-0cbc-4d7e-88bc-534fe43eec9b@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AUUK7G7NpwIF2qsL"
Content-Disposition: inline
In-Reply-To: <20230303160556.lezccmwa7ymymxws@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AUUK7G7NpwIF2qsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 05:05:56PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> > RINTC structures in the MADT provide mapping between the hartid
> > and the CPU. This is required many times even at run time like
> > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > the RINTC structures and provide a function to get the correct
> > RINTC structure for a given cpu.
> >=20
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  9 ++++++
> >  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)

> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index 111a8ed10af1..8be16c1ef7da 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num,=
 u32 slot) { }
> > =20
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  		       unsigned int cpu, const char **isa);
> > +
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > +
> > +u32 get_acpi_id_for_cpu(int cpu);
> >  #else
> >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  				     unsigned int cpu, const char **isa)
> > @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_tab=
le_header *table,
> >  	return -EINVAL;
> >  }
> > =20
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return -1;
> > +}
>=20
> Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
> ID.

I think I asked for this (or assumed it existed) in v1, when I requested
the removal of #ifdef CONFIG_ACPI stuff in riscv_fill_hwcap().
Personally, I'd rather have this stub than the ifdeffery :)

Cheers,
Conor.


--AUUK7G7NpwIF2qsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAInSQAKCRB4tDGHoIJi
0q0kAQCRhhViXko50omZit7Mc2H7+lY6SumTsapcSF6E4s9TSgEA2I1OvC1P0fbJ
L9+705mVwaQcCRmFffXsNrh8zobzyg8=
=nTk5
-----END PGP SIGNATURE-----

--AUUK7G7NpwIF2qsL--
