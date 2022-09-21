Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9745C050D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIURDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiIURDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:03:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F647B78C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:03:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so10277179lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hJcZ3+WztjMCRPWNsty0/PogrgPtQJKPkN9t4aZEBZ4=;
        b=DVkXjJvkIRy+yqK8A9d+F7u8/ms5hShQd6KUAXofYy917jmIGnaMvamC0fhoV1QNpZ
         7huLhYTzEFv+OciHeFJZ6JzV4lVW4beiG8ToNMa+oJ87yGUjj/pPnHSekLlFEvMgw0pa
         Xi7HV4mRk8yIiWD6UIoozEyKbgGGA7LK8c9er6XHg2vZKVqDCqp5YcaKI51pt9n/RxTQ
         eVf4vO0pY+sWBjotcAZS09OupKXG6Sw1o0Bti7KU2Be2H1KO/zhWEqR4+MKGaZhW6dOj
         C32o05ZANhTgtvFFU2NWnaX8uRINm+ajdmF9VNcoNkPk6PMgcWe08fvoaKrcy15y9kJi
         776A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hJcZ3+WztjMCRPWNsty0/PogrgPtQJKPkN9t4aZEBZ4=;
        b=3TE84klGBwzn5Qmc8HSf4M2C1ofbOUdadAjrMW9Ottp3ARft3cWJANY0L6QaiLHwJS
         cy0u7u8dY6ytAGTB3IRW24PIIso7XgvyW3TlSrRcTe2cepjMcv0vgoyzaMARC63+dz/+
         ThIF1AfgA9UBwe/trRZjS81m3+iQZ3MidOLL5W+fitPkZ7wanbH99bchhv+tpD8k5c9Z
         p68br77kcl+8Uufn9VqLrLC+rqX617rT6bvpwwfS1EnrH+C/vowh/IWmTnCdPOnVtRo8
         HzdYgqY99BZZo6NDssyghMr8plJS82imF/m3yiEtmXQ+v/sHixxQ7MvIscb+7J9A8eTu
         zLmA==
X-Gm-Message-State: ACrzQf0FaXLjRNeCf95pMlLih4BIFFul7kigUyHB88clIgAORg7BbtY5
        +oExTPdwwDHHqujFvVVBJF/J+rYWTsfrTvzLIXjcSw==
X-Google-Smtp-Source: AMsMyM4BmuCZegU+whmZfOcLVMFZm51THn/0HoxBg4fgXAFIvTXW8W81kZ7YMyGD6fhznNHbL9+e90S0jywJtO/t538=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr10293908lfe.523.1663779789010; Wed, 21
 Sep 2022 10:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org> <20220921155521.qb3jb74nbjoenau6@airbuntu> <YytAa9a8DSyuJWhT@slm.duckdns.org>
In-Reply-To: <YytAa9a8DSyuJWhT@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Sep 2022 19:02:57 +0200
Message-ID: <CAKfTPtBCUu80dpGneyhsZneTtcqcm3DrVVoqv6rH60oX_vEz+Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sept 2022 at 18:48, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Sep 21, 2022 at 05:07:38PM +0100, Qais Yousef wrote:
> > Wouldn't cpu.latency.nice be enough? I think the latency_offset is
> > implementation detail that userspace shouldn't be concerned about.
>
> One option could be just using the same mapping as cpu.weight so that 100
> maps to neutral, 10000 maps close to -20, 1 maps close to 19. It isn't great
> that the value can't be interpreted in any intuitive way (e.g. a time
> duration based interface would be a lot easier to grok even if it still is
> best effort) but if that's what the per-task interface is gonna be, it'd be
> best to keep cgroup interface in line.

I would prefer a signed range like the [-1000:1000] as the behavior is
different for sensitive and non sensitive task unlike the cpu.weight
which is reflect that a bigger value get more

>
> As for whether a single value would fit the bill, it's again something which
> should be answered for both task and cgroup based interface at the same
> time. That said, my not-too-throught-through opinion is that a single value
> for per-task / per-cgroup interface + system level knobs to fine tune how
> that actually applies is likely enough and probably better than exposing
> exposing a host of internal details to applications directly.
>
> Thanks.
>
> --
> tejun
