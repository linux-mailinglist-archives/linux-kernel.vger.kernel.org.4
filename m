Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF369721E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBNXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjBNXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:51:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367730280;
        Tue, 14 Feb 2023 15:51:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54CEE6195E;
        Tue, 14 Feb 2023 23:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D383EC433D2;
        Tue, 14 Feb 2023 23:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676418684;
        bh=c/MAgO1xKi/ERdMzGZwYAEi3IC8eF4dU6wSNq85v+mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lhs/n0LZl4mSGX8tngnbwqHWm2bzpQsxhswfMQ/uTeO1a7uppvCPDBs9heKcWj1Pw
         1Dz6eSti88kTww4JHSfSKYIBAr0HXV/OFhmeyf8qfa+fuH9YUulwUR4yhoIr4QQmMP
         ZJ2t8wQeliAyTtPCRff/BubW2o/t3vqTmpk9pfmMfdd1uLi9NCFR3zsZoHzfLq69PG
         /e8jyqlV9Xg2xSxA1aECUhAgcJdhu0sc23Tk+yH72rM44LDxSP6UCqXcxar9lCfXfs
         RK/JWJM9dINoxVlcD7GzR+A9Q+6GFux4LnBBS+16fw48C7VywCaI0mji70bIyQFoHS
         HUrw3cYD0eQbg==
Date:   Tue, 14 Feb 2023 23:51:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Message-ID: <Y+wedUsNEfWsKU5I@spud>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bxCV90zBRy7p6P4"
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-3-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bxCV90zBRy7p6P4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

Just as a preface, I'm reviewing this lot from a position of ignorance
on what glibc wants so I'll refrain from commenting on call itself.
I figure that since the commentary has kinda died on the sysfs front &
Palmer seems to be still into the syscall stuff, that we're pushing on
with this approach...

On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> system call that quite does this, so let's just provide an arch-specific
> one to probe for hardware capabilities.  This currently just provides
> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> the future.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
> Changes in v2:
>  - Changed the interface to look more like poll(). Rather than supplying
>    key_offset and getting back an array of values with numerically
>    contiguous keys, have the user pre-fill the key members of the array,
>    and the kernel will fill in the corresponding values. For any key it
>    doesn't recognize, it will set the key of that element to -1. This
>    allows usermode to quickly ask for exactly the elements it cares
>    about, and not get bogged down in a back and forth about newer keys
>    that older kernels might not recognize. In other words, the kernel
>    can communicate that it doesn't recognize some of the keys while
>    still providing the data for the keys it does know.
>  - Added a shortcut to the cpuset parameters that if a size of 0 and
>    NULL is provided for the CPU set, the kernel will use a cpu mask of
>    all online CPUs. This is convenient because I suspect most callers
>    will only want to act on a feature if it's supported on all CPUs, and
>    it's a headache to dynamically allocate an array of all 1s, not to
>    mention a waste to have the kernel loop over all of the offline bits.
>=20
>=20
> ---
>  Documentation/riscv/hwprobe.rst       |  37 +++++++
>  Documentation/riscv/index.rst         |   1 +
>  arch/riscv/include/asm/hwprobe.h      |  13 +++
>  arch/riscv/include/asm/syscall.h      |   3 +
>  arch/riscv/include/uapi/asm/hwprobe.h |  25 +++++
>  arch/riscv/include/uapi/asm/unistd.h  |   8 ++
>  arch/riscv/kernel/cpu.c               |   3 +-
>  arch/riscv/kernel/sys_riscv.c         | 146 +++++++++++++++++++++++++-
>  8 files changed, 234 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/riscv/hwprobe.rst
>  create mode 100644 arch/riscv/include/asm/hwprobe.h
>  create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> new file mode 100644
> index 000000000000..97771090e972
> --- /dev/null
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -0,0 +1,37 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +RISC-V Hardware Probing Interface
> +---------------------------------
> +
> +The RISC-V hardware probing interface is based around a single syscall, =
which
> +is defined in <asm/hwprobe.h>::
> +
> +    struct riscv_hwprobe {
> +        __s64 key;
> +        __u64 value;
> +    };
> +
> +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_coun=
t,
> +                           size_t cpu_count, cpu_set_t *cpus,
> +                           unsigned long flags);
> +
> +The arguments are split into three groups: an array of key-value pairs, =
a CPU
> +set, and some flags.  The key-value pairs are supplied with a count.  Us=
erspace
> +must prepopulate the key field for each element, and the kernel will fil=
l in the
> +value if the key is recognized.  If a key is unknown to the kernel, its =
key
> +field will be cleared to -1, and its value set to 0.  The CPU set is def=
ined by
> +CPU_SET(3), the indicated features will be supported on all CPUs in the =
set.
> +Usermode can supply NULL for cpus and 0 for cpu_count as a shortcut for =
all
> +online CPUs. There are currently no flags, this value must be zero for f=
uture
> +compatibility.
> +
> +On success 0 is returned, on failure a negative error code is returned.
> +
> +The following keys are defined:
> +
> +* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, as p=
er the
> +  ISA specifications.

