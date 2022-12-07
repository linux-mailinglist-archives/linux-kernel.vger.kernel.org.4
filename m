Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7A6451FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGCYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGCYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:24:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388C4C25B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:24:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q15so15209327pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 18:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XlDMsRUpu/xnXct4TsOafZdLl4rYJetwGCVHmIqhWZ8=;
        b=rCW1VEUCajjlxmW7mqr5jYelH5e3t9jK/EoauFb7m+5Z1cZAhh0LuAYIfDIC2noN+Y
         MZVWdFbEgczzOF9nlrBDAnAS3kswrQlD7iBS9JEPU5NXKrF+dlTlSH87+7WPivMdYm1O
         ia8zP+xQaLnaWTDZf4tjk2ONkDSJQa98NnnfOdbbNwG9lwBeZG/Wq4GDZy7RlCf3on98
         dAbRBFedzhJazQytU+Xb3JHXoLxHacQz6wQXBDw7FjIVCM9/L2OAmag7dJDUwAWX+MzM
         vNldI8Udl8zSqBWWoDtIzHoab1z+ocPOGd4mrw1Q4Y10JkPnI6KIpKjv/vevMTTv1XR/
         n+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlDMsRUpu/xnXct4TsOafZdLl4rYJetwGCVHmIqhWZ8=;
        b=3Rmj4is1PcPnmb+6UvgA6IwmjAkis+h0qeHzry/kE3JH33JxfIMUXdQaya9g61Z+7m
         OLB9La7MAx7/j/Fy7UbHL8doAdxXk19gpDWjr1XPOwuqnYwjsHjU89J7TPJWFP8fv0rs
         M1Xo/PMfkcVuuw8w42csPZixmBnSyFsbXOzlk0tUfHlgFMk9VSpMig4Z5/NMO+dsRlow
         iyzaZlKzShdoMWh1anQCYLe2+AiLQjlRGacMeuQ34dqek5zwS3e346ylSRU0NeHawJZZ
         5heN6M71Kqy4Jxyln9mBnxPVjQL8adRXKp/Nz3PZa3wyZB5dECC55/Zcl7tnzDg8e514
         1jFQ==
X-Gm-Message-State: ANoB5pn7drmLUR6w0xvOFXg4Tik/kdgTn7vh84kB+aKtu7W1//JM9Ljy
        0sX2CYFgpXqxgcR68lb9tMuEj86OB3QbPHmPnZ4wBQ==
X-Google-Smtp-Source: AA0mqf6Hs2e7pCRHolwrPr6Wob7+keyiEFkznivWBVAfj9H3kWoez+Sw3/ykpukzKOca6Eo9/qMxr41YKMGpuMY3gsY=
X-Received: by 2002:a17:902:e194:b0:189:56ab:ab68 with SMTP id
 y20-20020a170902e19400b0018956abab68mr64104314pla.144.1670379839574; Tue, 06
 Dec 2022 18:23:59 -0800 (PST)
MIME-Version: 1.0
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1> <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1> <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 6 Dec 2022 18:23:47 -0800
Message-ID: <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't want to add more dedicated knobs. So using
> sysctl_sched_min_granularity as you are doing in this patch looks ok

If not a knob, then maybe at least a smaller hardcoded value? Several
milliseconds seems like too long for this optimization; the
opportunity cost of not doing the idle search likely doesn't make
sense if the waker is going to be active for several additional
milliseconds. I would have guessed something on the order of 100us.

Chen, what is the run duration of tasks in your ping pong example?
