Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06316FC30F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjEIJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjEIJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:48:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2DD9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:48:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f4b911570so869421966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683625714; x=1686217714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ssFb5TKrUxDuSwzgf3mFueyqkmtk+lVo5a7Efc/W2I=;
        b=ZN2Nc4KwU1Bj5BSAFhnaSB7vzpHs1RhygZN+XFGK6hQBeLnMiYwvwPAXnsYMiqJHcm
         p5Avtf3vt8Y4M1ljhuJY4Ln3gMYVG7jsegJ0RHNvxURf0hlpLwZueGcJGInAG8o/DEpx
         it6a0EUAy5fX5DjfyZ+qlO6ITrPw0whW+MWWfRWmNA+Rdx0XgpCVPzNndlG2EnyxycPT
         n/qx5p3EDi+udnGMqVQxfwTqIeuqo9wtrHkaGhTl36t8RDumMIFpAccz+H4xw3J0Xa4f
         tR5hRvEoLeSQd7RlB2rJF6Pz4xRdXkzxi/FXfrC0VcYNWsG1552WhKHK1SU8vXmFz6Vz
         VZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683625714; x=1686217714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ssFb5TKrUxDuSwzgf3mFueyqkmtk+lVo5a7Efc/W2I=;
        b=R9TBCwp4sB8wDLBGFOIyei3v5BqAW82SPxUbHBInCyX/pNY6/krKcMBToDvXJ8EUpf
         j3UdzxGGwmFedfnHMG+lKQNz9S59etH41GDmxKAUdMiFKZ5Oa757GGkApqe9DQAYhaEW
         Gvy8mx9TR4x4/Jfw7PlMTJKz8ZJ1QMJb1CZDpzR4eJkOu0AEB5S1KudnpkfPCxX0ZHON
         mr8cwt8/O+ON52yCVwCNI3OosYhuSzD5GAvoiAVqp5CzA4myHoLmY/zLmh6ez0J2tSR4
         VEx8X+oyHQGV72DRKhKVU/aMGCQ3v6VxWnTr67DPniUZAzcd2OwiwPit9hQgFu8xdrao
         dIKw==
X-Gm-Message-State: AC+VfDwl3HnNfwGVhckqAB74pDmWfN2KRS/M31OO1O8TDFIG1WWhG1Qt
        Gse3Np72BB4dLMuHCnrU30rr3Q==
X-Google-Smtp-Source: ACHHUZ4csAwN4H1Mldb1yqeubVyBLjLh5qJMfW88DpJJEltr6uvpRCkmVOXq0ie/fCZXpf1YLvGLNg==
X-Received: by 2002:a17:907:a01:b0:94a:5d5c:fe6f with SMTP id bb1-20020a1709070a0100b0094a5d5cfe6fmr10679597ejc.47.1683625714394;
        Tue, 09 May 2023 02:48:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id jx6-20020a170907760600b00958434d4ecesm1143737ejc.13.2023.05.09.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:48:34 -0700 (PDT)
Date:   Tue, 9 May 2023 11:48:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn,
        conor.dooley@microchip.com
Subject: Re: [PATCH 1/2] RISC-V: lib: Improve memset assembler formatting
Message-ID: <20230509-b76dc35d2a84d96806496c8e@orel>
References: <20230505-9ec599a36801972451e8b17f@orel>
 <20230509022207.3700-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509022207.3700-1-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:22:05AM +0800, zhangfei wrote:
> From: Andrew Jones <ajones@ventanamicro.com>
> 
> Aligning the first operand of each instructions with a tab is a
> typical style which improves readability. Apply it to memset.S.
> While there, we also make a small grammar change to a comment.
> 
> No functional change intended.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Please pick up Conor's r-b on this reposting.

Thanks,
drew

