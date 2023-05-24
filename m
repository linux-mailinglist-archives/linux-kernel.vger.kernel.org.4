Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0170F72C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjEXNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjEXNDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:03:10 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6210F7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:02:31 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-541f4ee6f89so350717eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933350; x=1687525350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vdbwHbXRQumNFwA8UyQK25G7Ufvsj1W7ddnIDk9gS+g=;
        b=RWNTzZ6pSqiTOb6U4GdEjdR3jsFaECKKBvg55+It5Km3nJ80ftas/71muSloYpRrHI
         w7jxrxV5fnkBkKrVo8xErs49n/mk5ohg7EEneNUNWA05kO6Utdq3PL9tZu5cxyjIVQ/3
         RSZ80KkuQrbNT+TGvkWTzn3QKWBTQWEBEj7h5m8aITfGvIbq/EPBrtQT2Ukru2/yzky6
         EoOv+eftpfbVDcppwReDYblnp+ezvx3klhE9k6KUfVjZgabXMPg9JtLwxlPuuV/xeLed
         ao6kvcxntUhzf/tLMo5M41n2Po5dfD39T4RObzY4qocDoKCJm5oNoHhumJdcbtBCjvcw
         Eq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933350; x=1687525350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdbwHbXRQumNFwA8UyQK25G7Ufvsj1W7ddnIDk9gS+g=;
        b=ddJ9K3zRFkxAbBXE2mSpmqWGf1EHAELB+UgTLqCB2Br8V7UdWVmEBVmt1l5iLCDabX
         NMCimeqMfuhtPmJY0ypxHqs3m5/cOsWdKCG+ZGhW3oIAAtedDA8Nckp7UQkNNFNCIhAr
         /ZctgZRE+6rVPZZ83QAaPgQloiHHXTr2AKHEanLqLgPKCwSsbOy8kS2uBs6g4gTsIq8/
         XS8cpkbQNFJ4gTYJQxu3cwrJc6n06QsvsKE8qpdOxEGdHXGO8jVvvPn6sEy5jZs0wxu+
         pQQGsIvLnlwgFzEhmunEK6apcArWLiVo6Pkm+m3MJaHI5xM0Y/dp21wIZWFKEOdbOXHk
         uvjQ==
X-Gm-Message-State: AC+VfDz+uOb77tIfEmWroTtJYLsO3bq0dXPVZkHuFhrXUNFXxjr/i7LG
        XccsCU9EVPZwFy8eZ86Pb4MgwVAyeYKVrTedyDCF0A==
X-Google-Smtp-Source: ACHHUZ7Lo5VynzbWayWaWvibO3+PR2emuxA0DtKTlRpZs5aLyrprk59Z6G1Ct6g/Gw7a0eEv4KsG8w5LIeBJx4QC3GM=
X-Received: by 2002:a05:6358:910:b0:123:52c7:d5b3 with SMTP id
 r16-20020a056358091000b0012352c7d5b3mr98868rwi.12.1684933349696; Wed, 24 May
 2023 06:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
 <163344312261.25758.16010066552550079330.tip-bot2@tip-bot2> <20230523105935.GN83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230523105935.GN83892@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 May 2023 15:02:18 +0200
Message-ID: <CAKfTPtDHuM99sy7eU1LQSAUuZNb6VNUr0uYq4B7Dy3WyQcavqQ@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/topology: Introduce sched_group::flags
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>, x86@kernel.org
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

On Tue, 23 May 2023 at 12:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 05, 2021 at 02:12:02PM -0000, tip-bot2 for Ricardo Neri wrote:
>
> > index 4e8698e..c56faae 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -716,8 +716,20 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >               tmp = sd;
> >               sd = sd->parent;
> >               destroy_sched_domain(tmp);
> > -             if (sd)
> > +             if (sd) {
> > +                     struct sched_group *sg = sd->groups;
> > +
> > +                     /*
> > +                      * sched groups hold the flags of the child sched
> > +                      * domain for convenience. Clear such flags since
> > +                      * the child is being destroyed.
> > +                      */
> > +                     do {
> > +                             sg->flags = 0;
> > +                     } while (sg != sd->groups);
>
>
> I happened to be reading this here code and aren't we missing:
>
>         sg = sg->next;
>
> somewhere in that loop?

Yes, I missed that.

That being said, the only reason for sd to be degenerate is that there
is only 1 group. Otherwise we will keep it and degenerate parents
instead
