Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA76C03A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCSRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099E19F0A;
        Sun, 19 Mar 2023 10:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E1160F4F;
        Sun, 19 Mar 2023 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A2C433EF;
        Sun, 19 Mar 2023 17:55:51 +0000 (UTC)
Date:   Sun, 19 Mar 2023 13:55:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <20230319135550.22aaa04b@rorschach.local.home>
In-Reply-To: <ZBcqWqWyq0uW/wj7@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
        <20230316173811.1223508-5-revest@chromium.org>
        <ZBcqWqWyq0uW/wj7@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 16:29:30 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Mar 16, 2023 at 06:38:08PM +0100, Florent Revest wrote:
> 
> SNIP
> 
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index 30ef8bd48ba3..fd24daa99f34 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
> >  	  that hooks to wake_up_process and prints the parameters.
> >  
> >  config SAMPLE_FTRACE_DIRECT_MULTI  
> 
> nit, we could perhaps remove this config option as well
> and use SAMPLE_FTRACE_DIRECT_MULTI

Remove SAMPLE_FTRACE_DIRECT_MULTI for SAMPLE_FTRACE_DIRECT_MULTI?

-- Steve

> 
> jirka
> 
> > -	tristate "Build register_ftrace_direct_multi() example"
> > +	tristate "Build register_ftrace_direct() on multiple ips example"
> >  	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
> >  	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >  	help  