"per the ISA specifications" sounds like dangerous wording to me! ;)

> +* :RISCV_HWPROBE_KEY_MARCHID:: Contains the value of :marchid:, as per t=
he ISA
> +  specifications.
> +* :RISCV_HWPROBE_KEY_MIMPLID:: Contains the value of :mimplid:, as per t=
he ISA
> +  specifications.

> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> new file mode 100644
> index 000000000000..591802047460
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright 2022 Rivos, Inc
> + */
> +
> +#ifndef _UAPI_ASM_HWPROBE_H
> +#define _UAPI_ASM_HWPROBE_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * Interface for probing hardware capabilities from userspace, see
> + * Documentation/riscv/hwprobe.rst for more information.
> + */
> +struct riscv_hwprobe {
> +	__s64 key;
> +	__u64 value;
> +};
> +
> +#define RISCV_HWPROBE_KEY_MVENDORID	0
> +#define RISCV_HWPROBE_KEY_MARCHID	1
> +#define RISCV_HWPROBE_KEY_MIMPID	2
> +/* Increase RISCV_HWPROBE_MAX_KEY when adding items. */

Can't wait for that to get forgotten!

> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/ua=
pi/asm/unistd.h
> index 73d7cdd2ec49..37d47302322a 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -43,3 +43,11 @@
>  #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
>  #endif
>  __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> +
> +/*
> + * Allows userspace to probe

That comment looks chopped off midway through.

> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 5d3f2fbeb33c..868a12384f5a 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -6,8 +6,11 @@
>   */
> =20
>  #include <linux/syscalls.h>
> -#include <asm/unistd.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
> +#include <asm/hwprobe.h>
> +#include <asm/uaccess.h>
> +#include <asm/unistd.h>
>  #include <asm-generic/mman-common.h>
> =20
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> @@ -69,3 +72,144 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start,=
 uintptr_t, end,
