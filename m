Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81525FAC59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJKGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:14:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA9C481FB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:14:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s2so18695776edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0TA01kmXvUPheOdi7PWrUQ8bC3Ldfd2bpo9D/D22tM=;
        b=iC8Eu0A8wEOIQzqpkvvzA5G1HbHcX08LWn+3fxHRuBbycUMKDEiGW+E61qErnMIYyR
         yrx+HfbgY8Qqm1ugiweoYpOLnv1vhkB3G45aesBxxS+VDScoVfIYRpxvSHmP9Lu+w2sw
         o/M6TU5EUPZ3Qq54Io7SK7SF86iIoBkGN1eZqFaYLEpCYE5z97wTLuAoNFv/r3L3C+3F
         jlpiB4IWbaRUHvsLIkhkEqYXXFj2v8J8Gb0o9jlxk9diN7addgalt/LuF0qZCjWU4kiG
         WRzIOw+XmYZY+ohLCb+t6S+DGABWLXy7FEWgR6YIY3uzKPdcEJ9Fb/tyeIED+gAxjTPM
         lohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0TA01kmXvUPheOdi7PWrUQ8bC3Ldfd2bpo9D/D22tM=;
        b=gzG0mZR4tnWlXGP6tv251tdfW6HqwHYhcISbnmKlHMKaR//Ut7r892mVG59aUqHrDK
         Ku0fU9Ig832L23XEpql5MsRKswuJtOqC+dGuOfuio9e6NshCwIC+Vke0meYdQ4MlWiFF
         BWkNB75LLVot6Z12enOgR6kjcks/G8WgzSOnM4jMmiFPFwJb+1wG6SjcaO4Od8DiDY4o
         qZfxyzw83ncUPl64+A8Ajr7S0TGGERciaXN8n3zf12znRBZEoATUeBDI3hqhMJKkOJJs
         kxt4PsiS2qhcNaCyDBrJRrPhqOnTxFRPRL1KHDXxMqNRhEduiAemueHl0HXOpIidrDpR
         IsyA==
X-Gm-Message-State: ACrzQf0ftkZmFAOFo79q3aBIOAx23vdXSgLm9MOZzTCvo4rT/+MjGTTd
        9d3jcpJGWOCflGB1wJk0Oq85ont4gZIeohQy3UFQcEFqGSk=
X-Google-Smtp-Source: AMsMyM4po/TUMzer633bzFCiLbaL2CzyI5TuuP7AvvnC2XdtbUaJ40NnyZRtYuz86VtweGhBBw25opHmCHt06h6M8O0=
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id
 y15-20020a056000168f00b0022e04c3de09mr13585250wrd.40.1665468838995; Mon, 10
 Oct 2022 23:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
 <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
In-Reply-To: <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 23:13:46 -0700
Message-ID: <CAP-5=fUK8VXZAyjTVQ3e88F5AeYfEF5PP-=k=PoFONWpXE+XVA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Mon, Oct 10, 2022 at 10:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Andi,
>
> On Mon, Oct 10, 2022 at 5:25 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> >
> > On 10/10/2022 10:35 PM, Namhyung Kim wrote:
> > > Hello,
> > >
> > > Current perf stat code is somewhat hard to follow since it handles
> > > many combinations of PMUs/events for given display and aggregation
> > > options.  This is my attempt to clean it up a little. ;-)
> >
> >
> > My main concern would be subtle regressions since there are so many
> > different combinations and way to travel through the code, and a lot of
> > things are not covered by unit tests. When I worked on the code it was
> > difficult to keep it all working. I assume you have some way to
> > enumerate them all and tested that the output is identical?
>
> Right, that's my concern too.
>
> I have tested many combinations manually and checked if they
> produced similar results.  But the problem is that I cannot test
> all hardwares and more importantly it's hard to check
> programmatically if the output is the same or not.  The numbers
> vary on each run and sometimes it fluctuates a lot.  I don't have
> good test workloads and the results work for every combination.
>
> Any suggestions?

I don't think there is anything clever we can do here. A few releases
ago summary mode was enabled by default. For CSV output this meant a
summary was printed at the bottom of perf stat and importantly the
summary print out added a column on the left of all the other columns.
This caused some tool issues for us. We now have a test that CSV
output has a fixed number of columns. We added the CSV test because
the json output code reformatted the display code and it would be easy
to introduce a regression (in fact I did :-/ ). So my point is that
stat output can change and break things and we've been doing this by
accident for a while now. This isn't a reason to not merge this
change.

I think the real fix here is for tools to stop using text or CSV
output and switch to the json output, that way output isn't as brittle
except to the keys we use. It isn't feasible for the perf tool to
stand still in case there is a script somewhere, we'll just accumulate
bugs and baggage. However, if someone has a script and they want to
enforce an output, all they need to do is stick a test on it (the
Beyonce principle except s/ring/test/).

Thanks,
Ian
