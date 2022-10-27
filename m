Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702860FBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiJ0PXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiJ0PW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:22:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDADA8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:22:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n18so1571245qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu8teaCMlPYTjOnrG0NiGe0Q3Jj8nxpIHrZvb7hsUZY=;
        b=NAxKMS8me1V4RbzOLdYqMcn0/WLx8xABPe3sRwtPTAt3neyoYKPTBrotl26e9jJfNj
         OReLFvlVgXr3NWH1gxgUsU/Pkq2JQTXVdpLX+6DTLiGFVeQzfIaoDMXCEqpOC5UgHvox
         1f463fK37nOqbDmbxRE+//ji9Wqpy4TTAZOFFpXur+6IgWa4H9azXAInbjKtnb944Pu3
         RuDgBfm4Xw+gdvYr+NnsAaTBDHG2CWsqxK5+vhrJTCfdTQh/JeSkLc4wEvAzC572CEv0
         p2r5Rh6CsUcr1JuKo9LHveMQ+Dd/zpWsItcr5n32/HjhcbadTexu6kQMHqltnZ/gCty0
         MODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:to:from:date:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hu8teaCMlPYTjOnrG0NiGe0Q3Jj8nxpIHrZvb7hsUZY=;
        b=50qpSFEUPGZ+OPdlFXKtUL20DhIHS4yhbKbX4EPEgbOHqVbg9z8SxcLgWR+B88pEcx
         K9G/MrFBkoZjH2+6SahZsKAmex65rIk2XrMUyo0+lL2s2xvPlS69zQyGbhIj6rDWZCh0
         p0W3ZK/gvB8zfXK3VKwS0XG9RedF24biyEjQOufz6ML6X/L4FtUASbNIT5n8+t1jJaYW
         gO80msxNzxTWDoQ9YdEC2j3vqcCe7fdFNR2QWe0wbJztJhkit6XzN50aSKR0ATqr6q5A
         MA4G6NxB0J7LABMoncjiQysiMoQN/paQoRTqbRVglKDlcLOG1eDFGFDK3xXL6u5CIR1+
         mBnA==
X-Gm-Message-State: ACrzQf1ndmJga5n4/268obmq7aIrxQ9LNGCe9vt1HoLI11AFt/62iW/i
        haeN9fVAsSHsUFokwtZbbjOQw+m5gQ==
X-Google-Smtp-Source: AMsMyM7z8odXC+oerCw4Hn3frKFCNHqLivZ/LAQX9TvC5UEUiQ8d+cALNG27lPFFRRWqq6GCXAYWyQ==
X-Received: by 2002:ad4:5c8c:0:b0:4b9:436:de75 with SMTP id o12-20020ad45c8c000000b004b90436de75mr32203291qvh.73.1666884176825;
        Thu, 27 Oct 2022 08:22:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.147.45])
        by smtp.gmail.com with ESMTPSA id n16-20020ac85a10000000b0039cc82a319asm997273qta.76.2022.10.27.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:22:56 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2cd9:e696:a60f:3003])
        by serve.minyard.net (Postfix) with ESMTPSA id 342EC1800BD;
        Thu, 27 Oct 2022 15:22:55 +0000 (UTC)
Date:   Thu, 27 Oct 2022 10:22:54 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [RFC][PATCH v2 10/31] timers: ipmi: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y1qiTjLWG8u2eDPh@minyard.net>
Reply-To: minyard@acm.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150926.969147187@goodmis.org>
 <Y1qhrqfF87gnyiCE@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1qhrqfF87gnyiCE@minyard.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:20:15AM -0500, Corey Minyard wrote:
> On Thu, Oct 27, 2022 at 11:05:35AM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Before a timer is freed, del_timer_shutdown() must be called.
> 
> Thanks, this is in my queue, or:
> 
> Acked-by: Corey Minyard <cminyard@mvista.com>
> 
> if you prefer that.

Well, del_timer_shutdown() isn't there yet, so I guess the Ack is what
you need.

-corey

> 
> -corey
> 
> > 
> > Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> > 
> > Cc: Corey Minyard <minyard@acm.org>
> > Cc: openipmi-developer@lists.sourceforge.net
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
> >  drivers/char/ipmi/ipmi_ssif.c       | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index 49a1707693c9..b577f66f3ca6 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -5540,7 +5540,7 @@ static void __exit cleanup_ipmi(void)
> >  		 * here.
> >  		 */
> >  		atomic_set(&stop_operation, 1);
> > -		del_timer_sync(&ipmi_timer);
> > +		del_timer_shutdown(&ipmi_timer);
> >  
> >  		initialized = false;
> >  
> > diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> > index e1072809fe31..bb4df879a5ab 100644
> > --- a/drivers/char/ipmi/ipmi_ssif.c
> > +++ b/drivers/char/ipmi/ipmi_ssif.c
> > @@ -1273,8 +1273,8 @@ static void shutdown_ssif(void *send_info)
> >  		schedule_timeout(1);
> >  
> >  	ssif_info->stopping = true;
> > -	del_timer_sync(&ssif_info->watch_timer);
> > -	del_timer_sync(&ssif_info->retry_timer);
> > +	del_timer_shutdown(&ssif_info->watch_timer);
> > +	del_timer_shutdown(&ssif_info->retry_timer);
> >  	if (ssif_info->thread) {
> >  		complete(&ssif_info->wake_thread);
> >  		kthread_stop(ssif_info->thread);
> > -- 
> > 2.35.1
