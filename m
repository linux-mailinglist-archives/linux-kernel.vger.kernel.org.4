Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C66660FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjAKQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjAKQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:54:18 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733F140F9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:54:16 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:40424)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pFeMe-00AaJZ-9n; Wed, 11 Jan 2023 09:54:12 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:35842 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pFeMc-00Btqi-O7; Wed, 11 Jan 2023 09:54:11 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
Date:   Wed, 11 Jan 2023 10:53:43 -0600
In-Reply-To: <20230110201841.2069353-1-vineetg@rivosinc.com> (Vineet Gupta's
        message of "Tue, 10 Jan 2023 12:18:41 -0800")
Message-ID: <87tu0xko6g.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pFeMc-00Btqi-O7;;;mid=<87tu0xko6g.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+fwyd9BlePvUBxqwyPNTq7xFHkSxOf+m8=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Vineet Gupta <vineetg@rivosinc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 980 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.4%), b_tie_ro: 2.8 (0.3%), parse: 0.84
        (0.1%), extract_message_metadata: 14 (1.4%), get_uri_detail_list: 2.4
        (0.2%), tests_pri_-2000: 4.4 (0.4%), tests_pri_-1000: 1.85 (0.2%),
        tests_pri_-950: 0.98 (0.1%), tests_pri_-900: 0.77 (0.1%),
        tests_pri_-200: 0.64 (0.1%), tests_pri_-100: 10 (1.0%), tests_pri_-90:
        210 (21.4%), check_bayes: 194 (19.8%), b_tokenize: 10 (1.0%),
        b_tok_get_all: 11 (1.1%), b_comp_prob: 2.2 (0.2%), b_tok_touch_all:
        166 (17.0%), b_finish: 0.68 (0.1%), tests_pri_0: 490 (50.0%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 6 (0.6%),
        poll_dns_idle: 227 (23.1%), tests_pri_10: 2.5 (0.3%), tests_pri_500:
        237 (24.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineet Gupta <vineetg@rivosinc.com> writes:

> This implements the elf loader hook to parse RV specific
> .riscv.attributes section. This section is inserted by compilers
> (gcc/llvm) with build related information such as -march organized as
> tag/value attribute pairs.
>
> It identifies the various attribute tags (and corresponding values) as
> currently specified in the psABI specification.
>
> This patch only implements the elf parsing mechanics, leaving out the
> recording/usage of the attributes to subsequent patches.

Why does the kernel care?

Unless I am mistaken the kind of information you are describing is
typically dealt with by the dynamic linker, rather than the kernel.

As a general strategy I think it is smart to leave as much to
userspace and the dynamic linker and possible intead of asking
the kernel's elf loader to care.  That allows more rapid
prototyping and reduces the impact of parsing bugs.

Eric



> Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_COMPAT
> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
> ---
>  arch/riscv/Kconfig           |   1 +
>  arch/riscv/include/asm/elf.h |  11 +++
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/elf-attr.c | 150 +++++++++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
>  create mode 100644 arch/riscv/kernel/elf-attr.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..f7e0ab05a2d2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,6 +12,7 @@ config 32BIT
>  
>  config RISCV
>  	def_bool y
> +	select ARCH_BINFMT_ELF_STATE
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index e7acffdf21d2..7ab8bd0ec330 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -116,6 +116,17 @@ do {							\
>  		*(struct user_regs_struct *)regs;	\
>  } while (0);
>  
> +struct arch_elf_state {
> +};
> +
> +#define INIT_ARCH_ELF_STATE {}
> +
> +extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
> +			    bool is_interp, struct arch_elf_state *state);
> +
> +extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
> +			  struct arch_elf_state *state);
> +
>  #ifdef CONFIG_COMPAT
>  
>  #define SET_PERSONALITY(ex)					\
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..eff6d845ac9d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y	+= riscv_ksyms.o
>  obj-y	+= stacktrace.o
>  obj-y	+= cacheinfo.o
>  obj-y	+= patch.o
> +obj-y	+= elf-attr.o
>  obj-y	+= probes/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
> diff --git a/arch/riscv/kernel/elf-attr.c b/arch/riscv/kernel/elf-attr.c
> new file mode 100644
> index 000000000000..148d720f97de
> --- /dev/null
> +++ b/arch/riscv/kernel/elf-attr.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-24 Rivos Inc.
> + */
> +
> +#include <linux/binfmts.h>
> +#include <linux/elf.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "rv-elf-attr: " fmt
> +
> +#define PT_RISCV_ATTRIBUTES		0x70000003
> +
> +#define RV_ATTR_TAG_stack_align		4
> +#define RV_ATTR_TAG_arch		5
> +#define RV_ATTR_TAG_unaligned_access	6
> +
> +#define RV_ATTR_SEC_SZ			SZ_1K
> +
> +static void rv_elf_attr_int(u64 tag, u64 val)
> +{
> +}
> +
> +static void rv_elf_attr_str(u64 tag, const char *str)
> +{
> +}
> +
> +static u64
> +decode_uleb128(unsigned char **dpp)
> +{
> +	unsigned char *bp = *dpp;
> +	unsigned char byte;
> +	unsigned int shift = 0;
> +	u64 result = 0;
> +
> +	while (1) {
> +		byte = *bp++;
> +		result |= (byte & 0x7f) << shift;
> +		if ((byte & 0x80) == 0)
> +			break;
> +		shift += 7;
> +	}
> +	*dpp = bp;
> +	return result;
> +}
> +
> +/*
> + * Parse .riscv.attributes elf section to get the various compile time
> + * attributes such as -march, unaligned access and so no.
> + */
> +static int rv_parse_elf_attributes(struct file *f, const struct elf_phdr *phdr,
> +				   struct arch_elf_state *state)
> +{
> +	unsigned char buf[RV_ATTR_SEC_SZ];
> +	unsigned char *p;
> +	ssize_t n;
> +	int ret = 0;
> +	loff_t pos;
> +
> +	pr_debug("Section .riscv.attributes found\n");
> +
> +	/* Assume a reasonable size for now */
> +	if (phdr->p_filesz > sizeof(buf))
> +		return -ENOEXEC;
> +
> +	memset(buf, 0, RV_ATTR_SEC_SZ);
> +	pos = phdr->p_offset;
> +	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
> +
> +	if (n < 0)
> +		return -EIO;
> +
> +	p = buf;
> +	p++;				/* format-version (1B) */
> +
> +	while ((p - buf) < n) {
> +
> +		unsigned char *vendor_start;
> +		u32 len;
> +
> +		/*
> +		 * Organized as "vendor" sub-section(s).
> +		 * Current only 1 specified "riscv"
> +		 */
> +
> +		p += 4;			/* sub-section length (4B) */
> +		while (*p++ != '\0')	/* vendor name string */
> +			;
> +		p++;			/* Tag_File (1B) */
> +		len = *(u32 *)p;	/* data length (4B) */
> +		p += 4;
> +
> +		len -= 5;		/* data length includes Tag and self length */
> +		vendor_start = p;
> +		while ((p - vendor_start) < len) {
> +
> +			u64 tag = decode_uleb128(&p);
> +			unsigned char *val_str;
> +			u64 val_n;
> +
> +			switch (tag) {
> +			case RV_ATTR_TAG_stack_align:
> +				val_n = decode_uleb128(&p);
> +				break;
> +
> +			case RV_ATTR_TAG_unaligned_access:
> +				val_n = decode_uleb128(&p);
> +				pr_debug("Tag_RISCV_unaligned_access =%llu\n", val_n);
> +				rv_elf_attr_int(tag, val_n);
> +				break;
> +
> +			case RV_ATTR_TAG_arch:
> +				val_str = p;
> +				while (*p++ != '\0')
> +					;
> +				pr_debug("Tag_RISCV_arch =[%s]\n", val_str);
> +				rv_elf_attr_str(tag, val_str);
> +				break;
> +
> +			default:
> +				val_n = decode_uleb128(&p);
> +				pr_debug("skipping Unrecognized Tag [%llu]=%llu\n", tag, val_n);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Hook invoked from common elf loader to parse any arch specific elf segments
> + */
> +int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
> +		     bool is_interp, struct arch_elf_state *state)
> +{
> +	struct elf_phdr *phdr = _phdr;
> +	int ret = 0;
> +
> +	if (phdr->p_type == PT_RISCV_ATTRIBUTES && !is_interp)
> +		ret = rv_parse_elf_attributes(elf, phdr, state);
> +
> +	return ret;
> +}
> +
> +int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
> +		   struct arch_elf_state *state)
> +{
> +	return 0;
> +}
