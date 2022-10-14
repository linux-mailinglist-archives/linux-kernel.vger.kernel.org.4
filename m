Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A835FE795
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJND00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJND0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:26:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61718F276
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:26:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y10so2381677wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezfMH1M8CgZm9uCtaIu6h7oFmHb3YSxbGtnTFpXFyu4=;
        b=thGSPXyv3XwUcIvqe1vn1S10l+qpM1ML+rE4YuOaSlP1nRa0TIm7FKciGqUzlvc/B9
         BVde/7FQbl3itAcPpATPaXtRDi9tS3rhjbu0YpeuqcNTfK1iRn8md2Jk7NvbNaT249ur
         1vkb9mjpuTFcdoKDsw7esb4L05N5SCWbkTD8eqs4Dm1Km4pLuhsUD1ub7iCaib40Oke/
         7ibv8ErocpFFJB+3pXEp/hcTusFKo+snlPXvt9JbW7Ud5dbBhvGJ9F0lxRMnhuZD+hyr
         ghwnLpEu3kunTtNwPx1haW8VKX3mQux9miTP4LUx909bhho7OGedQIOcZwqk832Ll0xR
         BZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezfMH1M8CgZm9uCtaIu6h7oFmHb3YSxbGtnTFpXFyu4=;
        b=n3Rjdo1DF3/n2fpQk4VxT+XekjslxAVKv7Ob2lugPddxymZaZ8KMer/ozpvzb9TV0q
         OuBkAStxbR+fXNwdoehlfuqXJqMo/mMIAXNXyRNvmsMLWU66278Sd8palTb2Qnx2fNEb
         gsi2+A98Dr7JtvQVtyKY5Ct6deMFNv2705dbIddwM75p9DZfmjMde7/65CFFoQiA0D17
         gUmAd28kmRBozFOcdqiCb7nrXHhpzaII5nQJxjTIZM6kpQe8WqEJUbSSofE7YZuxhSb2
         8Y8wIjiTRDwA1KBz2ab5e2Tj3n6LmxTFfE1Csc6H9dXO0I1WntXVzWlMCK7NDmZrgMMQ
         uPtQ==
X-Gm-Message-State: ACrzQf2+5SiqQKPo3ZKT3Qgz1eD9CX2AM6KjBVcz5H9DYUUt+u+YsQ52
        nZzLpINei0cgg5IaTlDdubyXyl5zU1NO9whHXRXQTGPcIUf3OQ==
X-Google-Smtp-Source: AMsMyM4UMdiWhBGftgOzR8/2OwZAPIfOcGhVzGJzBOUhF3W3yYfjUz1PqaN3zdDRIrR8K9OwAxz2BvZlzeRx8Y7TTus=
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id
 l17-20020a1ced11000000b003b4d3e10becmr1830314wmh.196.1665717976609; Thu, 13
 Oct 2022 20:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
In-Reply-To: <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 20:25:40 -0700
Message-ID: <CAJD7tkayXxKEPpRE7QvBN4CikqeQcUe3_qfrUaH4V+cJrk0y=Q@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 7:39 PM John Stultz <jstultz@google.com> wrote:
>
> On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > I have a question about ktime_get_mono_fast_ns(), which is used by the
> > BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> > this function specifies that there are cases where the observed clock
> > would not be monotonic.
> >
> > I had 2 beginner questions:
>
> Thinking about this a bit more, I have my own "beginner question": Why
> does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
> accessor instead of ktime_get_ns()?
>
> I don't know enough about the contexts that bpf logic can run, so it's
> not clear to me and it's not obviously commented either.

I am not the best person to answer this question (the BPF list is
CC'd, it's full of more knowledgeable people).

My understanding is that because BPF programs can basically be run in
any context (because they can attach to almost all functions /
tracepoints in the kernel), the time accessor needs to be safe in all
contexts.

Now that I know that ktime_get_mono_fast_ns() can drift significantly,
I am wondering why we don't just read sched_clock(). Can the
difference between sched_clock() on different cpus be even higher than
the potential drift from ktime_get_mono_fast_ns()?

>
> Looking at some of the uses of ktime_get_mono_fast_ns() spread around
> the kernel, some are clearly necessary (trying to get timestamps in
> suspend paths after timekeeping might be shutdown, etc). But there's
> also a few cases where the need isn't clear and I'm worried the
> reasoning is because it says "fast" in its name.
>   "Why stop with ktime_get_mono_fast_ns() when you could instead use
> ktime_get_real_fast()! It's *real fast*!" :)
>
> thanks
> -john
