Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E5603A39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJSG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJSG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:59:09 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3974E34
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:59:07 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id l19so10812228qvu.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b+dxGPxsF1U/h9C74jKmspxOijVQ4vRVIdXZB4T2rw=;
        b=Njn7c+zxkjdSzCkyt/fVfI/Qawme0OF20wCqlBCSMBShp3Fbil6EQOHshsGlXB9Lxw
         Bqx6Qh5zqWWIYicNRMmFUw+4DVs+YWCWcuX153CzqxXferIOU/kyYLO7qqOnuQJ96r9q
         ONjIagTiFLowDjBP5q6+cOF6fFbrUv7nkzMFWWvzTXShQWTHLychJpLiGIMM7TkLyVzo
         WwuLT4bZ0ttMBg1z+ZieINXbhH1xmkPWjVOhZdqJGBADD7hNIruuhtdKRwnS8eOvYklb
         4K7yuG8Kveir8T1Fs8//as84eqLq6j4wp42PXHzbPRYNtQJKPEepISQgofOpVhtGdqnm
         XZEw==
X-Gm-Message-State: ACrzQf1DgMAxQDjfMi6UMxZAB/9tUwzbOnSVckgI0oke9pJ7ntkEUdNh
        Af3TAwl32VO+Y3caKM/o9LOPkQZMTe48++Cm
X-Google-Smtp-Source: AMsMyM56veWCtFY4aGRzQb4NhG3iRtGkvRR1KiwBY4LHuC3Fln6s81xPbMm6Mn23ZCf9pzDh5SErEg==
X-Received: by 2002:ad4:5c46:0:b0:4b1:b7ed:33c8 with SMTP id a6-20020ad45c46000000b004b1b7ed33c8mr5284911qva.115.1666162746635;
        Tue, 18 Oct 2022 23:59:06 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id hh6-20020a05622a618600b00343057845f7sm3360854qtb.20.2022.10.18.23.59.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 23:59:06 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i127so8958683ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:59:05 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr5230561ybb.604.1666162745385; Tue, 18
 Oct 2022 23:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com> <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de> <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
 <Y065nbfVQwZhwt51@yury-laptop> <Y067uYGTaA93Hn3z@smile.fi.intel.com>
 <Y06/SipcWdh4uIqd@yury-laptop> <CAMuHMdVjViT8-VMPuKZz2O1sudy5ogHpzVYM_P+isjRRUNgirw@mail.gmail.com>
 <Y07RcE3fgoGLpNZz@yury-laptop>
In-Reply-To: <Y07RcE3fgoGLpNZz@yury-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Oct 2022 08:58:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3S2GS_YW4KP63TSWN2MEyusrvC6fh1ep7KMjU2OYHcg@mail.gmail.com>
Message-ID: <CAMuHMdX3S2GS_YW4KP63TSWN2MEyusrvC6fh1ep7KMjU2OYHcg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Tue, Oct 18, 2022 at 6:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Tue, Oct 18, 2022 at 05:15:41PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 18, 2022 at 5:01 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Tue, Oct 18, 2022 at 05:44:09PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 18, 2022 at 07:35:09AM -0700, Yury Norov wrote:
> > > > > On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:
> > > >
> > > > ...
> > > >
> > > > > For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
> > > > > to a value that matches to what's parsed from DT.
>
> ...
>
> > I haven't tried the patch from your other email yet, but I did try
> > CONFIG_NR_CPUS=4 and CONFIG_FORCE_NR_CPUS=y on
> > Icicle earlier today.
> >
> > There was no warning, as the number of CPUs did match, but the
> > fourth CPU (cpu@4, i.e. the fifth core in DT) failed to come online:
> >
> >     CPU3: failed to come online
> >     smp: Brought up 1 node, 3 CPUs
> >
> > BTW, it behaves the same with CONFIG_FORCE_NR_CPUS=n.
> > Increasing CONFIG_NR_CPUS (before I used 8) makes the fourth
> > CPU core come online again.
>
> The problem is seemingly unrelated to CONFIG_FORCE_NR_CPUS...
> If so, we don't need ARCH_UNFORCE_NR_CPUS. Is that right?
>
> This all looks weird. RISCV hasn't an arch code to setup nr_cpu_ids,
> and therefore should use generic setup_nr_cpu_ids(), which is:
>
>   void __init setup_nr_cpu_ids(void)
>   {
>           set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
>   }
>
> Where:
>
>   static inline void set_nr_cpu_ids(unsigned int nr)
>   {
>   #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
>           WARN_ON(nr != nr_cpu_ids);
>   #else
>           nr_cpu_ids = nr;
>   #endif
>   }
>
>
> As you can see, at this point cpu_possible_mask is initialized based
> on DT, and even if arch has non-dense cpu_possible_mask, the logic
> should still be correct.

Quite possible this is just an issue with the RISC-V CPU sparse hart ID
handling code.  E.g. arm64 works fine with cpu@{0,1,2,3,100,101,102,103}
and CONFIG_NR_CPUS=8.  NR_CPUS in arch/riscv/Kconfig has always
defaulted to at least 8, while all upstream DTS files describe only
4 Linux-capable CPU cores (+ 1 management core).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
