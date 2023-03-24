Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2474D6C87DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCXV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCXV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:59:40 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940115C82;
        Fri, 24 Mar 2023 14:59:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h27so2669206vsa.1;
        Fri, 24 Mar 2023 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMI9am9Who8Vr+JcgsFIxZwdNfhXbZD74wYkzXXqGrE=;
        b=Y1Hcc/DOwFkD5em8m3cGq9KizwVFun0h5yj9KWDVpN1IBHUCgwasXAzNydhazPclKW
         Af76dJeX4KB7uIu8sphfyGJy4i1/rfjN/pr1L/t0//eaaRfo8OJcV6J+jV90qYvjFUR1
         7/CoguAgMQTFYyZNEfndEedGIfpptz/EP1AbJhaAu6TLYGeuIGE8Tz4dtWj/3lDewgc1
         JLEEE+LlouIkpjPB7Mm04n6QazFsJAMPWEjzqaErkq95VL03WumVlDr/Hr68aW0Y2c5r
         Imr/voLpm5aAvWVnc0v77+zgKHkUH6MWwcxt3+fre+8+UWOa71p0M70TaB3VDdV+uEDH
         9cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMI9am9Who8Vr+JcgsFIxZwdNfhXbZD74wYkzXXqGrE=;
        b=Hjn2IS9Ya6IthP8HTRFLEnreZiIXfcJpNP+MxsQ8Eo1aez/FdAS2PLPpEhthkoMnDg
         IQkIEef+IvY4fWyxnAVjHkanJ2SYqP7g3ZGJkAwhTEBDr5LOS/eJsezQUvjpzj0XvSka
         EQowUxkmNLKNZlxI+0fU8V0g7sJaWrAJIT9KyyV6BTqsggcWAncFwTYeb2vRnGo+q5PP
         9LHUIb9HreQN8LinERqGB/kNi4j6u2GY/tTh44U6eIry1FFERrkVDUjS7KoxjJbBDmUV
         x2zmbP8kOn0mhd3CEDs8xQguC6axX1zYJhhfVwIJtKBeqCcWlrehgPHsBIHGmqMhCBlI
         BoRQ==
X-Gm-Message-State: AAQBX9eDZNsGQUT/eHHgr3qBQVgcUow9dP4ykZ//vTl7t+sRAZOGBYx1
        DL7MjTXNe5XfEVqd3+k1m33+J6hPg4YfgSNuhbKofAhUcf2c8w==
X-Google-Smtp-Source: AKy350Y4ycW+PakcRHUbwa/ef6g9P6OejUHdxPOZAdamYNr0z294CU3Glt+E1U8V91GyUv4t1y5UxN0/UsoqvLIoUNE=
X-Received: by 2002:a67:c290:0:b0:426:8391:de08 with SMTP id
 k16-20020a67c290000000b004268391de08mr1332332vsj.2.1679695177471; Fri, 24 Mar
 2023 14:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230308032748.609510-1-nphamcs@gmail.com> <20230314160041.960ede03d5f5ff3dbb3e3fd0@linux-foundation.org>
 <20230315170934.GA97793@cmpxchg.org> <20230315191459.f3z3gahxdew4dwrv@awork3.anarazel.de>
In-Reply-To: <20230315191459.f3z3gahxdew4dwrv@awork3.anarazel.de>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 24 Mar 2023 14:59:26 -0700
Message-ID: <CAKEwX=PgG-mrWqEOAcjPbGRF8WxHviaF3ci+_1yS-qq_x5nqFg@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] cachestat: a new syscall for page cache state of files
To:     Andres Freund <andres@anarazel.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:15=E2=80=AFPM Andres Freund <andres@anarazel.de>=
 wrote:
