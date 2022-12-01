Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDA63F9FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiLAVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiLAVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:45:11 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B110CC673
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:45:09 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f9so2791385pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn46VnyUMqzSzQ1K8Ll32Y84XAVx4QsLdJfs9pzff2s=;
        b=njUgiMv1w3eaALeRfGiRAfEogZF0XpkTXtaI/JcN69XbIgDREebzyGcYDeeyfwqxwr
         didsmGudQD3e+ffzRjUxzTg0RB/NaIq+WwaQnOzIs69/aA5I65o/69bn+G74NEoMYEzK
         rcvYS9N5m3ZpuBRmTGVvOmCM+8kBxy1TVHi0/oTQPQ7ClwDJ2zQqaosuOS8wRZheQoVy
         8B3zR+DhH9XLVcAZgqkYQ12xJUmNyWmIxg/eJF9Rd9IcD5qCZ0ZZQQmRLa8AI/ohGTNb
         xRNeSMSfRgawDoRhyOOQsOQBoWyvjw0RysTu0cy63T4RcGgfIgTgTh1rnnGuVIVA+/N4
         dawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wn46VnyUMqzSzQ1K8Ll32Y84XAVx4QsLdJfs9pzff2s=;
        b=HnG1L1UYBlQjO5ilGc6Cxr1+Af2CrSjJc+gQrJjc/7u4ypScvPll1C3lnVF1o2Grqc
         k6DavC7R4cuHBI/Uqfim2sA4qh09UEh2ghosJwaO21VS2AQ5ypVgqhCPRNxBuP+6GXax
         QT2QsG4XaORrqVkTXABYdArG1myRFbwxOlpWdBoXsGvZx/fm0iyCQwMxGmfE37It0rGd
         CVeuCYyRiFqHr037KCV0s2g+1Zni5oKEh255wgGbq3FQu85u0EilvDPhIWwRV6ecSFr5
         Y3OKXTPVuz8mqa7f39oc07os8qqQLAOramxv24iVtMWYZbuuyNf8a6y0oNoD4r1+XfQL
         4fzA==
X-Gm-Message-State: ANoB5pksE1l10rxOvDJDGbPfsdojdLda2rcvWqRlrZSpyE8XkeLkEruE
        LYUUsJDesVcEM7TQNhvQ9MO3w+V+XI2BAN6vkNM26B1v
X-Google-Smtp-Source: AA0mqf74OiiJr1/ycuLqcR+MfCt64pJ0eYbzKhTwzKvBv+KcYVP+Nx073aJ9jnZY2v9EFdMFV2Foy0VoL1MwA8A1S3U=
X-Received: by 2002:aa7:8753:0:b0:576:4673:ce3e with SMTP id
 g19-20020aa78753000000b005764673ce3emr2005323pfo.39.1669931108703; Thu, 01
 Dec 2022 13:45:08 -0800 (PST)
MIME-Version: 1.0
References: <202210181535.7144dd15-yujie.liu@intel.com> <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X> <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X> <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
 <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info> <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
 <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
In-Reply-To: <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Dec 2022 13:44:57 -0800
Message-ID: <CAHbLzkpH3StOAP3jnR1ALO9dpz43j8zOR88+fj4iwCRYsnt3=A@mail.gmail.com>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 01 Dec 2022 15:29:41 -0500 Rik van Riel <riel@surriel.com> wrote:
>
> > On Thu, 2022-12-01 at 19:33 +0100, Thorsten Leemhuis wrote:
> > > Hi, this is your Linux kernel regression tracker.
> > >
> > > On 28.11.22 07:40, Nathan Chancellor wrote:
> > > > Hi Rik,
> > >
> > > I wonder what we should do about below performance regression. Is
> > > reverting the culprit now and reapplying it later together with a fix
> > > a
> > > viable option? Or was anything done/is anybody doing something
> > > already
> > > to address the problem and I just missed it?
> >
> > The changeset in question speeds up kernel compiles with
> > GCC, as well as the runtime speed of other programs, due
> > to being able to use THPs more. However, it slows down kernel
> > compiles with clang, due to ... something clang does.
> >
> > I have not figured out what that something is yet.
> >
> > I don't know if I have the wrong version of clang here,
> > but I have not seen any smoking gun at all when tracing
> > clang system calls. I see predominantly small mmap and
> > unmap calls, and nothing that even triggers 2MB alignment.
>
> 2.8% speedup for gcc is nice.  Massive slowdown in the malloc banchmark
> and in LLVM/clang is very bad - we don't know what other userspace will
> be so affected.
>
> So I think we revert until this is fully understood.

+1

>
>
