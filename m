Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A860B488
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJXRuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJXRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:49:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A21178B5;
        Mon, 24 Oct 2022 09:26:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j14so13439089ljh.12;
        Mon, 24 Oct 2022 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhv2GNYlAHMhD+I+TqEL7nLZ167lO7mHj3XQ3WERP8s=;
        b=l0O7CIxlRiCvVvh7a0o4E7eqw5I2GoJJxZr7AsShTrKJ1TC3+6drIs1DJF0PpGy1wS
         apc9EvEiLcyFYGrwV+TV4pkNYsAcEzklOSFBZTlkDcKPTPu3wDhKnDh6yZ4QtNq1Atx5
         IgGf2qHNVPX1gz4w7JWdBx5Vj7mVg88ajXK1ejo+moBBPvgCLlrY2DqJu2i75b2y2xc+
         kqvz5LLlVMPmRxCwmxsd3GQNLH55e/MAL3/nQD4FubYwjPbPHOegDp+CFrR6YfRws0rV
         U5UxnSJJ18yv0QduPBlcbpDZnfAVcYQEqdht8EGdxo8ZYxdqRi2ejhNKIh25cyEaq7Wu
         cC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhv2GNYlAHMhD+I+TqEL7nLZ167lO7mHj3XQ3WERP8s=;
        b=tVW8usIB4DQFNvqHm8kHgRda+3aOo+H6nnfUxVThKP4aP39Q+g2Zl/eahg/Hcr2e6k
         t4onPRMNLKAOnPgkk5nuLHsYYWoqnZRw0BliTmuwVTt1SL6wBogEk/m7oNIocplbnsxU
         IMdF43XEChUl+QB6lK4EPT2EroYYx3fzpPvoYsyDUq0fNeqRfv8lsIC1iwWGkSdJ7aG3
         JqkfevEbLIzdAj4tptwvO88hZv16J9sRhiceGUh7uSEJvWt/0AHwgCs0UhR/vup7NrO3
         GF6zG0bpBm+B9WuOy9JgmKMD6GEmbw6fsVVF5fT8GY0HiFRbTqi5pCr12+yjsgJ7k+sL
         EBnQ==
X-Gm-Message-State: ACrzQf20A+sFrb+sIGdmn19T+WHPUCeixsWn0x4KbLU0G8E+JQTuy01F
        XtVVxdyLgDkOwgBR/PF6dps=
X-Google-Smtp-Source: AMsMyM4/q2UiXy3rmYZzmcWAy+OxhPsuqLmY2mO5afqGUU3zRt6Qp50KY/nEz4MfGxPpMmWYcxEgEg==
X-Received: by 2002:a2e:9801:0:b0:25e:45ed:edc5 with SMTP id a1-20020a2e9801000000b0025e45ededc5mr11574338ljj.467.1666628733138;
        Mon, 24 Oct 2022 09:25:33 -0700 (PDT)
Received: from pc636 (host-217-213-69-138.mobileonline.telia.com. [217.213.69.138])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651234c700b00492b0d23d24sm4596086lfr.247.2022.10.24.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:25:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 24 Oct 2022 18:25:30 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1a8ei1h7SzyYZx9@pc636>
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You guys might need to agree on the definition of "good" here.  Or maybe
> understand the differences in your respective platforms' definitions of
> "good".  ;-)
>
Indeed. Bad is when once per-millisecond infinitely :) At least in such use
workload a can detect a power delta and power gain. Anyway, below is a new
trace where i do not use "flush" variant for the kvfree_rcu():

<snip>
1. Home screen swipe:
         rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
         rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
         rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
         rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
         rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
         rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
         rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
         rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
         rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
2. App launches:
         rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
         rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
         rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
         rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
         rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
         rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
         rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
         rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
         rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
           <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
         rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
           <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
           <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
         rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
           <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
         rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
         rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
         rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
         rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
         rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
         rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
         rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
         rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
         rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
         rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
         rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
<snip>

it is much more better. But. As i wrote earlier there is a patch that i have submitted
some time ago improving kvfree_rcu() batching:

<snip>
commit 51824b780b719c53113dc39e027fbf670dc66028
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Thu Jun 30 18:33:35 2022 +0200

    rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval

    Currently the monitor work is scheduled with a fixed interval of HZ/20,
    which is roughly 50 milliseconds. The drawback of this approach is
    low utilization of the 512 page slots in scenarios with infrequence
    kvfree_rcu() calls.  For example on an Android system:
<snip>

The trace that i posted was taken without it.

--
Uladzislau Rezki
