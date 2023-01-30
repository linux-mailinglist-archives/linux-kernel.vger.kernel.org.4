Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A287680B42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjA3KtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjA3KtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:49:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F82305CB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:49:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1711245wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SaqOey6takqXeZ8f0/kRCVEhlQpWs2nzQX4ec1B7cGw=;
        b=AZJbWWO1gFB7jtxzXSoG06CX5t1F9m7wuJQaTL25u0qZSfjmlTN8zFIp3n9uCrVfiZ
         JRNavrjnrkEIGNNcT1YMWdUT7z5m17mFK/3gGERCqIPpGgpL5YUbRYZ/01OPmRvnd+tZ
         NdbDUkL9Qy5UAfS1QoONoX2eg+CB2fxuDqR4O2SH4+vvBSa4DQHSHTZW+le49dnVlcxY
         2Or3crt25V4t+roMEsh9CxJsWysT2ya2BurNrtaYOMbQkzFnwDCkX7Hnd+3+rxGPWnf4
         vwpKV3iTV6yUYPxMARk3i9O4Msv5rbbBuKSl1lE5yyExkkB6qywuBPfuQsUhwD2oGqMr
         aFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaqOey6takqXeZ8f0/kRCVEhlQpWs2nzQX4ec1B7cGw=;
        b=or+pP5BPsR4m4rqKjwHBjxY/tJ9H91muOne4oCpN83RIVDxfzNjy0T35WLQgPT4A0P
         XiqGxGx5MwTZDz2dLLNNWmb5Yn7swzz1cGCI1kiRqOkVC8qy91MDcdaKm6pis+ZnaoQv
         giawLVarB3Cfdc4Z/tTjO0qYnDUPbImX7/kZcMiiJKS55Ib9SQcIBCLVKK8IsinExyEI
         300t5+676oCbHIwpTmI1b2ZHsGKUX9KFWUzXY/YWSefGbrPR5V3ZO1cPtFDD/Bb/9EVw
         Dwo0TVpb9xXIoP56h4OrVwjX8Fl/OOWUVLVBOo/Pj4wg6TTGTh/acxkzEDkwpOCgEShk
         j3tA==
X-Gm-Message-State: AO0yUKUchPkBCeOGWF3pivIO33bcoRjmwl56aUu3VUb5eMlC5CxP9CgQ
        aDTsG9raqlO0toOgL3cz97KkLQ==
X-Google-Smtp-Source: AK7set+jzH5DbXimXIu/PLpv0ONHG0IeYaZOzibiKULpjUegqIkW8pznBX7JLvV6A6P125z8hVfdhA==
X-Received: by 2002:a05:600c:1e0d:b0:3dc:3f1b:6757 with SMTP id ay13-20020a05600c1e0d00b003dc3f1b6757mr10561869wmb.15.1675075741688;
        Mon, 30 Jan 2023 02:49:01 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm12927057wmb.1.2023.01.30.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:49:01 -0800 (PST)
Date:   Mon, 30 Jan 2023 11:49:00 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Jinyu Tang <tjytimi@163.com>, palmer@rivosinc.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com, yuzhao@google.com,
        conor.dooley@microchip.com, guoren@kernel.org,
        tongtiangen@huawei.com, anup@brainfault.org,
        akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
Message-ID: <20230130104900.muwgikgkvkn2byna@orel>
References: <20230129064956.143664-1-tjytimi@163.com>
 <CAK9=C2VaxNezv+M=s=ZSA-YDf_17+hcom_z1=_j2YkRHg-yg7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2VaxNezv+M=s=ZSA-YDf_17+hcom_z1=_j2YkRHg-yg7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:55:55PM +0530, Anup Patel wrote:
> On Sun, Jan 29, 2023 at 12:21 PM Jinyu Tang <tjytimi@163.com> wrote:
> >
> > The arch_has_hw_pte_young() is false for riscv by default. If it's
> > false, page table walk is almost skipped for MGLRU reclaim. And it
> > will also cause useless step in __wp_page_copy_user().
> >
> > RISC-V Privileged Book says that riscv have two schemes to manage A
> > and D bit.
> >
> > So add a config for selecting, the default is true. For simple
> > implementation riscv CPU which just generate page fault, unselect it.
> 
> I totally disagree with this approach.
> 
> Almost all existing RISC-V platforms don't have HW support
> PTE.A and PTE.D updates.
> 
> We want the same kernel image to run HW with/without PTE.A
> and PTE.D updates so kconfig based approach is not going to
> fly.
> 
> >
> > Signed-off-by: Jinyu Tang <tjytimi@163.com>
> > ---
> >  arch/riscv/Kconfig               | 10 ++++++++++
> >  arch/riscv/include/asm/pgtable.h |  7 +++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e2b656043abf..17c82885549c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -180,6 +180,16 @@ config PAGE_OFFSET
> >         default 0x80000000 if 64BIT && !MMU
> >         default 0xff60000000000000 if 64BIT
> >
> > +config ARCH_HAS_HARDWARE_PTE_YOUNG
> > +       bool "Hardware Set PTE Access Bit"
> > +       default y
> > +       help
> > +         Select if hardware set A bit when PTE is accessed. The default is
> > +         'Y', because most RISC-V CPU hardware can manage A and D bit.
> > +         But RISC-V may have simple implementation that do not support
> > +         hardware set A bit but only generate page fault, for that case just
> > +         unselect it.
> > +
> >  config KASAN_SHADOW_OFFSET
> >         hex
> >         depends on KASAN_GENERIC
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 4eba9a98d0e3..1db54ab4e1ba 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> >          */
> >         return ptep_test_and_clear_young(vma, address, ptep);
> >  }
> > +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
> 
> > +#define arch_has_hw_pte_young arch_has_hw_pte_young
> > +static inline bool arch_has_hw_pte_young(void)
> > +{
> > +       return true;
> 
> Drop the kconfig option ARCH_HAS_HARDWARE_PTE_YOUNG
> and instead use code patching to return true only when Svadu
> ISA extension is available in DT ISA string.

Indeed. I should have checked if there was an extension for this
first. It crossed my mind that we should only be enabling features
when the extensions are present, but looking at the privileged manual
isn't sufficient to learn about the Svadu extension. I should have
checked https://wiki.riscv.org/display/HOME/Specification+Status

Anyway, I retract my r-b and agree with Anup.

Thanks,
drew
