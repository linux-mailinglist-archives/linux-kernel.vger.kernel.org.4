Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095846DA666
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjDGAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDGAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:00:50 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48483FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:00:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c12009c30so56428637b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUe0Zeu+77um4muZNyM98wqgNCUSH9t8M+sk1P4Rs2c=;
        b=GAEu0hx2ollv+g0TFazo9MnuzGvE0WDNcW64TTrX0NKQ9CqQU1OY6BjBHOgZgeeLCL
         CGniCLuxUFAfE9r0tZhfZs5/oFl6eiA/uOSitNgdka5p7+CVUwEOwdZd8MWbi0qxj9SJ
         8iwTgtLb3G1q2pQgNWyBjxWuOui/eKrOTJkOMuFUYtAQ8lPoM8hK/+fpd5zKfwNRPYsq
         JtVcrH8ZSI9sZ+a6X9dXiXZXZC66l6g0lJEmUOzY9CBGZV1NWKkPGee3AAo8MEKzhTWP
         DNsYUwHbhlG5x87B60Wco+S0q0utb+UVgVdGIwUTHjt34Hbohp7KBaXTH+/v3CtC2LLy
         6MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUe0Zeu+77um4muZNyM98wqgNCUSH9t8M+sk1P4Rs2c=;
        b=inaawvjLovxav1hCOk49m1lRuARhXq9zxoDL/rWbrNHqybtYBe1g6WIsorGv2FrKsH
         DcCf/dMQFJkNMhc06r5gTDZj6iVsjnM8zdtxloOHb4E/5LYBEARYoXzyRSXMWru/gdmv
         ibVWshHuTWzvSRV6OiijFiahOvSsEYso760vGtAv4gFMkwcu2qYhAs29pJswjabcvIes
         cOVX7NvQ6/IjeqkzhoWfH9gv2UN/f+K5JYuquk4plNpxliflajtvJ6haBLUi3PYomZMX
         wWDZUKMCn/XpqNbD9yT3OfAyN6wGyqoYrjsrf228lVl55QKSOjk9gWNqvy+VkFoeOLkp
         cVDg==
X-Gm-Message-State: AAQBX9c+8wYvcEZU65CQ6/rN+Sr0fRiRYYcY9vDjT1+QTt/gANKXVfxr
        N7pcBFRjQtW9vneMDkH4jQS2Zo3sWnWDyNG7uunKBUFJMDFwqBYfMq51hw==
X-Google-Smtp-Source: AKy350bf6UAG8mhENjiS0Lfk7jW8qr2aRjuZOYeJPenecPeBYqIeH1wo/a3sO+5YoLHoz5czfJvPs1BbexpqT4d5WxA=
X-Received: by 2002:a81:ac64:0:b0:541:7237:6e6b with SMTP id
 z36-20020a81ac64000000b0054172376e6bmr84906ywj.0.1680825645755; Thu, 06 Apr
 2023 17:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185650.239f9721f066aa480e83d543@linux-foundation.org>
 <20230405172524.e25b62e1c548a95564b1d324@linux-foundation.org>
 <20230406000854.25764-1-jaewon31.kim@samsung.com> <20230406014419epcms1p3f285b6e3fdbb1457db1bcbaab9e863be@epcms1p3>
 <CGME20230406000841epcas1p3630010a770682be0f1d540a448f3e00e@epcms1p2>
 <20230406021712epcms1p216f274040d25d18380668ffbfa809c48@epcms1p2>
 <20230405200923.9b0dca2165ef3335a0f6b112@linux-foundation.org>
 <CANDhNCq+mhhXjW7huYoQwUq18sRCcn6HjbPqh7mU9KrGyKeLfA@mail.gmail.com>
 <CABdmKX0ZnQX5BPEJjqxwUsx=c8ykcX8Bjitak50DAYvfti6VFw@mail.gmail.com> <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
In-Reply-To: <20230406163822.faae6a90b3aa4942df6e7442@linux-foundation.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 6 Apr 2023 17:00:34 -0700
Message-ID: <CABdmKX3NzTWHa3K_rna1iY+UERUrYK1Rq9WqUt9VQRaAKZsWwg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/heaps: system_heap: Avoid DoS by limiting
 single allocations to half of all memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Stultz <jstultz@google.com>, jaewon31.kim@samsung.com,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 4:38=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 6 Apr 2023 16:27:28 -0700 "T.J. Mercier" <tjmercier@google.com> w=
rote:
>
> > > When you say "decide what's the largest reasonable size", I think it
> > > is difficult as with the variety of RAM sizes and buffer sizes I don'=
t
> > > think there's a fixed limit. Systems with more ram will use larger
> > > buffers for image/video capture buffers.  And yes, you're right that
> > > ram/2-1 in a single allocation is just as broken, but I'm not sure ho=
w
> > > to establish a better guard rail.
> > >
> > > thanks
> > > -john
> >
> > I like ENOMEM with the len / PAGE_SIZE > totalram_pages() check and
> > WARN_ON. We know for sure that's an invalid request, and it's pretty
> > cheap to check as opposed to trying a bunch of reclaim before failing.
>
> Well, if some buggy caller has gone and requested eleventy bigabytes of
:)
> memory, doing a lot of reclaiming before failing isn't really a problem
> - we don't want to optimize for this case!
>
The issue I see is that it could delay other non-buggy callers, or
cause reclaim that wouldn't have happened if we just outright rejected
a known-bad allocation request from the beginning.

> > For buffers smaller than that I agree with John in that I'm not sure
> > there's a definitive threshold.
>
> Well...  why do we want to do _anything_ here?  Why cater for buggy
> callers?  I think it's because "dma-buf behaves really badly with very
> large allocation requests".  Again, can we fix that instead?
>
There are a variety of different allocation strategies used by
different exporters so I don't think there's one dma-buf thing we
could fix for slow, large allocations in general. For the system_heap
in this patch it's really just alloc_pages. I'm saying I don't think
the kernel should ever ask alloc_pages for more memory than exists on
the system, which seems like a pretty reasonable sanity check to me.
Given that, I don't think we should do anything for buffers smaller
than totalram_pages() (except maybe to prevent OOM panics via
__GFP_RETRY_MAYFAIL when we attempt to exhaust system memory on any
request - valid or otherwise).
