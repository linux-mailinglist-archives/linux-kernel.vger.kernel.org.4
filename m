Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFA5FBA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJKSYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJKSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:24:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581675FDD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:24:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m15so21297657edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MC+yukkeSsEMWJh5BzF5ssgR1etwXnfqKmMkQ84MBVE=;
        b=RfGWZvOlTkRLiwHFdbigGnRPPCM9ltxxyd5QDDyAUXXEIIlnRYddsBwY4Sn+pXsZFb
         3C3ZHGljKDHOUNuP8SVNpWt1o2KxkEk4y6YWWM36keIIPktNMPjaNLV+qNPET+F7YPiw
         NAlLvW7y419U65vLXbnmoREd9n6lByVfDpl2zvfeFnCvXuFiVZK1A91A9xyz3oZXujEG
         exu2jJGssf9ibQ+oQSRocoA4khbIa/t8QPApgEr7GDUGqz1MhT1jjWHgmPuZJrVc13PE
         PFJzX121DgUSAV8PCiP7FS4hzUlEry3Fdw+VkZtYt3ZqlU7oV5w9abwJfpUm4FDOQCjn
         98xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC+yukkeSsEMWJh5BzF5ssgR1etwXnfqKmMkQ84MBVE=;
        b=Q51+N0H1r4TDv6kt694y2moDW7bCbVIQtcFFkJlgPeUlKSb5Emf6fhcXSD2odm/wL+
         STpulmLd+U9TQowHXCv6N0mt5Ya12R5+js9111LD2gM0JbXxV4KB5hC2DSWVRE4+A39N
         QfH0Sz/JrAVkQHDGa0c8jdZyN9N9mHPqZqt5QjpXY6UU3v0QI6V1yYaeqAOlrRvewS62
         tHh4yV4VZERmnke2KL0a/4sLeJONtL8sCTsJfEjblmh7x/rfLuq1SWvnPOVg8odo02ky
         pTFT4GGy6KQz9IFkSAM2udbfU+SGex4m+V3ilaWGGOWRyQV/pX+n1G/UdzBImvq/55rQ
         repQ==
X-Gm-Message-State: ACrzQf01+NCVspKtd6AIieqYJIc1GBAJJevdy3X5/GCVNPEF6iXRWbC6
        LPKYuCvoE0MAw5WFpOJpc0cXnQ==
X-Google-Smtp-Source: AMsMyM5PSQg8pwUqt0L1ltBi/OecJlhjlCP5oDsGLSzXyeQKmOSXuF2SrkC20EzurgL9mXf+IvMuSQ==
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr24160928edb.373.1665512637921;
        Tue, 11 Oct 2022 11:23:57 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id kf3-20020a17090776c300b0074182109623sm96580ejc.39.2022.10.11.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:23:57 -0700 (PDT)
Date:   Tue, 11 Oct 2022 20:23:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] RISC-V: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221011182356.xbgvpoddhe4st6va@kamzik>
References: <20221011175040.1782772-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011175040.1782772-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Boris pointed out on my x86 version of this patch that I didn't
give nearly enough information on why I sent it. Sorry about that!
I've tried to fill in some of that information in my reply to him
[1]. Sorry for lazily just pointing to that link here, but I'll
send a v2 with the information properly added tomorrow.

[1] https://lore.kernel.org/all/20221011181715.dpayrpjueha7kxoj@kamzik/

Thanks,
drew

On Tue, Oct 11, 2022 at 07:50:40PM +0200, Andrew Jones wrote:
> Upcoming cpumask changes will start issuing warnings[*] when cpu
> indices equal to nr_cpu_ids are passed to cpumask_next* functions.
> Ensure we don't generate a warning when reading /proc/cpuinfo by
> validating the cpu index before calling cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/riscv/kernel/cpu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 4aa8cd749441..592ff065e09f 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -166,9 +166,12 @@ static void print_mmu(struct seq_file *f)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> -	if ((*pos) < nr_cpu_ids)
> -		return (void *)(uintptr_t)(1 + *pos);
> +	if (*pos < nr_cpu_ids) {
> +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> +		if (*pos < nr_cpu_ids)
> +			return (void *)(uintptr_t)(1 + *pos);
> +	}
> +
>  	return NULL;
>  }
>  
> -- 
> 2.37.3
> 
