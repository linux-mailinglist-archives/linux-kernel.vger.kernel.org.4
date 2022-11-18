Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCA62F50A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiKRMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:38:24 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF1109A;
        Fri, 18 Nov 2022 04:38:23 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q186so5171687oia.9;
        Fri, 18 Nov 2022 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnPNdGmx2+WfKEq5rCq9Je3jd3hTo4v6cL93WbUNslU=;
        b=JawN7GOEUsICERcjgDs1t77di68kPIYA39tnTmek1x4qUCIFO4O3HrQ9uIU0gn/gAh
         7hcLX4wxMyIGGXHMr3ayoD/tSIwxKvHsREd8oaEdFucJLl3E/aS7hG0NYEWml2z+zVS9
         UjZQT2r3qsYTAsLq9wB1ycDW7+6XSomwY8D6gqtBxvUqNX1IKOtn77sW9ihDN11+7+kc
         dm1D6CZxyHZTNmmO+8noBdwKFNeyVgZj/t1UCViHLvmU3B0BEAmlWGT0o/xrD1BaWmFQ
         zKxx3td+AZzLZL4rGZwybEpSLLde6N1fnZNFuCYKh8qBBNP9Vh0LJ7fZ21N7F7U52Tfs
         03KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnPNdGmx2+WfKEq5rCq9Je3jd3hTo4v6cL93WbUNslU=;
        b=5t/4xYtr4dvpQ3USh5wH1O9bQxY/iaLOe6iEeMFh9VkLgG/vVvpm4MBFcxnXpWJM2y
         I3ctX0xW9GyjoDjG1NEjyRwn8rtPRQVkIKn5+0limiEclqy4bhR0VQzBFAsfvy5XUBwj
         CjQWVKOTR/wx09MPU+n0icrFEJXgOvB9uj3tLL1U+IAAhvk/OKyOYTaxujA8sZpdvzO7
         QW8Lq8tcZyAQcR48mSpGZAxHiARNrbxTUX5WK5EnZ353qkIPjpP3nS8Jbn2tDEHn2jHh
         gZYvjohJc3LF07KrGP8HBHy+LsgZUs6apVn/UjCK5DOCbXGXFNWPDuD+IMGX1o60LiyU
         kzkw==
X-Gm-Message-State: ANoB5pnfAksYrU2wYs9D+4tqiCYSA1HxqX7QcNZD5M4tlj6gPjpwdFxc
        LqFrMCRvYhZ0UwTOnL0IxZXQQL6aqmWyvQ==
X-Google-Smtp-Source: AA0mqf76AV630ZgdFbLGJijwxnwErGYrd0oiqRIR42NnOlWixexRkd+Mtx/vsdqa8kimPTMWC/8i8Q==
X-Received: by 2002:a05:6808:81:b0:354:b67e:611d with SMTP id s1-20020a056808008100b00354b67e611dmr5951512oic.210.1668775102303;
        Fri, 18 Nov 2022 04:38:22 -0800 (PST)
Received: from macondo ([2804:431:e7cc:5fdd:4170:7dca:de7e:f578])
        by smtp.gmail.com with ESMTPSA id s25-20020a056830125900b00660d9afc216sm1502730otp.17.2022.11.18.04.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:38:21 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:38:18 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling trigger
Message-ID: <Y3d8uhHrvSYbFzUx@macondo>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
 <20221117211726.4bbbb96a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117211726.4bbbb96a@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:17:26PM -0500, Steven Rostedt wrote:
> On Wed, 16 Nov 2022 16:25:51 -0300
> Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> 
> > That happens because enable_eprobe() will eventually trigger the
> > kmem/mm_page_alloc trace event:
> > 
> > - enable_eprobe [trace_eprobe.c]
> >   - trace_event_trigger_enable_disable [trace_events_trigger.c]
> >     - trace_event_enable_disable [trace_events.c]
> >       - __ftrace_event_enable_disable [trace_events.c]
> >         - trace_buffered_event_enable [trace.c]
> >           - alloc_pages_node [gfp.h]
> > 	   ...
> >             - __alloc_pages [page_alloc.c]
> >               - trace_mm_page_alloc // eprobe event file without TRIGGER_COND bit set
> > 
> > By the time kmem/mm_page_alloc trace event is hit, the eprobe event file
> > does not have the TRIGGER_COND flag set yet, which causes the eprobe's
> > trigger to be invoked (through the trace_trigger_soft_disabled() path)
> > without a trace record, causing a NULL pointer dereference when fetching
> > the event fields.
> > 
> > Fix this by setting the cond flag beforehand when enabling the eprobe's
> > trigger.
> > 
> > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > ---
> 
> Thanks for the report, but I'm worried that this isn't enough because of
> how memory ordering can happen on different architectures. That is, just
> because you switch the order of updates, doesn't mean that the architecture
> will honor it.
> 
> I don't want to add memory barriers in the fast path, but instead we can
> simply check if rec is NULL in the handler.

Ok. That was my first approach but then looking for the same pattern in
trace_events_trigger.c and trace_events_hist.c I saw commit 4e4a4d75700d
("tracing: Update cond flag when enabling or disabling a trigger") [1]
and I thought the same would apply here without much thought.

[1] https://lore.kernel.org/lkml/20151126022048.111221642@goodmis.org/

> 
> So basically:
> 
> 
> static void eprobe_trigger_func(struct event_trigger_data *data,
> 				struct trace_buffer *buffer, void *rec,
> 				struct ring_buffer_event *rbe)
> {
> 	struct eprobe_data *edata = data->private_data;
> 
> 	if (!rec)
> 		return;
> 
> 	__eprobe_trace_func(edata, rec);
> }
> 
> And this should be documented.
> 
> -- Steve
