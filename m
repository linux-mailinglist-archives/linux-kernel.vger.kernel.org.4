Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26656291FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiKOGqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiKOGqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:46:05 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B61C912
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:46:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so33631293ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z333HxX5gPy9NORJdJPh5x75FiRSYhz5BQverCzuReI=;
        b=BYRZsjOI09drJblN+gA12cyZBzdAun4cC1h8zEf9GkrquLLMRX5ayWTEWN4Z57waV8
         fZTQI8SYKDcH1hwG/vI80csxKDACqnq9pIdyenEKFyszXO0zpb0aznjEeN6ATWrSJa5J
         39IjedjKi5vX+cqOPa1k62yXGUgoyfU99WawtDeq3GgUT2t+7TpHG0oTvg63Kw6gEHXj
         MZfj9iq2QZ2ZbDdllTg/xG5tohiRZ6eQMcKjlkqno0b/ChQAa6dzFQy56Ei8eSTnq9cS
         Q2bmrElYaYn1MRm7XA5m32U6IyixhXIfHbvstxc73nGgmt5e2/0WniuznEoG6gMZcoks
         C5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z333HxX5gPy9NORJdJPh5x75FiRSYhz5BQverCzuReI=;
        b=7bzF/RXaUNr3rvwWPALGlL+j6oOgF71Vzqohgz2JzbLBTHOM7ZnaLOPh61Ti+YvVeh
         hCmq3fhIOFlJhxyfkipGU+Zsc2sXAM33uX6xaF6iMDkFp3pqBxghloJXsPN9jyy1jK9b
         XMVNygeL7lqu34C6RRgVfjOazSsN2sB7wqUgAC+aWKfkqf+mlqQL/5DbJn5R7JeDmEUH
         zdX+je7cmI4PbZDK5r1IJPqMo2XsscjXnSu0rdH6ORyUyq1oONb31icU3aBt4i2HVVSM
         8a2YZ+jcnVMrUSCqSCMF8pfIAK6Wg2n0drLtzQCYHVUEFYdkPgwA/H1VqZCDYWYBLfjn
         5gkg==
X-Gm-Message-State: ANoB5pnZIMoQHlGpiES44ThJ7Mw2q3B+MpMEco7kbcs03TwqrLYLlbx5
        ddhPU+DSbmrxyDn8eYDhbkmNzw==
X-Google-Smtp-Source: AA0mqf4yokm7ojLEsAwKwb1SgOwx50ag245MHJ+A0ANJfRzFd5AidpHQIt6v3wBKwQUbXnMnqCZAug==
X-Received: by 2002:a17:906:ae8b:b0:7ad:9892:921a with SMTP id md11-20020a170906ae8b00b007ad9892921amr12324383ejb.506.1668494761825;
        Mon, 14 Nov 2022 22:46:01 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id k17-20020aa7c391000000b00467cc919072sm2809748edq.17.2022.11.14.22.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:46:01 -0800 (PST)
Date:   Tue, 15 Nov 2022 07:46:00 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     aou@eecs.berkeley.edu, jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v2] scripts/gdb: add lx_current support for riscv
Message-ID: <20221115064600.e6jzigbl23hwpuzi@kamzik>
References: <20221111195938.1499148-2-debug@rivosinc.com>
 <20221115012917.1781185-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115012917.1781185-1-debug@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:29:17PM -0800, Deepak Gupta wrote:
> csr_sscratch CSR holds current task_struct address when hart is in user space.
> trap handler on entry spills csr_sscratch into "tp" (x2) register and zeroes out
> csr_sscratch CSR. trap handler on exit reloads "tp" with expected user mode value
> and place current task_struct address again in csr_scratch CSR.
> 
> This patch assumes "tp" is pointing to task_struct. If value in csr_scratch is numerically
> greater than "tp" then it assumes csr_scratch is correct address of current task_struct.
> This logic holds when
>    - hart is in user space, "tp" will be less than csr_scratch.
>    - hart is in kernel space but not in trap handler, "tp" will be more than csr_scratch.
>    - hart is executing trap handler
>            - "tp" is still pointing to user mode but csr_scratch contains ptr to task_struct.
>              numerically higher.
>            - "tp" is now pointing to task_struct but csr_scratch now contains either 0 or numerically
>               smaller value.

When is (csr_scratch != 0 && csr_scratch < tp)? IIUC, it should always be
zero or >= tp.

> 
> Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py

Please wrap commit message lines at ~74.

> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
>  scripts/gdb/linux/utils.py |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..fd818d7896ce 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,21 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_tp = gdb.parse_and_eval("$tp")
> +         scratch_reg = gdb.parse_and_eval("$sscratch")
> +
> +         # by default tp points to current task
> +         current_task = current_tp.cast(task_ptr_type)
> +         
> +         # scratch register is set 0 in trap handler after entering kernel.
> +         # When hart is in user mode, scratch register is pointing to task_struct.
> +         # So when scratch register holds higher value (negative address as ulong is bigger value) than tp,

Please wrap source lines at 100.

> +         # then use scratch register
> +         if (scratch_reg.cast(utils.get_ulong_type()) >  current_tp.cast(utils.get_ulong_type())):
                                                          ^ extra space here

> +             current_task = scratch_reg.cast(task_ptr_type)
> +             
> +         return current_task.dereference()
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index 1553f68716cc..ddaf3089170d 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -35,12 +35,17 @@ class CachedType:
>  
>  
>  long_type = CachedType("long")
> +ulong_type = CachedType("ulong")
>  atomic_long_type = CachedType("atomic_long_t")
>  
>  def get_long_type():
>      global long_type
>      return long_type.get_type()
>  
> +def get_ulong_type():
> +    global ulong_type
> +    return ulong_type.get_type()
> +
>  def offset_of(typeobj, field):
>      element = gdb.Value(0).cast(typeobj)
>      return int(str(element[field].address).split()[0], 16)
> -- 
> 2.25.1
>

Besides the line wrapping and the commit message clarification this looks
good to me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
