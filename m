Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC265691252
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBIU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBIU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE0668AD2;
        Thu,  9 Feb 2023 12:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3498E61BD4;
        Thu,  9 Feb 2023 20:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78184C433D2;
        Thu,  9 Feb 2023 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675976311;
        bh=+Yd/d9WuWdnBLSjpzdnSBSDjImB9hMd6N45zMT0LCx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgKbH+CS4kLbySGezMezeFiTVHmyOSyo7q2O4z/Fut/YpS/SurHjFhuTAEQRC0gAo
         eirVQEJXCf0O7cMYrR6BbafEV8dk4AUrYU4bKLLA9YLAz4AoiCkA6qR47Izy07EEPs
         0xdcNTO6EvwhDsjqK1erVlnk3D2he5F8WjoMmEx3pcOKO0sumP6VSnZCe+T0gwnsSB
         b6DPusCTY8c1YEPyd624PuFthCYX6gcDdsTYj03Dxm0aUpm7/G8WJ8KVBL1RFXgY5S
         sZoSjGbwFXlGwOjhH75OPKuzUwENcBWlzUniT0l0MFz1fJpI6Q+h0VUUilx8LftG49
         788XZo15WNZXA==
Date:   Thu, 9 Feb 2023 20:58:25 +0000
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
Subject: Re: [PATCH 16/24] RISC-V: ACPI: clocksource/timer-riscv: Add ACPI
 support
Message-ID: <Y+VecXd9PVpkDggY@spud>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-17-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5sSD2eN/0kaTN7tv"
Content-Disposition: inline
In-Reply-To: <20230130182225.2471414-17-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5sSD2eN/0kaTN7tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 11:52:17PM +0530, Sunil V L wrote:
> timer-riscv driver needs to get the timebase-frequency from
> RISC-V Hart Capabilities Table (RHCT) on ACPI platforms. Add
> support to read the information from RHCT.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 4016c065a01c..8079666753a6 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -10,6 +10,7 @@
> =20
>  #define pr_fmt(fmt) "riscv-timer: " fmt
> =20
> +#include <linux/acpi.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> @@ -198,3 +199,11 @@ static int __init riscv_timer_init_dt(struct device_=
node *n)
>  }
> =20
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> +
> +#ifdef CONFIG_ACPI
> +static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
> +{
> +	return riscv_timer_init_common();

I feel like I need to ask as it was deleted in the previous patch, how
does ACPI determine whether the arch timer can wake the CPUs?

Cheers,
Conor.


--5sSD2eN/0kaTN7tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+VecQAKCRB4tDGHoIJi
0lj/APsFW/j+nu+K0lFR7Ikr83L7/hsc6PYgzVXs9X/hKGhcNAD/TXOjuugHcgLq
fQKGugiSw4cbY1As8Bl4hW5omFPxugM=
=oD+2
-----END PGP SIGNATURE-----

--5sSD2eN/0kaTN7tv--
