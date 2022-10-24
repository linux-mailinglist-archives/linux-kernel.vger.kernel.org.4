Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D0609DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJXJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJXJRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:17:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D566C121
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:17:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r18so8164449pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E90yK8wonsHofoZqda9QGC2Kinjyxdvs/JNsLBuhZMI=;
        b=MuoVAmKPz2IxYaB6nczSI3E/Y78v4f7sUKyAPkUGTb+M0iiZq8IbgRw2u3QZBpnPRT
         gY0MPc0a/UMRoBuLKRtHRuZXNgLEOBivRI5jA/qFOuHnnjpOOl/b8/letmaAkKnbvAEX
         hhR4hrNkB5RcVMqnU+t8LraIPg3UQIPhrINtWSqpzp+Y7BbBAkyAq/zaJuGsYquGFeiH
         6CohnitTxgTfgOBtQdYzjmh09lu/FfcARO7EeNEn9NggZhWu+vs32ny0P2F9LgsxJHBu
         LhkYfrWzV4+NgLH+MVob7G6gocLimybd5usm7JFM98WY3aPSp6sx49AF3URCGqGvOweG
         Qh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E90yK8wonsHofoZqda9QGC2Kinjyxdvs/JNsLBuhZMI=;
        b=H3z80n9GSEw+KhnvFEpgfNTow0idd8r7zj7JKR2spCgpanzrG+1bLdzdXvDlcRZhgj
         ZvM5o99gGGpvSwkaeBhmwTkvY0cgVnLxVxpX5auXw57bjOUWEmOs2GFqsrk4PHAHFfbW
         9LAI5JFH4nUlgzJdN7eWRtS0DnvIT8EGYRX90eLeNm9yU4bqsal6HvtOM7D5WL7Nnmy9
         jBpDZd4NmxcB2GSV7I+qIO0/5SqylqEI8rdmPFa8eO/qMhS+R1zdoQVTRpFkFOgWxZ+4
         ZRDYZkNbDQFdz4u9N9nckFXa3OBG6nod3CKMR3XI83nXAy/4sGLf7mOBzuxiyTJbPJd/
         cwaA==
X-Gm-Message-State: ACrzQf3lLfd2z0APLGPU0KCfI9QEubjeEruduV+aNUt46Xl+OuVfK5kZ
        Ub8ZNrdrxptQ+0D+iF9whnHVwA==
X-Google-Smtp-Source: AMsMyM6+5BaNoVlMbXOb9WhEsuyIraEFR5wrdMYEtNDGK09RXK2gptzkDetXYlPoHQqDgdHXzcybXw==
X-Received: by 2002:a63:1f0d:0:b0:464:69f8:1cbc with SMTP id f13-20020a631f0d000000b0046469f81cbcmr28015852pgf.574.1666603025252;
        Mon, 24 Oct 2022 02:17:05 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0018693643504sm3269727plb.40.2022.10.24.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 02:17:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 17:16:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf record: Fix event fd races
Message-ID: <Y1ZYCD1LjC5OhWsq@leoy-huanghe.lan>
References: <20221024011024.462518-1-irogers@google.com>
 <Y1X+7FCemionnepj@leoy-huanghe.lan>
 <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWUrwQ187O7d0incvRFQ7RT+1viG30k+F1ZEEU3BEFeFA@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:33:30PM -0700, Ian Rogers wrote:

[...]

> > > +static volatile int done_fd = -1;
> >
> > Here is a bit suspecious for adding volatile qualifier.  See the
> > document: process/volatile-considered-harmful.rst.
> >
> > I know the document is mainly for kernel programming, but seems to me
> > it's also valid for C programming in userspace.
> >
> > I not sure what's the purpose for adding volatile for done_fd, if we
> > really have concern for reading any stale value for done_fd, should we
> > use WRITE_ONCE/READ_ONCE?
> 
> We could just switch to C11 and stdatomic. The volatile is consistent
> with the code above and more consistent with the expectation of
> writing to a variable that is read in a signal handler.

Thanks for the info for C11 and stdatomic.h.  The documentation [1] says
the safe way is for accessing shared data in signal handler is:

  static volatile sig_atomic_t done_fd = -1;

It's fine if you want to use another patch to address this issue, this
patch for fixing errno is fine for me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

[1] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
