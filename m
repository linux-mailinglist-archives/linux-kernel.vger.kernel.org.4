Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F3064E7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLPHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLPHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:36:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71885379FB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:36:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so1704837ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oFqrjyPYfae2XSyQbiGUZG3rY81EUIaDL06EKkI6tM=;
        b=KVsxLpQ7oQzcgeZDnvA+Fo+lfQxv0hNTvZ8Yw7NAvD1WFMsisuTPXWwmd1eamU883Z
         EXk+Igz3X351JARfptB/reH3VB3wqKukNJceOoQuMcdMrPTZbgkp4GZGuBrwNe9Fk0j3
         ni9/vAaLYQiMcmcyRkoP8nG1HUHLe8pUwcTGfwFLDAz6vUQ6IO2U4OBS4MDBYnuJL/Ba
         JyqnIPBfOWaW9+jA65j1R+9Ax8h9ynndPQLrqYecL+ImCENBjsv3VKrHNo421cD6j+ii
         VwWv034ojOniIA2EZDzkcR3Y2F81GKl/wh2dQ1OyPwRHytSGHDqj9zQmPc/qp3kNf2l/
         XvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oFqrjyPYfae2XSyQbiGUZG3rY81EUIaDL06EKkI6tM=;
        b=paCnw49O9K0LiZAGbtZyRyJpeYK+uTFBmptinZs1HKbH+C5CF/KruXQ67Y9v3vTVDu
         tSVQfTPoUxTAbLuUY+/gsSgOV3rgdn9ozmisxaSU2uTHknTH4za27grNCJc/IKRuK5oE
         gJRqoTB9XMyYcRx3gqNb+rcY3gsbS9uw3uAPlzAwv7stZtcBe3Ygna4hPA+z++afV7a5
         a22UbvMwo2cy9kMySJ1NvFNzTb0Jm2YXZjF3mDu66WUEdy6zBkDTnpX4rdSCe1EVOClr
         xNKcw5PmXqkJgTaO4zX24OUMXFEhfewreNq1Jnf5YGiS0pxK2TCuUrlo/RwR1QDDoiF9
         FM/Q==
X-Gm-Message-State: ANoB5pkpcz2tztIxTk9/wfLA7ngMxEPmIOEix5R8pZOIx2LeHbAM6VyP
        USWVK0o1uLOrszsvHnjCEBZIHeNVfbdyTA==
X-Google-Smtp-Source: AA0mqf75PhHtisJYH8ZIDDVjR2R5VreZaDl8LDNJe7RZ4xRtvO+Ql5tjsmC8Lt0Uf6CqQK9C5mvqb74RqklYuA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:fc5:0:b0:6fc:677a:d649 with SMTP id
 188-20020a250fc5000000b006fc677ad649mr30852517ybp.65.1671176202726; Thu, 15
 Dec 2022 23:36:42 -0800 (PST)
Date:   Fri, 16 Dec 2022 07:36:40 +0000
In-Reply-To: <13c73151-4b28-4324-afd5-8b84b82bc25d@shopee.com>
Mime-Version: 1.0
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
 <20221215181803.ome46pkh6g7qu3t4@google.com> <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
 <20221216064210.krxtxebuwc7dijzu@google.com> <13c73151-4b28-4324-afd5-8b84b82bc25d@shopee.com>
Message-ID: <20221216073640.xjtpsyigoej77v5h@google.com>
Subject: Re: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
From:   Shakeel Butt <shakeelb@google.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:28:53PM +0800, Haifeng Xu wrote:
> 
> 
> On 2022/12/16 14:42, Shakeel Butt wrote:
> > On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
> >>
> >>
> >> On 2022/12/16 02:18, Shakeel Butt wrote:
> >>> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
> >>>> The memory events aren't supported on root cgroup, so there is no need
> >>>> to account MEMCG_OOM_KILL on root memcg.
> >>>>
> >>>
> >>> Can you explain the scenario where this is happening and causing issue
> >>> for you?
> >>>
> >> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
> >> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
> >> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
> >> does not count any memory event.
> >>
> > 
> > What about v1's memory.oom_control?
> >
>  
> The memory.oom_control doesn't set the CFTYPE_NOT_ON_ROOT flag. But oom_kill_disable or
> under_oom actually only support non-root memcg, so the memory_events should be consistent
> with them.

Did you take a look at mem_cgroup_oom_control_read()? It is displaying
MEMCG_OOM_KILL for root memcg. Irrespective it makes sense or not, you
want to change behavior of user visible interface. If you really want to
then propose for the deprecation of that interface.
