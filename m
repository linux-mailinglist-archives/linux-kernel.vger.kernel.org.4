Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1615A6143FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 05:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKAEte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 00:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAEtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 00:49:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F971FD12;
        Mon, 31 Oct 2022 21:49:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q9so34499892ejd.0;
        Mon, 31 Oct 2022 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WqRNDbAUlJ0O3/34AOe0TVDEPlr0UlTZFj5VM45W9Q=;
        b=iYtIw1Eq8dpSU+eEwDdnHE7hg6LUSp40eXnzR9aB7OZrL2moWt+99Mm6bMst7tEP9J
         ZavOkhBsDRBmNzpMw8FtDfmIx9d5jgx9Hg9LILR7CGNM70EydWvXvKUl/7mi+83/kxOm
         b1lfPhxaKC1XAzCEtC3aw8R6Yp0MWSFHq9OpLr8CpjWRI5xiekNJsKoI9h08wkWLoGih
         e5P+9h5hyyqBGq0IxYkYVX8RPN9xLhFW7/BEg14hu8HLFoW9nqTyMGxVIFh9yA05tUPi
         LtimMo8hHLo4uZcWcYN9XgegcC7mqG8uKGjoLpqoOe9SxVfjRWhRu9JIBEL1qW7TSdFJ
         Kp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WqRNDbAUlJ0O3/34AOe0TVDEPlr0UlTZFj5VM45W9Q=;
        b=G2sF6rW7yv7uwX80VaEX2E4+xdoUot8a4FduHiXnXvmPrD2xeLDxUdoeRyS9zRHXFZ
         xdg6a6JSOwmDVQqO6fabTrYsREV3BrGPc4tMzdr1qFXMCiYTYIVZZBcGcO2Fw9jUQf3Q
         jn9OVjJco/fvHINVQi4Jt5pTWFilaE9Zio6vhyS7tDQMwrP+2WorRXeLvJp3xEb03dIo
         H5K20eY7aKbwB7VNNADCZa9VIyGYXNxamtVRx1qfandxtc5SD2kjvmvHoNH0ALZL5yLY
         sT+sxfHJk+QmhJRlzugWmZJUP7uK5H3o4dstOk6glg3smC66W71BJciKXQBG2Z3xX19H
         VYkQ==
X-Gm-Message-State: ACrzQf3PgaHWVPcXckq9oIowQeP0bTelJACBq1MyJGun224HrZ01Krm9
        DwCzV2NDFNMJ6wVIqqg79WYm8aVRydk=
X-Google-Smtp-Source: AMsMyM7pHRAEfENB1OAVTQn74jeAN1OqeQnMUo4lZuM/uovIxovpq9/9cvKjgs9e/LJtG+hpPFyskA==
X-Received: by 2002:a17:907:9627:b0:78d:a7d8:9407 with SMTP id gb39-20020a170907962700b0078da7d89407mr16026062ejc.675.1667278169936;
        Mon, 31 Oct 2022 21:49:29 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0078d9b967962sm3780601ejt.65.2022.10.31.21.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 21:49:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 1 Nov 2022 05:49:27 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y2ClV/i9ongBosna@pc636>
References: <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1xIY77sFTyxgAsU@google.com>
 <Y1/LwKz60iU2izOZ@pc636>
 <CAEXW_YTmtm2yb0MVvNV9C1jPEs=5K9PaEFsWEG7pAmPAyWJ_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTmtm2yb0MVvNV9C1jPEs=5K9PaEFsWEG7pAmPAyWJ_qQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 31, 2022 at 9:21 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
> > > On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > > > >
> > > > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > > > understand the differences in your respective platforms' definitions of
> > > > > > "good".  ;-)
> > > > > >
> > > > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > > >
> > > > > <snip>
> > > > > 1. Home screen swipe:
> [...]
> > > > > 2. App launches:
> [...]
> > > > > <snip>
> > > > >
> > > > > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > > > > some time ago improving kvfree_rcu() batching:
> > > > >
> > > > > <snip>
> > > > > commit 51824b780b719c53113dc39e027fbf670dc66028
> > > > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Date:   Thu Jun 30 18:33:35 2022 +0200
> > > > >
> > > > >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > > > >
> > > > >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > > > >     which is roughly 50 milliseconds. The drawback of this approach is
> > > > >     low utilization of the 512 page slots in scenarios with infrequence
> > > > >     kvfree_rcu() calls.  For example on an Android system:
> > > > > <snip>
> > > > >
> > > > > The trace that i posted was taken without it.
> > > >
> > > > And if I am not getting too confused, that patch is now in mainline.
> > > > So it does make sense to rely on it, then.  ;-)
> > >
> > > Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
> > > to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?
> > >
> > This is very good.
> >
> > Below is a plot that i have taken during one use-case. It is about three
> > apps usage in parallel. It was done by running "monkey" test:
> >
> > wget ftp://vps418301.ovh.net/incoming/monkey_3_apps_slab_usage_5_minutes.png
> >
> > i set up three apps as usage scenario: Google Chrome, YoTube and Camera.
> > I logged the Slab metric from the /proc/meminfo. Sampling rate is 0.1 second.
> >
> > Please have a look at results. It reflects what i am saying. non-flush
> > kvfree RCU variant makes a memory usage higher. What is not acceptable
> > for our mobile devices and workloads.
> 
> That does look higher, though honestly about ~5%. But that's just the
> effect of more "laziness". The graph itself does not show a higher
> number of shrinker invocations, in fact I think shrinker invocations
> are not happening much that's why the slab holds more memory. The
> system may not be under memory pressure?
> 
The idea is to minimize a possibility of entering into a low memory
condition mode. This is bad from a sluggishness point of view for users.
I am saying it in a context of android devices.

> Anyway, I agree with your point of view and I think my concern does
> not even occur with the latest patch on avoiding RCU that I posted
> [1], so I come in peace.
> 
> [1] https://lore.kernel.org/rcu/20221029132856.3752018-1-joel@joelfernandes.org/
> 
I will have a look at it.

>
> I am going to start merging all the lazy patches to ChromeOS 5.10 now
> including your kfree updates, except for [1] while we discuss it.
>
Good for ChromeOS users :)

--
Uladzislau Rezki
