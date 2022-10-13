Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5125FDD92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJMPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJMPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:52:52 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606CFF8D9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:52:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g11so1623180qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWMv3DmVinwzc+hnXTMc4Pdb2dwueFn5cUn33fiS298=;
        b=Rx+1ixrOX8U/D56rpEjVFONZ4Eeos6N/Uzey9b3QCI6MuLHNJWdG1/VDtRTNfxrjWa
         92kkEbL7E9wSYIkv82x/LHCoj+4DI9ApKdxnVkq6MQfKxeKoztUA+p0lF5Ihx0XylN/L
         bux8C9DmEnYR/F6xLA4JU20Dj0n0F+KT9FD+wn3B8uc6UwbDbnaLFGEpaTa9/XmUu0N/
         LBDNW2OZJ/GoqXGL1A//DFW67sjLo8L+mgEe7+fcf3IXfA1GrsFGMb934CbNDG0q6xgA
         2qiSD+oQNwdg7z5bDC/kuJsRzzzdh3YeTUVOyBLZUGB+97fcOsTRS3+wyWYULWJhHbnX
         BPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWMv3DmVinwzc+hnXTMc4Pdb2dwueFn5cUn33fiS298=;
        b=RFyWVg8tGwF1w7Km1ekdbCPHxy3nKBwCQHRtIZDKPQ6IETJvTplWyHAoiqd4VevOYS
         7OkUEuobsYTmqPCPShFjrk3GwbDHVkJ7bq2cP0aOKvv3toh875mormnIy/THAdBdLQcc
         90PMN2zn9JKbEr4rKe8t5Id4pImIHkdhMxedjARqLM2T67H8Y2ozaswPRDd5SEb3Hfy4
         xd4TT4yh0sTcxyG+1P3UMenJBG2N/6PeyeLY4BmbgYpTnicUPUnw6HhYF+LDmgleAy0I
         wbXc173irxKeRrDFYylFltcnrzEnFkvIMHDHApyQmTJr3Pg/180/+hCopNaimRbhNflX
         cHhQ==
X-Gm-Message-State: ACrzQf0MLY8jSaddlKHrwKY2cyYiof/Vjry9Tuc+yOYL/VGGWgc3xJfS
        jFXHGDnd78ex1zolg/rmVjNSMf0W1C/u9Q==
X-Google-Smtp-Source: AMsMyM5iWTK3O5BxAWkm9T51P7VAdBDohzYZDDdQz8wTgoLFOdvsSFu/nWT7SJhKLK+LpLHBIzxv9w==
X-Received: by 2002:a05:620a:6004:b0:6d4:56aa:430f with SMTP id dw4-20020a05620a600400b006d456aa430fmr392091qkb.579.1665676369885;
        Thu, 13 Oct 2022 08:52:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3a61])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a0bd300b006bb8b5b79efsm5906qki.129.2022.10.13.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:52:49 -0700 (PDT)
Date:   Thu, 13 Oct 2022 11:52:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Message-ID: <Y0g0UAAJMhPczNm/@cmpxchg.org>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
 <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
 <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
 <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:06:55PM +0800, Chengming Zhou wrote:
> Should I still need to copy groupc->tasks[] out for the current_cpu as you
> suggested before?

It'd be my preference as well. This way the resched logic can be
consolidated into a single block of comment + code at the end of the
function.

> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                              u32 *pchanged_states)
>  {
>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +       int current_cpu = raw_smp_processor_id();
> +       bool reschedule;
>         u64 now, state_start;
>         enum psi_states s;
>         unsigned int seq;
> @@ -256,6 +258,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>                 memcpy(times, groupc->times, sizeof(groupc->times));
>                 state_mask = groupc->state_mask;
>                 state_start = groupc->state_start;
> +               if (cpu == current_cpu)
> +                       reschedule = groupc->tasks[NR_RUNNING] +
> +                               groupc->tasks[NR_IOWAIT] +
> +                               groupc->tasks[NR_MEMSTALL] > 1;
>         } while (read_seqcount_retry(&groupc->seq, seq));

This also matches psi_show() and the poll worker. They don't currently
use the flag, but it's somewhat fragile and confusing. Add a test for
current_work() == &group->avgs_work?
