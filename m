Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8722E60807E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJUVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJUVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:04:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27752D1ED;
        Fri, 21 Oct 2022 14:04:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1286149pjc.0;
        Fri, 21 Oct 2022 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufCCYZYJTmJF/KoW5M3amrstoH4BcMXNIbfmJhiw4Bg=;
        b=WCWaYaayvJhFN0nzxYZ8rTHbSJb3QZ8teTfyxYm1ciVC4ozBAjqHfy5axAMQ+Lq1pz
         wMmHX/otXDp+ixHCVLZitVt/EsirR80dPz75DR/89XspfmMN7qtcsOop1T0ETvSY1ESK
         duNo6HAR+TD2Z4ee2LnD33fhQNuEeB16NFirodfgKS1WdurxWUvd5yENnrQVhk3YvCWk
         4JO7UxIDGEXfH5uQLzODMbz9w8rXiJ8WE+ETjtpZCEaovHQE4jB+uXUKjsXpihDskgpa
         3gZQ8lQ6EJrraUf3tqB7IcM/Qjs+N6bOlr2EMQE5qoAp1Z/DrRwkvXIQKc6yGK+p5CmM
         /jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufCCYZYJTmJF/KoW5M3amrstoH4BcMXNIbfmJhiw4Bg=;
        b=pH8AK0NCJQkHNNJIWrvM+0VdKD0v1OzLxgX168qYyW5BxJQq1acAeDLbJa+Z25hS+A
         AusLCWOFv4tkHMzU6ro21tx74d54XOReTeDHaimB80kAM8bbntxU9pDCu4P0/EJwYscP
         PR/y2AW7xGqyLaPzj1MtPaaEgrg843l4+ixZ9zPQ5CPaFjUuqYu2NhsxqFSkc+tMX38o
         CSyGOPCBDh0Wk94BzwmA19Is8cmHbpvqn58ahnKnvQJ49+CZSdQ+jJrlJ6rcIqq4q6K6
         tl3Doq9Gpz1LKZ6IQQLW6oDlGuZB1tuXkDWMCpKgu95xHUGiqVTDBGa26uS0ZIZ9vk2I
         XGBQ==
X-Gm-Message-State: ACrzQf0ZmZzUimVC/nkf8iTbQNm7Eb0luXBpFjYHmpecINpSLNJfQkIh
        frJN0yoxq1fn2cV0YzDBc4CVsrHUy51RVHMQ8xQ=
X-Google-Smtp-Source: AMsMyM5tsrngLoCck9omAqu1bf1kz4Ah2EpMQMR6bhFE6MpEItn2IXmD213rWwn/DZs1vJCr8D+09/EppIvZSTFyUfI=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr21208456plg.102.1666386287303; Fri, 21
 Oct 2022 14:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221005180341.1738796-1-shy828301@gmail.com> <20221005180341.1738796-3-shy828301@gmail.com>
 <20221013123830.opbulq4qad56kuev@techsingularity.net> <CAHbLzkpc+CAfsYe6gXjh=-3MxMH_aWhPMYhic7ddFZgWttOhng@mail.gmail.com>
 <20221017094132.vnanndrwa2yn7qcw@techsingularity.net> <CAHbLzkpmbmtOdOsud-VG+wyk18wFAFnan8T55XxxwkHrnhLCmw@mail.gmail.com>
 <20221021091911.ak3a7a3wr3qcbe3b@techsingularity.net>
In-Reply-To: <20221021091911.ak3a7a3wr3qcbe3b@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Oct 2022 14:04:34 -0700
Message-ID: <CAHbLzkpAX3CGRGsxj4CTsj=atXqPakJe7TSxVvp3KnKmygk=3g@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 2:19 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Oct 18, 2022 at 11:01:31AM -0700, Yang Shi wrote:
> > > > Yeah, I didn't think of a better way to pass the pages to dm-crypt.
> > > >
> > > > >
> > > > > How about this
> > > > >
> > > > > 1. Add a callback to __alloc_pages_bulk() that takes a page as a
> > > > >    parameter like bulk_add_page() or whatever.
> > > > >
> > > > > 2. For page_list == NULL && page_array == NULL, the callback is used
> > > > >
> > > > > 3. Add alloc_pages_bulk_cb() that passes in the name of a callback
> > > > >    function
> > > > >
> > > > > 4. In the dm-crypt case, use the callback to pass the page to bio_add_page
> > > > >    for the new page allocated.
> > > >
> > > > Thank you so much for the suggestion. But I have a hard time
> > > > understanding how these work together. Do you mean call bio_add_page()
> > > > in the callback? But bio_add_page() needs other parameters. Or I
> > > > misunderstood you?
> > > >
> > >
> > > I expected dm-crypt to define the callback. Using bio_add_page
> > > directly would not work as the bulk allocator has no idea what to pass
> > > bio_add_page. dm-crypt would likely need to create both a callback and an
> > > opaque data structure passed as (void *) to track "clone" and "len"
> >
> > I see. Yeah, we have to pass the "clone" and "len" to the callback via
> > pool_data. It should not be hard since dm-crypt already uses
> > crypt_config to maintain a counter for allocated pages, we should just
> > need to pass the struct to the callback as a parameter.
> >
> > But I'm wondering whether this is worth it or not? Will it make the
> > code harder to follow?
> >
>
> A little because a callback is involved but it's not the only place in the
> kernel where a callback is used like this and a comment should suffice. It
> should be faster than list manipulation if nothing else. Mostly, I'm wary
> of adding the first user of the list interface for the bulk allocator that
> does not even want a list. If there isn't a user of the list interface
> that *requires* it, the support will simply be deleted as dead code.

Thanks, I see your point. Will work on the new version to implement
the callback approach.

>
> --
> Mel Gorman
> SUSE Labs
