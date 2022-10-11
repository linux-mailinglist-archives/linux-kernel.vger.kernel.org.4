Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394935FB917
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJKRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:21:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0A5A897
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:21:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so32835127ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDH/yqMBY6z65ZJG9YUJcRxt5TLwOS8GZpBny1UR+wU=;
        b=LaM8+qFG1my8Jgpzmgkwd2c1XQ3CJfP3M/S+A5zp45CCeJhA2l0XTf0twHAYpk8Zj4
         kEp56yDKYvjnZtHEPfLlAAiS5Gy5wXhP/Xe+bGZ/tBtN/M+s3sdTXlDB9fEtyXbbUqbj
         Acy9wf3dQvzqraceTxSpOQIA4igavGsxfuXFkVk5ZSIIA/c9SaR/JXz0S7Qf4yH3uS//
         9seOf7/JyiUSvNMuSvgrVUXfb+0KTR9VaFk5uQn4sSu/NfrwYR41ajMyvxz/OcBSsEsu
         7u8sy7GVw9nuWNKDgeXz+nu7EcTTiIgfHD+5j11wS6GiFAGlqZWysHua12KhNwkiS2UL
         tRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDH/yqMBY6z65ZJG9YUJcRxt5TLwOS8GZpBny1UR+wU=;
        b=2LiU5O0SctZkhUkhT6RTH20lfw4fqlrqEC27138o76vbCcvwCGs4FzGeTbPRiWT8Bb
         El29AeLrolTq4wbPRaFrl2yXNSxemF5MHaUmzg3SMPoQc4A7YChqqQn52vkQ3AsSeBAr
         oqa9a957lYLytPMipMdtvA2qM8e0SKHyHKqbvWPjHvfmRFM5/vUgBIDLWmW1ylrtj1Yd
         gEQCsU5JBf2Nf8ch7bdrdyhJBDo2DcXxFQoMboT1dw6ohDzQvsGz/d1p8/t6sT8H6Ruz
         k9pndxT8wYNsTqPHpULzcIJy129hEX1rix+70+327OvJ+4zya1amQLSt6fShJQf1gwV5
         S2dw==
X-Gm-Message-State: ACrzQf0NqLK176/A4LBHmXLohYfYTpppxOwWVQU7BPWc2ZEv1Z6rPZAI
        vGhL7A8pXwAdBfvGwrDyW0uOf0JAPIqDqw==
X-Google-Smtp-Source: AMsMyM7Ysdj7qDeAq5GSAX1M7OKEZKLjyhDmK7KAEeekQ2yxzv+UJ2NGaWADd65guNvdOYPICU0EbA==
X-Received: by 2002:a17:906:db0a:b0:781:f24:a782 with SMTP id xj10-20020a170906db0a00b007810f24a782mr19551598ejb.399.1665508887606;
        Tue, 11 Oct 2022 10:21:27 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b0078d46aa3b82sm44170ejc.21.2022.10.11.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:21:27 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:21:26 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, lkp@lists.01.org,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <20221011172126.24csegoozshpy34z@kamzik>
References: <YzeclACdH9JmaRza@yury-laptop>
 <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
 <Yzh19JhBMzkMr4+L@yury-laptop>
 <20221011170949.upxk3tcfcwnkytwm@kamzik>
 <Y0Wk0WD6CL4aFEIi@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Wk0WD6CL4aFEIi@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:16:01AM -0700, Yury Norov wrote:
> > Hi Yury,
> > 
> > I just wanted to report that the warning fires when doing
> > 'cat /proc/cpuinfo' on at least x86 and riscv. I don't think
> > those are false positives. I'm guessing a patch should be
> > something like the following diff. If you haven't already
> > addressed this and I'm not off in left field, then I guess
> > we should integrate it into your series.
> > 
> > Thanks,
> > drew
>  
> Hi Andrew,
> 
> Can you please send it as a patch with a description?

Will do. I'll send two patches, one for each arch.

> 
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 4aa8cd749441..4c5dfa230d4b 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -166,9 +166,12 @@ static void print_mmu(struct seq_file *f)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > -	if ((*pos) < nr_cpu_ids)
> > -		return (void *)(uintptr_t)(1 + *pos);
> > +	if (*pos < nr_cpu_ids) {
> > +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > +		if ((*pos) < nr_cpu_ids)
> 
> Braces around *pos are not needed.

The braces were preexisting, but I'll drop them while indenting.

Thanks,
drew

> 
> > +			return (void *)(uintptr_t)(1 + *pos);
> > +	}
> > +
> >  	return NULL;
> >  }
> >  
> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > index 099b6f0d96bd..2ea614e78e28 100644
> > --- a/arch/x86/kernel/cpu/proc.c
> > +++ b/arch/x86/kernel/cpu/proc.c
> > @@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > -	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > -	if ((*pos) < nr_cpu_ids)
> > -		return &cpu_data(*pos);
> > +	if (*pos < nr_cpu_ids) {
> > +		*pos = cpumask_next(*pos - 1, cpu_online_mask);
> > +		if ((*pos) < nr_cpu_ids)
> 
> Here too.
> 
> Thanks,
> Yury
> 
> > +			return &cpu_data(*pos);
> > +	}
> > +
> >  	return NULL;
> >  }
> >  
> > >  
> > > > I suspect that to avoid any automation noise, you should just rebase
> > > > so that the fixes come first. Otherwise we'll end up wasting a lot of
> > > > time on the noise.
> > > > 
> > > > This is not that different from introducing new buil;d-time warnings:
> > > > the things they point out need to be fixed before the warning can be
> > > > integrated, or it causes bisection problems.
> > > 
> > > OK, I'll reorder the patches. Thanks for your help.
> > > 
