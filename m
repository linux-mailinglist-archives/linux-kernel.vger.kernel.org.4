Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB26124EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ2SqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:46:21 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37F45227
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:46:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-36cbcda2157so74599467b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I5M42xH956VA0eEVqAgck6Km6Zbq9KHp3UzoX8yEhtk=;
        b=OCdmA01964Z5GWe0fQVjPd9Km6OgUshXB5kpYJnoMvRAWYSF8nI0hFhx8UltF3Pdlj
         +DSchlPvrlVUlhE8dEMx/AoU6Q18t8VY+9cMuxR39s+k4f8jyFFIW4kVgJHvDdoelFFQ
         Ihfl6cz9rQKMU9Ca8h86iRkQvs4rQZ1A8aye7KQyhu0SNiOvJkscskueLU5v6xKsHzkP
         GF63bTfHQ880Ttfm6TpW+bZf769CHVau8dPuuOi7IBk+oOM6oH1QTCX6zAoRJZG37YPh
         qN6nSq208OE7eYBLn+908Nizlx31qyjVJbIQbLyd8dgWx3CSBFxBrieYSgOz9DKj9zig
         eQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5M42xH956VA0eEVqAgck6Km6Zbq9KHp3UzoX8yEhtk=;
        b=1o6lvPSX4jPBrLCWNJnyURsDzQsQ8ADxPI2yr4QqLukN2Jp79L0EfJtaGhJVu0dcDh
         mchV70ZBcJ3EfTpnTmIEyz4aQeItX1patEvQQ5S3vR0RBOhhoF10eAES898jtf7XbKoJ
         irHrklbpaX+Qk6qPGj+8v0NZDnWZik23QSXWHEi9a9DyXu8j1G+SewqIWVU8DDPHh6Zi
         w8P/U9/hE2rY3O+SDFm0ndZ8Hh0S62bSeOn20uUwaD/SBj+gF2ZVbsIp6p/W9zy1ryax
         1edWq8pM4m8av25wxtAFOw8yhyNgAdvX2ljhSHxlAz5CMhGNm5mwl571AuHGvhMhcbKL
         uOjA==
X-Gm-Message-State: ACrzQf3S4e7zU7onP+prP2FZDK2WYYbhMmaMJCtLTOMmegH4+RHymmIW
        igmUjM13SZXdwIP/T8IrTRobBbRPG78IoFKJwO7XwrMjLj0=
X-Google-Smtp-Source: AMsMyM6fOyIsTHK/Hv2UW8rwWkFw0UyWwfCclzmg/qL4gE8hPYBxuKlINVwu/nxq3NBo5gtt8TEOZeqCEtcI5HNMKjw=
X-Received: by 2002:a81:8a81:0:b0:36a:4785:ab9f with SMTP id
 a123-20020a818a81000000b0036a4785ab9fmr5206758ywg.218.1667069179033; Sat, 29
 Oct 2022 11:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com> <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
 <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net> <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
 <6ea3a2ca-85d7-b338-f516-c91ec5e7a128@bytedance.com>
In-Reply-To: <6ea3a2ca-85d7-b338-f516-c91ec5e7a128@bytedance.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 29 Oct 2022 11:46:07 -0700
Message-ID: <CAJuCfpHrm-BtpLyS-b-PQbnMiSpuLfVjtzwWxWDbFz__1Jb8Mg@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
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

On Sat, Oct 29, 2022 at 5:42 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/10/29 19:55, Peter Zijlstra wrote:
> > On Fri, Oct 28, 2022 at 09:53:57PM +0200, Peter Zijlstra wrote:
> >> On Fri, Oct 28, 2022 at 08:58:03AM -0700, Suren Baghdasaryan wrote:
> >>
> >>> Not sure what went wrong. Peter, could you please replace this one
> >>
> >> Probably me being an idiot and searching on subject instead of msgid :/
> >>
> >> I'll go fix up -- tomorrow though, it's late and I'm likely to mess it
> >> up again.
> >
> > Can you please check queue.git/sched/core ; did I get it right this
> > time?
>
> I just checked that three patches, LGTM.

Yep, all three patches are correct. Thanks!

>
> And would you mind picking up this, by the way?
>
> https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/
>
> Thanks!
