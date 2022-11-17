Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8D62DD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKQNoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbiKQNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:43:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FA716E3;
        Thu, 17 Nov 2022 05:43:58 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u11so2738657ljk.6;
        Thu, 17 Nov 2022 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=39fAotyhMYZaBu0mj5cNmHTlGzK+8bWVHaBxa8IRXT8=;
        b=mxC9wd2ZWDuMo/eEpfQ2dEI8F1VemvEeNYLxIfS4RMf8y+v/3S6U1XUbEOAQetHyw5
         vNxh1kRCEsw/ZO6FY86kjNfnQjbynDcoxBOa0MN2VIzJ3rtgjem2rOhHAV7RTdTzCWoY
         G3uBqny4f3svsIHy4aQM7olfvvwNr7B3xcGuSkInWULtA+NH0GOtXSsNJUr8AKQ+ikOQ
         vrFrjsZudSYm+twYG8w/QmLO2h11zkAtCVx+qDtsHl6OIIhsZCqIN0vZ4C2xoifRCpTt
         XgnFESqaRu8yo4/ER3ofxjGOmADf/5fQURlh5cnhCXWgbSPp2yBQ1r6hGMBAtcVaUDkl
         i1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39fAotyhMYZaBu0mj5cNmHTlGzK+8bWVHaBxa8IRXT8=;
        b=mrMSePPDf7DqNJJ6iRIOCLx279D/uq2YkJHL8AXq2OildNXWGSVN9oZ8Xt/C/BkluM
         V9eAolLs6w5m/NHOc6tfDKke2zQ9DnEUvLkPyOUhbtGJRUol7/IjMpXAxjnLL7+lecAR
         8WSd6Bp9aj33dngSXOhq2r+WcNuu9tEokD17YdpJcNvr6G5j0gw0ACysT5X1vtOavlsO
         gGmGNrZzdaGYk3HWzimXzdRTGgJJjdt3aKCVtJdWbFQCuqMPrcnm4BGkIe1iPYfRCxP+
         DRzQZLX3mNvmyvvt7dSFg/NoKruFJdq8q+1g0GlzcXFhsPs33YC2WP2/sNrOAMvBfhcb
         fB1Q==
X-Gm-Message-State: ANoB5pmlt4UnvHYhnexsVLPmZb5E5dvIM+wADbDNJ9iUuw/46cMW1JaX
        mMAX82atTmYvmLUhZySiQRxZeoDh0tw=
X-Google-Smtp-Source: AA0mqf6t4c/zD3RJc0wX7jOwkrlkYqCkjoiHic08R4lCvZ9T7Wt0p27N9uDJmMu8regsa0UcQ3yUvA==
X-Received: by 2002:a2e:9457:0:b0:26e:6730:2da2 with SMTP id o23-20020a2e9457000000b0026e67302da2mr1027292ljh.245.1668692636384;
        Thu, 17 Nov 2022 05:43:56 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004b40c2fccfdsm158148lfc.59.2022.11.17.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:43:56 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 17 Nov 2022 14:43:53 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3Y6mU5WUqbxfunf@pc636>
References: <Y3YzCi9exKhiAAd0@pc636>
 <938BD0DD-9F91-44E6-BCBA-3DA3FA6779C0@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <938BD0DD-9F91-44E6-BCBA-3DA3FA6779C0@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:23:30AM -0500, Joel Fernandes wrote:
> 
> 
> > On Nov 17, 2022, at 8:11 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Thu, Nov 17, 2022 at 08:06:21AM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Nov 17, 2022, at 7:58 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> ﻿On Wed, Nov 16, 2022 at 10:05:46PM +0000, Joel Fernandes wrote:
> >>>>> On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>> 
> >>>>> Hello, Paul, Joel.
> >>>>> 
> >>>>>>> 
> >>>>>>> Yes sure, I am doing a run now with my patch. However, I have a
> >>>>>>> question -- why do you feel blocking in the kworker is not an issue?
> >>>>>>> You are taking a snapshot before queuing the normal kwork and then
> >>>>>>> reading the snapshot when the normal kwork runs. Considering it is a
> >>>>>>> high priority queue, the delay between when you are taking the
> >>>>>>> snapshot, and reading it is likely small so there is a bigger chance
> >>>>>>> of blocking in cond_synchronize_rcu(). Did I miss something?
> >>>>>>> 
> >>>>>> We can wait indeed in the reclaim worker. But the worker does not do any
> >>>>>> nasty or extra work here. If there is a need we block and wait. After a
> >>>>>> grace period, we are awoken and proceed.
> >>>>>> 
> >>>>>> Therefore i do not see the reason in handling two cases:
> >>>>>> 
> >>>>>> if (gp_done)
> >>>>>>   queue_work();
> >>>>>> else
> >>>>>>   queue_rcu_work();
> >>>>>> 
> >>>>>> it is the same if we just queue the work and check on entry. The current
> >>>>>> scenario is: queue the work after a grace period. This is the difference.
> >>>>>> 
> >>>>>> Right if the reclaimer was a high prio kthread a time would be shorter.
> >>>>>> 
> >>>>>> In your scenario the time seems even shorter(i have not checked) because
> >>>>>> you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
> >>>>>> basically even though you have objects whose grace period is passed you
> >>>>>> do not separate it anyhow. Because you update the:
> >>>>>> 
> >>>>>> krcp->gp_snap = get_state_synchronize_rcu();
> >>>>>> 
> >>>>>> too often.
> >>>>>> 
> >>>>> Once upon a time we discussed that it is worth to keep track of GP
> >>>>> per-a-page in order to reduce a memory footprint. Below patch addresses
> >>>>> it:
> >>>> 
> >>>> In the patch below, it appears you are tracking the GP per krwp, and
> >>>> not per page. But I could be missing something - could you split it
> >>>> into separate patches for easier review?
> >>>> 
> >>> I will split. I was thinking about it. The GP is tracked per-a-page. As for
> >>> krwp it is only for channel_3. Everything goes there if no-page or no cache.
> >>> 
> >> Ah, ok.
> >> 
> >>>> 
> >>>> Also it still does cond_synchronize_rcu() :-(
> >>>> 
> >>> Sometimes we need to wait for a GP we can not just release :)
> >> 
> >> You know that is not what I meant ;) I was concerned about the blocking.
> >> 
> > Let me split. After that we/you can test and check if there is any issue
> > with sleeping on entry for waiting a GP if needed.
> 
> Ack. What I’ll also do is, whenever you split it, I’ll put it on ChromeOS and see in real world, how many times we block. It could be I’m missing something of how polled GP works.
> 
Good!

--
Uladzislau Rezki
