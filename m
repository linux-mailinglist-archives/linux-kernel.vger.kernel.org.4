Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80716602302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJRD7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJRD7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:59:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5F88A20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:59:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id be13so4979528lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1IbzdSiR6tLjp8VojCh4WDcI7764XTDkXzy+V8xmVY=;
        b=B5PkU4My2AxIlUJjYKnjO09o2ko/+ftSVSLvqM1r1SXOLwoUNKrCz+O1IeLkFmJT1X
         4QLi2puqIkCWUzWNDoqGtzr+oKk9s+FLTuQGWJamRpggVMHG2qrwyHSCA/Qi3smcubFX
         hrSAJvlcdaas8RAAFunnT3XUGWqs4yz9Kgt/J1RG8MxEAtyrQdMP0i5kU5dkxlEq4X1z
         ikp5NrdL026ZaBX9lHTk49il5M2R/nK/7FpY2HAhBv7gmRz1hRbT6FCFIl/mftA12HO/
         8AKQefLlzlBUMatpi1S2P42kKxXnbMkoNU3EF7q0RR6qB+3duHe3qrFywwFDWiDQwxeM
         nFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1IbzdSiR6tLjp8VojCh4WDcI7764XTDkXzy+V8xmVY=;
        b=lvB48fvcY7S39XRGoJZL3Z+0gJb5eap4c306HDChEyRln/4Q3lOjV5tFu39UdAoF6W
         fi0Pdd39wU5kg/KlcMJyWh87Lp469o8AJErS33SosqJkmMh6LGKbdfJEBDOgpadE9lwp
         8JayfHhF9uYnHXhFA2HntpWgI3RWh6wgBWZCn1RBKVds3n8hd9LHRKn99gMkQj00d1vn
         DrVVSXomkSWbx3VwohtJYD9bNyhQUgfFOXQyx4isSO3zQAA1BhCEKG8gd+9wSAQBGG0x
         xZqxuOOg2YV7Oqo+QfvB1BZ1sn5FoSJXtJTyggP7u1BKqKcxpceHHhDtIKZ2D6+2s+CR
         iZyg==
X-Gm-Message-State: ACrzQf0/PIn5yQqWCVyrqfT5H3HsSbHgCKHMRRTiXmW9zE3mtAOhnGaA
        YjxQiPGV/nhQ7NNcGVIjRhtuJ9sU01aYY268HftW
X-Google-Smtp-Source: AMsMyM72TApPq3OVgpetzuPHz8LlxPX1q59uQQ0L+B3PKdxgU5eHHQA0xVvpb0bSquwhc+Cnf67wTXxCBYn8E/8IA5M=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr275725lfk.426.1666065553267; Mon, 17 Oct
 2022 20:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com> <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
In-Reply-To: <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 17 Oct 2022 20:59:00 -0700
Message-ID: <CANDhNCqsVm6OFm1aYoWJbha8EXS433JL3-jg3eFLcmE5wX9NOw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
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

On Mon, Oct 17, 2022 at 8:42 PM John Stultz <jstultz@google.com> wrote:
>  On Mon, Oct 17, 2022 at 5:40 AM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> > select_task_rq_rt() takes the lock and reads curr already,
> > before calling this funciton. I think there is a way to
> > decompose it in a better way.
>
> Hrm. Suggestions? As select_task_rq_rt() is only one of the callers.
> Trying to pass curr into cpu_busy_with_softirqs() would mean
> cpupri_find_fitness() would need to read the cpu_rq(cpu)->curr for the
> specified cpu and pass that in.
>
> The original patch actually was
>

Whoops I didn't finish my thought there. I was going to say the
original patch did similar to your suggestion, passing the target cpu
curr task value in from select_task_rq_rt().
However it didn't use the cpupri_find_fitness() and duplicated a lot
of similar logic in a way that is not as nice as what the current
version uses.  But I'm very much open to suggestions for other ways to
simplify that as you suggest.

thanks
-john
