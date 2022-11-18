Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33BE62F519
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiKRMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:40:15 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458921571C;
        Fri, 18 Nov 2022 04:40:14 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-141ca09c2fbso5776127fac.6;
        Fri, 18 Nov 2022 04:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aGgvpVBQS1++uw6n+xGXGUa91sdtxecLOzxy60SSl4=;
        b=YVIha6qiPXqHoyKYb6aEZ9+3VlVDLVIXgsBP+1sLipzZrqa+O9JyNaY5BErBh4ibrh
         /kY/XRoIRfHtRjEHBCpx+xhAK6UODZsMLjlgW/FOtDQ/2tQl2Hz8+R018mr6iSZkg5pZ
         BauDuciY8iuNmjWKvAZfqACN1ck0kVOwjdJniACy+BQBJ0Go6/CtFAEwYyaiMTESW0RP
         uPCTQ3IjMTPvHHU/TWyDuM+1ng8A+VTzLt3yv0GB0TBYid43io/vZDJ5AmjLSPbVOCa9
         D83aDggeMYY4rVfRsIaAkQA8SYQFv+xMFQZlE367UFD63BldB9lz/PbSbnQRUiAKguWK
         QF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aGgvpVBQS1++uw6n+xGXGUa91sdtxecLOzxy60SSl4=;
        b=RF/+ypm8Xw2XumdUAE5vXyfF/A1pTInmaomx4kj/Swgr0Ou5bJCkp4FvZJwZm3rSo7
         HXR68zHRVg5MoiWi/iOj+XDO+blhj3OV3NL252QREtdQV8HZrYUImB9HOQWrTbksiddI
         v9DKUdPk1SEADRxznAQXHpd3EUADrUa7AOJ6S6OlFLm30dddc7zcOwZrQrq6BEZa9oaJ
         c6rdwAW7Ep1E/9EayZTMp6euQ9ROsj8R4RwVi5XEJDJ/ShhCM7snUmagb4JZTIlOD8oa
         Dn8Gw07bFp0u6uAtBTzfTBp8A9Ko7/psQDqIuTLOipWzZnQL03LM+j+kyVxz22mL+c5j
         aWdQ==
X-Gm-Message-State: ANoB5pk3l5Z2i/T8Ppr12Js6+5VBtkNuQe2KnVz9TYKtYv7y62JZRRQC
        jLPd9WJuC+b+eKB3sTh1VZc=
X-Google-Smtp-Source: AA0mqf5hgu+Iy/4uUl7v7HjAQEc4bZtOxSOqIwOyh6+QgRAeyqIHMYoVf/u94aqS+bqihFxTUWNwSQ==
X-Received: by 2002:a05:6870:2481:b0:13c:c5bd:c33e with SMTP id s1-20020a056870248100b0013cc5bdc33emr3709409oaq.244.1668775213420;
        Fri, 18 Nov 2022 04:40:13 -0800 (PST)
Received: from macondo ([2804:431:e7cc:5fdd:4170:7dca:de7e:f578])
        by smtp.gmail.com with ESMTPSA id em22-20020a0568705b9600b00136a0143de8sm1882995oab.40.2022.11.18.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:40:13 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:40:09 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling trigger
Message-ID: <Y3d9KcpcwrEUUYKT@macondo>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
 <20221117211726.4bbbb96a@gandalf.local.home>
 <20221117213109.6119750e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117213109.6119750e@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:31:09PM -0500, Steven Rostedt wrote:
> On Thu, 17 Nov 2022 21:17:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 16 Nov 2022 16:25:51 -0300
> > Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> > 
> > > That happens because enable_eprobe() will eventually trigger the
> > > kmem/mm_page_alloc trace event:
> > > 
> > > - enable_eprobe [trace_eprobe.c]
> > >   - trace_event_trigger_enable_disable [trace_events_trigger.c]
> > >     - trace_event_enable_disable [trace_events.c]
> > >       - __ftrace_event_enable_disable [trace_events.c]
> > >         - trace_buffered_event_enable [trace.c]
> > >           - alloc_pages_node [gfp.h]
> > > 	   ...
> > >             - __alloc_pages [page_alloc.c]
> > >               - trace_mm_page_alloc // eprobe event file without TRIGGER_COND bit set
> > > 
> > > By the time kmem/mm_page_alloc trace event is hit, the eprobe event file
> > > does not have the TRIGGER_COND flag set yet, which causes the eprobe's
> > > trigger to be invoked (through the trace_trigger_soft_disabled() path)
> > > without a trace record, causing a NULL pointer dereference when fetching
> > > the event fields.
> > > 
> > > Fix this by setting the cond flag beforehand when enabling the eprobe's
> > > trigger.
> > > 
> > > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > > ---  
> > 
> > Thanks for the report, but I'm worried that this isn't enough because of
> > how memory ordering can happen on different architectures. That is, just
> > because you switch the order of updates, doesn't mean that the architecture
> > will honor it.
> > 
> > I don't want to add memory barriers in the fast path, but instead we can
> > simply check if rec is NULL in the handler.
> > 
> > So basically:
> > 
> > 
> > static void eprobe_trigger_func(struct event_trigger_data *data,
> > 				struct trace_buffer *buffer, void *rec,
> > 				struct ring_buffer_event *rbe)
> > {
> > 	struct eprobe_data *edata = data->private_data;
> > 
> > 	if (!rec)
> > 		return;
> > 
> > 	__eprobe_trace_func(edata, rec);
> > }
> > 
> > And this should be documented.
> > 
> 
> In fact, does this fix it for you?

It does. I found this while enabling eprobe for all events in my setup.
Doing the same test wih the proposed patch it did not trigger any issue.
Thanks.

> 
> I'm going to take this patch and reference you as a reported-by, as I have
> a lot of urgent code that needs to got upstream, and I need to start
> testing it.
> 
> Thanks!
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 5dd0617e5df6..6b31b74954d9 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -563,6 +563,9 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
>  {
>  	struct eprobe_data *edata = data->private_data;
>  
> +	if (!rec)
> +		return;
> +
>  	__eprobe_trace_func(edata, rec);
>  }
>  
> 
