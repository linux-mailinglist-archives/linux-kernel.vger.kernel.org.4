Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D726373453C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFRHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 03:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 03:30:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C719C3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 00:30:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so2562964276.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687073447; x=1689665447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GpkTkFOMPY9g8skCMNjWh2GIwghKNPBLJZcIyUZbKMY=;
        b=MTNOWty8sSIzlRJfIO2vIN2hsFJlvKyooHme6SOOygoIuKLiU6vwtpcKAxgsRQGCiy
         obAltEuK17x5oALGPyI5GM3iVnNvNrfu1L3KFLZ4mAEenTpUPyDKU0GtxanyVFrOw4xg
         V+TytkF05W7BFl83cy1dhoMgCPna8CSXk5ayNqWZuOdC/d6syJaZAoXFDutIfPO/uwTZ
         C392JQqnSZBW8pjiRhif0ikGzkhFr0SQeVOwURg432qbkE10PHmsL0xgbrB7k1/JY7OY
         knu15jpSgspeVtvL21kBcv80jrqkH0tCC1yAEP5yVkU8guldWtys4n35SGjhzGBmX1ZL
         fW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687073447; x=1689665447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpkTkFOMPY9g8skCMNjWh2GIwghKNPBLJZcIyUZbKMY=;
        b=ClmK5GyeSBk/nOlYSa8frHwv5d5fVh1dg2N+0o/v0MMaGOUVrvuFuLLD100x7RE8NJ
         P+0wQiwIOhA0NUEjCkjJL1VVQauULf/gKGcBEupQzzDN3UqV8I8WNiEJ/udzv/uuGJHO
         wSgsDCI+JYG7JedU1h9OqXUOs1rkpIR0DyVgoqOL/XV9tgrrAoYqgzb+GocH8B6No//c
         XVwziTnXUGKNpe7XgEiGJ2cyRQZtN1flNteXhkoIzyrNe2kQvtEsWX3cGRQuB1rKNJ7E
         V+XC7WEbx5GLAyv5l9j9zZUFhvkQsxj1g+YJQpa5X+mymAytVIb6o8ZHXRWB25NDbVwo
         5gkA==
X-Gm-Message-State: AC+VfDwT3ERkTW9qIJHJ1DSYUYCgAlTXGwrLqWQQvM2yZxvqPht95IDj
        5jzw1NZKn1s8syAjqMybQX51VwKpbWKbDShIUr4=
X-Google-Smtp-Source: ACHHUZ7wfPMknVqcHtn8Fydlw32kRSMNVHIkLtrIcmKI/AMde8bhUhQHGm8dW4CcP2CWd1dQf+wOXdY5I2oeTSR6OJM=
X-Received: by 2002:a25:c514:0:b0:bc9:f5c8:7514 with SMTP id
 v20-20020a25c514000000b00bc9f5c87514mr3907005ybe.26.1687073447400; Sun, 18
 Jun 2023 00:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230615142016.419570-1-zhiguangni01@gmail.com>
 <20230615170011.GK52412@kernel.org> <CACZJ9cVxqeDooeAMi8HBFmeo_85E+NuMYbW9PCvp7Rm-wunOGg@mail.gmail.com>
 <20230618070850.GY52412@kernel.org>
In-Reply-To: <20230618070850.GY52412@kernel.org>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sun, 18 Jun 2023 15:30:36 +0800
Message-ID: <CACZJ9cVSxsOcGJwxEWaMs3Wtt0XHij5OiYq+uWvC7UQZApNGdw@mail.gmail.com>
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in numa_meminfo_cover_memory()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Jun 2023 at 15:09, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Jun 17, 2023 at 06:47:11PM +0800, Liam Ni wrote:
> > On Fri, 16 Jun 2023 at 01:00, Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Fri, Jun 16, 2023 at 12:20:16AM +1000, Liam Ni wrote:
> > > > In a previous implementation,The ram page is calculated
> > > > by counting the number of holes,
> > > > however,the number of ram pages is calculated during hole calculation.
> > > > Therefore,we can directly calculate the amount of ram pages.
> > > >
> > > > Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> > > > ---
> > > >  arch/x86/mm/numa.c |  4 ++--
> > > >  include/linux/mm.h |  4 ++++
> > > >  mm/mm_init.c       | 33 +++++++++++++++++++++++++++++++++
> > > >  3 files changed, 39 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > > index 2aadb2019b4f..8ea0e956e3d7 100644
> > > > --- a/arch/x86/mm/numa.c
> > > > +++ b/arch/x86/mm/numa.c
> > > > @@ -461,12 +461,12 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> > > >               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> > > >               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> > > >               numaram += e - s;
> > > > -             numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> > > > +             numaram += __available_pages_in_range(mi->blk[i].nid, s, e);
> > >
> > > This is wrong. You add number of pages in range core MM sees to the number
> > > of pages covered by the numa_meminfo.
> > >
> > > More generally, rather than traverse all the numa_meminfo's and for each of
> > > them traverse all the regions in memblock.memory it's enough to count
> > > memory in memblock that doesn't have the node assigned and compare it to
> > > memblock_phys_mem_size().
> >
> > Logic like below?
> > static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> > {
> >    u64 error_value;
> >    error_value = pages_without_nid_in_range(0,max_pfn);
> >     if ((error_value ) >= (1 << (20 - PAGE_SHIFT))) {
> >         //print error information
> >         return false;
> >      }
> >      return true;
> > }
> >
> > I can't figure out why compare it with memblock_phys_mem_size().
> > The number of pages in memblock that doesn't have the node
> > assigned,which also means that these pages are not in numa_info.
> > So these pages can represent the number of lose pages.
>
> Yes, there is no need to compare with memblock_phys_mem_size() if you count
> pages that don't have nid set in memblock.

Got it,i will send V2.

Liam.
>
> --
> Sincerely yours,
> Mike.
