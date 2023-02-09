Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9A6912DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBIVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBIVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:54:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5416312D;
        Thu,  9 Feb 2023 13:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED00DB816DD;
        Thu,  9 Feb 2023 21:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA4CC433D2;
        Thu,  9 Feb 2023 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675979687;
        bh=jRismUHOyVxVBabYaWn4wT8Nrr82S/bxWlRxPdH4hO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1NVK4lpV5VB6E2sgPr/s/cSKIEm2oUyhlAyffmdhJiJQJ0YjGJcPDGmGpjDbHmXW
         HRJGhBBdW1Iia4hzMLl5bU2BE+rwlOa7E/M2USCNji8LBCIfWhiNC9ujBSojlHcDaJ
         tM5XaPqnzeqFJC5LzDSzvvZliOzPc3yMNUN8XB1Hb8YrUgpJUU1QVPNMy03EppKxDZ
         qPz4BoCynp/MOMccqOOUXKAhftwYEvE3shOtSoLdoc8XK7U8rRNVlCRfSLMsz3u0nB
         6tv8EvcJ6RaAAY4rnDasoNvXcbprzoPJwijhU0enTk+csnSekIiA2cH9c1+xSD0Vbq
         3VS4mfUuoLP0g==
Date:   Thu, 9 Feb 2023 21:54:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 23/24] MAINTAINERS: Add entry for drivers/acpi/riscv
Message-ID: <Y+Vroj6CmrL4I9lN@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-24-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V5lUTQp9r2xga7S0"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-24-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V5lUTQp9r2xga7S0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:24PM +0530, Sunil V L wrote:
> ACPI defines few RISC-V specific tables which need
> parsing code added in drivers/acpi/riscv. Add maintainer
> entries for this newly created folder.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a5c25c20d00..b14ceb917a81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -450,6 +450,13 @@ S:	Orphan
>  F:	drivers/platform/x86/wmi.c
>  F:	include/uapi/linux/wmi.h
> =20
> +ACPI FOR RISC-V (ACPI/riscv)
> +M:	Sunil V L <sunilvl@ventanamicro.com>
> +L:	linux-acpi@vger.kernel.org
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained

Supported, no?

> +F:	drivers/acpi/riscv
> +
>  ACRN HYPERVISOR SERVICE MODULE
>  M:	Fei Li <fei1.li@intel.com>
>  L:	acrn-dev@lists.projectacrn.org (subscribers-only)
> --=20
> 2.38.0
>=20

--V5lUTQp9r2xga7S0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+VroQAKCRB4tDGHoIJi
0hKrAP9++kwugl7SFcTtfhGUxoAGynIdNXhyQA747zCm8InMJgEA//0+dz0BbQmI
3S1VtaoE6iBUoXd7Qq+7iHfGORrEogM=
=gQ/m
-----END PGP SIGNATURE-----

--V5lUTQp9r2xga7S0--
