Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F84632D06
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiKUTbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKUTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:31:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FDBE86C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:31:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d20so15553507ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xjZQRT1eglhnBvPQrkMATSynTj+P8hQRG7JbjMaxvk=;
        b=jkEOexRnXCpOcEEjHzhPJzyuRJ23OXfQ7+uu2D4WuUtPnVFyknMX0hvbfA/EgOhwl8
         WVaaBLPGvH/3Tq7GsYSeqr+JBDtJje2EJNpwkBWGpEstrcZpDb5S+OHJtk2iUK1fRb3Q
         FqHw72VRgJcn5l0DTM2pLGUQqoAXUnGbt3Pcyft3qbTI963QYJrSxnmBZOS3fqWrmyvJ
         QLfH6QFRBSX0jQA6UMfzpEFPO9BaisSSaPObx9MP6DUnru0a6OjyMXjlvKwgKSXtr5G7
         gxd43VrhyJPNuyw7bpYqwD/D3zCosBh3UkbkRSxYrs8WqaobGu0hvsNblCvGrvksF1nM
         20fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xjZQRT1eglhnBvPQrkMATSynTj+P8hQRG7JbjMaxvk=;
        b=LV0qwl+cDiFmHIcTY7Ee7oC32rYYqOcOinmhM7DoDPo14UuKXN4Fqvzxh6fBJq8fFI
         NU+Zln8qMnD8bH2mC9xInc4GE2QqusBiR7uBsZ/PmxEvAl28gVojNqwcuZUMw9jDx7TI
         3ZddE3jkIVrhyhPCf0V6loLs6lqG1p36V85+65mLAluC9tbQN9yH85oJ8nKsAkJ69f5c
         N6SBOAgO16XbfKxp3kFO7jUO/JBQP1ks1rlii5qGEljQmUZ5uzSs3MAHQ8rCkQ1Nw6DD
         HR7/7LTdeZOXqB0RWDFQd5limp9ePIB37ShqAyFYQigWr+A3hTw8S1qP6AIJsrA8to8r
         VM8w==
X-Gm-Message-State: ANoB5plvUJpXsrd20nZpEYKxrJjJC0daKvlCnSB4x6PemgcZFRVxaOvq
        ftWhYP+nRwVMCFg6FchQpM347v503DWoADGXpByVFA==
X-Google-Smtp-Source: AA0mqf4m9Je1aBhIn5u7MHEcEUAtUxRlvUGgSnhiTkwor278flUJxRK3ixDOmkmlFh/8R9zLCwV+W9eEaoWjZnAyMdI=
X-Received: by 2002:a2e:8356:0:b0:277:6c68:12d3 with SMTP id
 l22-20020a2e8356000000b002776c6812d3mr6025954ljh.499.1669059093572; Mon, 21
 Nov 2022 11:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com> <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 21 Nov 2022 11:31:20 -0800
Message-ID: <CABk29Nsxg2AvUzsvn4kLpE8rzWRJNt-EKwFi1HcK7c6uY_oUUA@mail.gmail.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
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

> Please test the final version as found here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=4e3c1b7b489e218dfa576cd6af0680b975b8743e

Thanks Peter, the patch looks good to me and continues to work
correctly. Note that I needed to make two edits to get it to build
though on sched/core:

- local_cfq_rq doesn't match variable name used in function (local_unthrottle)
- rq_lock_irqrestore -> rq_unlock_irqrestore

Best,
Josh