>
> Hi,
>
> On 2023-03-15 13:09:34 -0400, Johannes Weiner wrote:
> > On Tue, Mar 14, 2023 at 04:00:41PM -0700, Andrew Morton wrote:
> > > A while ago I asked about the security implications - could cachestat=
()
> > > be used to figure out what parts of a file another user is reading.
> > > This also applies to mincore(), but cachestat() newly permits user A =
to
> > > work out which parts of a file user B has *written* to.
> >
> > The caller of cachestat() must have the file open for reading. If they
> > can read the contents that B has written, is the fact that they can
> > see dirty state really a concern?
>
> Random idea: Only fill ->dirty/writeback if the fd is open for writing.
>
>
> > > Secondly, I'm not seeing description of any use cases.  OK, it's fast=
er
> > > and better than mincore(), but who cares?  In other words, what
> > > end-user value compels us to add this feature to Linux?
> >
> > Years ago there was a thread about adding dirty bits to mincore(), I
> > don't know if you remember this:
> >
> > https://lkml.org/lkml/2013/2/10/162
> >
> > In that thread, Rusty described a usecase of maintaining a journaling
> > file alongside a main file. The idea for testing the dirty state isn't
> > to call sync but to see whether the journal needs to be updated.
> >
> > The efficiency of mincore() was touched on too. Andres Freund (CC'd,
> > hopefully I got the email address right) mentioned that Postgres has a
> > usecase for deciding whether to do an index scan or query tables
> > directly, based on whether the index is cached. Postgres works with
> > files rather than memory regions, and Andres mentioned that the index
> > could be quite large.
>
> This is still relevant, FWIW. And not just for deciding on the optimal qu=
ery
> plan, but also for reporting purposes. We can show the user what part of =
the
> query has done how much IO, but that can end up being quite confusing bec=
ause
> we're not aware of how much IO was fullfilled by the page cache.
>
>
> > Most recently, the database team at Meta reached out to us and asked
> > about the ability to query dirty state again. The motivation for this
> > was twofold. One was simply visibility into the writeback algorithm,
> > i.e. trying to figure out what it's doing when investigating
> > performance problems.
> >
> > The second usecase they brought up was to advise writeback from
> > userspace to manage the tradeoff between integrity and IO utilization:
> > if IO capacity is available, sync more frequently; if not, let the
> > work batch up. Blindly syncing through the file in chunks doesn't work
> > because you don't know in advance how much IO they'll end up doing (or
> > how much they've done, afterwards.) So it's difficult to build an
> > algorithm that will reasonably pace through sparsely dirtied regions
> > without the risk of overwhelming the IO device on dense ones. And it's
> > not straight-forward to do this from the kernel, since it doesn't know
> > the IO headroom the application needs for reading (which is dynamic).
>
> We ended up building something very roughly like that in userspace - each
> backend tracks the last N writes, and once the numbers reaches a certain
> limit, we sort and collapse the outstanding ranges and issue
> sync_file_range(SYNC_FILE_RANGE_WRITE) for them. Different types of tasks=
 have
> different limits. Without that latency in write heavy workloads is ... no=
t
> good (to this day, but to a lesser degree than 5-10 years ago).
>
>
> > Another query we get almost monthly is service owners trying to
> > understand where their memory is going and what's causing unexpected
> > pressure on a host. They see the cache in vmstat, but between a
> > complex application, shared libraries or a runtime (jvm, hhvm etc.)
> > and a myriad of host management agents, there is so much going on on
> > the machine that it's hard to find out who is touching which
> > files. When it comes to disk usage, the kernel provides the ability to
> > quickly stat entire filesystem subtrees and drill down with tools like
> > du. It sure would be useful to have the same for memory usage.
>
> +1
>
> Greetings,
>
> Andres Freund

Thanks for the suggestion/discussion regarding cachestat's use cases,
Johannes and Andres! I'll put a summary of these points (along with a link =
to
the original discussion thread) in the cover letter and commit message
of the new version of the patch set.

In the meantime, feel free to let me know if there is something else caches=
tat
could help with (along with any improvements that could facilitate such
use cases)

Best,
Nhat
