Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C570F771
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjEXNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjEXNPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:15:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FE09B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:15:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25355609a04so224771a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684934132; x=1687526132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFFQcA3Btt+4XJh67VjF6R8wRNAfn3oS742ecIWryuY=;
        b=eHpk5OBLbvIK9FJvz15lEqT9nf1sPlz9zZdIgYX3EubFEG3e0dDWilM0d69KM8ZylO
         uk58hj+31p7qt+M+bjKKncB07vbOHX1zSfwVnQs5R/eP2K0BQEsbYp6OxBp2kjmmIuDG
         pbENTmB1hMeLlBZBTy5lpAx9s62EXWQfPGWfZD70UXT26466TxTdeIOfyqvmpO/zvjV1
         Rltk9H4wPsqDpVO4b8/fSyR1iUQ1o4HmmIN5u3yavkJbgfF2lA3w7CoT+uoKfXcZYxcm
         6lud79mPZiPgZ253DTfn18ASHLYIX9oTgShfUuLJuDzcCRNfME6ujP0rBdgjq9NqVhSE
         ecTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934132; x=1687526132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFFQcA3Btt+4XJh67VjF6R8wRNAfn3oS742ecIWryuY=;
        b=L004aU/s2AByMG6177K2Rr+fEDriktZM7VUZFEIQCES8WY4jZnmSkob8v82uLs/ZhF
         hkxw8MeR36Z+N/+qaNZM687XioMsWGtKp1SmQ0YBRFuMqLu6QgL4O7bDYKqDO/wmunwm
         rH3fl09+x2PUo042I/U5o9tiiVsTO0zqc4tKWAiOfB+glnJEg8LXAre1RsMZ8tA4EizC
         GPAZUhP8fnKHVZV8T15rHu1Yt/C8WwOSdO63KxeQz5KEWU0k3TJs7K3W6HKB8ABQmd9f
         zNqEE/ruGRGGRjuL6Wf/XuRW6SYEmwlli6F2Yx/8Lhm/BsURX47IhJ5OhHvN9VnfNDiE
         IKRg==
X-Gm-Message-State: AC+VfDwfdfnjZP/tdHKBzDlGZ6htXOzcJYbzJ1AMyOKm5JkYfJhd3mXF
        LsnaIreZz+V5EWQ6bMfCJHRoO6ZWiv4LeYeRIpQeSg==
X-Google-Smtp-Source: ACHHUZ63YPMvrXkwyk5teGL4okGUTFFIzXVGV2Lp8kYso51orc5rsGBwThT12zJP9d8fefGXAV3FFtaeV5GyQrcxAmM=
X-Received: by 2002:a17:90a:a505:b0:255:daec:2911 with SMTP id
 a5-20020a17090aa50500b00255daec2911mr1954795pjq.7.1684934132620; Wed, 24 May
 2023 06:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <20230523111818.GH4253@hirez.programming.kicks-ass.net>
 <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com> <20230524073456.GO83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230524073456.GO83892@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 May 2023 15:15:21 +0200
Message-ID: <CAKfTPtBdfyLudf2JpADqEbpzV8nL8UdKcVg2Q7x9zK+=hHSG+A@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 at 09:35, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 23, 2023 at 06:12:45PM +0200, Vincent Guittot wrote:
>
> > Another possibility to investigate would be that each wakeup of a
> > worker is mostly unrelated to the previous one and it cares only
> > waker. so we should use -1 for the prev_cpu
>
> Tejun is actually overriding p->wake_cpu in this series to target a
> specific LLC -- with the explicit purpose to keep the workers near
> enough.

yes, so -1 for prev_cpu was a good way to forgot the irrelevant prev
cpu  without trying to abuse in order to wake it up close to the waker

>
> But the problem is that with lots of short tasks we then overload the
> LLC and are not running long enough for the idle load-balancer to spread
> things, leading to idle time.

I expect to not pile up workers in the same LLC if we keep the
workqueue cpu affinity to the die. The worker will wake up in the LLC
of the callers and callers should be spread on the die

>
> And that is specific to this lots of little LLC topologies.
