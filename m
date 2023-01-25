Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA99567A81F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjAYBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAYBBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:01:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052452330B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:01:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so234124wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r258p27VavUNvApfuYJcsJzQa0lc+7UlWV5c3aqUTJw=;
        b=qOfrqmoggV+NhgdLNj+4I+cqsC/GmmuaYUu4cySkOHOl5laGmw66Mwe5G6WbI5LCZx
         H5CStENsfDnAvA6gOw2zJSisHxoiPGuUNUuCyOKHtjVwQtBuCDaksqLhNZe+Ed7esPtQ
         v00bA6TNDWBW8QrzfcKXXQ6O5T6XszMgHfmvHcnH+O+dfTBSeP2py5vF2sfQUu6RiLQV
         HECtvTtlMfuzU3kyqLzupTnpY4V9NoD4DwVf3/N0w6qoQbEd/LaUEqJ3+DeX6TY6Ux8D
         X4TN8LqK6cDQglZfSInL91buXsSjW953HY+6R4/28UmCipJpz4Yln6hPYIJZqc7c+dWO
         1O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r258p27VavUNvApfuYJcsJzQa0lc+7UlWV5c3aqUTJw=;
        b=RO46e1E09rjF/yLntYwSxW1D4GRPaU1aPZ83PZh1PwFmRRxSU07auJXXFaqCGhln/O
         QuXKG11KHWpatSMDSbfzZAUL4QYtck7kde3mLGSKLRnWkWL1R0W9XwFV0CBFWePS7Yjm
         09RbIGjSQkDt6V0eMAROVfD1qtoqn/8pKgebjGO3qZII8vHl5Jb1hm0TswVTmobLVBU5
         gwHxKrj5I+cW6AizbOQ+RjvxBibNR1I8ujRPhpFsIlpMCXt5R0lBum58JdYs1OfRrxO+
         nBrjg/SLHreYmYEDQNi1m/1NsGpDd1EcfABQR36/unmT7opcu+I4wB7zQ1w1+kptADfR
         xd4Q==
X-Gm-Message-State: AFqh2kq2SxSuOdl/nZs9I0z+dZMV4AfzDqQgJdk4iIJ0lr6S8km8ozQQ
        btW3APaDvMxlBLYw5klRBjzB8dmV2udO8IlJdhYRcA==
X-Google-Smtp-Source: AMrXdXs9t/+WWaJ1ixe14hbVHXiGhPAO7RO71szJsKK6e75z0WMrgDSVYGu6ZRu8sffLubZZdJs7G4hXoCkJehuhYz0=
X-Received: by 2002:a05:600c:6020:b0:3da:1bb6:ed44 with SMTP id
 az32-20020a05600c602000b003da1bb6ed44mr2202939wmb.149.1674608503357; Tue, 24
 Jan 2023 17:01:43 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org>
In-Reply-To: <Y7w2qshoCEjKKVlz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 17:01:31 -0800
Message-ID: <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Jan 09, 2023 at 07:28:26AM -0800, Ian Rogers escreveu:
> > Hi,
> >
> > The Linux Foundation will apply to be a mentor organization for the
> > Google Summer-of-Code again this year. That application process starts
> > on January 23rd. For the perf tool applying as part of the Linux
> > Foundation, we have a good record of getting the contributors we ask
> > for as part of the program. Contributors are very welcome! For the
> > program we need mentors and project ideas. For mentoring the workload
> > is to review changes, to attend the office hours with the contributor
> > and to fill-in the 2 evaluations. For the project suggestions,
> > anything goes. I've included links to last year's suggestions at the
> > bottom. If you have ideas for projects then please reply to this
> > email!
> >
> > Last year there was confusion over whether people working in industry
> > could be part of the program. Our answer was yes in terms of support,
> > but they wouldn't qualify for the GSoC funding. I'll try to make this
> > clear on our wiki, if it isn't already on the Linux Foundation's.
> >
> > We'd like to continue having the requirements that applications have:
> > 1) what the project will be,
> > 2) a weekly time plan.
> > To make the program run more smoothly this year, we're also going to
> > add a requirement that the contributor has sent a patch to the mailing
> > list. The patch doesn't need to do very much, say a documentation
> > improvement, but I'd like to be strict and say that any application
> > not meeting this bar be rejected. Thoughts about this, improvement
> > ideas, and thoughts on what are good requirements are appreciated.
>
> A project like perf, being out there for quite a while, accumulates tech
> debt, such being a fact of life for any project.
>
> This being so common, I'd encourage people to try and propose to fix
> things not of their liking when trying to build, cross-build, use these
> tools.
>
> Being able to at least voice what you dislike, and possibly get some
> money out of trying to fix it, out in the open, what an opportunity!
>
> Go and try to fix things!
>
> Thanks Ian for year after year to go and take the SOC opportunity to
> improve perf.
>
> - Arnaldo

The GSoC 2023 wiki for perf is now available:
https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf

GSoC 2023 is trying to further broaden who can participate, and
"newcomers" are eligible. I asked for some clarity on what qualifies
as a newcomer and got the following reply:

"Newcomer" means newcomer in free software coding not newcomer in IT
in general, so people who have only worked in closed-source before or
people who were only managing in open-source but not coding are
eligible.

Thanks,
Ian




> > Thanks,
> > Ian
> >
> > https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
> > https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf
