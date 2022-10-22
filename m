Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C76083BA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJVCzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 22:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJVCz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:55:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F624C10A;
        Fri, 21 Oct 2022 19:55:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so7571532wrp.10;
        Fri, 21 Oct 2022 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZQfSOG007JsloJZSjWgDXcu2EJ1dOkGZ6PoehGE318=;
        b=gnkOAP1URqY/NavqdeDr5qlYr5U1Fpo5eHgq0NbuExKfsEoLXllMQAYIYfKSy28nZ0
         u1IYUg7LyiGkp7CalxtkptnNtqHGL7sJ1tt5/WQmdHmQ3gG877WFoxMErf6e1EONefXz
         XVWfnU7go4mdCPopwGMrH+OxUGLl1gpWM4S2Ii5XZtjO0ssGElCXNJwQ70kTlt3ZA9jh
         8e8eyU8JRR7MO1hIRiFdMKSNp2Ag9BXkReVZAfY2Kzub2bArcKcB5GSqvi5KkzcfMPjA
         AF1buO5yeZVVsSV/FQrbwgPrS4ahZdRwhlV2KHuzGultkPYQiOv70NJtDmtWmcQ+7Gkq
         F6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZQfSOG007JsloJZSjWgDXcu2EJ1dOkGZ6PoehGE318=;
        b=cXvqHsPrS2M60XpBeRshv7o+lEVIggyVAaQCpoQjOM0rwTL/bBfhCDr0xk49axPUiN
         tRmVg+7NYleGY1lOe9VouD6lN+smpjwA30P++K5gOU9JmKpN19VgqEABHwDCY3tCLbRo
         IvCJnPYmVRZ2HDUmHTSD142Ykzts9ggFWD0zqPc0RpgKLqmyDjOfHmfCoJmiEZsoWXxH
         toXUB198rx2I5nZ0ENojri/wyRk5A9C4iB0j5cQlpDcKjTEZ58bLY4XGWJWVdQHbBfu7
         mqhdwSpdwTKlP7iTMZVI8QBlmyqvjDXowdZXyJhyFskj+4OaYOPV4daIM8jjpf8VTD3O
         dt4g==
X-Gm-Message-State: ACrzQf2o898VUZUibMxMHBJATeRMutOUZndjaoqZxzWnAUbMnnbUwQlr
        RHbzmGziRp1gxxcxiU5BG9mfBkww4g1oGuwe4QVbHEHOGt8=
X-Google-Smtp-Source: AMsMyM5EZV7UZ5T2DfupDfA4ALKUvjmk8AUTc5iIsI10M7Ly8pniRmKQ9kyO4QEDREO9iHLONujQskwaay1ufoMGoTM=
X-Received: by 2002:a5d:59a4:0:b0:230:eaa4:88d7 with SMTP id
 p4-20020a5d59a4000000b00230eaa488d7mr14537675wrr.35.1666407323787; Fri, 21
 Oct 2022 19:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rM0K=-wgJrS0iLMkam77JTO7oRxcP9VkHGbuTiVGBovMA@mail.gmail.com>
 <20221020111439.76e72230@gandalf.local.home> <CAJNi4rMVUzfZJPge=ncaULD87wLQ4TwWS=oKDuC1hZMoWi0OjA@mail.gmail.com>
 <20221020221255.5b3dffe1@gandalf.local.home> <CAJNi4rPPDp0xeEmqMBqX-pBqgAX7Biivyd+P_zhC7Y0-K3W0VQ@mail.gmail.com>
 <20221021083254.3c879824@rorschach.local.home>
In-Reply-To: <20221021083254.3c879824@rorschach.local.home>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Sat, 22 Oct 2022 10:55:12 +0800
Message-ID: <CAJNi4rNM+5FBvONjEc9k+6bR2oEgjgGnJ6w8ih=ZJXkVbUnKpQ@mail.gmail.com>
Subject: Re: Question about 'for_each_kernel_tracepoint(...)' function
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bristot@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 8:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 21 Oct 2022 11:51:20 +0800
> richard clark <richard.xnu.clark@gmail.com> wrote:
>
> > On Fri, Oct 21, 2022 at 10:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 21 Oct 2022 09:43:14 +0800
> > > richard clark <richard.xnu.clark@gmail.com> wrote:
> > >
> > >
> > > > Ah, as you can see that I did it, but the result is not what I
> > > > expected :-). Help?
> > >
> > > Looking at the code, I see it does indeed only look at builtin tracepoints.
> >
> > What the logic behind is not to implement a function like
> > 'for_each_tracepoints' instead of 'for_each_kernel_tracepoint' to find
> > all the TPs defined by both builtin kernel and external kernel
> > modules, just like we can find all the kernel symbols and exported
> > symbols from external module?
>
> Why? It's not needed upstream. If you push your code upstream and it's
> something to get accepted, then we can think about adding that.
>
> >
> > >
> > > But if you want one module to have access to the tracepoints of another,
> > > then you can have the first one export it.
> > >
> > > EXPORT_SYMBOL_TRACEPOINT_GPL(function_event_a);
> > >
> > > And then module b should have access to it.
> > >
> > Yes, but module b needs to register a new probe call back function for
> > the new TPs defined by module a in my case, so first it needs to find
> > the TPs defined by module a. Any comments?
>
> No, because I have no idea what you are doing or why you need this.

I've noticed that we have a Runtime Verification module merged into
the mainline and very interesting, so I am trying to provide a monitor
for my events in module A,  which means we need to register some new
probe call back functions for the TPs defined in the external kernel
modules. OK, I am writing this email just to confirm, maybe I need to
think about if I can add the external TPs into the
'for_each_kernel_tracepoint(...)' function...

Thanks!

>
> -- Steve
