Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000F87271E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjFGWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjFGWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:43:27 -0400
X-Greylist: delayed 1555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 15:43:22 PDT
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49F1BDD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686177800;
        bh=cCAUrNmU+J815DYSZ5cktA1xY0j369ZobkcNeWzlNRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lEQB8zPBROkJdjQ9M/gpk/Y2vHdtl3Wz2G0Z7DGgPlJbhE/bBPek7Vbnh8FFy5GB5
         MeO+XkFLCUjUWmrNjoh6MCe4Zkvf+lwuP+ENI3ce72kjO0GuWqeOAoM/nUtB0JOm3V
         ak4sapX6BJb4z422KWz0s027AtPh/6/T0beyvW/s=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 45691E38; Thu, 08 Jun 2023 06:17:22 +0800
X-QQ-mid: xmsmtpt1686176242t9fsqhh9d
Message-ID: <tencent_79F42B5A66F98A65266F989EC9C86A69F005@qq.com>
X-QQ-XMAILINFO: M/KZc43Jb0t6fZLsxm96JoAJQZPFjaWS36XYe1dvHTvjmeJMArfgm0LyjcSCZv
         8tsaaiZE5Jo5PKS9RiucQ2gpPFKy/mLp0dKx8/g7g1K/19jUlopw1++CeQBrCcclgcld9Hl7mEuy
         PhLH6mWn21F4HTI1xhJa7W7kaZx6hir+HOBGvN/KulSLN118IlXeyNDBeSoufYu3FYb14aVZ4PGk
         /TG7YB4U/aCMp36XBkhHmG+Us8HqXImvf89UwfXFJZltnvaLshq/IMtA48MmV/L31c0HizgDBjPb
         jZnh7zgtS5wzKNg7e+l6c5DUP+jpTHlI07sd523vw76XAUgdV8VMK+0sN1YEFzHv5FHZwienqN7g
         Pleg/QpUgsxw+5Pifczx0wBbLcg0zmHuN45rlJ9IfkGtizP5WAYYISLQ196aOy0u0muiDPnLNK2P
         ViNFm3F87h8aUcmes9JhJK9dJkTvlBmbVe8VfATwX9KTq3oiMldHAadPlaMJsWmSCu1jnnVVf2qX
         YRwbnC1Q0JuyH6RQ+fY58Qwa4DTSAMia6WikMwGHOz0PIffK0iEd7OlM7eLTZPg0y/juMyKBSdKw
         ekZ+jkrM6jby/t73FKRkjTn2K8xTAy5+76GYGcclOu+XbAkUloNDDeEYUNJVNq0eAn0AWWTUXbF5
         3mmtvOoGtMFsa0ouAZbJsmSfe8j1xZev2sR5uFrbX1gYnwhL+8WbZOeeSuK1NSAcoAzm84wZBN81
         pea3xKqZz1MBpaHNYH2aXRDrXCyr9XzkFBkZWqcDoMGqUcWp3GJUXaEAYBkUbhZi+6W+kjjAfUDU
         YNgBInUWA+z3osMjmocBjsLfB1i9IeUWUnKz/N0YFGYqJSkEndWh1fwFD9GdG31kMSVsmaK7B+yh
         9xQUZTBEBCGlyfW3uX73h/BuCk8U7T1sH1+oTMG/HYJN7dlpJn6jD4duuSFQwsvSaVmPmtBtWJ8y
         CAUc6ZUEYYDjDFGPkjgw==
Date:   Thu, 8 Jun 2023 06:17:22 +0800
From:   Woody Zhang <woodylab@foxmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
X-OQ-MSGID: <ZIEB8ur8gRUcOmkF@dev>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607-jogging-grudging-70dede86bc53@spud>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

On Wed, Jun 07, 2023 at 07:17:28PM +0100, Conor Dooley wrote:
>+CC Alex, you should take a look at this patch.
>
>On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
>> It's possible that early_init_fdt_scan_reserved_mem() allocates memory
>> from memblock for dynamic reserved memory in `/reserved-memory` node.
>> Any fixed reservation must be done before that to avoid potential
>> conflicts.
>> 
>> Reserve the DTB in memblock just after early scanning it.
>
>The rationale makes sense to me, I am just wondering what compelling
>reason there is to move it away from the memblock_reserve()s for the
>initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
>should be the sufficient minimum & would keep things together.

IMO, moving it to parse_dtb() is more reasonable as early scanning and
reservation are both subject to DTB. It can also lower the risk to
mess up the sequence in the future. BTW, it's also invoked in
setup_machine_fdt() in arm64.

Thanks,
Woody

>
>Cheers,
>Conor.
>
>> 
>> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
>> ---
>>  arch/riscv/kernel/setup.c | 10 ++++++++++
>>  arch/riscv/mm/init.c      |  9 ---------
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 36b026057503..c147fa8da929 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/console.h>
>>  #include <linux/screen_info.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/libfdt.h>
>>  #include <linux/sched/task.h>
>>  #include <linux/smp.h>
>>  #include <linux/efi.h>
>> @@ -256,6 +257,15 @@ static void __init parse_dtb(void)
>>  		pr_err("No DTB passed to the kernel\n");
>>  	}
>>  
>> +	/*
>> +	 * If DTB is built in, no need to reserve its memblock.
>> +	 * Otherwise, do reserve it but avoid using
>> +	 * early_init_fdt_reserve_self() since __pa() does
>> +	 * not work for DTB pointers that are fixmap addresses
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>> +
>>  #ifdef CONFIG_CMDLINE_FORCE
>>  	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>>  	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index c6bb966e4123..f8c9a79acd94 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -254,15 +254,6 @@ static void __init setup_bootmem(void)
>>  	 */
>>  	early_init_fdt_scan_reserved_mem();
>>  
>> -	/*
>> -	 * If DTB is built in, no need to reserve its memblock.
>> -	 * Otherwise, do reserve it but avoid using
>> -	 * early_init_fdt_reserve_self() since __pa() does
>> -	 * not work for DTB pointers that are fixmap addresses
>> -	 */
>> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>> -
>>  	dma_contiguous_reserve(dma32_phys_limit);
>>  	if (IS_ENABLED(CONFIG_64BIT))
>>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>> -- 
>> 2.39.2
>> 


