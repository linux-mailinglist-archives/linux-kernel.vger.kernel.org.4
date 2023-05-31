Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F90718950
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjEaSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjEaSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:22:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC397
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:22:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so6856904e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1685557369; x=1688149369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GyEurHwEiX59cT21A0ZjtetqGR44jcas9hRcmVwdBA=;
        b=tPeTHaxN+AJNPyxEidQ1n2XNcljImcYidxbm2MDI9ZgZsX/rpfaqXCd1iWFFtaXNTT
         iwqe7jYDw6MCACE8w57q0+BNqjSphJggHgIJVtcIkWsaLsZnSEqzFh9x8BUmt6bMH4sy
         F3Uwvv2QFTH1O58YpawDogc4XKcupH8M89/f3cEGl74Fqja/zkwVz8kWemO+utc0719L
         FJcY+bI4nfHNn8UlSokshyUH8Ff4BoPNr92908/EegLmNqZRCr2APT6eOfkDk1K0VvIq
         W/8WMJUA/liuqEW57cedpV4jx7pA8jU9wBmXQtpoKbe8SRhxTp9qUI1CWjWdOCW5azA8
         JfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557369; x=1688149369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GyEurHwEiX59cT21A0ZjtetqGR44jcas9hRcmVwdBA=;
        b=QxBz6CyeyjHsZNDS9X1kC8ar1OyJ9cX8Y82/9Qi69QcsLCNgoD28j3f+f9uS7pxij3
         TYyWTaXThdg1inUWZj7hWv7T6nfjW++wJJN4QPGpzx0gEdOmkzj/nYwc8eTYfmeZNWdN
         /zsIHHiu+Cc7OZqaplxvF5Uz/a5QDdHTQ5wswYMCiXjryVZU+WD17BcDnnv+SSc8A6q2
         97Vpeb9by/gPTTKUeyCSsOo+pbBlqcD44AguRhduAgdEwIEJBh6IEtHnr/eWPuftf5XK
         dGOtXSi6V806CDEiHxtAD/dcZfUQguaTXTfBXvPCKrpdu1rdN1bKQkAqIwROQ8euRzyY
         ni/Q==
X-Gm-Message-State: AC+VfDwE7jD++MBdYrNOeKsgVBTjM2yDeATwHxhyJxRzKnCOoUpfiWh9
        LjLWZP2mosYyaeEUaocw6wEoIg==
X-Google-Smtp-Source: ACHHUZ7Ld3y8iwMuw9iMhBZwkj8ipsa1begSEOnmuiURtYUpVt+tl8Af63xW/gf4gPhoyVSM7n37dg==
X-Received: by 2002:ac2:5237:0:b0:4eb:42b7:8c18 with SMTP id i23-20020ac25237000000b004eb42b78c18mr3254561lfl.53.1685557368674;
        Wed, 31 May 2023 11:22:48 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d6e5c000000b0030aea925fbesm7712105wrz.50.2023.05.31.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:22:47 -0700 (PDT)
Date:   Wed, 31 May 2023 19:22:43 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230531182243.r4d5teuijiadwp2c@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <48db3f08-a066-c078-bfc9-bf20f66e067a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48db3f08-a066-c078-bfc9-bf20f66e067a@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz!

Sorry for late response..

On 05/22/23 09:30, Lukasz Luba wrote:
> Hi Qais,
> 
> I have a question regarding the 'soft cpu affinity'.

[...]

> > IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
> > is two folds:
> > 
> > 	1. Prevent tasks from consuming energy.
> > 	2. Keep them away from expensive CPUs.
> > 
> > 2 is actually very important for 2 reasons:
> > 
> > 	a. Because of max aggregation - any uncapped tasks that wakes up will
> > 	   cause a frequency spike on this 'expensive' cpu. We don't have
> > 	   a mechanism to downmigrate it - which is another thing I'm working
> > 	   on.
> > 	b. It is desired to keep these bigger cpu idle ready for more important
> > 	   work.
> > 
> > For 2, generally we don't want these tasks to steal bandwidth from these CPUs
> > that we'd like to preserve for other type of work.
> 
> I'm a bit afraid about such 'strong force'. That means the task would
> not go via EAS if we set uclamp_max e.g. 90, while the little capacity
> is 125. Or am I missing something?

We should go via EAS, actually that's the whole point.

Why do you think we won't go via EAS? The logic should be is we give a hint to
prefer the little core, but we still can pick something else if it's more
energy efficient.

What uclamp_max enables us is to still consider that little core even if it's
utilization says it doesn't fit there. We need to merge these patches first
though as it's broken at the moment. if little capacity is 125 and utilization
of the task is 125, then even if uclamp_max is 0, EAS will skip the whole
little cluster as apotential candidate because there's no spare_capacity there.
Even if the whole little cluster is idle.

> 
> This might effectively use more energy for those tasks which can run on
> any CPU and EAS would figure a good energy placement. I'm worried
> about this, since we have L3+littles in one DVFS domain and the L3
> would be only bigger in future.

It's a bias that will enable the search algorithm in EAS to still consider the
little core for big tasks. This bias will depend on the uclamp_max value chosen
by userspace (so they have some control on how hard to cap the task), and what
else is happening in the system at the time it wakes up.

> 
> IMO to keep the big cpus more in idle, we should give them big energy
> wake up cost. That's my 3rd feature to the EM presented in OSPM2023.

Considering the wake up cost in EAS would be a great addition to have :)

> 
> > 
> > Of course userspace has control by selecting the right uclamp_max value. They
> > can increase it to allow a spill to next pd - or keep it low to steer them more
> > strongly on a specific pd.
> 
> This would we be interesting to see in practice. I think we need such
> experiment, for such changes.

I'm not sure what you mean by 'such changes'. I hope you don't mean these
patches as they are not the key. They fix an obvious bug where task placement
hint won't work at all. They don't modify any behavior that shouldn't have
already been there. Nor introduce new limitation. I have to say I am
disappointed that these patches aren't considered an important fix for an
obvious breakage.


Thanks

--
Qais Yousef
