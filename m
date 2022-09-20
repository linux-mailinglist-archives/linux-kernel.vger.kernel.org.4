Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738785BE96E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiITO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiITO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:57:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB94B0FC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:57:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so4228116lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VXJHObo0AaoKhcpZ+uR9GeJuvPJhUQU0+5Xdrsh3wJE=;
        b=tdzCJviRK5GqllvXhxhBQSh4iUn+AqvkyAXcd3ABlPg6jpUQNeO6BNFxuVJYX7Ekm4
         GVE9jWms+0+UB20Ga+o+OHQ8dwayZec1qXDFxW3MidP2XhUTUjfOAJG6FDS8D5X9AjBm
         GKx0Zl3vtnqe+3tLfqcOjVKi5KJovNLMjyI92FYv8UId/GtjxqERRIpm9KQlhmIWgEPO
         6DmeNMECx9IuITccce/jsxOkkc5K42kP9RMk7SFeegYILfILffoUViPgTtg2GE2j1z9p
         zM+TRWX3lhUT0Wrf3zRniDPwlchIiXHDKhSgKbbfwMv1i3YQFgQz07+G7u9y4q4QJzpU
         cxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VXJHObo0AaoKhcpZ+uR9GeJuvPJhUQU0+5Xdrsh3wJE=;
        b=74ZU3JWU85BrcIUYuawXSretWpAdE0gsn+bGDKxaUNWiQxgkA2ASCMmRr3Vs5sfmXD
         lpebK75BwHzYwLtRlwZDYWjl1OAHSL9tdtqauxAm2mWlfaL5IimiXLfZV1adGG212mT9
         RfMc+EV7OUBy5j6sl+pVVb+QQdLL/UVw4KhQyNdFZ25w/3CDrQQw+pYl4Df3aurEfiRX
         /7BGUq7gqnP8RuJHTqkNtikvTbdWoSpnELHLN3wqZhUNkkUHkC2YFjXTaNpq7IaSGMio
         l3CHHC5lEWaI8sDHbgMdC8ol87asaZXGKrWrq322ATWFLrxKTp9mZSDxsJeGpgjavz0X
         yV5A==
X-Gm-Message-State: ACrzQf1xHHc3Kf0eRGYUmUL0y6Dzmjvsk2/Dxd0SyUVP87XmvzO7iRJh
        jgu2dZgzEUalpfqrzlP0+URINIToPDLK9lcQ4BY5Zg==
X-Google-Smtp-Source: AMsMyM5gakyQSfDrc9u0pDGBpdHu/o8QX76B9e5JHQ8ECCdkESU2+fCnjeW2O9/W8QuQpnpCkeErsCCkCGhG/EqRrcw=
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id
 g9-20020a05651222c900b00499cb5dc138mr8191499lfu.490.1663685821832; Tue, 20
 Sep 2022 07:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-5-vincent.guittot@linaro.org> <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
 <CAKfTPtB8OeRzbDjfKoNUGLC1XUXT07G9QedCJ8stSMGvAD5hNg@mail.gmail.com> <ca9231c6-ef15-959f-f028-e55fbe686699@gnu.org>
In-Reply-To: <ca9231c6-ef15-959f-f028-e55fbe686699@gnu.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Sep 2022 16:56:50 +0200
Message-ID: <CAKfTPtB7aWZ8nGoPK73XDgDJL42zVQzrXz4TYpcxbGHnmtq4Cg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] sched/core: Add permission checks for setting the
 latency_nice value
To:     Tim Janik <timj@gnu.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 12:18, Tim Janik <timj@gnu.org> wrote:
>
> Hi.
>
> On 19.09.22 14:41, Vincent Guittot wrote:
> > Hi,
> >
> > Thanks you for describing in detail your use case.
>
> > Ok, Your explanation makes sense to me especially because we want to
> > ensure to not provide more cpu time with this latency prio. I'm
> > curious to see the feedback from others about the reason we want
> > CAP_SYS_NICE other than following nice priority.
> >
> > Side question, Have you tried this patchset (minus this patch) with
> > your use case ?
>
> I have now tested a modified version of the ALSA Test_latency.c program
> that acquires latency nice as non-root:
>    https://gist.github.com/tim-janik/88f9df5456b879ecc59da93dc6ce6be1
>
> With a busy but not overloaded CPU, the short time latency tests are
> often better, measured with: ./lnice-latency -p -s 1
>
> But the results aren't very reliable with this test. I.e. requesting a
> latency nice value of -20 reduces the chance for underruns somewhat but
> doesn't eliminate them (and lnice-latency.c gives up on the first XRUN

It's expected that latency nice can't fix all scheduling latency
problems. The hard real time constraint can only be ensured with FIFO
or deadline scheduler

> in the given time period). It might be better to instead count the XRUN
> occurances over a given time pertiod.

Thanks. I'm going to have a look the test

>
>
> --
> Anklang Free Software DAW
> https://anklang.testbit.eu/
