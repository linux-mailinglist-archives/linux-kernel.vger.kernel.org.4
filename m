Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8574A248
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGFQgt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:36:48 -0400
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net [46.105.56.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E0183
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:36:45 -0700 (PDT)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.109.138.183])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id B4C7527FF9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 16:29:41 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wpskd (unknown [10.110.115.224])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 46DFD1FD48;
        Thu,  6 Jul 2023 16:29:40 +0000 (UTC)
Received: from courmont.net ([37.59.142.108])
        by ghost-submission-6684bf9d7b-wpskd with ESMTPSA
        id aWRRK/TrpmQSVwEAjIW+zg
        (envelope-from <remi@remlab.net>); Thu, 06 Jul 2023 16:29:40 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-108S002b99956f8-f89e-4d86-9669-24d14b05874b,
                    8891399453053EE55EDFED6858B7B4D362CEA829) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] RISC-V: Framework for vendor extensions
Date:   Thu, 06 Jul 2023 19:29:37 +0300
Message-ID: <5947209.lOV4Wx5bFT@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-1-ad6915349c4d@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 17002495969472879067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudelgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnhepffegtdfhgeevfefhhfffhedvtddvtefgleevueeukeekteevgfdtgfffvdfhgeevnecuffhomhgrihhnpehrvghmlhgrsgdrnhgvthenucfkphepuddvjedrtddrtddruddpkeejrdelvddrudelgedrkeekpdefjedrheelrddugedvrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgvmhhisehrvghmlhgrsgdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le torstaina 6. heinäkuuta 2023, 6.30.17 EEST Charlie Jenkins a écrit :
> Create Kconfig files, Makefiles, and functions to enable vendors to
> provide information via the riscv_hwprobe syscall about which vendor
> extensions are available.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kbuild                     |  1 +
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/Kconfig.vendor             |  3 +++
>  arch/riscv/include/asm/hwprobe.h      |  1 +
>  arch/riscv/kernel/sys_riscv.c         | 40
> ++++++++++++++++++++++++++++++++--- arch/riscv/vendor_extensions/Makefile |
>  3 +++
>  6 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index afa83e307a2e..bea38010d9db 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -3,6 +3,7 @@
>  obj-y += kernel/ mm/ net/
>  obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
>  obj-y += errata/
> +obj-y += vendor_extensions/
>  obj-$(CONFIG_KVM) += kvm/
> 
>  obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c1505c7729ec..19404ede0ee3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -276,6 +276,7 @@ config AS_HAS_OPTION_ARCH
> 
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.errata"
> +source "arch/riscv/Kconfig.vendor"
> 
>  menu "Platform type"
> 
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..213ac3e6fed5
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,3 @@
> +menu "Vendor extensions selection"
> +
> +endmenu # "Vendor extensions selection"
> diff --git a/arch/riscv/include/asm/hwprobe.h
> b/arch/riscv/include/asm/hwprobe.h index 78936f4ff513..fadb38b83243 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -9,5 +9,6 @@
>  #include <uapi/asm/hwprobe.h>
> 
>  #define RISCV_HWPROBE_MAX_KEY 5
> +#define RISCV_HWPROBE_VENDOR_EXTENSION_SPACE (UL(1)<<63)

Isn't this UB on 32-bit RISC-V ?

> 
>  #endif
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 26ef5526bfb4..2351a5f7b8b1 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -188,9 +188,35 @@ static u64 hwprobe_misaligned(const struct cpumask
> *cpus) return perf;
>  }
> 
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
> +	if (((unsigned long) pair->key) >= 
RISCV_HWPROBE_VENDOR_EXTENSION_SPACE) {
> +		struct riscv_hwprobe mvendorid = {
> +			.key = RISCV_HWPROBE_KEY_MVENDORID,
> +			.value = 0
> +		};
> +
> +		hwprobe_arch_id(&mvendorid, cpus);
> +		if (mvendorid.value != -1ULL)
> +			err = hwprobe_vendor(mvendorid.value, pair, 
cpus);
> +		else
> +			err = -1;
> +	}
> +
>  	switch (pair->key) {
>  	case RISCV_HWPROBE_KEY_MVENDORID:
>  	case RISCV_HWPROBE_KEY_MARCHID:
> @@ -217,13 +243,21 @@ static void hwprobe_one_pair(struct riscv_hwprobe
> *pair,
> 
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> -	 * call, but get their element key set to -1 and value set to 0
> -	 * indicating they're unrecognized.
> +	 * call, instead an error is raised to indicate the element key
> +	 * is unrecognized.
>  	 */
>  	default:
> +		err = -1;
> +		break;
> +	}
> +
> +	/*
> +	 * Setting the element key to -1 and value to 0 indicates that
> +	 * hwprobe was unable to find the requested key.
> +	 */
> +	if (err != 0) {
>  		pair->key = -1;
>  		pair->value = 0;
> -		break;
>  	}
>  }
> 
> diff --git a/arch/riscv/vendor_extensions/Makefile
> b/arch/riscv/vendor_extensions/Makefile new file mode 100644
> index 000000000000..e815895e9372
> --- /dev/null
> +++ b/arch/riscv/vendor_extensions/Makefile
> @@ -0,0 +1,3 @@
> +ifdef CONFIG_RELOCATABLE
> +KBUILD_CFLAGS += -fno-pie
> +endif


-- 
レミ・デニ-クールモン
http://www.remlab.net/



