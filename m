Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDC68D2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjBGJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjBGJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:36:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256361F92F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:36:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id e22so12272478ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqez0WTIjAECpSTVy+WsmSYal7hlzq2xCqDHrqSIPeE=;
        b=OlFBWppjWdhZgTAaVEr/i2pmkfvPGiFu9YKXuxsMh2cVXSMsJ0CCp+gJoIyulTAMPC
         6S4Kz0/JkGXmIHlpyWiCTmWRC0rbdUAhzXeMuFpMvjA8iJO8GzT8vt2VAuINFFqqoLbh
         jDbB9UOG+hqea849xn2POxst8feet+hozIth8YGgHvK8mG/2+kgN9DbFBnd7t1knmAh0
         +mGS13Q0XXVxzDueaoqGPp25lvt/LCFWDJUo6VswjoZJQhzVdvpgIZKE0q3l1Ic0MUaO
         HgyxYJuKueVZ9srtpDYhkKUpXkwW5hVlwfUAaGTUq5IA3DEZzihJ6S9hSu2PFFpJsNZT
         U/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqez0WTIjAECpSTVy+WsmSYal7hlzq2xCqDHrqSIPeE=;
        b=H/a6gxAnHP4SPvySF4Q8+UjYGu/Xu6hz7mEourTD0t0Uy5RDON5Z9RSM34s7FkwRRO
         Utav8CWkO73MZ4AEHqR+wUL//RTu8a/0y84g5H1tWUHfDhItq2zZ/BkZxcELnzBlzgfX
         oSZuQlEc2nb1FMrQv5h1tPSdMMPVMMFNP0NNRghTSZ84VQhqQdIAIdyjqK+y2Xjnd4ij
         xRpXRJzK9WN23G32zthdA8Jv7aw86x0FvgQoLBuoBg+jXrOBo399mYoZS//xupfmg7mV
         BlIl10ErHhFtu29ei9IpGaprUpFLl2TpIBcXwi3VK7T0v0P8VUU2osclRDb8So6KHfqA
         jsbw==
X-Gm-Message-State: AO0yUKVI861ZgqMpJRVA3tS5tTHdYYkQ5OyHWx3twMiHBTJwTSSiLZXL
        JUGThrGBN2FkqFGPIjv+fAg=
X-Google-Smtp-Source: AK7set92ftr/mk4GxkwEKjv3pgNhGInhZFE08TNlhvcIsKEHSzQJYYZxd086/H0KkwUNKnNavMN+iA==
X-Received: by 2002:a17:906:fe41:b0:8aa:12c2:5ef2 with SMTP id wz1-20020a170906fe4100b008aa12c25ef2mr1467858ejb.13.1675762589697;
        Tue, 07 Feb 2023 01:36:29 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id o24-20020a170906861800b0089c72982de6sm3371030ejx.160.2023.02.07.01.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:36:29 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:36:27 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: vt6655: Macro with braces issue changed
 to inline function
Message-ID: <Y+Ibm7T447KUY7VU@combine-ThinkPad-S1-Yoga>
References: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
 <Y+IUXSO8LM53qHoJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+IUXSO8LM53qHoJ@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:05:33AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 07, 2023 at 09:40:37AM +0100, Guru Mehar Rachaputi wrote:
> > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > as '(iobase)' to avoid precedence issues" changed to inline function. In
> > relation to this, names of the callers of macro are also modified to call
> > this function.
> > 
> > 
> > Changes in v4:
> > 	- Modified commit message to be clear
> > 
> > Changes in v3:
> > 	1. Whitespace error from checkpatch fixed
> > 	2. Should be applied together with changes in v2 for testing
> > 
> > Changes in v2:
> > 	- Macros with one statement that is to call 'iowrite8' function changed
> > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > 	In relation to this, names of the callers of macro are also modified
> > 	to call this function.
> > 
> > 
> > Guru Mehar Rachaputi (4):
> >   staging: vt6655: Add braces to macro parameter 'iobase'
> >   staging: vt6655: Macro with braces issue change to inline function
> >   staging: vt6655: Macro with braces issue change to inline function
> >   staging: vt6655: Macro with braces issue changed to inline function
> > 
> >  drivers/staging/vt6655/card.c        |  4 ++--
> >  drivers/staging/vt6655/channel.c     |  4 ++--
> >  drivers/staging/vt6655/device_main.c | 12 ++++++------
> >  drivers/staging/vt6655/mac.c         |  8 ++++----
> >  drivers/staging/vt6655/mac.h         | 12 +++++++++---
> >  5 files changed, 23 insertions(+), 17 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> > -- 
> > Thanks & Regards,
> > Guru
> 
> > >From 447c10de599e3434fb6c012cdfc2cc8e4b5c839b Mon Sep 17 00:00:00 2001
> > Message-Id: <447c10de599e3434fb6c012cdfc2cc8e4b5c839b.1675753094.git.gurumeharrachaputi@gmail.com>
> > In-Reply-To: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
> > References: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
> > From: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > Date: Sat, 4 Feb 2023 04:34:38 +0100
> > Subject: [PATCH v2 1/4] staging: vt6655: Add braces to macro parameter
> >  'iobase'
> 
> <snip>
> 
> Do you see other examples of people on the mailing list submitting
> patches as multiple attachments?
> 
> Please do not do this.
> 
> I recommend taking a week or so and reviewing the other submissions that
> are sent to the list first, to understand the processes involved, before
> trying to submit your own changes.
> 
> Remember, you need to learn to read first, before you learn how to write :)
> 
> thanks,
> 
> greg k-h

Noted, Thank you.

-- 
Thanks & Regards,
Guru
