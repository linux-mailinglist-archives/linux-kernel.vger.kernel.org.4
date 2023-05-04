Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A966F6ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjEDPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEDPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:23:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2744E44AF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:23:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f315735514so68188315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1683213812; x=1685805812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35JAtLvIMF2KRIOqkirvKykblc6filsyyn1v4l59ziY=;
        b=xzEsH8fHRqdRDIEHQolcr6pCg8r4R6nA6cAEUq/ygxKNbEGC4+pIlB5Enw8uGlnCmV
         JJf7DyZrR7yepYToTifIrVD64Kqt1O7Z2a2CKRA7fXq/lBYfdRnRwubkVYftd7FVPoq5
         XVy/iBnsqnce3lCBV7KhQpNgL21SQhIU98BHw/QHZ3F9xdpnwLtAO0vXyrnQ+7gXyb5n
         x2eZBIy2tl7cDo601n5+6/OeWgVkuSmsVwZUZauHHg8LA+z9aPdvK3r3tPr4gbuUPU0B
         U3r2aKBhFeKr8ozfcmG/bP8FyGsdRw73ONQolpqIOl7RbMqhM/s/5rdS7p46S1dFwuan
         nThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213812; x=1685805812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35JAtLvIMF2KRIOqkirvKykblc6filsyyn1v4l59ziY=;
        b=ArZhnlj8oDe+oHFnZCbMEi29yyeNKLygZMIiIqrBi9r96KGI2QlAmEsPLtTn9jgkIc
         2TTgPbDxy1HAYwDlLOUlBisejrqSBxZ/EEAXh6tb31kpn6Bx0hpRi3TmCmA5KLNJMoYH
         5tzI1RlklYDkEyIouchFrg9olvf3UMVPjMq44m1QFArJORMCiILsvQbuhnxikSXSdSxu
         mY1A7byj0YAjCuqow3LAPdaAw22tUj8ydg12B8SMfN0xSTQdqc5XqPvWvHGQqRZSmvhO
         YKAbVG3RX0lFAyEiwTfvZHPKAAC3Y4p8exoBlRDtc//aJPHAWHUFHsPkorHqpPMwBEy9
         wkwg==
X-Gm-Message-State: AC+VfDxGIYF/q+NEKsQd+EeGrES1vd6uYKYAHkXff8OBhBDPqIUpUgKW
        LVgbfkfrwTwhtM35I1btoWmA8fTFTFr3NxZc84c=
X-Google-Smtp-Source: ACHHUZ5bHsSdgbO9fyET5To2L7fVxDiydoV3BXs/L1SC2XmJsTniKpv4s4W75ygygChqLiQLQ4LKVg==
X-Received: by 2002:a7b:c041:0:b0:3f1:7287:55ad with SMTP id u1-20020a7bc041000000b003f1728755admr61807wmc.10.1683213812515;
        Thu, 04 May 2023 08:23:32 -0700 (PDT)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id a20-20020a1cf014000000b003f173c566b5sm5247775wmb.5.2023.05.04.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:23:32 -0700 (PDT)
Date:   Thu, 4 May 2023 16:23:28 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Message-ID: <20230504152328.twh3rqgq2o2gvd4u@airbuntu>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
 <4c77a01e-8ff3-f415-ffff-01c8d79a8bc7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c77a01e-8ff3-f415-ffff-01c8d79a8bc7@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/23 19:13, Dietmar Eggemann wrote:
> On 29/04/2023 16:58, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 05:50:30PM +0200, Dietmar Eggemann wrote:
> >> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
> >>
> >> The former returns max(util_avg, runnable_avg) capped by max CPU
> >> capacity. CPU contention is thereby considered through runnable_avg.
> >>
> >> The change in load-balance only affects migration type `migrate_util`.
> > 
> > But why, and how does it affect? That is, isn't this Changelog a wee bit
> > sparse?
> 
> Absolutely. 
> 
> I have compelling test data based on JankbenchX on Pixel6 for 
> sugov_get_util() case I will share with v2.

I am actually still concerned this is a global win. This higher contention can
potentially lead to higher power usage. Not every high contention worth
reacting to faster. The blanket 25% headroom in map_util_perf() is already
problematic. And Jankbench is not a true representative of a gaming workload
which is what started this whole discussion. It'd be good if mediatek can
confirm this helps their case. Or for us to find a way to run something more
representative. The original ask was to be selective about being more reactive
for specific scenarios/workloads. If we can't make this selective we need more
data it won't hurt general power consumption. I plan to help with that, but my
focus now is on other areas first, namely getting uclamp_max usable in
production.

Sorry for being cynical. I appreciate all the effort put so far to help find
a sensible solution.


Thanks!

--
Qais Yousef
