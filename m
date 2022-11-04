Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAED618FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKDFNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKDFNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:13:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A827FDC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:13:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g62so3551070pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQhQGhyhGquSofm52cjAAkU6Fzx8FE6v+R8p+O6DonQ=;
        b=cJgBTj5+VK2r4tr77YFAeNubKerNgFNWlQq2YZIN7dm5oQ2/r9sUKFEBmmcFYNq2pG
         diq3eRTq7fNDrxAHCvG31SylCqlRYRVgWOkaP3gzTvhdm0nXKhj7ytcnnQQ4EOKUsSDu
         P4lTdlKb4bWwfOYzAm7jYbSoGnBcpJQdskxf/dqmfr7Hqgg1j0lfE5g2TuF9YMq+Ljbq
         MrbtXTUjNAPXJGuy7pxIZqpymM/h9WQoANH8djkBV67Awn2HSScsZp3CXEJuUxYpsrv/
         HRrC9mVhph5jRF75AT+/Px0sXAloN9Fi1NtO0u2gHqCRny5D8PKCevmfj7fYQSPkpFdD
         EoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQhQGhyhGquSofm52cjAAkU6Fzx8FE6v+R8p+O6DonQ=;
        b=oLz7f2SoYGtxEPb2xwolT/FLNGG5F8QiHQOSv7XWP2OvheqfpQarTlaS1joIE/iy24
         t4FUXeLfTAWVSFLP9zbgSYCt97SQaF4e8IuTpH9301UNN4b3MJvkqQWK7XhmsyoztuTA
         pedLqNSXMg2fi68uVqhVVYuQaZ12z2s/qrsJAlJ6QLOaee5V7VJHVr2wCbn7iWXFiyJE
         gXVgot39vQmyzQiYqssjw8agJMlTzx42kpBwRim2i6f4eSrqm36jGEBBhenHeHstleoJ
         RJF8bRWsUq7F9OaMnT+7ffIoRL6oaCxoNLqH661QrbSKtXITeJnYgcJACm1RWSa3u3o5
         b28A==
X-Gm-Message-State: ACrzQf0jZQG8nnIW8wjadVO6M0FeexBcfNMQlSLzyJFuTi2h8G5B1LUt
        R3LaAiVE/Fcf6ssYu9HvLujqkw==
X-Google-Smtp-Source: AMsMyM4CyTZNCkRG3R9ouuVtH4B+s5xPrYGR2coHQzAUQpnyFNaXjJqXDJOxwdFboWeApUXZ95VUqA==
X-Received: by 2002:a05:6a00:4206:b0:56c:2e49:ca0d with SMTP id cd6-20020a056a00420600b0056c2e49ca0dmr34132547pfb.22.1667538787394;
        Thu, 03 Nov 2022 22:13:07 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00186cf82717fsm1578086plk.165.2022.11.03.22.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 22:13:06 -0700 (PDT)
Message-ID: <784babf1-ca2b-0a7e-7bdb-c767304c3dd5@rivosinc.com>
Date:   Thu, 3 Nov 2022 22:13:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 07/17] riscv: Add vector struct and assembler
 definitions
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-7-stillson@rivosinc.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20220921214439.1491510-7-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 14:43, Chris Stillson wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> Add vector state context struct in struct thread and asm-offsets.c
> definitions.
> 
> The vector registers will be saved in datap pointer of __riscv_v_state. It
> will be dynamically allocated in kernel space. It will be put right after
> the __riscv_v_state data structure in user space.

"Vector state includes vector reg file and additional dynamic 
configuration CSRs. To handle variable sized reg file context (due to 
implementation defined ref size) and to enable lazy-allocation of this, 
there's datap which points to appropriate location on user/kernel mode 
stack as relevant..."

Something like above.

> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 19eedd4af4cd..95917a2b24f9 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -39,6 +39,7 @@ struct thread_struct {
>   	unsigned long s[12];	/* s[0]: frame pointer */
>   	struct __riscv_d_ext_state fstate;
>   	unsigned long bad_cause;
> +	struct __riscv_v_state vstate;

I think this patch should be preparatory, don't wire up the vstate in 
thread_struct now. Only do it when the save/restore calls are wired up 
in low level code.


> +struct __riscv_v_state {
> +	unsigned long vstart;
> +	unsigned long vl;
> +	unsigned long vtype;
> +	unsigned long vcsr;
> +	void *datap;
> +	/*
> +	 * In signal handler, datap will be set a correct user stack offset
> +	 * and vector registers will be copied to the address of datap
> +	 * pointer.
> +	 *
> +	 * In ptrace syscall, datap will be set to zero and the vector
> +	 * registers will be copied to the address right after this
> +	 * structure.
> +	 */

Nice.

>   
> +	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
> +	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
> +	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
> +	OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
> +	OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
> +

Ok.

Also move the __vstate_{save,restore} functions from patch 5/17 here.


