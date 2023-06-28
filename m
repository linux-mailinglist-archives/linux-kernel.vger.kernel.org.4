Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3D74121A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF1NRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjF1NQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:16:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46545FC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:16:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-311394406d0so5276660f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958204; x=1690550204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8N+4fMqa0BCu62rjXxgXcpik2GdLjc+HJ9AxcsHedac=;
        b=npuFv+IaF9x3T+2zcY6/3A4C+TWRSpEhnn2ds0jlIo3hh5gtCh0GtE3ZoWP+itPjKs
         Mw59D6ZSTHEofHQLy8pOowg2y3xNn4gU4LN3n07aR5yiteBQUbwERO9WhA6kwdR7MlY4
         mSWkB5CbhtmA+n8h3WEGayQ3qMU28HW3P+OFI9xv7+T0pvqmV2VkM5f3UtUpUi7Mg0Ku
         ub+S2sBYSEgm+izHewWbYuTwlWMM31u+zBV5+tKcHpH9vZMBIqyLCfEaGitbAFDUcrFH
         MSSu07tjm7nI4cTCuxjiHeIswXoQuTGzgJ7aOct3uvrFTodaAHNRRrFuLmTlu+oR4A46
         wtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958204; x=1690550204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8N+4fMqa0BCu62rjXxgXcpik2GdLjc+HJ9AxcsHedac=;
        b=DKeB5pIztYMAhoE2fIkUs4V2XkxXCrO/AzSADdL3U7q3lLb9SRxBCQwIh4dstE570C
         FyszMNsqybUytvTBJIrEKArWyeDR/ii/Ck4e3+jDxnck8oZModtJ8lGNTtp1Kk/Cu3yw
         Nyroq5WM5+UzYU8wlU2Dzd4hIiQTVweGNZlw1bar8Y4f+yjGU/t4SPszSaJ22TF9TGdi
         EWoJuA8LOXUhsu3gghwDZPTPX9opOYxI+Ye2Dc+/hYqLcbGrk1Ul4vWaLIYt8XM3SdhL
         aJGQuzHm1FJg6PKYob1QO6PTK3EXyPaex9yj/cE77OM4rRO8Pc1QjxoPyEAFTQvmJzPK
         Uk3A==
X-Gm-Message-State: AC+VfDzatIqHoqatXgzUnFW9dwjp5/nQ/u0lvTVhBKEVD2Z6oqB7VpqR
        6XpJzEqsWIe+0FlXMkf9WmI=
X-Google-Smtp-Source: ACHHUZ7ZwofWVAJ0bsBYCKDZtz/Y7eSt6MRpEjnQLdCuYoGa4S8hTIEhfFUSziG4EvDizRoMskl60g==
X-Received: by 2002:a5d:4e4b:0:b0:312:74a9:8259 with SMTP id r11-20020a5d4e4b000000b0031274a98259mr19301077wrt.71.1687958203579;
        Wed, 28 Jun 2023 06:16:43 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7727:ec6a:e01a:66dd:ab98? ([2a10:bac0:b000:7727:ec6a:e01a:66dd:ab98])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b00313eeca9f4asm9752238wrt.14.2023.06.28.06.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:16:38 -0700 (PDT)
Message-ID: <75ea8257-cad1-418e-fd2a-329fd7b208ce@gmail.com>
Date:   Wed, 28 Jun 2023 16:16:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] x86: ia32.h: Remove unused code
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org
References: <20230625125411.25840-1-yuehaibing@huawei.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
In-Reply-To: <20230625125411.25840-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.06.23 г. 15:54 ч., YueHaibing wrote:
> Since commit 32974ad4907c ("[IA64] Remove COMPAT_IA32 support")
> IA32_STACK_TOP and ia32_setup_arg_pages() is not used anymore.
> And commit 675a0813609f ("x86: unify mmap_{32|64}.c") left behind
> ia32_pick_mmap_layout() extern declaration.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   arch/x86/include/asm/ia32.h | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index fada857f0a1e..68f7eefe63d3 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -57,17 +57,6 @@ struct stat64 {
>   	unsigned long long	st_ino;
>   } __attribute__((packed));
>   
> -#define IA32_STACK_TOP IA32_PAGE_OFFSET
> -
> -#ifdef __KERNEL__
> -struct linux_binprm;
> -extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
> -				unsigned long stack_top, int exec_stack);
> -struct mm_struct;
> -extern void ia32_pick_mmap_layout(struct mm_struct *mm);
> -
> -#endif
> -
>   #endif /* CONFIG_IA32_EMULATION */
>   
>   #endif /* _ASM_X86_IA32_H */


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

I've sent very similar patch (minus removal of IA32_STACK_TOP define) on 
12.06 - 
https://lore.kernel.org/all/20230612154438.638491-1-nik.borisov@suse.com/
