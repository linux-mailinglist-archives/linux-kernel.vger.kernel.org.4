Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D2621D35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKHTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHTsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:48:51 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3462380
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:48:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l11so24130389edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlkv2tlDXejHn+hQsU73722g8dssIRwNgf4clzEKA80=;
        b=u4lSuk40Qa6Qhn86j97i/sV4jHTyWgm3XdoGOMkNaPHd6tUNlMRgs4J31VW7CgLpfL
         L0cfv5vAf6kc4c+ccuSWDLiBnQZ66PfHQkxRF0HEUYaj5+IuklD1X3N+S51akNS/qkpw
         xJYRR+GHQ94jZpP/uq6u1JjHbbMvFnF5Ai7SINxaNcGj6C0VLHhsqttEd7tF/Axrb3KJ
         dYfcd9DJAemKlHpqX47DM1jM+kpwft4LH8MpE4qBUzuAcI3exjAK8NE/gnI+r8D69Zgr
         +qnUQXY8ZVbBQPO4XcvSJ/IpMKfvHKPvG881szJMaDCTS8z45F2sqjEipV/drfkMp48o
         1X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlkv2tlDXejHn+hQsU73722g8dssIRwNgf4clzEKA80=;
        b=pRhbvUlDDnqONcYMnyaL4WhusPr/D6cfLAqQvTvsnvkH0LPpiGtuB0M9Dp6Ej8gtY8
         ofVJ9/TdwtKcdtjxKV55gEy827HpXLX71BE3jjnvHJpuan8RRNnIsJhdR0aHc3IXI1za
         5MAehrwqzNk7w6Y2vf5a4CPgEFjPmEfKbLlzbqm8lQDUzE2tYly/ilspgDpdRH9ed67B
         hb25puogwlQMwZenhFUu7vVGGzucCSVVJq3qShqprbbPBOBcxKK6WmAQgixDsnjp/p4E
         ZhI8EiqSmActRMQEMAU3GUgOgJ1CCpslpYcM8ih0XhxZsgB1nrmuqWsKpOVhF0+iEcOJ
         eFcg==
X-Gm-Message-State: ACrzQf0+1posKgRM7sxV3BgyHGXJkaWM7iUh/+v8u5MfOHp7WxPds8tR
        K8lKiyyLvt+PFudr6PkNaXyDIA==
X-Google-Smtp-Source: AMsMyM6eCQJg88gNeoEFGJ/UaDP+ltk4Q+gSzLON34mXuIr8AsCVJtdn0Hb8g/holaOcisL7TWqsOw==
X-Received: by 2002:aa7:d590:0:b0:463:d21a:f0af with SMTP id r16-20020aa7d590000000b00463d21af0afmr38558880edq.50.1667936928417;
        Tue, 08 Nov 2022 11:48:48 -0800 (PST)
Received: from airbuntu (92.40.171.176.threembb.co.uk. [92.40.171.176])
        by smtp.gmail.com with ESMTPSA id a12-20020a50ff0c000000b00458b41d9460sm5863890edu.92.2022.11.08.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:48:48 -0800 (PST)
Date:   Tue, 8 Nov 2022 19:48:43 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20221108194843.i4qckcu7zwqstyis@airbuntu>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 14:41, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> 
> > Based on all the tests we've seen, jankbench or otherwise, the
> > improvement can mainly be attributed to the faster ramp up of frequency
> > caused by the shorter PELT window while using schedutil.
> 
> Would something terrible like the below help some?
> 
> If not, I suppose it could be modified to take the current state as
> history. But basically it runs a faster pelt sum along side the regular
> signal just for ramping up the frequency.

A bit of a tangent, but this reminded me of this old patch:

	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/

I think we have a bit too many moving cogs that might be creating undesired
compound effect.

Should we consider removing margins in favour of improving util ramp up/down?
(whether via util_est or pelt hf).

Only worry is lower end devices; but it seems to me better improve util
response and get rid of these magic numbers - if we can. Having the ability to
adjust them at runtime will help defer the trade-offs to sys admins.


Thanks

--
Qais Yousef
