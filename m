Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84F6FD8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjEJIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEJIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:05:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85C1BC0;
        Wed, 10 May 2023 01:05:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643912bca6fso5525350b3a.0;
        Wed, 10 May 2023 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683705908; x=1686297908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljqJSEHf5rB6CjYX95aOeKks26kY/lRoTVOs3zuSrsY=;
        b=Ys7J/ceWGdZcQJJI0XvvUCM74oG4/0PMQGNnl1WEClOA1YLotv/SSKEBh/8ZcHhy6n
         qr/kIenbhTa6BOLhA249rxp4PreFX/LSsWwwgnI1jyp/T2yG7Rfj279R67k6xQf4wuiv
         Nk7iDYGWtrQ6MO0yDwkEfNu6+o+Hx+mSybkB7FjlmQ73VJGunMUbda8aeggnyixDpNI+
         2Zi4PJBw3g7sI01lezMCpf6hT6dfObmyn0RjCm3LGaNa1ILZjK68i9RoJsoZ9QTie280
         yBm0kP9/K02g1Vu1d0XpUtqB31iSW5jZCUcR1zqwIlfEn4PYipFy+/iDZiDjqnPnugZe
         9Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705908; x=1686297908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljqJSEHf5rB6CjYX95aOeKks26kY/lRoTVOs3zuSrsY=;
        b=UO7OaBwv4EOZl03Q7f5FbiUKensTyTvmoBE2bJQioxXEtKWopgvdXFzlSZSRY/q+it
         EShOxDA5HKoM20sr2mhkjOClVh0c/fK9rzfy45NNAmf7K8W3MSuxMbOtIftXtH2FZROU
         EeOXdpUbRN0P+YwcsGhEE87dJ/yvDfwCrgaiHDTc+CTZlwgHQGhIzE2Jeag9jBxDe+cX
         ze5nPUMDIf7c2hbgWBdxcVxzqu6bABtWeHBEtoGJzOLYj2rUI5SDRgoCHWU/VPs86hay
         wi85+/7YY6FyHHUk/9lcPNtreS66tePMriFpCZsukwozuCDvmkXJsT05XHdYtR10cwXr
         5png==
X-Gm-Message-State: AC+VfDzg68RJKtgbgVlVuMrgHFHl847MFx3svbmjUJxLjKvTZiC8dzRJ
        yeUoG3vUugxExHWFJsvr6m0=
X-Google-Smtp-Source: ACHHUZ4lDifCu3ZS5CJ5soAkm9+6gAWNvWTXy/zEqbc1HNnzCB99N08rr5bjRNhCMa2Tdh4HHTPQog==
X-Received: by 2002:a05:6a20:394a:b0:101:9344:bf82 with SMTP id r10-20020a056a20394a00b001019344bf82mr4648069pzg.15.1683705907881;
        Wed, 10 May 2023 01:05:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b00640f51801e6sm2949635pfa.159.2023.05.10.01.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:05:07 -0700 (PDT)
Message-ID: <b97d63e4-0ff7-720b-30d7-ad27611e9a8c@gmail.com>
Date:   Wed, 10 May 2023 15:05:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] Documentation: sched/deadline: Update GRUB
 description
Content-Language: en-US
To:     Vineeth Pillai <vineeth@bitbyteword.org>,
        luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
 <20230508160829.2756405-2-vineeth@bitbyteword.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230508160829.2756405-2-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 23:08, Vineeth Pillai wrote:
> diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
> index 9d9be52f221a..0c73f07f712d 100644
> --- a/Documentation/scheduler/sched-deadline.rst
> +++ b/Documentation/scheduler/sched-deadline.rst
> @@ -195,11 +195,15 @@ Deadline Task Scheduling
>        its utilization is added to the active utilization of the runqueue where
>        it has been enqueued.
>  
> - For each runqueue, the algorithm GRUB keeps track of two different bandwidths:
> + For each runqueue, the algorithm GRUB keeps track of three different bandwidths:
>  
>    - Active bandwidth (running_bw): this is the sum of the bandwidths of all
>      tasks in active state (i.e., ActiveContending or ActiveNonContending);
>  
> +  - Active bandwidth of SCHED_FLAG_RECLAIM tasks(reclaim_bw): this is the sum of
> +    bandwidth of all tasks in active state which participates in GRUB. This is a
> +    subset of running_bw and is needed for reclaimable bandwidth calculation.
> +
>    - Total bandwidth (this_bw): this is the sum of all tasks "belonging" to the
>      runqueue, including the tasks in Inactive state.
>  
> @@ -209,12 +213,12 @@ Deadline Task Scheduling
>   to
>  
>             dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
> +           dq = -(Ureclaim / (Uextra + Uinact + Ureclaim)) dt
>  
>   where:
>  
> -  - Ui is the bandwidth of task Ti;
> -  - Umax is the maximum reclaimable utilization (subjected to RT throttling
> -    limits);
> +  - Ureclaim is the (per runqueue) bandwidth of all SCHED_FLAG_RECLAIM tasks
> +    in active state;
>    - Uinact is the (per runqueue) inactive utilization, computed as
>      (this_bq - running_bw);
>    - Uextra is the (per runqueue) extra reclaimable utilization
> @@ -222,7 +226,8 @@ Deadline Task Scheduling
>  
>  
>   Let's now see a trivial example of two deadline tasks with runtime equal
> - to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
> + to 4 and period equal to 8 (i.e., bandwidth equal to 0.5). Tasks are
> + allowed to use the whole cpu(Umax = 1)::
>  
>           A            Task T1
>           |
> @@ -244,7 +249,7 @@ Deadline Task Scheduling
>           0   1   2   3   4   5   6   7   8
>  
>  
> -         A            running_bw
> +         A            reclaim_bw
>           |
>         1 -----------------               ------
>           |               |               |
> @@ -272,7 +277,7 @@ Deadline Task Scheduling
>  
>      This is the 0-lag time for Task T1. Since it didn't woken up in the
>      meantime, it enters the Inactive state. Its bandwidth is removed from
> -    running_bw.
> +    running_bw and reclaim_bw.
>      Task T2 continues its execution. However, its runtime is now decreased as
>      dq = - 0.5 dt because Uinact = 0.5.
>      Task T2 therefore reclaims the bandwidth unused by Task T1.
> @@ -280,7 +285,7 @@ Deadline Task Scheduling
>    - Time t = 8:
>  
>      Task T1 wakes up. It enters the ActiveContending state again, and the
> -    running_bw is incremented.
> +    running_bw and reclaim_bw are incremented.
>  
>  
>  2.3 Energy-aware scheduling

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

