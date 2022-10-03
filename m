Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028D5F373C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJCUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJCUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:42:30 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479130579
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 13:42:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a20so7070431qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YkPlmrjxBMM8aygZJ+MEaS2w/zQPxfdd9N26rHkvUfY=;
        b=QRVWCFvHKIDDxNQe0wGLPERzZKc5NNbOqLVki0w65x5f2zCp/NjReFI5CqRX5tPX4d
         xxac1q0qC7PHvePJykNj2OCWs5wPLp1rRK2UT4pdeewflWCddm8/eK+KZaUP9hocaZH0
         S4m+pmOOeb3eSFgK7gfxqkqAZHmFyLqXzNqN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YkPlmrjxBMM8aygZJ+MEaS2w/zQPxfdd9N26rHkvUfY=;
        b=X45phc0oH0LnfG0bJV+5OwohGOxKHoc/hkT/6V/aZV9nN6Mwy/1mVLjkHcsyL6I5Gx
         tO21W3eMxu6psa8TpGDU94yrZTq20g9Sryb2qmgh948OjJBzmzPTDoR10h3Ce3MbDKQP
         +u3J6s5r9qe89O+evgI0SYbBGWf0zfMOpqn3lG+yWAzMPi828/6iyAIoEtC6ZIlbiITG
         ZtbchVLKx5MRFOyvGo8gncDpEePW00VH8E4tYD4Ft9qh/ySjH0GSzRaVir15A41VB3O9
         OvKfdeFMkoe696WXcEyvBmJWjfkhjp3hBBrCgoXSF0+TazLG/GmOM/KvwyuOMcxhNBwc
         FT2A==
X-Gm-Message-State: ACrzQf3n6wgI9mf3YbpCHJP1KkxfM6FMX7aDZrOcdLzUz1zm05rnWq+B
        vKtoi+WZf7F++x9ovO4e2NXCKw==
X-Google-Smtp-Source: AMsMyM7h02Jdu0UDJxVYMtqX1s1yZjYwP3SVrLiEQaXlsBOoZ34GeIplGYym1mLycHMduLNkSHENtA==
X-Received: by 2002:a05:622a:c4:b0:35d:4738:3e9d with SMTP id p4-20020a05622a00c400b0035d47383e9dmr17535785qtw.417.1664829749136;
        Mon, 03 Oct 2022 13:42:29 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id dt35-20020a05620a47a300b006ce3cffa2c8sm12487486qkb.43.2022.10.03.13.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:42:28 -0700 (PDT)
Date:   Mon, 3 Oct 2022 20:42:28 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Add Masami Hiramatsu as co-maintainer
Message-ID: <YztJNGLZvKKfYGjk@google.com>
References: <20220930124131.7b6432dd@gandalf.local.home>
 <20221001091706.8efaeb64266efa6058a468df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001091706.8efaeb64266efa6058a468df@kernel.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 09:17:06AM +0900, Masami Hiramatsu wrote:
> On Fri, 30 Sep 2022 12:41:31 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Masami has been maintaining kprobes for a while now and that code has
> > been an integral part of tracing. He has also been an excellent reviewer
> > of all the tracing code and contributor as well.
> > 
> > The tracing subsystem needs another active maintainer to keep it running
> > smoothly, and I do not know anyone more qualified for the job than Masami.
> > 
> > Ingo has also told me that he has not been active in the tracing code for
> > some time and said he could be removed from the TRACING portion of the
> > MAINTAINERS file.
> > 
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Thanks Steve,
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f5ca4aefd184..6c7c9cdff05a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20614,7 +20614,7 @@ F:	drivers/char/tpm/
> >  
> >  TRACING
> >  M:	Steven Rostedt <rostedt@goodmis.org>
> > -M:	Ingo Molnar <mingo@redhat.com>
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> >  F:	Documentation/trace/ftrace.rst
> > @@ -20630,7 +20630,7 @@ F:	tools/testing/selftests/ftrace/
> >  
> >  TRACING MMIO ACCESSES (MMIOTRACE)
> >  M:	Steven Rostedt <rostedt@goodmis.org>
> > -M:	Ingo Molnar <mingo@kernel.org>
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> >  R:	Karol Herbst <karolherbst@gmail.com>
> >  R:	Pekka Paalanen <ppaalanen@gmail.com>
> >  L:	linux-kernel@vger.kernel.org
> > -- 
> > 2.35.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
