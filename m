Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841B70EB23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbjEXCLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbjEXCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:11:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F919D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:11:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af8127031cso127129a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684894294; x=1687486294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rvU4IWdyOj7PqgqMsmY1eUvdDYl6lnUaw3J/gTxqbw=;
        b=RGy0GfD69SeamfTavaqr3JfSK3rg4Pdj9TM/FDSYjzaR5HOmzt+4MWzXN3PVTjpAhN
         eQjOEyB+3QzaLAbiuGN5iZHAAcI804et5wpqAGjg6yogoDfcyniQd6dqf5DeOhrS4Roa
         q7tJ2yHxvNO6V65e6LrUcTm0xxrwO8BQznJdG0MA/64/0trvg1ENL6OQlxSCEmk0Qd/6
         9IDLOqqiHcFj48dNrdUg8GtTXxiODGsSAh5d2kKHwV0SSowYRn+AecAu8SsAAUgu+VUr
         fODE8MPq3oLroJJbhJ6ho98oQturWtrEJt0o/a9CcomeGZW3QumYkT35up1zSH3B7c/Z
         t8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684894294; x=1687486294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rvU4IWdyOj7PqgqMsmY1eUvdDYl6lnUaw3J/gTxqbw=;
        b=UeI4mxpi2x64063thobEHJyoB4qiazC+fb+shnB1xhDZfumUPsIF6sBfHOjnXpcqvA
         qlmQHWzFHo+2YLQaFg2Enqh27rQTxCI4eAza9DLxP592H0qBxsD+/t0A83idDqlSNt6j
         MbGYIjPaPyaXUImbkUvo1jkm4xP3hd0cXrW7ett0rHiRNRsAiGGAOP90WaVJk4atE96p
         27B9H/ef/lM2ywzwhdFtMc4foXTAniEP3eV9tV3gNfX/CJaiu0JM7/J/XZxftW2gsjCE
         JDZa31M9Bq2x52RlBUMnmGwOFfL1QCCOZut3EMyiG1D85/CpthirRfOfGku4iZOv5It9
         4t/A==
X-Gm-Message-State: AC+VfDzlLjl8cg+wxqpVsxPVoXoTHXWr5vHbtrLWCyB7j5ijPgynB8Rz
        8ntU2u8Xu6MBM6AjBcSRM1ghXjC9Nl6NuTzY1LZkXg==
X-Google-Smtp-Source: ACHHUZ7laGQwk4xBWMpdhNm7pHJLBIRyto77+HdA/ivTJLjXhCvzFea62AqmFVXeERyl8CWk707lCkqjyAPbulnzsbE=
X-Received: by 2002:a9d:6d0a:0:b0:6af:8db0:bd08 with SMTP id
 o10-20020a9d6d0a000000b006af8db0bd08mr2141360otp.10.1684894294728; Tue, 23
 May 2023 19:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
 <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
 <20230516093729.0771938c@luca64> <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
 <20230519115621.2b3f75e2@luca64> <20230519121804.6c85a3ed@luca64>
 <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
 <20230520115857.3838a7ea@nowhere> <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
 <20230523225831.60d75b38@nowhere>
In-Reply-To: <20230523225831.60d75b38@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Tue, 23 May 2023 22:11:23 -0400
Message-ID: <CAO7JXPihFGX5Dop=ox3YDQ=8aQbzZ-ka_1h3hT1G46vsbxpzNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> >
> > I think it probably makes sense to get the fix for the equation to go
> > in as a first step and then we can investigate more about the second
> > issue (less reclaiming with less load and different bandwidth) and
> > fix it separately. What do you think?
>
> I fully agree. If you split this change in a first patch, IMHO it
> can be applied.
>
Thanks, I shall have it as the first patch in the next iteration.

> BTW, I tried changing the equation without introducing div64, and it
> seems to me that it works well... So, if removing the bw_ratio
> approximation is needed, I think you can do it in a second patch (so,
> the first patch changes the reclaiming equation, and the second one
> introduces div64)
>
There was one more reason for removing the bw_ratio. The second patch
fixing the issue with mix of normal and SCHED_FLAG_RECLAIM tasks,
do not have a constant Umax, so we cannot calculate the bw_ratio in
advance and has to be calculated in grub_reclaim().

As you suggested, I shall remove the bw_ratio as the second patch and
then have the third patch to fix the case of SCHED_FLAG_RECLAIM and
normal deadline tasks. For the rest of the issues, I shall work on it as
a separate patch series once this goes in.

Will send it out tomorrow after a bit more testing.

Thanks again,
Vineeth
