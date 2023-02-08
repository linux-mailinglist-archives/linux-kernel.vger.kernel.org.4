Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757168F9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBHVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHVeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:34:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267218145;
        Wed,  8 Feb 2023 13:34:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CB4617DA;
        Wed,  8 Feb 2023 21:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD1C433EF;
        Wed,  8 Feb 2023 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675892049;
        bh=Frt26srycEDnTaQe7B7tU/DqA0WSAWAkqfb5tJZSCuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP97vjw/PyubC0CpESEZgZ1CG2zuzhvGoNNTqp5d49ECfQ2p/BeppEJO5gIau7wxC
         /cjIj+Od9SPU00zuRCvA/QRnLXPP+i6OSNsd1yttz1ExuUuPpyMlF77qzCxOPSxZO6
         e4LfTk34m4F4PceT6qJCwd+DmWP7iDYaw3LGzQp3in0nVOrnUgmMSiMLVLOxgFhSKh
         tXbyD0SMsU3PybPFjAQIA1bgecC+T4UKE/WIBnLQM3aEGIgQK6hkxnCTBlQaqhkYjW
         td0KMC+m8DyVO125txUrvfhCVKcXavEeSOMlfjOn1vGGb+2ce9v5sXGgc/zVsb0VQy
         miuQJgRQck0mg==
Date:   Wed, 8 Feb 2023 21:34:03 +0000
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
Subject: Re: [PATCH 12/24] RISC-V: ACPI: smpboot: Create wrapper smp_setup()
Message-ID: <Y+QVSxzbpC5WbRvY@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NE7BMaNMGtVs0aCh"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-13-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NE7BMaNMGtVs0aCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:13PM +0530, Sunil V L wrote:
> Subject: RISC-V: ACPI: smpboot: Create wrapper smp_setup()

As I pointed out the other day, this one of the patches that really
doesn't warrant an ACPI: prefix.

With that fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> smp_setup() currently assumes DT based platforms. To enable ACPI,
> first make this as a wrapper function and move existing code to
> a separate DT specific function.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/kernel/smpboot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 00b53913d4c6..26214ddefaa4 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
> =20
> -void __init setup_smp(void)
> +static void __init of_parse_and_init_cpus(void)
>  {
>  	struct device_node *dn;
>  	unsigned long hart;
> @@ -116,6 +116,11 @@ void __init setup_smp(void)
>  	}
>  }
> =20
> +void __init setup_smp(void)
> +{
> +	of_parse_and_init_cpus();
> +}
> +
>  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
>  {
>  	if (cpu_ops[cpu]->cpu_start)
> --=20
> 2.38.0
>=20

--NE7BMaNMGtVs0aCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+QVSwAKCRB4tDGHoIJi
0rA0AQCroHvywJ2/alTXUyLQurVVhB6TsNE5+X/Kdt9LMX+7PwEA2ThIcbHkMQtO
X/uJ5T+Gft/uIzrywZzvl8dgupEJfAA=
=h91G
-----END PGP SIGNATURE-----

--NE7BMaNMGtVs0aCh--
