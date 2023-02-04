Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08268A8F1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 09:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjBDIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 03:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjBDIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 03:19:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A07237F18
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 00:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BRiVB63AftqDByLcZWZmN27G3XGOzdZCgH3vLdtLe1c=; b=IbLIpTy0sYpKObEm1t9HpNOkaa
        SNf/Fqio5rPxgYDKEsvZoHI+q7x+cKex5jyHVaGzWSldHz1oCk+fPTpGJAl19OzU+u17sVLwVC5v0
        CbVpaG9fKMRxTmHaTu4tvUi9IkefdUsuhDXJvt6rMWrPGpGTLhQJyEXffFPiHzraul6y+zfWFgqFe
        cg4zBnFUiUXc1fz62+5p01ViF7IM7+6fkdxYcZnxzhfKrXwnpuaKH55dtJqKIxlURE8WbxHy7SLmC
        lPXmPl0wz4hTdIoe8d39LDF2kLTiG07Cd8U+3IcKgsqTWcusa5Lwr7Em34H8vUDR9HTowXzo9UQp/
        01gsV9Hg==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pODlm-004iCX-RO; Sat, 04 Feb 2023 08:19:34 +0000
Message-ID: <b1079e99-c7ae-71f1-d578-80270adf44e7@infradead.org>
Date:   Sat, 4 Feb 2023 00:19:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on
 ppc
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-16-sv@linux.ibm.com>
 <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/29/22 23:41, Christophe Leroy wrote:
> 
> 
> Le 29/08/2022 à 07:52, Sathvika Vasireddy a écrit :
>> This patch adds [stub] implementations for required
>> functions, inorder to enable objtool build on powerpc.
> 
> Not all powerpc it seems, see below
> 

When cross-compiling PPC32 (on x86_64), I get 3600+ of these:

/bin/sh: line 1: ./tools/objtool/objtool: No such file or directory
/bin/sh: line 1: ./tools/objtool/objtool: No such file or directory
/bin/sh: line 1: ./tools/objtool/objtool: No such file or directory

Is there some way that objtool should work when cross-compiling?

Thanks.

