Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3936A593D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjB1Mmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjB1Mml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:42:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B31642FCCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:42:38 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8Axkk699v1jW3cGAA--.6658S3;
        Tue, 28 Feb 2023 20:42:37 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ7289v1jIPVAAA--.50084S3;
        Tue, 28 Feb 2023 20:42:37 +0800 (CST)
Subject: Re: [PATCH v2 3/6] LoongArch: Create a exception handlers section
To:     Jinyang He <hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
 <20230228080257.28807-4-hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <68036cab-e2f0-86b6-c26c-4bcd0716e554@loongson.cn>
Date:   Tue, 28 Feb 2023 20:42:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230228080257.28807-4-hejinyang@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxJ7289v1jIPVAAA--.50084S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw1xZw4fAw43Zr4ruw4xtFb_yoW8Xr4Dpr
        y2vrWkZr4DCFn8ZFyDZa1jvrWjv34Sgw43Gayaga48C3WavF109r4kAryDAanF9w1kXa18
        XF1rA3ySya45Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bYkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCF
        FI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
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

Hi, Jinyang

On 02/28/2023 04:02 PM, Jinyang He wrote:

> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index ad2ce1a0908e..e99b50359900 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -21,6 +21,11 @@
>   */
>  PECOFF_FILE_ALIGN = 0x200;
>  PECOFF_SEGMENT_ALIGN = 0x10000;
> +EX_HANDLER_ALIGN = SZ_512;
> +EX_HANDLER_SIZE = SZ_512;
> +EX_HANDLER_TOTAL = 78; /* 64 Exceptions + 14 Interrupts */

You can define EXCCODE_NUM as 78 in loongarch.h, and remove the unused
EXCCODE_INT_END and EXCCODE_INT_NUM in PATCH4.

Youling.

> +EXCEPTION_ENTRY_ALIGN = SZ_64K;
> +TLBR_ENTRY_ALIGN = SZ_4K;
>
>  OUTPUT_ARCH(loongarch)
>  ENTRY(kernel_entry)
> @@ -54,6 +59,17 @@ SECTIONS
>  	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>  	_etext = .;
>
> +	. = ALIGN(EXCEPTION_ENTRY_ALIGN);
> +	.ex_handlers : {
> +		__ex_handlers = .;
> +		*(SORT_BY_INIT_PRIORITY(.exception_handlers.*))
> +		. = ALIGN(EX_HANDLER_ALIGN);
> +		__ex_handlers_end = .;
> +		. = ALIGN(TLBR_ENTRY_ALIGN);
> +		__tlbr_entry = .;
> +		*(.tlbrhandler)
> +	}
> +
>  	/*
>  	 * struct alt_inst entries. From the header (alternative.h):
>  	 * "Alternative instructions for different CPU types or capabilities"
> @@ -154,3 +170,6 @@ SECTIONS
>  		*(.eh_frame)
>  	}
>  }
> +
> +ASSERT(__ex_handlers_end == (__ex_handlers + EX_HANDLER_SIZE * EX_HANDLER_TOTAL),
> +       "The amount of exception handlers does not match!");

