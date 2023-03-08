Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC56B03F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCHKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCHKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:21:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D060AAF;
        Wed,  8 Mar 2023 02:21:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86148B81B29;
        Wed,  8 Mar 2023 10:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C23C433D2;
        Wed,  8 Mar 2023 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678270871;
        bh=4KQBiX+zBplgwRl6rTGlLz+7p9lJaG6/YAbBfam9ax8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3OAOeSrAu1FcFxJNz/WU3Ux4YtOS5a3Fx2RygOGxk+DJzfs8TFol4Sg6TYBVuT1I
         qnC+XjChuawvxf6EWUZF/3TNWZaVP4E1H+g1QsFXE9gwqeCzClVt4dJl977eoVcP4d
         fZyhsGFpYIyDNH/EcAykYFi2zt/YUJ/HetK4QvZLGG4u6lBhfpruY5BeuXwwWbOaUQ
         l0Yxm8UD78gawFw9DwkKRQxx66E6q0fpA/N8UrGZrgFun+KpTN+cn0A7q16uJ0u4T+
         9zFTZdEM3dF5KzelHUYY7KtjGW9X3fzTVtl0m6q3TIBONW5XthXSQ1uwzx3Xjx5Mv/
         HwHpr7QJw8rzQ==
Date:   Wed, 8 Mar 2023 10:21:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
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
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 18/20] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <e1cf9976-17a1-4096-b497-08985c1f8e0f@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-19-sunilvl@ventanamicro.com>
 <b38179fe-f1b8-4146-ae22-11e8bbbd500e@spud>
 <ZAhYeuCmdYAnanNv@sunil-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63+IG2qcJZyEQHTv"
Content-Disposition: inline
In-Reply-To: <ZAhYeuCmdYAnanNv@sunil-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63+IG2qcJZyEQHTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 03:12:18PM +0530, Sunil V L wrote:
> On Mon, Mar 06, 2023 at 09:17:34PM +0000, Conor Dooley wrote:
> > On Fri, Mar 03, 2023 at 07:06:45PM +0530, Sunil V L wrote:
> > > Initialize the ACPI core for RISC-V during boot.
> > >=20
> > > ACPI tables and interpreter are initialized based on
> > > the information passed from the firmware and the value of
> > > the kernel parameter 'acpi'.
> > >=20
> > > With ACPI support added for RISC-V, the kernel parameter 'acpi'
> > > is also supported on RISC-V. Hence, update the documentation.
> > >=20
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> >=20
> > > +static int __init acpi_fadt_sanity_check(void)
> > > +{
> > > +	struct acpi_table_header *table;
> > > +	struct acpi_table_fadt *fadt;
> > > +	acpi_status status;
> > > +	int ret =3D 0;
> > > +
> > > +	/*
> > > +	 * FADT is required on riscv; retrieve it to check its presence
> > > +	 * and carry out revision and ACPI HW reduced compliancy tests
> > > +	 */
> > > +	status =3D acpi_get_table(ACPI_SIG_FADT, 0, &table);
> > > +	if (ACPI_FAILURE(status)) {
> > > +		const char *msg =3D acpi_format_exception(status);
> > > +
> > > +		pr_err("Failed to get FADT table, %s\n", msg);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	fadt =3D (struct acpi_table_fadt *)table;
> > > +
> > > +	/*
> > > +	 * Revision in table header is the FADT Major revision, and there
> > > +	 * is a minor revision of FADT.
> >=20
> > What is the point of this part of the comment? Isn't it obvious from the
> > below code that you expect a major and minor revision?
> > If feel like you're trying to make a point in it, but the point has been
> > lost :/
> >=20
> It just highlights that major and minor revision fields are in two
> different places.=20

I thought that that was what you meant, but only because the code does
it. The comment doesn't actually say so!

Instead of deleting it, something like the following?
/*
 * The revision in the table header is the FADT's Major revision. The
 * FADT also has a minor revision, which is stored in the FADT itself.
 * <snip>


--63+IG2qcJZyEQHTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAhhkQAKCRB4tDGHoIJi
0krvAP0eBw+cdEVFy8lgx9EsKqFkr7cLWq8k9aDC+5LghJ2RuQD/ZnzN20QyBPC1
imyxaNv7BcEyf8CQlBw+HH7hKVgtYQ4=
=2b/3
-----END PGP SIGNATURE-----

--63+IG2qcJZyEQHTv--