> =20
>  	return 0;
>  }
> +
> +/*
> + * The hwprobe interface, for allowing userspace to probe to see which f=
eatures
> + * are supported by the hardware.  See Documentation/riscv/hwprobe.rst f=
or more
> + * details.
> + */
> +static int set_hwprobe(struct riscv_hwprobe __user *pair, u64 val)
> +{
> +	long ret;
> +
> +	ret =3D put_user(val, &pair->value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static long hwprobe_mid(struct riscv_hwprobe __user *pair, size_t key,

ngl, it took me far too long to figure out that "mid" was not some
shortening of "middle". I don't have any suggestions though, other than
using cpu_id to match your variable and I think it becomes clearer by the
end of the series anyway when the access alignment stuff appears.

> +			cpumask_t *cpus)
> +{
> +	long cpu, id;
> +	bool first, valid;
> +
> +	first =3D true;
> +	valid =3D false;

Just make that
boot first =3D true, valid =3D false;
no?

> +	for_each_cpu(cpu, cpus) {
> +		struct riscv_cpuinfo *ci =3D per_cpu_ptr(&riscv_cpuinfo, cpu);
> +		long cpu_id;
> +
> +		switch (key) {
> +		case RISCV_HWPROBE_KEY_MVENDORID:
> +			cpu_id =3D ci->mvendorid;

Are you intentionally avoiding using riscv_cached_mfooid()?

> +			break;
> +		case RISCV_HWPROBE_KEY_MIMPID:
> +			cpu_id =3D ci->mimpid;
> +			break;
> +		case RISCV_HWPROBE_KEY_MARCHID:
> +			cpu_id =3D ci->marchid;
> +			break;
> +		}
> +
> +		if (first) {
> +			id =3D cpu_id;
> +			valid =3D true;

So, we only end up in this function if there are CPUs in the set.
Does that mean we can assume validity by default and just define valid =3D
true from the get go?

> +		}
> +
> +		if (id !=3D cpu_id)
> +			valid =3D false;
> +	}
> +
> +	/*
> +	 * put_user() returns 0 on success, so use 1 to indicate it wasn't
> +	 * called and we should skip having incremented the output.
> +	 */
> +	if (!valid)
> +		return 1;

I'm not sure why you're returning 1 here. If the id is deemed to be
invalid, why aren't we treating it as a "real" error.
TL;DR I don't understand the comment explaining this.

> +
> +	return set_hwprobe(pair, id);
> +}
> +
> +static
> +long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_coun=
t,

The files not wrapped at 80 anyway, so why not put this on the same line
as `static`?

> +		      long cpu_count, unsigned long __user *cpus_user,
> +		      unsigned long flags)
> +{
> +	size_t out;
> +	s64 key;
> +	long ret;
> +	struct cpumask cpus;
> +
> +	/* Check the reserved flags. */
> +	if (flags !=3D 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * The only supported values must be the same on all CPUs. Allow

"The only supported values" doesn't really make much sense. Is that
intended to be read as meaning that we only report the features
supported by all CPUs in the set?

> +	 * userspace to specify NULL and 0 as a shortcut to all online CPUs.
> +	 */
> +	cpumask_clear(&cpus);
> +	if ((cpu_count =3D=3D 0) && (cpus_user =3D=3D NULL)) {

Is this not just `if (!cpu_count && !cpus_user)`?

> +		cpumask_copy(&cpus, cpu_online_mask);
> +	} else {
> +		if (cpu_count > cpumask_size())
> +			cpu_count =3D cpumask_size();

nit: newline here please, helps my poor auld eyes out on the days
they're not doing too well!

Cheers,
Conor.

> +		ret =3D copy_from_user(&cpus, cpus_user, cpu_count);
> +		if (!ret)
> +			return -EFAULT;
> +
> +		/*
> +		 * Userspace must provide at least one online CPU, without that there's
> +		 * no way to define what is supported.
> +		 */
> +		cpumask_and(&cpus, &cpus, cpu_online_mask);
> +		if (cpumask_empty(&cpus))
> +			return -EINVAL;
> +	}
> +
> +	for (out =3D 0; out < pair_count; out++, pairs++) {
> +		long ret;
> +
> +		if (get_user(key, &pairs->key))
> +			return -EFAULT;
> +
> +		switch (key) {
> +		case RISCV_HWPROBE_KEY_MVENDORID:
> +		case RISCV_HWPROBE_KEY_MARCHID:
> +		case RISCV_HWPROBE_KEY_MIMPID:
> +			ret =3D hwprobe_mid(pairs, key, &cpus);
> +			break;
> +
> +		/*
> +		 * For forward compatibility, unknown keys don't fail the whole
> +		 * call, but get their element key set to -1 and value set to 0
> +		 * indicating they're unrecognized.
> +		 */
> +		default:
> +			ret =3D put_user(-1, &pairs->key);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret =3D set_hwprobe(pairs, 0);
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		}
> +
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +SYSCALL_DEFINE5(riscv_hwprobe, uintptr_t, pairs, uintptr_t, pair_count,
> +		uintptr_t, cpu_count, uintptr_t, cpus, uintptr_t, flags)
> +{
> +	return do_riscv_hwprobe((void __user *)pairs, pair_count, cpu_count,
> +				(void __user *)cpus, flags);
> +}
> --=20
> 2.25.1
>=20

--4bxCV90zBRy7p6P4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+wedQAKCRB4tDGHoIJi
0ifYAP4oPF+kJj2nyurSqdfWtOq86+AC+YUmPno2ALVsHuIXqAEAtpkjD7gSilEI
uz6qTXglOlAs0Aga095968bIco6Opwo=
=ZvEj
-----END PGP SIGNATURE-----

--4bxCV90zBRy7p6P4--
