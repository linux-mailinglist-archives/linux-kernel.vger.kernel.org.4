Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A255FC622
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJLNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJLNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:13:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE080BF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:13:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so24358444edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qec+PTzHVRJaCTYLMbLbFJcUxjGagA3lcOkRy3Fcpa0=;
        b=H8ZXF5cgpFfTnH9WMmsidkLVvJGK2QRQafdmcsaxlacZ0dMT33o30zQOTesinRlBQt
         Upa2RzZRvOczcNg3VHcZ3/QmtScT7DVwDYnnwJv6RD/jinZ9RkfDNf+fefI4vWIGQOyd
         mG5Bej+3NVpguxNW0668vRbI/oFDyRdAbRH3GgfYNWSvQXT3nt8Z2fAB9Ih9dPKJ5uVM
         66xv++Ydk8nARhfySiRM2XRkF0X6R6PG3rTr+FvlhOUQ1wjQqeLGwbD5hB0YXfHn/WLG
         LG8Q71jcieCDM4asn7V9LOUVFHG4ueEMWNdlIfKZQNU7CnVWoE1fobla2Y6rOx+VZtnP
         7nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qec+PTzHVRJaCTYLMbLbFJcUxjGagA3lcOkRy3Fcpa0=;
        b=UKOUSWxJscZd1I+c3hip64rTsmpb+Xaf9OunEvXaV/8U9bPbVMnRyOM4KgR5N1I+7Y
         kL/OeIFzopq4o8WbSg8CrOguk9vZ0K1nkM2SFN83TItry9S7b3xDnPjN4sfZPx+t7PlE
         qz7VZJvlrUjl0/lBqbboDrECmQ9LVYar/gx465DIGl0kiL8XBVBlgJoeFuhMxhibMk66
         Azk45DjSyTNTzYkZHIRYNO7B/e43N+me0XBwlQ+XT8ZKjGrQBWjcWJrbRogtnLUW5acA
         qP7zvvOIWhtEFxX/w8exmCr8Z18fs+/wud6Z3k5XfTAQevKWi0KBU4kFUdyPRXSUt/t7
         oryg==
X-Gm-Message-State: ACrzQf3sUA71IrLbtwGNN/FIA0WsS3Kxi5DvRqJW2u/aGfT3PM4pxjAl
        UIIagi+n3mrgxvFnTK1OS3nBmg==
X-Google-Smtp-Source: AMsMyM4Z8GIXaJySZvnILH18H+0/tiWIyJ+Goli8Iw3sXUFq88849aAGyyIj+faT/QC287JNERqTvA==
X-Received: by 2002:a05:6402:5256:b0:459:42b3:3d86 with SMTP id t22-20020a056402525600b0045942b33d86mr26362820edd.370.1665580406476;
        Wed, 12 Oct 2022 06:13:26 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709067d8100b0078d957e65b6sm1279316ejo.23.2022.10.12.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:13:26 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:13:25 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2] RISC-V: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221012131325.oc7onxqo7t46wxq5@kamzik>
References: <20221012082949.1801222-1-ajones@ventanamicro.com>
 <Y0a5QYWzEwRlGtxf@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0a5QYWzEwRlGtxf@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:55:29AM -0700, Yury Norov wrote:
> On Wed, Oct 12, 2022 at 10:29:49AM +0200, Andrew Jones wrote:
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > start and next seq operations implement a pattern like
> > 
> >   n = cpumask_next(n - 1, mask);
> >   show(n);
> >   while (1) {
> >       ++n;
> >       n = cpumask_next(n - 1, mask);
> >       if (n >= nr_cpu_ids)
> >           break;
> >       show(n);
> >   }
> 
> Can you instead of sudo-code print show the real control flow? What
> function hosts the infinite loop?

The function is seq_read_iter(), which is pointed out above. I'd rather
not reproduce / describe more than what I've done here, as the function
is large. I'd be happy for reviewers to double check my pseudocode to
make sure I got it and the analysis right, though.

> 
> > which will issue the warning when reading /proc/cpuinfo. Ensure no
> > warning is generated by validating the cpu index before calling
> > cpumask_next().
> > 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > ---
> > v2:
> >   - Got comments on the x86 equivalent patch and made the same
> >     changes to this one
> >     - Added all the information I should have in the first place
> >       to the commit message [Boris]
> >     - Changed style of fix [Boris]
> > 
> > 
> >  arch/riscv/kernel/cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 4aa8cd749441..63138b880b92 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -166,6 +166,9 @@ static void print_mmu(struct seq_file *f)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > +	if (*pos >= nr_cpu_ids)
> > +		return NULL;
> > +
> >  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> >  	if ((*pos) < nr_cpu_ids)
> >  		return (void *)(uintptr_t)(1 + *pos);
> 
> OK, as far as I understood your explanations, *pos == nr_cpu_ids
> is a valid index because it's used as stop-code for traversing.
> 
> However, you're completely silencing cpumask_check(), including
> those cases where *pos > nr_cpu_ids. I suspect there's no valid
> cases for it. If so, the patch should look like:
> 
>  +	if (*pos == nr_cpu_ids)
>  +		return NULL;
>  +

That makes sense and it's probably worth a v3. I'll wait and see if more
comments roll in before sending though.

> 
> The same for x86 patch. 
> 
> If it comes to v3, can you send both as a series?

OK. I'll write a cover letter trying to explain that I don't expect them
to both go through the same tree.

Thanks,
drew
