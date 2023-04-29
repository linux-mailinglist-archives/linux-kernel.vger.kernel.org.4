Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496276F2425
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjD2Kbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2Kba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935D61BE8;
        Sat, 29 Apr 2023 03:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A2D61610;
        Sat, 29 Apr 2023 10:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28794C433EF;
        Sat, 29 Apr 2023 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682764288;
        bh=0GbmBMGiNiQlIdnACBgahvtc+QtoJehbHv6nICycqIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFhPkZUDutv1XqNNNayYgpxTWhqBsGyicP5ZE+0P5aZPM1SFgNwGsYutMDbjAeX7r
         JoIbcHIL0grDinAv1Xen+AI6GLJDOeK7oulXXWtq6Af2EkCNZQ+Mv+TGKx4KpPj8HN
         o37YI2ZiY580d9dsHNxhOy0NYV9xON8ceNNwkVCsu8Ru8dxYj+hqpK5NDa69iCq5bv
         r9g9qfYstDE8+Mz8clTHSExMwWUjXwj04kTfT766VTMf5JEJoTxTu2UDU6msp9DTxf
         zniinNBnHQ9amnPS6KwooRNkDA8OaKb5fE7QYpuHGv+Jrcx6drNQ/sHkF9tOE8VPCP
         qPbfmrd2AbdWQ==
Date:   Sat, 29 Apr 2023 11:31:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH V4 13/23] RISC-V: cpufeature: Add ACPI support in
 riscv_fill_hwcap()
Message-ID: <20230429-voucher-tutor-715fd4f6c24e@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-14-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mD53ytQ30VQ4ln/R"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-14-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mD53ytQ30VQ4ln/R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sunil,

On Tue, Apr 04, 2023 at 11:50:27PM +0530, Sunil V L wrote:

> @@ -103,14 +109,36 @@ void __init riscv_fill_hwcap(void)
> =20
>  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
> =20
> -	for_each_of_cpu_node(node) {
> +	if (!acpi_disabled) {
> +		status =3D acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
>  		unsigned long this_hwcap =3D 0;
>  		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
>  		const char *temp;
> =20
> -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> -			continue;
> +		if (acpi_disabled) {
> +			node =3D of_cpu_device_node_get(cpu);
> +			if (node) {
> +				rc =3D of_property_read_string(node, "riscv,isa", &isa);
> +				of_node_put(node);
> +				if (rc) {
> +					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +					continue;
> +				}
> +			} else {
> +				pr_warn("Unable to find cpu node\n");
> +				continue;

I was poking at this the last few days and went back to look at the ACPI
code again. Is there a reason we don't do early-return here? IOW:

	node =3D of_cpu_device_node_get(cpu);
	if (!node) {
		pr_warn()
		continue;
	}

	rc =3D of_property_read_string(node, "riscv,isa", &isa);
	of_node_put(node);
	if (rc) {
		pr_warn();
		continue;
	}

Cheers,
Conor.

> +			}
> +		} else {
> +			rc =3D acpi_get_riscv_isa(rhct, cpu, &isa);
> +			if (rc < 0) {
> +				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
> +				continue;
> +			}
>  		}
> =20
>  		temp =3D isa;
> @@ -243,6 +271,9 @@ void __init riscv_fill_hwcap(void)

--mD53ytQ30VQ4ln/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzx+AAKCRB4tDGHoIJi
0uDXAP0UihCqegQRGuBLnWtSMvMhsuIza2XwUNXv6Jsjw1EdNwD5AT1aXZpghWod
R72zPlGiSaij2J867SuTR51j5SWNmQE=
=7cU+
-----END PGP SIGNATURE-----

--mD53ytQ30VQ4ln/R--