>>
>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
>> [Christophe Leroy: powerpc: Add missing asm/asm.h for objtool]
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/Kconfig                          |  1 +
>>   arch/powerpc/include/asm/asm.h                |  7 ++
>>   tools/objtool/arch/powerpc/Build              |  2 +
>>   tools/objtool/arch/powerpc/decode.c           | 74 +++++++++++++++++++
>>   .../arch/powerpc/include/arch/cfi_regs.h      | 11 +++
>>   tools/objtool/arch/powerpc/include/arch/elf.h |  8 ++
>>   .../arch/powerpc/include/arch/special.h       | 21 ++++++
>>   tools/objtool/arch/powerpc/special.c          | 19 +++++
>>   8 files changed, 143 insertions(+)
>>   create mode 100644 arch/powerpc/include/asm/asm.h
>>   create mode 100644 tools/objtool/arch/powerpc/Build
>>   create mode 100644 tools/objtool/arch/powerpc/decode.c
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/cfi_regs.h
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/elf.h
>>   create mode 100644 tools/objtool/arch/powerpc/include/arch/special.h
>>   create mode 100644 tools/objtool/arch/powerpc/special.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 4c466acdc70d..dc05cd23c233 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -237,6 +237,7 @@ config PPC
>>   	select HAVE_MOD_ARCH_SPECIFIC
>>   	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
>>   	select HAVE_OPTPROBES
>> +	select HAVE_OBJTOOL			if PPC32 || MPROFILE_KERNEL
> 
> Why restrict it to MPROFILE_KERNEL ? In your RFC it was for all PPC64.
> 
> Recent discussion on the list shows new problem with recordmcount, see 
> https://lore.kernel.org/all/MW5PR84MB184250EA1CAE04497C1E7CE9AB769@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/
> 
> Those ones are with ppc64 big endian, so objtool would be welcome here 
> as well.
> 
>>   	select HAVE_PERF_EVENTS
>>   	select HAVE_PERF_EVENTS_NMI		if PPC64
>>   	select HAVE_PERF_REGS
>> diff --git a/arch/powerpc/include/asm/asm.h b/arch/powerpc/include/asm/asm.h
>> new file mode 100644
>> index 000000000000..86f46b604e9a
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/asm.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_ASM_H
>> +#define _ASM_POWERPC_ASM_H
>> +
>> +#define _ASM_PTR	" .long "
>> +
>> +#endif /* _ASM_POWERPC_ASM_H */
>> diff --git a/tools/objtool/arch/powerpc/Build b/tools/objtool/arch/powerpc/Build
>> new file mode 100644
>> index 000000000000..d24d5636a5b8
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/Build
>> @@ -0,0 +1,2 @@
>> +objtool-y += decode.o
>> +objtool-y += special.o
>> diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
>> new file mode 100644
>> index 000000000000..8b6a14680da7
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/decode.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <objtool/check.h>
>> +#include <objtool/elf.h>
>> +#include <objtool/arch.h>
>> +#include <objtool/warn.h>
>> +#include <objtool/builtin.h>
>> +#include <objtool/endianness.h>
>> +
>> +unsigned long arch_dest_reloc_offset(int addend)
>> +{
>> +	return addend;
>> +}
>> +
>> +bool arch_callee_saved_reg(unsigned char reg)
>> +{
>> +	return false;
>> +}
>> +
>> +int arch_decode_hint_reg(u8 sp_reg, int *base)
>> +{
>> +	exit(-1);
>> +}
>> +
>> +const char *arch_nop_insn(int len)
>> +{
>> +	exit(-1);
>> +}
>> +
>> +const char *arch_ret_insn(int len)
>> +{
>> +	exit(-1);
>> +}
>> +
>> +int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
>> +			    unsigned long offset, unsigned int maxlen,
>> +			    unsigned int *len, enum insn_type *type,
>> +			    unsigned long *immediate,
>> +			    struct list_head *ops_list)
>> +{
>> +	u32 insn;
>> +
>> +	*immediate = 0;
>> +	insn = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
>> +	*len = 4;
>> +	*type = INSN_OTHER;
>> +
>> +	return 0;
>> +}
>> +
>> +unsigned long arch_jump_destination(struct instruction *insn)
>> +{
>> +	return insn->offset +  insn->immediate;
>> +}
>> +
>> +void arch_initial_func_cfi_state(struct cfi_init_state *state)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < CFI_NUM_REGS; i++) {
>> +		state->regs[i].base = CFI_UNDEFINED;
>> +		state->regs[i].offset = 0;
>> +	}
>> +
>> +	/* initial CFA (call frame address) */
>> +	state->cfa.base = CFI_SP;
>> +	state->cfa.offset = 0;
>> +
>> +	/* initial LR (return address) */
>> +	state->regs[CFI_RA].base = CFI_CFA;
>> +	state->regs[CFI_RA].offset = 0;
>> +}
>> diff --git a/tools/objtool/arch/powerpc/include/arch/cfi_regs.h b/tools/objtool/arch/powerpc/include/arch/cfi_regs.h
>> new file mode 100644
>> index 000000000000..59638ebeafc8
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/include/arch/cfi_regs.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef _OBJTOOL_CFI_REGS_H
>> +#define _OBJTOOL_CFI_REGS_H
>> +
>> +#define CFI_BP 1
>> +#define CFI_SP CFI_BP
>> +#define CFI_RA 32
>> +#define CFI_NUM_REGS 33
>> +
>> +#endif
>> diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
>> new file mode 100644
>> index 000000000000..3c8ebb7d2a6b
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/include/arch/elf.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef _OBJTOOL_ARCH_ELF
>> +#define _OBJTOOL_ARCH_ELF
>> +
>> +#define R_NONE R_PPC_NONE
>> +
>> +#endif /* _OBJTOOL_ARCH_ELF */
>> diff --git a/tools/objtool/arch/powerpc/include/arch/special.h b/tools/objtool/arch/powerpc/include/arch/special.h
>> new file mode 100644
>> index 000000000000..ffef9ada7133
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/include/arch/special.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef _PPC_ARCH_SPECIAL_H
>> +#define _PPC_ARCH_SPECIAL_H
>> +
>> +#define EX_ENTRY_SIZE 8
>> +#define EX_ORIG_OFFSET 0
>> +#define EX_NEW_OFFSET 4
>> +
>> +#define JUMP_ENTRY_SIZE 16
>> +#define JUMP_ORIG_OFFSET 0
>> +#define JUMP_NEW_OFFSET 4
>> +#define JUMP_KEY_OFFSET 8
>> +
>> +#define ALT_ENTRY_SIZE 12
>> +#define ALT_ORIG_OFFSET 0
>> +#define ALT_NEW_OFFSET 4
>> +#define ALT_FEATURE_OFFSET 8
>> +#define ALT_ORIG_LEN_OFFSET 10
>> +#define ALT_NEW_LEN_OFFSET 11
>> +
>> +#endif /* _PPC_ARCH_SPECIAL_H */
>> diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
>> new file mode 100644
>> index 000000000000..d33868147196
>> --- /dev/null
>> +++ b/tools/objtool/arch/powerpc/special.c
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include <string.h>
>> +#include <stdlib.h>
>> +#include <objtool/special.h>
>> +#include <objtool/builtin.h>
>> +
>> +
>> +bool arch_support_alt_relocation(struct special_alt *special_alt,
>> +				 struct instruction *insn,
>> +				 struct reloc *reloc)
>> +{
>> +	exit(-1);
>> +}
>> +
>> +struct reloc *arch_find_switch_table(struct objtool_file *file,
>> +				    struct instruction *insn)
>> +{
>> +	exit(-1);
>> +}

-- 
~Randy
