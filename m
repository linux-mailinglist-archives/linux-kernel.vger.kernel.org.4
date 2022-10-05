Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986AA5F5AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJETjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJETj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:39:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C97F12C;
        Wed,  5 Oct 2022 12:39:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b15so8420931pje.1;
        Wed, 05 Oct 2022 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=qcCZ5N2/4Gq5VxVKZLNFAinPuKNfRX33ZqBDDpGg1Lg=;
        b=R0V618grOFbGdvu5EnDaTsnggxYiLLJF7RWAFAtfbldTcW7i4OgA6JX//yBuZHJ0Pt
         EDvPHt3YkUFgrHNs3WEcKGbZtrU1M+gxxWU7PEi4FeK6eYD0Acjj1oV8XHPCqznaXNnp
         VnYmCwxgXDTPaozwp4Okvhc+7bXRPHA1FsLNgmEcd6Kkk4r37I/OdFn3vv21gPjgJZg/
         sM33Ke/M9LcrjMW3R/1de55PDtyrq2vWKw0EIHXsjrNkw0dml9vMsIF8GsdEY9EdOCjn
         k1z1eLS1WddabKSw+bR1C4BhUtzYhiVH22VV7/Rd/earM8cAcLAb95sQxaEOxeJjRS+1
         BXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qcCZ5N2/4Gq5VxVKZLNFAinPuKNfRX33ZqBDDpGg1Lg=;
        b=LXWziqZCVHIFC6GYFmVvIxQ/hMoyI/Kwe1/ta/qTnzIPsAUFtDml1MFdureEUvZot5
         fccTtQ77+IFH9m+JUvkeGUfA1deYK4Sm9lgNQLC+XJRM49DMsCrbFrch3NPDcwGz+oIm
         8Q//bzjvLix2Xi/Z2V8dHhAn6mTRyuzvtJCdHSlmmylMsX8FTRu02dIBNrPDrCU/i588
         9Wlkb383wAKyNt5Tv96+OYAe5s8RAMj4Dzs2sivqENiVz9LiCFUYrxoj6paww4bv7AbM
         P0UO1x/+RhjU8pIpT3qFwUHLkMwA9kdN1xhfQ2XlWJuSIO8MSvCsCdBrML8ngDhNfuF5
         So4g==
X-Gm-Message-State: ACrzQf1XyInfra12klbklGc2icaSTywmATzC6vi5kTF+kbY8g/yoW8CO
        4CK8glYE27Kn0i6K7KfVh4E=
X-Google-Smtp-Source: AMsMyM6rAzIPrqAokQTco2uahl4P2HTtLt93hGCA3tN0pzcmi1sBa9895mCrKwsjNbq8MutwmouIRA==
X-Received: by 2002:a17:90a:a512:b0:209:9b31:5f2f with SMTP id a18-20020a17090aa51200b002099b315f2fmr1393637pjq.146.1664998766605;
        Wed, 05 Oct 2022 12:39:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r21-20020a63a555000000b0042bf6034b3fsm111740pgu.55.2022.10.05.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:39:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Oct 2022 12:39:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v2] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221005193924.GA3237208@roeck-us.net>
References: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
 <20221004185146.5d4419ba@gandalf.local.home>
 <20221005071946.blttrgv2s5amnrrj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005071946.blttrgv2s5amnrrj@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:19:46AM +0200, Uwe Kleine-König wrote:
> On Tue, Oct 04, 2022 at 06:51:46PM -0400, Steven Rostedt wrote:
> > On Tue,  4 Oct 2022 11:19:49 +0200
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > +DEFINE_EVENT(watchdog_template, watchdog_start,
> > > +	TP_PROTO(struct watchdog_device *wdd, int err),
> > > +	TP_ARGS(wdd, err));
> > > +
> > > +TRACE_EVENT(watchdog_set_timeout,
> > > +
> > > +	TP_PROTO(struct watchdog_device *wdd, unsigned int timeout, int err),
> > > +
> > > +	TP_ARGS(wdd, timeout, err),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field(int, id)
> > > +		__field(unsigned int, timeout)
> > > +		__field(int, err)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__entry->id = wdd->id;
> > > +		__entry->timeout = timeout;
> > > +		__entry->err = err;
> > > +	),
> > > +
> > > +	TP_printk("watchdog%d timeout=%u err=%d", __entry->id, __entry->timeout, __entry->err)
> > > +);
> > 
> > Nit, but I would probably put the above TRACE_EVENT() below the two
> > DEFINE_EVENT()s below. That way we have all the DEFINE_EVENT()s for a
> > specific DECLARE_EVENT_CLASS() together. Otherwise people may get confused.
> 
> I thought about that, too. The argument for the order I chose is that
> having start at the start and stop at the end is also intuitive.
> 
> But I don't care much and would let the watchdog guys decide what they
> prefer.
> 
> @Wim+Guenter: Feel free to reorder at application time or ask for a v3
> if this v2 doesn't fit your preference.

For my part I would prefer a version with Steven's Reviewed-by: tag,
whatever it is.

Guenter