> ---
>  arch/riscv/lib/memset.S | 143 ++++++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index 34c5360c6705..e613c5c27998 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -3,111 +3,112 @@
>   * Copyright (C) 2013 Regents of the University of California
>   */
>  
> -
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
>  
>  /* void *memset(void *, int, size_t) */
>  ENTRY(__memset)
>  WEAK(memset)
> -	move t0, a0  /* Preserve return value */
> +	move	t0, a0			/* Preserve return value */
>  
>  	/* Defer to byte-oriented fill for small sizes */
> -	sltiu a3, a2, 16
> -	bnez a3, 4f
> +	sltiu	a3, a2, 16
> +	bnez	a3, 4f
>  
>  	/*
>  	 * Round to nearest XLEN-aligned address
> -	 * greater than or equal to start address
> +	 * greater than or equal to the start address.
>  	 */
> -	addi a3, t0, SZREG-1
> -	andi a3, a3, ~(SZREG-1)
> -	beq a3, t0, 2f  /* Skip if already aligned */
> +	addi	a3, t0, SZREG-1
> +	andi	a3, a3, ~(SZREG-1)
> +	beq	a3, t0, 2f		/* Skip if already aligned */
> +
>  	/* Handle initial misalignment */
> -	sub a4, a3, t0
> +	sub	a4, a3, t0
>  1:
> -	sb a1, 0(t0)
> -	addi t0, t0, 1
> -	bltu t0, a3, 1b
> -	sub a2, a2, a4  /* Update count */
> +	sb	a1, 0(t0)
> +	addi	t0, t0, 1
> +	bltu	t0, a3, 1b
> +	sub	a2, a2, a4		/* Update count */
>  
>  2: /* Duff's device with 32 XLEN stores per iteration */
>  	/* Broadcast value into all bytes */
> -	andi a1, a1, 0xff
> -	slli a3, a1, 8
> -	or a1, a3, a1
> -	slli a3, a1, 16
> -	or a1, a3, a1
> +	andi	a1, a1, 0xff
> +	slli	a3, a1, 8
> +	or	a1, a3, a1
> +	slli	a3, a1, 16
> +	or	a1, a3, a1
>  #ifdef CONFIG_64BIT
> -	slli a3, a1, 32
> -	or a1, a3, a1
> +	slli	a3, a1, 32
> +	or	a1, a3, a1
>  #endif
>  
>  	/* Calculate end address */
> -	andi a4, a2, ~(SZREG-1)
> -	add a3, t0, a4
> +	andi	a4, a2, ~(SZREG-1)
> +	add	a3, t0, a4
>  
> -	andi a4, a4, 31*SZREG  /* Calculate remainder */
> -	beqz a4, 3f            /* Shortcut if no remainder */
> -	neg a4, a4
> -	addi a4, a4, 32*SZREG  /* Calculate initial offset */
> +	andi	a4, a4, 31*SZREG	/* Calculate remainder */
> +	beqz	a4, 3f			/* Shortcut if no remainder */
> +	neg	a4, a4
> +	addi	a4, a4, 32*SZREG	/* Calculate initial offset */
>  
>  	/* Adjust start address with offset */
> -	sub t0, t0, a4
> +	sub	t0, t0, a4
>  
>  	/* Jump into loop body */
>  	/* Assumes 32-bit instruction lengths */
> -	la a5, 3f
> +	la	a5, 3f
>  #ifdef CONFIG_64BIT
> -	srli a4, a4, 1
> +	srli	a4, a4, 1
>  #endif
> -	add a5, a5, a4
> -	jr a5
> +	add	a5, a5, a4
> +	jr	a5
>  3:
> -	REG_S a1,        0(t0)
> -	REG_S a1,    SZREG(t0)
> -	REG_S a1,  2*SZREG(t0)
> -	REG_S a1,  3*SZREG(t0)
> -	REG_S a1,  4*SZREG(t0)
> -	REG_S a1,  5*SZREG(t0)
> -	REG_S a1,  6*SZREG(t0)
> -	REG_S a1,  7*SZREG(t0)
> -	REG_S a1,  8*SZREG(t0)
> -	REG_S a1,  9*SZREG(t0)
> -	REG_S a1, 10*SZREG(t0)
> -	REG_S a1, 11*SZREG(t0)
> -	REG_S a1, 12*SZREG(t0)
> -	REG_S a1, 13*SZREG(t0)
> -	REG_S a1, 14*SZREG(t0)
> -	REG_S a1, 15*SZREG(t0)
> -	REG_S a1, 16*SZREG(t0)
> -	REG_S a1, 17*SZREG(t0)
> -	REG_S a1, 18*SZREG(t0)
> -	REG_S a1, 19*SZREG(t0)
> -	REG_S a1, 20*SZREG(t0)
> -	REG_S a1, 21*SZREG(t0)
> -	REG_S a1, 22*SZREG(t0)
> -	REG_S a1, 23*SZREG(t0)
> -	REG_S a1, 24*SZREG(t0)
> -	REG_S a1, 25*SZREG(t0)
> -	REG_S a1, 26*SZREG(t0)
> -	REG_S a1, 27*SZREG(t0)
> -	REG_S a1, 28*SZREG(t0)
> -	REG_S a1, 29*SZREG(t0)
> -	REG_S a1, 30*SZREG(t0)
> -	REG_S a1, 31*SZREG(t0)
> -	addi t0, t0, 32*SZREG
> -	bltu t0, a3, 3b
> -	andi a2, a2, SZREG-1  /* Update count */
> +	REG_S	a1,        0(t0)
> +	REG_S	a1,    SZREG(t0)
> +	REG_S	a1,  2*SZREG(t0)
> +	REG_S	a1,  3*SZREG(t0)
> +	REG_S	a1,  4*SZREG(t0)
> +	REG_S	a1,  5*SZREG(t0)
> +	REG_S	a1,  6*SZREG(t0)
> +	REG_S	a1,  7*SZREG(t0)
> +	REG_S	a1,  8*SZREG(t0)
> +	REG_S	a1,  9*SZREG(t0)
> +	REG_S	a1, 10*SZREG(t0)
> +	REG_S	a1, 11*SZREG(t0)
> +	REG_S	a1, 12*SZREG(t0)
> +	REG_S	a1, 13*SZREG(t0)
> +	REG_S	a1, 14*SZREG(t0)
> +	REG_S	a1, 15*SZREG(t0)
> +	REG_S	a1, 16*SZREG(t0)
> +	REG_S	a1, 17*SZREG(t0)
> +	REG_S	a1, 18*SZREG(t0)
> +	REG_S	a1, 19*SZREG(t0)
> +	REG_S	a1, 20*SZREG(t0)
> +	REG_S	a1, 21*SZREG(t0)
> +	REG_S	a1, 22*SZREG(t0)
> +	REG_S	a1, 23*SZREG(t0)
> +	REG_S	a1, 24*SZREG(t0)
> +	REG_S	a1, 25*SZREG(t0)
> +	REG_S	a1, 26*SZREG(t0)
> +	REG_S	a1, 27*SZREG(t0)
> +	REG_S	a1, 28*SZREG(t0)
> +	REG_S	a1, 29*SZREG(t0)
> +	REG_S	a1, 30*SZREG(t0)
> +	REG_S	a1, 31*SZREG(t0)
> +
> +	addi	t0, t0, 32*SZREG
> +	bltu	t0, a3, 3b
> +	andi	a2, a2, SZREG-1		/* Update count */
>  
>  4:
>  	/* Handle trailing misalignment */
> -	beqz a2, 6f
> -	add a3, t0, a2
> +	beqz	a2, 6f
> +	add	a3, t0, a2
>  5:
> -	sb a1, 0(t0)
> -	addi t0, t0, 1
> -	bltu t0, a3, 5b
> +	sb	a1, 0(t0)
> +	addi	t0, t0, 1
> +	bltu	t0, a3, 5b
>  6:
>  	ret
>  END(__memset)
> -- 
> 2.33.0
> 
