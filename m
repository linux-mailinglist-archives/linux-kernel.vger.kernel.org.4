Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA668606880
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJTS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:56:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FA144E0E;
        Thu, 20 Oct 2022 11:56:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so1890403ejd.0;
        Thu, 20 Oct 2022 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOkqJ3yOOQFkcMQbSOwgJrCEmoTaf2s2tr3nzMcHbt0=;
        b=fbYwZZwiNod4xj5Jklg9zaZScJ0H0Xz5Y3nhHgF2d8jzdhcEmMXKASW6Jb6YrU7nov
         jjJnR74lTiPvYaigckFhy6uOFnBvdf9mK4wwsNooGz1QpAeYHIZNUiepaM8wI70IEtNU
         RaHVrP3C07hQmL6LhpZFMpMGdafReS5nOMgLXhBA/qxy8Wer20w/qmHLtFPdRuVqNEyl
         9Y7ozURQVTOjbY01SIPWJjThEVzEDPfxu4OIk+2ZvatmrQ91Kx7J+1jSw6LPZjwKLJuB
         mVGLRGoqyRXclBp7pLHqHRPv3VF/D34uONSqvTUEC82pUV9mwdGugwrXCxvbl/39ncnw
         8GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOkqJ3yOOQFkcMQbSOwgJrCEmoTaf2s2tr3nzMcHbt0=;
        b=1qY8FLvwchBnv7QMp1lTyw4g5n37YLGoNxxSy0jimnHXj3Ih4Pyim8ne9wswY/DBQE
         MkBPFOjZdMgnmuxEnHHQiNQDpOiOzeYebeBUE2wM0G86uVQhZsYNbattiAliqdjJbKSN
         Ktz2XPfqRgW6FuXT8H1uuzjV1MJMnT66rjqV0AeawVgZV5KeXl89OGTHWwUN+gC5OMSK
         Qnb5eCe+Xunx/O1Y3EhX+F21v1+f0UTxtsuqWXJwmzzkWNYCw6jMXXCmwVsBQDBwBkes
         BGJz7iabF7q2jOB0471b7LUGkNs3OiAzviWANvzoqbUFWnN/9gUs9nL5xHd7C5f9XG0u
         WiGQ==
X-Gm-Message-State: ACrzQf3Nxfbd+xXF1ofhh48BlA9DjtqP+Ms2HNXsBXeTSIVJJOccxbj7
        wfDHD1Lsb8kL1tObmFIxhG2yYgN0qKM=
X-Google-Smtp-Source: AMsMyM6NWhUShU3QwrVek1U/gxYho1cTWm1qagu1cx9Ko+jwhyiAj12K9AClrVHb/+sdmffnwmArPQ==
X-Received: by 2002:a17:907:e93:b0:78d:b8ff:9b5f with SMTP id ho19-20020a1709070e9300b0078db8ff9b5fmr12408045ejc.12.1666292172431;
        Thu, 20 Oct 2022 11:56:12 -0700 (PDT)
Received: from nz (host81-147-8-29.range81-147.btcentralplus.com. [81.147.8.29])
        by smtp.gmail.com with ESMTPSA id gl22-20020a170906e0d600b0078d3f96d293sm10666707ejb.30.2022.10.20.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:56:12 -0700 (PDT)
Date:   Thu, 20 Oct 2022 19:56:11 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     yexingchen116@gmail.com
Cc:     akpm@linux-foundation.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ia64: Replace IS_ERR() with IS_ERR_VALUE()
Message-ID: <20221020195611.234ca44e@nz>
In-Reply-To: <20221020113004.400031-1-ye.xingchen@zte.com.cn>
References: <20221020113004.400031-1-ye.xingchen@zte.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 11:30:04 +0000
yexingchen116@gmail.com wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Avoid type casts that are needed for IS_ERR() and use
> IS_ERR_VALUE() instead.

Looks good to me!

Signed-off-by: Sergei Trofimovich <slyich@gmail.com>

> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/ia64/kernel/sys_ia64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
> index 215bf3f8cb20..f6a502e8f02c 100644
> --- a/arch/ia64/kernel/sys_ia64.c
> +++ b/arch/ia64/kernel/sys_ia64.c
> @@ -140,7 +140,7 @@ asmlinkage unsigned long
>  sys_mmap2 (unsigned long addr, unsigned long len, int prot, int flags, int fd, long pgoff)
>  {
>  	addr = ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
> -	if (!IS_ERR((void *) addr))
> +	if (!IS_ERR_VALUE(addr))
>  		force_successful_syscall_return();
>  	return addr;
>  }
> @@ -152,7 +152,7 @@ sys_mmap (unsigned long addr, unsigned long len, int prot, int flags, int fd, lo
>  		return -EINVAL;
>  
>  	addr = ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> -	if (!IS_ERR((void *) addr))
> +	if (!IS_ERR_VALUE(addr))
>  		force_successful_syscall_return();
>  	return addr;
>  }
> @@ -162,7 +162,7 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
>  	     unsigned long new_addr)
>  {
>  	addr = sys_mremap(addr, old_len, new_len, flags, new_addr);
> -	if (!IS_ERR((void *) addr))
> +	if (!IS_ERR_VALUE(addr))
>  		force_successful_syscall_return();
>  	return addr;
>  }
> -- 
> 2.25.1
> 


-- 

  Sergei
