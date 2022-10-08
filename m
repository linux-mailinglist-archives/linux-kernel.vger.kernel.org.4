Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BEC5F85F2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJHPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJHPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:50:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3A32B89;
        Sat,  8 Oct 2022 08:50:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l4so6983239plb.8;
        Sat, 08 Oct 2022 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4vy46gmcheBnWapCboJEueSpQKB4lJxx0lpuUJSix8=;
        b=HxAl+mIXwfo1RRUj7g2SG+tXu03aLjFhuLaE1n+wC9K3B932y63SLT65adlIjxILxU
         AzCYU3DNB5D+wb9ipEG70ULBP7sG3WwYh17a9dl3LvPOnYIpGCYP7odtxiem0zkFyhvb
         p0izq0iu2awUp6eDzXVlWo25/NMeiiGEKALFEAXGEAbQTpGBFLu0CJfyywpg6Ck+uqkT
         0iLO1Gn04IDznT3do5xnt3auTcacHnMs96nD4CQTznhBu41VKBgkfmwxBBL3RBsV25RE
         I1f3iUuf6eJd8oyZbsI0TxRC+1I8dsFVev/bLyAaV6peULUTyGYN+C5AftUoX94D4hy1
         KvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4vy46gmcheBnWapCboJEueSpQKB4lJxx0lpuUJSix8=;
        b=qzJswFrePtvQ+YeRwkaGaUyw+sKVUi0nOpuWbt1ZuzvVmtZqzGky672hTEYGsyMhum
         qQE4Ek/ONPGsSb8lLCyWvrr3yBN/17WDiHGxnMXpFVwoaMXSM/u59Y/fkucvShZUnvTU
         wXgrkGB6/2otYhsLxlXNussXpEtc1Z03BqOUttZbv4ziAOxrZjXuhbeEO/h4CWbems6q
         XRa7hMZBr2nHJeriKdt2sj660SLnHE6+VP1KXZEu09gLdh2xFdrr+8chAEh+ykruPcre
         tlQZlBhmsLiMOYdb5+dVpUAC4m32GfhwMCKvxCzpmHwOJFq1gUgOa/2EPSo4cGT5ao+5
         HOlA==
X-Gm-Message-State: ACrzQf0lZSWgB652ILEvUChGHmcgGrHSxHNll10IVLGfEYE0j68xUq8w
        YB6sAr/eXSg25C9hQJFhyac=
X-Google-Smtp-Source: AMsMyM4yyFDFC7YpekV2yHwfMLEWVyL3vEbMO6IDNSVMtYmXlsZxX23SqVAOipRNK1cqQTmA0g/PKQ==
X-Received: by 2002:a17:903:32c6:b0:180:9099:ff10 with SMTP id i6-20020a17090332c600b001809099ff10mr5485629plr.77.1665244208649;
        Sat, 08 Oct 2022 08:50:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gb9-20020a17090b060900b001fe39bda429sm3255746pjb.38.2022.10.08.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 08:50:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 8 Oct 2022 08:50:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v2] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221008155005.GA1733634@roeck-us.net>
References: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
 <20221004185146.5d4419ba@gandalf.local.home>
 <20221005071946.blttrgv2s5amnrrj@pengutronix.de>
 <20221005193924.GA3237208@roeck-us.net>
 <20221005171136.1a5e6673@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005171136.1a5e6673@gandalf.local.home>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 05:11:36PM -0400, Steven Rostedt wrote:
> On Wed, 5 Oct 2022 12:39:24 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > > > Nit, but I would probably put the above TRACE_EVENT() below the two
> > > > DEFINE_EVENT()s below. That way we have all the DEFINE_EVENT()s for a
> > > > specific DECLARE_EVENT_CLASS() together. Otherwise people may get confused.  
> > > 
> > > I thought about that, too. The argument for the order I chose is that
> > > having start at the start and stop at the end is also intuitive.
> > > 
> > > But I don't care much and would let the watchdog guys decide what they
> > > prefer.
> > > 
> > > @Wim+Guenter: Feel free to reorder at application time or ask for a v3
> > > if this v2 doesn't fit your preference.  
> > 
> > For my part I would prefer a version with Steven's Reviewed-by: tag,
> > whatever it is.
> 
> I much rather have the DEFINE_EVENTS followed by the DECLARE_EVENT_CLASS()
> as that's what most people look for.
> 
> For start and stop being together, I believe that will not trip many people
> up, where as the DEFINE_EVENTS() scattering will.
> 

I agree. Uwe, please send v3 with those changes.

Thanks,
Guenter
