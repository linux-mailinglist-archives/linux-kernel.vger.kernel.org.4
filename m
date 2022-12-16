Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E164E80A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLPIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiLPIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:17:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F030545
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:17:18 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d7-20020a170902b70700b0018f4bf00569so1252834pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9u9UPozyazmbsEh7xHrjuI6wVAR7pb7o/Fk3ONc5io=;
        b=Ish4adee2b4xOdi4ASCIbOyMXlYQPuTT4RfwhVcE4QkmR2I8uCQElWLiN6o0taAk7y
         M99rhxsX0ObV69XPcjkjAFIOOM0aVWoDKT5zObRN9UqKkuFht7gLeKnwoDnxikI/+BmD
         CZf0xdGu6IFdsLkDXTLAqesODmepzzPR43baipjc65zluFRWyWxhPpVFaI8YfiOoq0/L
         uqFMy8ax3av51jRB4ihm+MDUPZMZSL2HD0gsraBsBSUPcyPZogwpImU1gzPRbHHfNLd0
         8v7vd1laZuktaR4rnKsLyqmu/VmrVo7Xuizvqi6FRLaiWQ10PGhvF6uSVmla3Zl8IHCJ
         lj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9u9UPozyazmbsEh7xHrjuI6wVAR7pb7o/Fk3ONc5io=;
        b=sJSNErL40fhC2Umtikis8rF7dFEKIZNnrjLWVKUoSDWBsZDerXwyDvOwRzaiB/EYO9
         qwpJ00SkpfFDynUIBoSWwhFQm0cgj9P47pvFF7ik6CrhWM7I797DRUZFsHYqAa6AD3X0
         IQc9p1nhZvuom87vzLA6S6Re3QulBwYcaiXFII6lQHgQzzh7cNt1vjGD4OmYH70oFwzJ
         2egYeKXWYt1eB9JRiNSkkektSfbLFo8LZApplOpiYAEeBsU92S0DIeevLGOTozQ5q9bY
         luCkSeEC+ANzNfOUgj/vtql6p3mOZaKo92klI1trSljDAe+DgBvFm+w+yFk6c5PcaKtS
         f7sg==
X-Gm-Message-State: ANoB5pmN8nZwf1Sf/Rz7gESprqr7cQmLW5373+stcyKLRdqEySGsMqG8
        Cp/98FdDn5mkO3K76WwNAFZQ6qRZ+o5Ztw==
X-Google-Smtp-Source: AA0mqf7jOnNIzJEPROPql6qcfBiS0Rogs4+sLuEQsw8ztDpjOMsPfySpfmt88NAIzHihgE1hVTVKTcLTYxvsxA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:440d:b0:57a:6e2a:c236 with SMTP
 id br13-20020a056a00440d00b0057a6e2ac236mr860173pfb.82.1671178638123; Fri, 16
 Dec 2022 00:17:18 -0800 (PST)
Date:   Fri, 16 Dec 2022 08:17:16 +0000
In-Reply-To: <a1b0d3c8-d6c2-2f22-5269-92a32f78614e@shopee.com>
Mime-Version: 1.0
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
 <20221215181803.ome46pkh6g7qu3t4@google.com> <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
 <20221216064210.krxtxebuwc7dijzu@google.com> <13c73151-4b28-4324-afd5-8b84b82bc25d@shopee.com>
 <20221216073640.xjtpsyigoej77v5h@google.com> <a1b0d3c8-d6c2-2f22-5269-92a32f78614e@shopee.com>
Message-ID: <20221216081716.7o4o33sg3eof2iww@google.com>
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

On Fri, Dec 16, 2022 at 03:50:49PM +0800, Haifeng Xu wrote:
> 
> 
> On 2022/12/16 15:36, Shakeel Butt wrote:
> > On Fri, Dec 16, 2022 at 03:28:53PM +0800, Haifeng Xu wrote:
> >>
> >>
> >> On 2022/12/16 14:42, Shakeel Butt wrote:
> >>> On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
> >>>>
> >>>>
> >>>> On 2022/12/16 02:18, Shakeel Butt wrote:
> >>>>> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
> >>>>>> The memory events aren't supported on root cgroup, so there is no need
> >>>>>> to account MEMCG_OOM_KILL on root memcg.
> >>>>>>
> >>>>>
> >>>>> Can you explain the scenario where this is happening and causing issue
> >>>>> for you?
> >>>>>
> >>>> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
> >>>> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
> >>>> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
> >>>> does not count any memory event.
> >>>>
> >>>
> >>> What about v1's memory.oom_control?
> >>>
> >>  
> >> The memory.oom_control doesn't set the CFTYPE_NOT_ON_ROOT flag. But oom_kill_disable or
> >> under_oom actually only support non-root memcg, so the memory_events should be consistent
> >> with them.
> > 
> > Did you take a look at mem_cgroup_oom_control_read()? It is displaying
> > MEMCG_OOM_KILL for root memcg. Irrespective it makes sense or not, you
> > want to change behavior of user visible interface. If you really want to
> > then propose for the deprecation of that interface.
> 
> Yes, I have see it in mem_cgroup_oom_control_read() and I think that 
> showing MEMCG_OOM_KILL for root memcg doesn't make much sense.
> 

It doesn't matter as there might already be users using it.

> Shoud I add the CFTYPE_NOT_ON_ROOT flag for cgroup v1?
> 

Before doing anything, I am still not seeing why we really need this
patch? What exactly is the issue this patch is trying to solve? To me
this patch is negatively impacting the readability of the code. Unless
you are seeing some real production issues, I don't think we need to add
any special casing for MEMCG_OOM_KILL here.
