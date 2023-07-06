Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08E74A272
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGFQss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjGFQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:48:45 -0400
X-Greylist: delayed 962 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 09:48:43 PDT
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3761BD4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:48:42 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.146.82])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 6EF3727632
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 16:32:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mhm5w (unknown [10.110.115.91])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 113E41FD37;
        Thu,  6 Jul 2023 16:32:37 +0000 (UTC)
Received: from courmont.net ([37.59.142.99])
        by ghost-submission-6684bf9d7b-mhm5w with ESMTPSA
        id dOCbN6XspmRRAB0Aw1bibA
        (envelope-from <remi@remlab.net>); Thu, 06 Jul 2023 16:32:37 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-99G00385d7860f-b553-4727-8c2e-c4777a99cb92,
                    8891399453053EE55EDFED6858B7B4D362CEA829) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
Date:   Thu, 06 Jul 2023 19:32:36 +0300
Message-ID: <2286282.ElGaqSPkdT@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17052317042732636635
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudelgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnhepffegtdfhgeevfefhhfffhedvtddvtefgleevueeukeekteevgfdtgfffvdfhgeevnecuffhomhgrihhnpehrvghmlhgrsgdrnhgvthenucfkphepuddvjedrtddrtddruddpkeejrdelvddrudelgedrkeekpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le torstaina 6. heinäkuuta 2023, 6.30.18 EEST Charlie Jenkins a écrit :
> Using vendor extensions in hwprobe, add the ability to query if the
> 0.7.1 vector extension is available. It is determined to be available
> only if the kernel is compiled with vector support, and the user is
> using the c906.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.vendor                       | 11 +++++++++++
>  arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
>  arch/riscv/kernel/sys_riscv.c                   | 20 ++++++++++++++++++++
>  arch/riscv/vendor_extensions/Makefile           |  2 ++
>  arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
>  arch/riscv/vendor_extensions/thead/extensions.c | 24
> ++++++++++++++++++++++++ 6 files changed, 81 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> index 213ac3e6fed5..b8b9d15153eb 100644
> --- a/arch/riscv/Kconfig.vendor
> +++ b/arch/riscv/Kconfig.vendor
> @@ -1,3 +1,14 @@
>  menu "Vendor extensions selection"
> 
> +config VENDOR_EXTENSIONS_THEAD
> +	bool "T-HEAD vendor extensions"
> +	depends on RISCV_ALTERNATIVE
> +	default n
> +	help
> +	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. 
Disabling
> +	  this Kconfig will disable all T-HEAD vendor extensions. Please say 
"Y"
> +	  here if your platform uses T-HEAD vendor extensions.
> +
> +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> +
>  endmenu # "Vendor extensions selection"
> diff --git a/arch/riscv/include/asm/extensions.h
> b/arch/riscv/include/asm/extensions.h new file mode 100644
> index 000000000000..27ce294a3d65
> --- /dev/null
> +++ b/arch/riscv/include/asm/extensions.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 by Rivos Inc.
> + */
> +#ifndef __ASM_EXTENSIONS_H
> +#define __ASM_EXTENSIONS_H
> +
> +#include <asm/hwprobe.h>
> +#include <linux/cpumask.h>
> +
> +#define THEAD_ISA_EXT0 (RISCV_HWPROBE_VENDOR_EXTENSION_SPACE)
> +#define THEAD_ISA_EXT0_V0_7_1 (1 << 0)
> +
> +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> +		  const struct cpumask *cpus);
> +#endif
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 2351a5f7b8b1..58b12eaeaf46 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -13,6 +13,7 @@
>  #include <asm/vector.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> +#include <asm/extensions.h>
>  #include <asm/unistd.h>
>  #include <asm-generic/mman-common.h>
>  #include <vdso/vsyscall.h>
> @@ -192,6 +193,25 @@ static int hwprobe_vendor(__u64 mvendorid, struct
> riscv_hwprobe *pair, const struct cpumask *cpus)
>  {
>  	switch (mvendorid) {
> +#ifdef CONFIG_VENDOR_EXTENSIONS_THEAD
> +	case THEAD_VENDOR_ID:
> +		struct riscv_hwprobe marchid = {
> +			.key = RISCV_HWPROBE_KEY_MARCHID,
> +			.value = 0
> +		};
> +		struct riscv_hwprobe mimpid = {
> +			.key = RISCV_HWPROBE_KEY_MIMPID,
> +			.value = 0
> +		};
> +
> +		hwprobe_arch_id(&marchid, cpus);
> +		hwprobe_arch_id(&mimpid, cpus);
> +		if (marchid.value != -1ULL && mimpid.value != -1ULL)
> +			hwprobe_thead(marchid.value, mimpid.value, 
pair, cpus);
> +		else
> +			return -1;
> +		break;
> +#endif
>  	default:
>  		return -1;
>  	}
> diff --git a/arch/riscv/vendor_extensions/Makefile
> b/arch/riscv/vendor_extensions/Makefile index e815895e9372..38c3e80469fd
> 100644
> --- a/arch/riscv/vendor_extensions/Makefile
> +++ b/arch/riscv/vendor_extensions/Makefile
> @@ -1,3 +1,5 @@
>  ifdef CONFIG_RELOCATABLE
>  KBUILD_CFLAGS += -fno-pie
>  endif
> +
> +obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) += thead/
> diff --git a/arch/riscv/vendor_extensions/thead/Makefile
> b/arch/riscv/vendor_extensions/thead/Makefile new file mode 100644
> index 000000000000..7cf43c629b66
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/thead/Makefile
> @@ -0,0 +1,8 @@
> +ifdef CONFIG_FTRACE
> +CFLAGS_REMOVE_extensions.o = $(CC_FLAGS_FTRACE)
> +endif
> +ifdef CONFIG_KASAN
> +KASAN_SANITIZE_extensions.o := n
> +endif
> +
> +obj-y += extensions.o
> diff --git a/arch/riscv/vendor_extensions/thead/extensions.c
> b/arch/riscv/vendor_extensions/thead/extensions.c new file mode 100644
> index 000000000000..a177501bc99c
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/thead/extensions.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 by Rivos Inc.
> + */
> +
> +#include <asm/extensions.h>
> +
> +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> +		  const struct cpumask *cpus)
> +{
> +	pair->value = 0;
> +	switch (pair->key) {
> +	case THEAD_ISA_EXT0:
> +#ifdef CONFIG_RISCV_ISA_V
> +		if (marchid == 0 && mimpid == 0)
> +			pair->value |= THEAD_ISA_EXT0_V0_7_1;

I'm not sure I follow the code, but exposing an extension to userspace that 
the kernel does not handle is a bad idea. AFAIK, the initialisation and 
context switching code must be in place first.

And I don't suppose that this can *simply* piggy-back on the existing RVV 
1.0.0 support, because user-space  assumes 1.0.0-compliant behaviour if the 
existing vector flag is set in hwprobe().

Indeed, I recall somebody else posted a recent patchset ostensibly with the 
same goal that was a lot more involved than this.

> +#endif
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return 0;
> +}


-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/



