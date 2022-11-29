Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8629763B74A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiK2Bcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiK2Bca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:32:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E692429B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:32:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d6so20228906lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqhAJ45Mn60yAGeU39MmfTEM/a4wAbyDIX0NbEi7DBw=;
        b=nzAFKZFYpYrt0XQczu0dYlhG5WmM9qRVJHMmT8GlA+CDIgPP+7my461zOG4FBhOMGp
         ee6eq7Tda0KULuh3PlSLZ8pKu+xS2fIPW7CMJvb7ZoRqN5qKxuYHW3ItVEPgCiL47auF
         MQQ10xNZ0bpoEpZCUvzhmwZrumKD4UrjccOKZMIme6r2vvmhwlxLrqiT3yUiA3An1ekg
         nqInS12Sz6AAJwlUG/MOS4hJTN7GcQfvItkZ5DKbxtG7UFBmgiX++2/9GQVmi7VFE5E5
         KYMbzlfzTKC7z5jF7Ikfvlcq8fuf5oH4+d5rO9alI55pPic7CA+rseDW+2XYNYufNAUV
         y/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqhAJ45Mn60yAGeU39MmfTEM/a4wAbyDIX0NbEi7DBw=;
        b=nSETL6RGfFZDQWmJffyXUJ2rvhoAaOIfv06xJK05tfFNpJ8ZQ7i1/2N2poHSJqoOLV
         aValL2H25EslicGBFh2HUG6Gf8oaZk1nuBatxaQgp1/vWkJAZNGYX2f5coRRLNu2My9u
         JQpv8hKrn18XmqY48cO0f0W2Xd7P5a5EVMfQA8eAxk+W6065t6RAJd3i8eIsH+ym+bnM
         twTqoYn/lpJjN6yEPcD1Mx3h7Vc0C+GJB4VIAYFy7HK/h1X+7AftZGTVb8TBjSOYwYQR
         qpQH+6WE716MfH8CY27/kfDyOTawaf2j+yMRLCOf1HY7DYF9fYBa1zzTwTwa5apwC0/s
         ZA0w==
X-Gm-Message-State: ANoB5plhRyuNTSneMgrMb4g9RgnGwy8t3k2lsX3wY3QQZHoli6qJ/ozb
        sTIF5bik0iWUnigSTJyFbkWeIBWrhOE2z5YliKLy3A==
X-Google-Smtp-Source: AA0mqf6Y19vc1bxzipOngZTHl1luLRE9ozxQdJzQYfU/5Ne8ureAO1n42VPkT/oc4OiNLFF2NQr6U3OsMoU3AoLnKcw=
X-Received: by 2002:ac2:5f41:0:b0:4b3:cc01:102b with SMTP id
 1-20020ac25f41000000b004b3cc01102bmr19211562lfz.133.1669685547794; Mon, 28
 Nov 2022 17:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev> <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
 <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net> <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
In-Reply-To: <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 28 Nov 2022 17:32:15 -0800
Message-ID: <CABk29NsyhxiOnE7ssJpPEvgFV2_em1k2=9Yy3nMG9z9TssbBNA@mail.gmail.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        anna-maria@linutronix.de
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

> @@ -1686,7 +1698,17 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>
>         lockdep_hrtimer_exit(expires_in_hardirq);
>         trace_hrtimer_expire_exit(timer);
> -       raw_spin_lock_irq(&cpu_base->lock);
> +
> +       local_irq_disable();
> +
> +       if (restart >= HRTIMER_RESTART_MIGRATE) {
> +               int cpu = restart - HRTIMER_RESTART_MIGRATE;

I know this is just a rough draft, but just noting that this wants a
check against MIGRATE_MAX :)

> +               if (new_cpu_base != cpu_base) {
> +                       timer->base = new_base;
> +                       enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
> +                       raw_spin_unlock(&new_cpu_base->lock);

unlock the old base->lock right?
