Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC826A593E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1Mmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjB1Mmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:42:49 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EACB0301AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:42:47 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8AxII_G9v1jdncGAA--.6665S3;
        Tue, 28 Feb 2023 20:42:46 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxG77G9v1jPfVAAA--.49491S3;
        Tue, 28 Feb 2023 20:42:46 +0800 (CST)
Subject: Re: [PATCH v2 4/6] LoongArch: Drop pernode exception handlers
To:     Jinyang He <hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
 <20230228080257.28807-5-hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <2defcb38-91f5-78ec-0c78-766e4f2271d5@loongson.cn>
Date:   Tue, 28 Feb 2023 20:42:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230228080257.28807-5-hejinyang@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxG77G9v1jPfVAAA--.49491S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFykKr13ur1UWrWxGw43GFg_yoW8urWrpF
        9Fgr1qyr4xK3Wq93WDAayq9r17AFyvg3yxKws3KrWYqwn7Zr1fKr4vy3WqyF4rJ348XFsa
        gF1kAr15AF4UXwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bYkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCF
        FI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWlkUUU
        UU=
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2023 04:02 PM, Jinyang He wrote:

> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 8bad6b0cff59..dda35eae1c49 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -250,50 +250,10 @@ static void output_pgtable_bits_defines(void)
>  	pr_debug("\n");
>  }
>
> -#ifdef CONFIG_NUMA
> -unsigned long pcpu_handlers[NR_CPUS];
> -#endif
> -extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
> -
>  void setup_tlb_handler(int cpu)
It may be necessary to rename the function after modification.

Youling.
>  {
>  	setup_ptwalker();
>  	local_flush_tlb_all();
> -
> -	/* The tlb handlers are generated only once */
> -	if (cpu == 0) {
> -		memcpy((void *)tlbrentry, handle_tlb_refill, 0x80);
> -		local_flush_icache_range(tlbrentry, tlbrentry + 0x80);
> -		set_handler(EXCCODE_TLBI * VECSIZE, handle_tlb_load, VECSIZE);
> -		set_handler(EXCCODE_TLBL * VECSIZE, handle_tlb_load, VECSIZE);
> -		set_handler(EXCCODE_TLBS * VECSIZE, handle_tlb_store, VECSIZE);
> -		set_handler(EXCCODE_TLBM * VECSIZE, handle_tlb_modify, VECSIZE);
> -		set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, VECSIZE);
> -		set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, VECSIZE);
> -		set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, VECSIZE);
> -	}
> -#ifdef CONFIG_NUMA
> -	else {
> -		void *addr;
> -		struct page *page;
> -		const int vec_sz = sizeof(exception_handlers);
> -
> -		if (pcpu_handlers[cpu])
> -			return;
> -
> -		page = alloc_pages_node(cpu_to_node(cpu), GFP_ATOMIC, get_order(vec_sz));
> -		if (!page)
> -			return;
> -
> -		addr = page_address(page);
> -		pcpu_handlers[cpu] = (unsigned long)addr;
> -		memcpy((void *)addr, (void *)eentry, vec_sz);
> -		local_flush_icache_range((unsigned long)addr, (unsigned long)addr + vec_sz);
> -		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
> -		csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
> -		csr_write64(pcpu_handlers[cpu] + 80*VECSIZE, LOONGARCH_CSR_TLBRENTRY);
> -	}
> -#endif
>  }
>

