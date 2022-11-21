Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A9632D99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiKUUDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKUUD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:03:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635526AE1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:03:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so20502295lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmYuX3VWcUYVzqGRCyga5UCUeirZrcUXT/K4ry4R96E=;
        b=VPP1K0/QOou9Lh89QKLdRSbxua06FbJPCj1mshq/bGLSyN6grxpijaPYSkM/KmrlhM
         qR1UcalqIr3wk9nNOqAnVqE1L8VVKfKjuqMuAbK/FN43jFEHPQ0oAcnGsTF6VgxsD3Vo
         HFs8QPw1DetuS282+KNF7ccYaImpCI03q92fv2rxptwsgCU+kDFVG3pnCgz3w6qFcFV/
         jKnIhZ5yyj3lhjDaeb1ClBNWyuXNkHrPQG34WPIlENaDpfoQLVt2fhfHRB0tBKIs5WS6
         wu+7Wrjg4ONPnicq9VVhHlqOaXkUb+LbRrR++EYPXKjhUWuVvKxhmAsC6yIewVVxX0ey
         aFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmYuX3VWcUYVzqGRCyga5UCUeirZrcUXT/K4ry4R96E=;
        b=hyfx/UyI2RGQYhBQeW2L/W8qIvqh9coEXSJA0HoOb2r/w9D/1BEQQkqr/gA17kXZzc
         rEndpubwwclMkgni96pY6fwOKwW5/t5Ex/rJEqTYnqUv9SV/nXSpk/svcYi6e81q5Bww
         MTKQvjMLDGSuRzcdIAVKxJcCISWcwCeP6qupXIcJu5iYrE4C+tDqNVsdtkgrNPr0ugpk
         Bcz9By3OupVfmSmUoO74+V4oARxnxnoE5m2rMyHa4+KrMJMGDqrNBxU4YC2b0L6bp5xh
         psS3JbuNplk4lte64/EbR8EBCMQ0UCzknngTT8tsBJzf6We3wfGZksiawfP9YwW+WgUL
         7EgA==
X-Gm-Message-State: ANoB5plgOOPiSLpRr//H5N4ldVzuatfjkFLFBSK1R6EWwNWzE0HI36oc
        qvjFv/bFl+HL/wYZo8GO52I=
X-Google-Smtp-Source: AA0mqf4ByMquJSxW5az0K/kINNMf2X0ta7kjCVg3nJKQjKuqgGl03pdZOY0hXqvXcN01v53k3Ju9FQ==
X-Received: by 2002:a19:6519:0:b0:4b4:b5d7:a70b with SMTP id z25-20020a196519000000b004b4b5d7a70bmr6357266lfb.584.1669061003431;
        Mon, 21 Nov 2022 12:03:23 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id n16-20020a195510000000b004aa255e2e66sm2171955lfe.241.2022.11.21.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:03:22 -0800 (PST)
Date:   Mon, 21 Nov 2022 23:03:21 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <Y3vZiYDpL73O3FNK@curiosity>
References: <20221111075902.798571-1-guoren@kernel.org>
 <Y3fxsWPLPlKGfMBj@curiosity>
 <CAJF2gTRQgqRwjOYKB9Z6OdYoogsHWWVTw5anwNqoQjhmK_A41g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRQgqRwjOYKB9Z6OdYoogsHWWVTw5anwNqoQjhmK_A41g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Ren,

> > > After use_asid_allocator is enabled, the userspace application will
> > > crash by stale TLB entries. Because only using cpumask_clear_cpu without
> > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > > Then set_mm_asid would cause the user space application to get a stale
> > > value by stale TLB entry, but set_mm_noasid is okay.
> >
> > ... [snip]
> >
> > > +     /*
> > > +      * The mm_cpumask indicates which harts' TLBs contain the virtual
> > > +      * address mapping of the mm. Compared to noasid, using asid
> > > +      * can't guarantee that stale TLB entries are invalidated because
> > > +      * the asid mechanism wouldn't flush TLB for every switch_mm for
> > > +      * performance. So when using asid, keep all CPUs footmarks in
> > > +      * cpumask() until mm reset.
> > > +      */
> > > +     cpumask_set_cpu(cpu, mm_cpumask(next));
> > > +     if (static_branch_unlikely(&use_asid_allocator)) {
> > > +             set_mm_asid(next, cpu);
> > > +     } else {
> > > +             cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > +             set_mm_noasid(next);
> > > +     }
> > >  }
> >
> > I observe similar user-space crashes on my SMP systems with enabled ASID.
> > My attempt to fix the issue was a bit different, see the following patch:
> >
> > https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
> >
> > In brief, the idea was borrowed from flush_icache_mm handling:
> > - keep track of CPUs not running the task
> > - perform per-ASID TLB flush on such CPUs only if the task is switched there
> >
> > Your patch also works fine in my tests fixing those crashes. I have a
> > question though, regarding removed cpumask_clear_cpu. How CPUs no more
> > running the task are removed from its mm_cpumask ? If they are not
> > removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
> > TLB flushes to those CPUs when ASID is enabled.
> A task would be migrated to any CPU by the scheduler. So keeping TLB
> contents synced with cpumask_set/clear needs additional tlb_flush just
> like noasid, and your patch still follows that style. The worth of
> ASID is avoiding tlb_flush during the context switch. Yes, my patch
> would increase some tlb_flush IPI costs. But when mapping is stable,
> no tlb_flush is needed during the switch_mm (Hackbench would be
> beneficiary because no more TLB flush is needed at his hot point
> path). Here are my points:
>  - We copied the arm64 globally unique asid mechanism into riscv,
> which depends on hardware broadcast TLB flush. My fixup patch is
> closer to the original principle design, proven in the arm64 world.
>  - If riscv continues local TLB flush hw design in ISA spec, please
> try x86's per-CPU array of ASID. But that is a significant change;
> let's fix the current issue with the smallest patch first.
> 
> In the end, thx your review and test.

By the way, how did you verify the patch ? Do you have any good
reproducer for this issue ?

Regards,
Sergey
