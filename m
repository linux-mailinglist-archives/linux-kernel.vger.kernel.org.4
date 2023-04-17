Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7386E3D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQCEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQCEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:04:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561D72126
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:04:06 -0700 (PDT)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxJ_AUqTxkbLkdAA--.46251S3;
        Mon, 17 Apr 2023 10:04:04 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxC74SqTxkFD4qAA--.49428S3;
        Mon, 17 Apr 2023 10:04:03 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: Add uprobes support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1681464781-4428-1-git-send-email-yangtiezhu@loongson.cn>
 <1681464781-4428-5-git-send-email-yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <26d4d13f-d678-be54-6b40-b87c71856eff@loongson.cn>
Date:   Mon, 17 Apr 2023 10:04:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1681464781-4428-5-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxC74SqTxkFD4qAA--.49428S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF4kCr4UKw4rKrWUKw17KFg_yoW8Ar48pa
        yDCFy8GFs7GFn5AFyUJayv9F1Iqr9Y9a1xK3sFkayrCF4avws5Wrykury7XayUA390qrW0
        gFy8tanYvFZ0vF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b2kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF
        6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8V
        WrMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRihFxUUUUUU==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu

On 04/14/2023 05:33 PM, Tiezhu Yang wrote:

/* snip */

> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index de8ebe2..cfc2e0c 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -45,6 +45,7 @@
>  #include <asm/tlb.h>
>  #include <asm/types.h>
>  #include <asm/unwind.h>
> +#include <asm/uprobes.h>
>
>  #include "access-helper.h"
>
> @@ -440,7 +441,6 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>  	if (regs->csr_prmd & CSR_PRMD_PIE)
>  		local_irq_enable();
>
> -	current->thread.trap_nr = read_csr_excode();
>  	if (__get_inst(&opcode, (u32 *)era, user))
>  		goto out_sigsegv;
>
> @@ -462,18 +462,17 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>  		else
>  			break;
>  	case BRK_UPROBE_BP:
> -		if (notify_die(DIE_UPROBE, "Uprobe", regs, bcode,
> -			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
> +		if (uprobe_breakpoint_handler(regs))
>  			goto out;
>  		else
>  			break;
>  	case BRK_UPROBE_XOLBP:
> -		if (notify_die(DIE_UPROBE_XOL, "Uprobe_XOL", regs, bcode,
> -			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
> +		if (uprobe_singlestep_handler(regs))

After the above modification, we should remove the DIE_UPROBE and
DIE_UPROBE_XOL definitions in arch/loongarch/include/asm/kdebug.h.

At the same time DIE_BREAK, DIE_SSTEPBP and DIE_PAGE_FAULT also need to
be removed after 6d4cc40fb5f581 ("LoongArch: Add kprobes support").

Thanks,
Youling
>  			goto out;
>  		else
>  			break;
>  	default:
> +		current->thread.trap_nr = read_csr_excode();
>  		if (notify_die(DIE_TRAP, "Break", regs, bcode,
>  			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
>  			goto out;

