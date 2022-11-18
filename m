Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534562F65D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiKRNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiKRNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:36:22 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8696705;
        Fri, 18 Nov 2022 05:34:45 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id t15-20020a4a96cf000000b0049f7e18db0dso771736ooi.10;
        Fri, 18 Nov 2022 05:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CeypTGsSQ7hIMjMqb97acJUIT2o1NQ3MZu5l62YdM1U=;
        b=GEHvLShAbIGmNaho6pyZ66GONWFROU14cnZomsWqLHcRDc1dbiHUynvkq6gM7tOPyb
         NLtqglztFcPlZjGgUmIUxJ7rpcRYZotezE6E9B9n55PEMgDiMuLCbrBRprMyaVY2dfm4
         AqcwbS9XbMqFw6QJDd0TnsMYUTFzMAVb3mNXA2G1ub9IfaCweCQ6atEiNmIo4ERlPRZW
         Fo7X14u/99YWOwLoe0ZHkKPkJRhSe++WcmNCabvTyCB9Qz9AP4KEWtJOv762SX+6ufj2
         6sER7Q4BtpwVEK51dSWUzbsuauxUmpPXxrnFGV2TLCmJ8mla2wsHXGRVAwYsJrIw6DL1
         3wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeypTGsSQ7hIMjMqb97acJUIT2o1NQ3MZu5l62YdM1U=;
        b=Vfwdz4fNaYL2cB2DO2Vbrn0snJytLHEJ6tmhrmvsL5K3i3NAIc9fiHk74242XTAWDp
         BS+RrNLKciq2NlQM+51/g8q9IxPQVZsPLQ7iTMAw6uyKGBf0pcBnwJ3vjKGm/UEOaWU9
         hJ2/Zw5T0jImqBfTpnykDL0hb2DmYu+ZT4DEV6xwXur0BG8Wt4r+2/tCNk2hEKzTFmVU
         QOEE4/8BWAAEiLZ1z+GuqVjAhC2C89cOulODQa1rB1MO6l98B89fhKI7hrSmwe8Hn1er
         fyQhmI8lEu03RrHBGCj0Q7kcwhyztZZEgoyet/oDZCrdzvBZb1b1uB+5/oqxcVYhdPgf
         x0ZA==
X-Gm-Message-State: ANoB5pnRnZ96N3Jh9YEYnJS1xpk1oW/7H7BvmRCaAuLx4t0sJl9o8fic
        p3gHEd/rvxfLIq97Anovk/w=
X-Google-Smtp-Source: AA0mqf6u6i/ixsmnk9uwXCGftLyUyxwBDWMAEKynfbXohFqLUX/wo+EiZ/dV82uGOn1RrcsTVQljPA==
X-Received: by 2002:a4a:d404:0:b0:49f:69ab:4afd with SMTP id n4-20020a4ad404000000b0049f69ab4afdmr3483297oos.19.1668778485003;
        Fri, 18 Nov 2022 05:34:45 -0800 (PST)
Received: from macondo ([2804:431:e7cc:5fdd:4170:7dca:de7e:f578])
        by smtp.gmail.com with ESMTPSA id 187-20020aca06c4000000b0035485b54caesm427421oig.28.2022.11.18.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:34:44 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:34:40 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling trigger
Message-ID: <Y3eJ8GiGnEvVd8/N@macondo>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
 <20221117211726.4bbbb96a@gandalf.local.home>
 <20221117213109.6119750e@gandalf.local.home>
 <Y3d9KcpcwrEUUYKT@macondo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3d9KcpcwrEUUYKT@macondo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:40:09AM -0300, Rafael Mendonca wrote:
> On Thu, Nov 17, 2022 at 09:31:09PM -0500, Steven Rostedt wrote:
> > On Thu, 17 Nov 2022 21:17:26 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Wed, 16 Nov 2022 16:25:51 -0300
> > > Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> > > 
> > > > That happens because enable_eprobe() will eventually trigger the
> > > > kmem/mm_page_alloc trace event:
> > > > 
> > > > - enable_eprobe [trace_eprobe.c]
> > > >   - trace_event_trigger_enable_disable [trace_events_trigger.c]
> > > >     - trace_event_enable_disable [trace_events.c]
> > > >       - __ftrace_event_enable_disable [trace_events.c]
> > > >         - trace_buffered_event_enable [trace.c]
> > > >           - alloc_pages_node [gfp.h]
> > > > 	   ...
> > > >             - __alloc_pages [page_alloc.c]
> > > >               - trace_mm_page_alloc // eprobe event file without TRIGGER_COND bit set
> > > > 
> > > > By the time kmem/mm_page_alloc trace event is hit, the eprobe event file
> > > > does not have the TRIGGER_COND flag set yet, which causes the eprobe's
> > > > trigger to be invoked (through the trace_trigger_soft_disabled() path)
> > > > without a trace record, causing a NULL pointer dereference when fetching
> > > > the event fields.
> > > > 
> > > > Fix this by setting the cond flag beforehand when enabling the eprobe's
> > > > trigger.
> > > > 
> > > > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > > > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > > > ---  
> > > 
> > > Thanks for the report, but I'm worried that this isn't enough because of
> > > how memory ordering can happen on different architectures. That is, just
> > > because you switch the order of updates, doesn't mean that the architecture
> > > will honor it.
> > > 
> > > I don't want to add memory barriers in the fast path, but instead we can
> > > simply check if rec is NULL in the handler.
> > > 
> > > So basically:
> > > 
> > > 
> > > static void eprobe_trigger_func(struct event_trigger_data *data,
> > > 				struct trace_buffer *buffer, void *rec,
> > > 				struct ring_buffer_event *rbe)
> > > {
> > > 	struct eprobe_data *edata = data->private_data;
> > > 
> > > 	if (!rec)
> > > 		return;
> > > 
> > > 	__eprobe_trace_func(edata, rec);
> > > }
> > > 
> > > And this should be documented.
> > > 
> > 
> > In fact, does this fix it for you?
> 
> It does. I found this while enabling eprobe for all events in my setup.
> Doing the same test wih the proposed patch it did not trigger any issue.
> Thanks.

It did not trigger the NULL pointer issue to be more specific. When
creating event probe for all events I was unable to create any event for
the xhci-hcd system:

root@localhost:/sys/kernel/tracing# echo 'e xhci-hcd/xhci_add_endpoint' > dynamic_events 
-bash: echo: write error: Invalid argument

Debugging the issue it seems that the problem is in the is_good_name()
check, which returns false for "xhci-hcd". Should we sanitize it by
converting '-' into '_'?

> 
> > 
> > I'm going to take this patch and reference you as a reported-by, as I have
> > a lot of urgent code that needs to got upstream, and I need to start
> > testing it.
> > 
> > Thanks!
> > 
> > -- Steve
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 5dd0617e5df6..6b31b74954d9 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -563,6 +563,9 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
> >  {
> >  	struct eprobe_data *edata = data->private_data;
> >  
> > +	if (!rec)
> > +		return;
> > +
> >  	__eprobe_trace_func(edata, rec);
> >  }
> >  
> > 
