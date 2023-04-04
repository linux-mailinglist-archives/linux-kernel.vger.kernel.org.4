Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5E6D6EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjDDV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDDV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0A19BD;
        Tue,  4 Apr 2023 14:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B15634D1;
        Tue,  4 Apr 2023 21:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B025C433D2;
        Tue,  4 Apr 2023 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680643658;
        bh=bnJKYz7hgPr/gLu9S3FIC84wJhIzGVDpgOk24YANfKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIS/Q3mMub53GidGokOOeIViscA6jtGr1sMYGURfpsX6xV/m1BRPYyhxQXt4EeWgb
         eMSWubsJ0xf8gWtuZ1vkQQOzfrfaTA4Gi6zpiab4zLL22ZxKX7aOsg78Ow8LVEtc4k
         K/ljs9ow2aZhlwj5+m5qJ1mHt9/8fTm7MnjigqmrMkMgQAjxmACuLN6tenc2H8vYU2
         LefxSUuTSHHbJnGPnTeUhILZVEYCgjbLH5ol58YxddtBaxQFhVZzIjY2AeEOyEXtJI
         tl0kRwvht81sb86zIZLXOlfOktUYrfjxCcZs1lWrSWcW4a1GvpmP7QSASSBRxBBMS2
         hmfTXggrYq5rQ==
Date:   Tue, 4 Apr 2023 22:27:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>, Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 17/23] clocksource/timer-riscv: Add ACPI support
Message-ID: <20230404-ammonium-cradle-a5bb0e4d4d3e@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-18-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sQmAUn5NMdxQBCz+"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-18-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sQmAUn5NMdxQBCz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:50:31PM +0530, Sunil V L wrote:
> Initialize the timer driver based on RHCT table on ACPI based
> platforms.
>=20
> Currently, ACPI doesn't support a flag to indicate that the
> timer interrupt can wake up the cpu irrespective of its
> power state. It will be added in future update.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

My only comment on v3 was about the commit message & mentioning why
there was no handling of the timer's ability to wake the cpu, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/clocksource/timer-riscv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index cecc4662293b..da3071b387eb 100644
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
> @@ -207,3 +208,13 @@ static int __init riscv_timer_init_dt(struct device_=
node *n)
>  }
> =20
>  TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> +
> +#ifdef CONFIG_ACPI
> +static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
> +{
> +	return riscv_timer_init_common();
> +}
> +
> +TIMER_ACPI_DECLARE(aclint_mtimer, ACPI_SIG_RHCT, riscv_timer_acpi_init);
> +
> +#endif
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--sQmAUn5NMdxQBCz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCyWQgAKCRB4tDGHoIJi
0rT7AQCGUlB0daUlvZlotXE9AX4dUyeEfJS6O7vxjF94PE3b8QEAib+YSnkdmpOM
ROSIWdBZztUmg+3YEDkEHx8u7yv+GAE=
=n76y
-----END PGP SIGNATURE-----

--sQmAUn5NMdxQBCz+--
