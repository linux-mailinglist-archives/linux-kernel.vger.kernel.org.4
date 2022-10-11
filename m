Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE85FB8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:09:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FBB2AD3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:09:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so32765068ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocUKjVgs7hkiBGPswf8jad/dUSoFrePCrz7xOrN9l9E=;
        b=VZcGRJ6u7FxdYhd5vqQjUP0icn2ivrEgwPFKHQrUyx50MyTtL8WXkE4VlPJYDMSSfI
         V1GwWNBIBZKjtASA+6n3G6r3r5maXR9IQZALhCbQ1ob9gMsZGLuvN/j+1qmoAAcbq4ps
         vYxCiGeMNIXw5AakxcIsuukVBA0ZwhB6bVGiS3G33riZD09adFQTDIaArU1ELkw4Ek6j
         p2uwko7VSsLdr3soOyhjTzILOXiCAAWWi9NQnjQvzLnEIWYvJSBaxeryghv+lCQIdrRH
         UDr0x8fxRwQTPAoeqTsZDh2tvPYtTH7LWNGcUMiowaZ9y8Y7nvFvaMtho16vUiH9jN1P
         zJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocUKjVgs7hkiBGPswf8jad/dUSoFrePCrz7xOrN9l9E=;
        b=BEwM/cfI9TLjJndHI6LPuAz8VCLIPJajb6xZo1Lel7yiANfjMnT7EtA7DdlbbAqm0W
         mORMCMvfTsIUUwSHWupi/+xNMZNlNlfVJKYBhl0GvPtpZid34YeRKmEDVSBqikheT8Cp
         4WP1+btTc3TSt1Be+H6yXJjPd78pGwtp7CFC9ynEW5+iwtJERX+neeM40begroBGnbIP
         SLJYz32/u/MUbwBtUdvunFUmpTY5cMketFjlO5fviD0SkgminvjXitsMqIQwBTZgSP5y
         +i8qcj+ia+rhhvnHy7whbokI0PGBuClObI2CVbFU8joBoQMcY2/9m5UdkG6s2MBTTzxY
         8AFQ==
X-Gm-Message-State: ACrzQf37cM8Yq65iWveKt7Bx62ALgPJR+cb4zTX2K7q17sCpi149bW17
        71GWTHOA49kdzNv2KtpgFBKbDA==
X-Google-Smtp-Source: AMsMyM4p9ffQMiaQ9KPg3sbrVvOcmF6cMCMngeBvzj16ErhZm+qKtjY+YLWcjZUtBBm6W/S920NGZg==
X-Received: by 2002:a17:907:2722:b0:77f:c136:62eb with SMTP id d2-20020a170907272200b0077fc13662ebmr19053701ejl.522.1665508190903;
        Tue, 11 Oct 2022 10:09:50 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b0078250005a79sm7163794ejc.163.2022.10.11.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:09:50 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:09:49 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, lkp@lists.01.org,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <20221011170949.upxk3tcfcwnkytwm@kamzik>
References: <YzeclACdH9JmaRza@yury-laptop>
 <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
 <Yzh19JhBMzkMr4+L@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzh19JhBMzkMr4+L@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 10:16:36AM -0700, Yury Norov wrote:
> On Sat, Oct 01, 2022 at 09:20:53AM -0700, Linus Torvalds wrote:
> > On Fri, Sep 30, 2022 at 6:51 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > The commit  b9a7ecc71fe582e ("cpumask: fix checking valid cpu range")
> > > fixes broken cpumask_check(), which for now doesn't warn user when it
> > > should. After the fix, I observed many false-positive warnings which
> > > were addressed in the following patches.
> > 
> > Are all the false positives fixed?
> 
> I build-tested on x86_64 and arm64. All fixed except for those
> generated by cpumask_next_wrap(). And I'm not even sure they
> are false positives.
> 
> This is what I'm working on right now. Hope moving it in next
> merge window.

Hi Yury,

I just wanted to report that the warning fires when doing
'cat /proc/cpuinfo' on at least x86 and riscv. I don't think
those are false positives. I'm guessing a patch should be
something like the following diff. If you haven't already
addressed this and I'm not off in left field, then I guess
we should integrate it into your series.

Thanks,
drew


diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4aa8cd749441..4c5dfa230d4b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -166,9 +166,12 @@ static void print_mmu(struct seq_file *f)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	*pos = cpumask_next(*pos - 1, cpu_online_mask);
-	if ((*pos) < nr_cpu_ids)
-		return (void *)(uintptr_t)(1 + *pos);
+	if (*pos < nr_cpu_ids) {
+		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+		if ((*pos) < nr_cpu_ids)
+			return (void *)(uintptr_t)(1 + *pos);
+	}
+
 	return NULL;
 }
 
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..2ea614e78e28 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -153,9 +153,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	*pos = cpumask_next(*pos - 1, cpu_online_mask);
-	if ((*pos) < nr_cpu_ids)
-		return &cpu_data(*pos);
+	if (*pos < nr_cpu_ids) {
+		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+		if ((*pos) < nr_cpu_ids)
+			return &cpu_data(*pos);
+	}
+
 	return NULL;
 }
 
>  
> > I suspect that to avoid any automation noise, you should just rebase
> > so that the fixes come first. Otherwise we'll end up wasting a lot of
> > time on the noise.
> > 
> > This is not that different from introducing new buil;d-time warnings:
> > the things they point out need to be fixed before the warning can be
> > integrated, or it causes bisection problems.
> 
> OK, I'll reorder the patches. Thanks for your help.
> 
