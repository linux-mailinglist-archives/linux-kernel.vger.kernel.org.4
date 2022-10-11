Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B775FB90A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJKRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJKRQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:16:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A1EA3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:16:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f22so4704978qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0TMmEU0awN4pXECmIXk1XAppujLcVlqRm9zJtAsubI=;
        b=o07802aJ1Zv1PhubgA0DI81pA5ci3gLQm8fcrMu5Q27g3sCWEXsfUOq9OPyG/gVlyD
         fL1q0fK/S9YAQNEi2x5wCGX2m7oERkJ22PXNL9wa4V8CeqeaYRGu1QNYER55BIk5xmiB
         3KTz8ayhFl1itHt+wSVs6t9tbL8GCp17PwQtHUa1U51pDjECr6m5IQ/WL9P6JO93VEXv
         ml5ooYq5KERO+DArZlPawZMmArIgDoDUNgZvGJuSdQbHNZIRgNMQ6tw6TcmSawj28fl/
         p/Ssi5QsWew18yMtvbubwh1+YkpxpiK78yezPbehchU4QB2QBnxBANWnBMVF+mUXRDXX
         HZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0TMmEU0awN4pXECmIXk1XAppujLcVlqRm9zJtAsubI=;
        b=h8LtnsvvvK0blLaLv0je0prbqRWbwctvue0Yh8DR2FXFKU7sEYG7roDOQmnSsPhau/
         gSpRQu/QOKZFYykEOfopwuG8VMEJNds6hpp3Bdkyoct4nCQeO4eH7/8ns8+9LH2S11xO
         XfbbMXzcdJ+DD+Zb9I8HqhPPAHpDwN8P855m2/ALemAWuFYuj0CF6c1RemInO15QXUxy
         unlzw/zbeifAtUAWsipWi6JX7/WMmdBXIGvP92aQcWegxKAEvcx120O2ndQ1YrgmWpVM
         BXV1ssZDcKhHTYKhdnaAACH4jLzbp7IB9w3q/jYMnjf+n/vhU9kUe+1e55x/6x95k7lA
         NQFg==
X-Gm-Message-State: ACrzQf3zFalxzI+Faz10LnCdiT55N5XkGmkK21cvhZM1Zw69h7odYhdm
        TmbobpErbIoRANwuVd6PXbU=
X-Google-Smtp-Source: AMsMyM6vBd4nYGfZ8fJ7aQfhyEgTgP6ewEUQkLEpP322CDUmqma5O+qml1b5fmljK4pZmGak1S0LLA==
X-Received: by 2002:a05:622a:58d:b0:394:9d68:edc2 with SMTP id c13-20020a05622a058d00b003949d68edc2mr20544718qtb.230.1665508562927;
        Tue, 11 Oct 2022 10:16:02 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:6051:2739:340:f252])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a269800b006b5cc25535fsm13484116qkp.99.2022.10.11.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:16:02 -0700 (PDT)
Date:   Tue, 11 Oct 2022 10:16:01 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, lkp@lists.01.org,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <Y0Wk0WD6CL4aFEIi@yury-laptop>
References: <YzeclACdH9JmaRza@yury-laptop>
 <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
 <Yzh19JhBMzkMr4+L@yury-laptop>
 <20221011170949.upxk3tcfcwnkytwm@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011170949.upxk3tcfcwnkytwm@kamzik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Yury,
> 
> I just wanted to report that the warning fires when doing
> 'cat /proc/cpuinfo' on at least x86 and riscv. I don't think
> those are false positives. I'm guessing a patch should be
> something like the following diff. If you haven't already
> addressed this and I'm not off in left field, then I guess
> we should integrate it into your series.
> 
> Thanks,
> drew
 
Hi Andrew,

Can you please send it as a patch with a description?

> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 4aa8cd749441..4c5dfa230d4b 100644
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
> +		if ((*pos) < nr_cpu_ids)

Braces around *pos are not needed.

> +			return (void *)(uintptr_t)(1 + *pos);
> +	}
> +
>  	return NULL;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..2ea614e78e28 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> -	if ((*pos) < nr_cpu_ids)
> -		return &cpu_data(*pos);
> +	if (*pos < nr_cpu_ids) {
> +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> +		if ((*pos) < nr_cpu_ids)

Here too.

Thanks,
Yury

> +			return &cpu_data(*pos);
> +	}
> +
>  	return NULL;
>  }
>  
> >  
> > > I suspect that to avoid any automation noise, you should just rebase
> > > so that the fixes come first. Otherwise we'll end up wasting a lot of
> > > time on the noise.
> > > 
> > > This is not that different from introducing new buil;d-time warnings:
> > > the things they point out need to be fixed before the warning can be
> > > integrated, or it causes bisection problems.
> > 
> > OK, I'll reorder the patches. Thanks for your help.
> > 
