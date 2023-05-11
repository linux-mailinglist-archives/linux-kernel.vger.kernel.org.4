Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67856FE9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjEKCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEKCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:44:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42C49F9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:44:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso5254872e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683773052; x=1686365052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7rMa9jvL/jm69EPCEihwi6Elw876z+kbt0ES9Rgu6g=;
        b=kso8xE9nDAZhqYv7SjjhFjTmw6sr6VZ2trUU3zhe74uOQAPtXuhcMnM9kUfCh5Xl6K
         cRvYTiMeHqxiu6gBWHaJSXxe0/QutYfXSzsGg7UikjMaDZQjPf+8Sja2FfrLMZSEXsaJ
         1aIUCWXirsSq1tKGR5+3x/H1nDbqLBFQ3Ub+xv/iHTjomsQuFTH0aBW1mloZDi2yxyC7
         jEntgyCcDT9N7QN2nPoIyLnrSYOAxPpHTLK0vTYyIRhXwbRfxjkS39qyQ1BIB71iALu+
         vl2KlgTAyHMBinGckrHZDCl1EORlU+ji5MxJWg1VPxWAydD60eE6CBYZv6Mk+pKqzyxj
         bnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683773052; x=1686365052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7rMa9jvL/jm69EPCEihwi6Elw876z+kbt0ES9Rgu6g=;
        b=UnFjYfyhl7Rt7gE0552GNRRJHntBVVmAH1JZOYwjUs959rPUXQbtrTRHeSNu6hKjJh
         yp6JvbfXdDZqtZRHJEaZKQ07OGqZEayteCjTjt6m97gfbX+GLdEFFC6g+QmtN6yHnGok
         d00qJ97RJimi6LZ4TGypk+IAA23uuw6CXaZh10sMmH66kpu9RVGp+qXIAExOflKpqrhU
         0LKdzfwe9ZagzdI1rJp7Gpy4WfCH3hcgEgTBu99HpAQpSBeJMiXZ0Yd0d4lAUAi7m/tw
         mdfkZIYjuET3+ZApbQ2/D97ZyE/z6YI+ilWtt2FDI/usk/qRf1wodM5zCg+rG5mb9Pwq
         H8hQ==
X-Gm-Message-State: AC+VfDy3QkkLi5hWjCijeOoyN4NonB7NZrDbKbbAV7cS0E2ftBELhv08
        HRGsX/BBX1h5TMhrqHLxjzN1zO1jLpVoJDnG3c8=
X-Google-Smtp-Source: ACHHUZ6pDenYmvTlbJdon/tXIRnRgvejfHLwAJ/zZA3nKt83sqaQgzu2laNIN3VD/OBxjY3xWEzXFbTqwbD0Q8aBhGE=
X-Received: by 2002:ac2:5fd2:0:b0:4ed:c61d:c8e8 with SMTP id
 q18-20020ac25fd2000000b004edc61dc8e8mr2366686lfg.29.1683773051996; Wed, 10
 May 2023 19:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <1683685251-2059-1-git-send-email-zhaoyang.huang@unisoc.com> <ZFwVypakvK7XJpFl@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZFwVypakvK7XJpFl@P9FQF9L96D.corp.robot.car>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 11 May 2023 10:43:48 +0800
Message-ID: <CAGWkznEa3fgZT6K+bKnd632Mt+3hCvOBoLBJx9MOcRAcq13xKw@mail.gmail.com>
Subject: Re: [PATCHv4] mm: optimization on page allocation when CMA enabled
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 6:08=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, May 10, 2023 at 10:20:51AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Let us look at the series of scenarios below with WMARK_LOW=3D25MB,WMAR=
K_MIN=3D5MB
> > (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start=
 to use
> > CMA since C which actually has caused U&R lower than WMARK_LOW (this sh=
ould be
> > deemed as against current memory policy, that is, UNMOVABLE & RECLAIMAB=
LE should
> > either stay around WATERMARK_LOW when no allocation or do reclaim via e=
ntering
> > slowpath)
> >
> > -- Free_pages
> > |
> > |
> > -- WMARK_LOW
> > |
> > -- Free_CMA
> > |
> > |
> > --
> >
> > Free_CMA/Free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> > fixed 1/2 ratio                 N             N           Y
> > this commit                     Y             Y           Y
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> I'm mostly fine with the code. The commit message is still very confusing=
 to me,
> not sure I understand what exactly this table means. And you still use "U=
&R".
I would like to highlight the scenario "A&B" where the previous fixed
1/2 ratio introduces over use of UNMOVABLE & RECLAIMABLE. I will try
to make it more clear by v5
>
> Also I'm a bit concerned about potential performance implications. Would =
be
> great to provide some benchmarks or some data.
> Probably it's ok because of we have pcp caches on top, but I'm not 100% s=
ure.
This patch helps solve my OOM issue in v5.15. Actually, It inherit the
logic of 1/2 ratio and just behave differently when free pages is
around corresponding watermark
>
> Thanks!
