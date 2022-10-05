Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E75F5B7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJEVLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJEVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF25220FD;
        Wed,  5 Oct 2022 14:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67683617B6;
        Wed,  5 Oct 2022 21:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01348C433D6;
        Wed,  5 Oct 2022 21:11:31 +0000 (UTC)
Date:   Wed, 5 Oct 2022 17:11:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v2] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221005171136.1a5e6673@gandalf.local.home>
In-Reply-To: <20221005193924.GA3237208@roeck-us.net>
References: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
        <20221004185146.5d4419ba@gandalf.local.home>
        <20221005071946.blttrgv2s5amnrrj@pengutronix.de>
        <20221005193924.GA3237208@roeck-us.net>
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

On Wed, 5 Oct 2022 12:39:24 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > > Nit, but I would probably put the above TRACE_EVENT() below the two
> > > DEFINE_EVENT()s below. That way we have all the DEFINE_EVENT()s for a
> > > specific DECLARE_EVENT_CLASS() together. Otherwise people may get confused.  
> > 
> > I thought about that, too. The argument for the order I chose is that
> > having start at the start and stop at the end is also intuitive.
> > 
> > But I don't care much and would let the watchdog guys decide what they
> > prefer.
> > 
> > @Wim+Guenter: Feel free to reorder at application time or ask for a v3
> > if this v2 doesn't fit your preference.  
> 
> For my part I would prefer a version with Steven's Reviewed-by: tag,
> whatever it is.

I much rather have the DEFINE_EVENTS followed by the DECLARE_EVENT_CLASS()
as that's what most people look for.

For start and stop being together, I believe that will not trip many people
up, where as the DEFINE_EVENTS() scattering will.

I'm OK if maintainers of the code are fine with the scattering, but it will
break precedence. 

-- Steve
