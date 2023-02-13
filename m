Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CA69472E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBMNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:38:21 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1941E1716B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:38:20 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id t74so2172718vkc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676295499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiocV00En5D5cLXBZHTCzW16cVc0Pj8et9mT/H0L18Y=;
        b=HxTUETCUsjJ18Q9E4rFJV4FjWTaROLW3+AtHothjcu7bNoPaqml3RyiyTic08AYEpk
         jTFHU7hGK8/gc9MK1yXPO6ShAH3XJqr4G9jDRAAh5zQWysE8Q/M8BJcagkLGNCLCD4Qg
         aGnzn6botuEeOo9CddWeqM7bd5+8V8M9cjam2jQ4o/YBMKzF5JQwdkJP7q5kwcJMutRN
         5jVj1e2Qum6g48RK3buasXKXSfqwrZITbCcAE5y0naCNG/krgYMUK4792vZRMMXunqEe
         19GMrMjdgnUCPZVH3MSfw7LGROB6nku1tyESlO8FzoEVPLtbm+RGQ4xNbDabQu+/UGxL
         osEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676295499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiocV00En5D5cLXBZHTCzW16cVc0Pj8et9mT/H0L18Y=;
        b=oNK8FKR4xAAXN5E2DX+ZrlP7SYbe6Uugg8HDf9wq+VE89csVneTtV9JxKX1UKu6wK3
         MMWws6eOiGN8yVc2y6ViofPud08jcudsYMz7qSb9pOe8IqvnaNjBrjVlFg0mdWjBzYlD
         E1ZeTGjPMXyUh72Ks9cCE61NCF0c3BlahGsGgHgSrPicfg27PefnDunM8iE8VisN8KkX
         YofhEXPTuSL07za4JE9/7VbK/eZbTKfRP5TPIiu5Ztrh9JQl83blPgYgnaiQkk+eNqSg
         Ov6LH/HQgjHa7yC2kU2hFMsEqd9exL/wkfIQhJ2lVNE3W4kNo3tTTTnz5dtRpSKlic/a
         1Gvw==
X-Gm-Message-State: AO0yUKVhDTb95HgRZMcMhz6/4XY81x+7t/v/NHev52nLJmF8Mp6ZZhmw
        fC1avnMogUuu3oJ4ZElO32j21HagJljrEfCcLL/+kZE+oT89FsykNTM=
X-Google-Smtp-Source: AK7set/l3c8GmYteAMqSJ6SPYkS1v+afgnQO1saFsyMt/OzFIAUcb8IlbO8CA0+xxyWvCN279WdrtcqJghM37ky6Zuk=
X-Received: by 2002:a1f:2bd0:0:b0:3e8:a035:4860 with SMTP id
 r199-20020a1f2bd0000000b003e8a0354860mr4437186vkr.7.1676295499037; Mon, 13
 Feb 2023 05:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <Y+aaDP32wrsd8GZq@tucnak>
 <CANpmjNO3w9h=QLQ9NRf0QZoR86S7aqJrnAEQ3i2L0L3axALzmw@mail.gmail.com>
 <Y+oYlD0IH8zwEgqp@tucnak> <Y+ouq8ooI7UH4cL+@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+ouq8ooI7UH4cL+@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Feb 2023 14:37:42 +0100
Message-ID: <CANpmjNNxX-YpRkEHYjpZGVDw=9nRpyHbGRz6jCV14=bxtsXENg@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org
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

On Mon, 13 Feb 2023 at 13:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 13, 2023 at 12:01:40PM +0100, Jakub Jelinek wrote:
>
> > The current gcc behavior is that operations like aggregate copies, or
> > clearing which might or might not need memcpy/memset/memmove under the hood
> > later are asan instrumented before the operation (in order not to limit the
> > choices on how it will be expanded), uses of builtins (__builtin_ prefixed
> > or not) are also instrumented before the calls unless they are one of the
> > calls that is recognized as always instrumented.  None for hwasan,
> > for asan:
> > index, memchr, memcmp, memcpy, memmove, memset, strcasecmp, strcat, strchr,
> > strcmp, strcpy, strdup, strlen, strncasecmp, strncat, strncmp, strcspn,
> > strpbrk, strspn, strstr, strncpy
> > and for those builtins gcc disables inline expansion and enforces a library
> > call (but until the expansion they are treated in optimizations like normal
> > builtins and so could be say DCEd, or their aliasing behavior is considered
> > etc.).  kasan behaves the same I think.
> >
> > Now, I think libasan only has __asan_ prefixed
> > __asan_memmove, __asan_memset and __asan_memcpy, nothing else, so most of
> > the calls from the above list even can't be prefixed.

Correct, right now libasan only does memmove, memset, and memcpy. I
don't think it'll ever do more, at least not in the near future.

> > So, do you want for --param asan-kernel-mem-intrinsic-prefix=1 to __asan_
> > prefix just memcpy/memmove/memset and nothing else?

Yes.

> > Is it ok to emit
> > memcpy/memset/memmove from aggregate operations which are instrumented
> > already at the caller (and similarly is it ok to handle those operations
> > inline)?

Yes, I think that's fair.

> I'm thinking it is trivial to add more __asan prefixed functions as
> needed, while trying to untangle the trainwreck created by assuming the
> normal functions are instrumented is much more work.

For the kernel param, I'd only do memcpy/memmove/memset, as those are
the most brittle ones. The string functions are instrumented on most
architectures through lib/string.c being instrumented.

Thanks,
-- Marco
