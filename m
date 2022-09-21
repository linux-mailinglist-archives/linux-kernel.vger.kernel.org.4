Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F385C042F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiIUQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiIUQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:31:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD8B6D08
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:12:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so10043522lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/C1pFo3gf4J66Amk3QoKEHG7IMiKH9n/hQwTisEJsh0=;
        b=MBHoGk3lJFC0BTMU+Z8PQ/BgsRor/o9idvw+HFtDprtyfQHV/u8nK5kYkxn7JG5jab
         tqDen3qH+sfBFPdNwhzUnqS7Vlhd6wwwdrHB5UbpdCgi1jJE4jk0eKqNJh92mO9f19uO
         9KTAmB35RxgMDWZP00ZQerID2t4xwfJ/PcPQURWnQM0XQYpmlFlHQo1WkOdGN5v8anpD
         nW4liMR/Id4Wl9eZAHXZgp9BS03rl5byR7tABVmrQ7yM6mZXZYVpxusytlNr9TD4gzax
         aWt7U2BzhHo60zx6O9tphfWuQu01hpQ8oQBckJFMkK3e4zBKYoyjHVj+WoE0b6Uq89Fl
         NG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/C1pFo3gf4J66Amk3QoKEHG7IMiKH9n/hQwTisEJsh0=;
        b=L0UstGEdF5KFFkozWmEwN2CTARM9OZAHPUKgR4HyOLwosKNC++xSmauDMgIpXoqqp5
         aYzHAE/JF8LGNQGbmkJlzVXQI405lf9y5k683owwjhxENK/7neJN5jYfxnWCDR2MYw1Z
         vnMBqcAKcBSIaxFKpr5cFRu+cVDgIYWd4VMeTFA/Nq1zdKzPJHAvVi1D6wrEzeX9vgCC
         zTaP69PgLDQ0kKj1zYmCwxSSJKL/rmY4FyhiJaDFHBfcGwjjLi0rLsL7eBELlJSIo0Ba
         GnT0yhi6uRkdSTvoKDlgogl1UwS2nLl70KVDro0DCIQ8v/5KS5jr711zwNCiLWq3IIpL
         6mNA==
X-Gm-Message-State: ACrzQf0nxXbP6GhZUtB/6G5r242U8jCzyHfseAtiFi/ZTgWMzgvVO9Ra
        8wPAww7/H3r97/yHcR9AiFhoWHUTAXRpt2hYFf1Iug==
X-Google-Smtp-Source: AMsMyM7K0MD1c3TeY2Iy2YSyDu787qk3Ls4S9wpbLVuj85TwLO/3qLcSowl2bPPRi/sTWvnupPpnBeHC0UW26evY3NE=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr10215620lfe.523.1663776713501; Wed, 21
 Sep 2022 09:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-5-vincent.guittot@linaro.org> <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
 <CAKfTPtB8OeRzbDjfKoNUGLC1XUXT07G9QedCJ8stSMGvAD5hNg@mail.gmail.com>
 <ca9231c6-ef15-959f-f028-e55fbe686699@gnu.org> <CAKfTPtB7aWZ8nGoPK73XDgDJL42zVQzrXz4TYpcxbGHnmtq4Cg@mail.gmail.com>
In-Reply-To: <CAKfTPtB7aWZ8nGoPK73XDgDJL42zVQzrXz4TYpcxbGHnmtq4Cg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Sep 2022 18:11:41 +0200
Message-ID: <CAKfTPtCQTsW2a0fKj8wD5Vmg=ANmY1-SbBQNpqyxJ5FJ67CDgw@mail.gmail.com>
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

On Tue, 20 Sept 2022 at 16:56, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 20 Sept 2022 at 12:18, Tim Janik <timj@gnu.org> wrote:
> >
> > Hi.
> >
> > On 19.09.22 14:41, Vincent Guittot wrote:
> > > Hi,
> > >
> > > Thanks you for describing in detail your use case.
> >
> > > Ok, Your explanation makes sense to me especially because we want to
> > > ensure to not provide more cpu time with this latency prio. I'm
> > > curious to see the feedback from others about the reason we want
> > > CAP_SYS_NICE other than following nice priority.
> > >
> > > Side question, Have you tried this patchset (minus this patch) with
> > > your use case ?
> >
> > I have now tested a modified version of the ALSA Test_latency.c program
> > that acquires latency nice as non-root:
> >    https://gist.github.com/tim-janik/88f9df5456b879ecc59da93dc6ce6be1
> >
> > With a busy but not overloaded CPU, the short time latency tests are
> > often better, measured with: ./lnice-latency -p -s 1
> >
> > But the results aren't very reliable with this test. I.e. requesting a
> > latency nice value of -20 reduces the chance for underruns somewhat but
> > doesn't eliminate them (and lnice-latency.c gives up on the first XRUN
>
> It's expected that latency nice can't fix all scheduling latency
> problems. The hard real time constraint can only be ensured with FIFO
> or deadline scheduler
>
> > in the given time period). It might be better to instead count the XRUN
> > occurances over a given time pertiod.
>
> Thanks. I'm going to have a look the test

I have done some tests with your modified ALSA Test_latency.c on my
dev system. I have been able to run lnice-latency -p -s 8 -e -m 128
simultaneously with hackbench -l 20000 -g 2 on my 8 cores arm64
system. The same test with a default latency nice 0 triggers a lot of
XRUN.

Side note, my system doesn't have many RT threads, IRQ or softirq
running . But as explained, latency nice can't do much with those


>
> >
> >
> > --
> > Anklang Free Software DAW
> > https://anklang.testbit.eu/
