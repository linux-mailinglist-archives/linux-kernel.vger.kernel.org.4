Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39B74A2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGFRQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGFRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A141BE8;
        Thu,  6 Jul 2023 10:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E71D060F27;
        Thu,  6 Jul 2023 17:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED65C433C7;
        Thu,  6 Jul 2023 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688663762;
        bh=K525Re3smqCn8xHm4THDIij+h4crszZpgCUGoxZhhUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFuWcgNAb/ds/zSAxxFst4Of6NVK+cdwSo+uyehJ0y59mKZNWHitYZQgI1BcoZijb
         6FtCerlX2kfXkz7OJiDDFq+Ykoalf4x4nIE/KHzquTVTRXehCWAxXvJatGmEiQ4jVa
         GxCwRTJW4JhuP9pjoVT3AmuaV7/6WQ6X9t0vs3AFzRpI7fqIZmtb9tjYf5Z856g/+H
         FZqA5h3WcLge2ZsbMl8F49WwYaT/SozDrUeeuQE4k1Fs+T3BNZ1YlO+fjHVUw8sHED
         YFw05t1TrPUt9KJAlNGtToCTonwBcJ+kJpAimi4L90ni6sgFMh2HL/N7WVYhwgNUNy
         XpHhxzrImIlFQ==
Date:   Thu, 6 Jul 2023 18:15:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Framework for vendor extensions
Message-ID: <20230706-curly-swinging-afbf79a4cdb7@spud>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UI60rudIHsqNxMLP"
Content-Disposition: inline
In-Reply-To: <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UI60rudIHsqNxMLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Wed, Jul 05, 2023 at 08:30:17PM -0700, Charlie Jenkins wrote:
> Create Kconfig files, Makefiles, and functions to enable vendors to
> provide information via the riscv_hwprobe syscall about which vendor
> extensions are available.

This is all apparently from reading the diff, you don't need to tell us
what files you have created etc. Please just stick with explaining the
rationale for your changes (especially anything that might make someone
reading it go "huh").

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kbuild                     |  1 +
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/Kconfig.vendor             |  3 +++
>  arch/riscv/include/asm/hwprobe.h      |  1 +
>  arch/riscv/kernel/sys_riscv.c         | 40 +++++++++++++++++++++++++++++=
+++---
>  arch/riscv/vendor_extensions/Makefile |  3 +++
>  6 files changed, 46 insertions(+), 3 deletions(-)

> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index afa83e307a2e..bea38010d9db 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -3,6 +3,7 @@
>  obj-y +=3D kernel/ mm/ net/
>  obj-$(CONFIG_BUILTIN_DTB) +=3D boot/dts/
>  obj-y +=3D errata/
> +obj-y +=3D vendor_extensions/
>  obj-$(CONFIG_KVM) +=3D kvm/
> =20
>  obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) +=3D purgatory/
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c1505c7729ec..19404ede0ee3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -276,6 +276,7 @@ config AS_HAS_OPTION_ARCH
> =20
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.errata"
> +source "arch/riscv/Kconfig.vendor"
> =20
>  menu "Platform type"
> =20
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..213ac3e6fed5
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,3 @@
> +menu "Vendor extensions selection"
> +
> +endmenu # "Vendor extensions selection"

These files don't do anything, don't add them until you need to.

> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 78936f4ff513..fadb38b83243 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -9,5 +9,6 @@
>  #include <uapi/asm/hwprobe.h>
> =20
>  #define RISCV_HWPROBE_MAX_KEY 5
> +#define RISCV_HWPROBE_VENDOR_EXTENSION_SPACE (UL(1)<<63)

Should this not be BIT_ULL(63)? Although I am not sure that we can
actually do this, more on that front later.

> =20
>  #endif
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 26ef5526bfb4..2351a5f7b8b1 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -188,9 +188,35 @@ static u64 hwprobe_misaligned(const struct cpumask *=
cpus)
>  	return perf;
>  }
> =20
> +static int hwprobe_vendor(__u64 mvendorid, struct riscv_hwprobe *pair,
> +			 const struct cpumask *cpus)
> +{
> +	switch (mvendorid) {
> +	default:
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  			     const struct cpumask *cpus)
>  {
> +	int err;
> +
> +	if (((unsigned long) pair->key) >=3D RISCV_HWPROBE_VENDOR_EXTENSION_SPA=
CE) {

Hopefully Bjorn or someone that actually knows a thing or two about uapi
stuff can chime in here, but I think what you are doing here (where the
vendor space sets the MSB) really muddies the api. These keys are defined
as signed 64 bit numbers & -1 is the value set when a key is not valid.
I'd much rather we kept the negative space off-limits, and used the 62nd
bit instead, avoiding using negative numbers for valid keys.

> +		struct riscv_hwprobe mvendorid =3D {
> +			.key =3D RISCV_HWPROBE_KEY_MVENDORID,
> +			.value =3D 0
> +		};
> +
> +		hwprobe_arch_id(&mvendorid, cpus);

I think this needs a comment explaining why you do this hwprobe call,=20
> +		if (mvendorid.value !=3D -1ULL)
> +			err =3D hwprobe_vendor(mvendorid.value, pair, cpus);
> +		else
> +			err =3D -1;
> +	}

I don't really understand the control flow here. Why are you continuing
on to the switch statement, if you have either a) already ran
hwprobe_vendor() or b) noticed that mvendorid.value is not valid?

>  	switch (pair->key) {
>  	case RISCV_HWPROBE_KEY_MVENDORID:
>  	case RISCV_HWPROBE_KEY_MARCHID:
> @@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwprobe *=
pair,
> =20
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> -	 * call, but get their element key set to -1 and value set to 0
> -	 * indicating they're unrecognized.
> +	 * call, instead an error is raised to indicate the element key
> +	 * is unrecognized.
>  	 */
>  	default:
> +		err =3D -1;
> +		break;
> +	}
> +
> +	/*
> +	 * Setting the element key to -1 and value to 0 indicates that
> +	 * hwprobe was unable to find the requested key.
> +	 */
> +	if (err !=3D 0) {
>  		pair->key =3D -1;
>  		pair->value =3D 0;
> -		break;
>  	}
>  }
> =20
> diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_ex=
tensions/Makefile
> new file mode 100644
> index 000000000000..e815895e9372
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/Makefile
> @@ -0,0 +1,3 @@
> +ifdef CONFIG_RELOCATABLE
> +KBUILD_CFLAGS +=3D -fno-pie
> +endif

There are no files in this directory, why do you need to do a dance
about relocatable kernels?

Cheers,
Conor.

--UI60rudIHsqNxMLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKb2zQAKCRB4tDGHoIJi
0hTDAP0c/L2QKrlqwK8Vy+oQbp9A2yhfsGsSd2Vo7S6Cc6UFvAD/VxwxL+ezSwJP
YptVnUsgEYOqE3Z7eZ2B14kRhmnkOQ8=
=knz0
-----END PGP SIGNATURE-----

--UI60rudIHsqNxMLP--
