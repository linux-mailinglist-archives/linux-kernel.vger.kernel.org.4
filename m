Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206816A02DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjBWGjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjBWGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:39:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB38A70
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:39:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so2182328wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qJ08paylLYIpqZj393DmlSgJI28b+LXoVSY+XPXR6Y=;
        b=aNaEmU0DREawGVFKaoJfBwUg8Cffu4p849yPLvioJyUCaf/whgBgTx3l5yN8bXrpwi
         HFIkM8WCQfOyulxB9851almxVn6JB6DSgq15oSXj6R6NxmrOdS1sFI65tnzIs1VjSVmY
         r7FIoplPw8BIiD6WRZHGeMqYmypUeODn4bZEj8RmTUVVoTXQ3l+qm+uKTZ2wK7FydrQc
         dSRSEPcwE/8m+ACaDTUNe87nlZgJON7DBnDvnRMCnQ8hijxqPEJgz5PoYFHCkCeySo7S
         FKjoydiF4SUE8PGwEuhQAqVjhsFA39NEsjv2vp5T++gSKz7xOhQBQOhsRCnTWVDuSQ/d
         914Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qJ08paylLYIpqZj393DmlSgJI28b+LXoVSY+XPXR6Y=;
        b=gMk439lU2AcLoFcKUacYJw/HnyXJ6xtWNY4mJVixEZwwjtXCV/diTVqz7H0YUmGwvc
         xgzw1MjrrXa8yySQGy9bAeNP5uK+RM0zWHxAJAci97dp9Akx0UigrFCz1nA9E2dAqPsP
         gcilWcr7kfxcowKtr8hxUauqE/iOANx14mrF4bHxqlImsYz/AJ3a+xl88Po/XcBBcuWT
         IxW1BbbHjOcrNENjZX2ZWSmmjOnJYGglfQ9vLPuRA7vhCzH5NQgizDs0Nq4/7tuzLAgK
         RACWnqTGJi639LvUAjbwdf0Qr8S2nZLLoBRynUQFp9oh+PffrSTnfPfeubE9HPMIb511
         9PHw==
X-Gm-Message-State: AO0yUKUTRzb6Aj46DJEzEAQSt6YZWK49G/DPryqNm6NiL8Qg7iLFgc3W
        OAyW/OEd2wTqDjT+F7vhXJKK3Q==
X-Google-Smtp-Source: AK7set+OyPmjzGSDtb2O9PRYc5Lj9qVUcLm41Pwwe3M9MYNOoFahuQG4yXNkLZOpG67Uz2iNkaFmKQ==
X-Received: by 2002:a05:600c:13c3:b0:3e0:39:ec9d with SMTP id e3-20020a05600c13c300b003e00039ec9dmr8906162wmg.23.1677134378051;
        Wed, 22 Feb 2023 22:39:38 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003e206cc7237sm11428892wms.24.2023.02.22.22.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:39:37 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:39:36 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/4] RISC-V: Change suspend_save_csrs and
 suspend_restore_csrs to public function
Message-ID: <20230223063936.6tsqh57lom3tvjxo@orel>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-2-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221023523.1498500-2-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:35:20AM +0800, Sia Jee Heng wrote:
> Currently suspend_save_csrs() and suspend_restore_csrs() functions are
> statically defined in the suspend.c. Change the function's attribute
> to public so that the functions can be used by hibernation as well.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/suspend.h | 3 +++
>  arch/riscv/kernel/suspend.c      | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 8be391c2aecb..75419c5ca272 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -33,4 +33,7 @@ int cpu_suspend(unsigned long arg,
>  /* Low-level CPU resume entry function */
>  int __cpu_resume_enter(unsigned long hartid, unsigned long context);
>  
> +/* Used to save and restore the csr */

s/the csr/CSRs/

> +void suspend_save_csrs(struct suspend_context *context);
> +void suspend_restore_csrs(struct suspend_context *context);
>  #endif
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 9ba24fb8cc93..3c89b8ec69c4 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -8,7 +8,7 @@
>  #include <asm/csr.h>
>  #include <asm/suspend.h>
>  
> -static void suspend_save_csrs(struct suspend_context *context)
> +void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
>  	context->tvec = csr_read(CSR_TVEC);
> @@ -29,7 +29,7 @@ static void suspend_save_csrs(struct suspend_context *context)
>  #endif
>  }
>  
> -static void suspend_restore_csrs(struct suspend_context *context)
> +void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
>  	csr_write(CSR_TVEC, context->tvec);
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
