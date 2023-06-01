Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD071F3C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjFAUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFAUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94B1A6;
        Thu,  1 Jun 2023 13:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BB064978;
        Thu,  1 Jun 2023 20:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E4C433D2;
        Thu,  1 Jun 2023 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685650777;
        bh=RGs/SUKoPaxdkxluJ+b5vvGwrcwCDZO9iUhGSIQLzOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYn0faRCsPjSa/kRRtYadpBK2Nym8KAbriZULBoh8Yg7Qh4zlyruNg8YrJFo4IeYC
         ua4AnK/AUipZ992fbbvqIFprmoGsNWt7vV9OLI5o8qcnf/7cFU8hzcs583bUKRA0Uq
         XD4etari9U1zlWy3UoXY/rYcAG+DzpLTOJkup6Il7nkKwIJwWf38o/9jdyk64TRNyv
         crChNj2APexeg2miknXqNJT1loPYIo41fL/UpIBd9Bmy3C7vjir55pO4YLRSciV5xq
         X0mbRgTGCjcMHJVZx73Q33bv1kXrxZZE3kDrn4HxMerPwRWnzpVM5oLfOwb0dXtd2E
         FIINcBhdL6eQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C706F40692; Thu,  1 Jun 2023 17:19:34 -0300 (-03)
Date:   Thu, 1 Jun 2023 17:19:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf pmu: Only warn about unsupported configs once
Message-ID: <ZHj9Vq6K6Oq9caZL@kernel.org>
References: <20230601023644.587584-1-irogers@google.com>
 <CAM9d7ciz744BuEkjKRpRov4VsfASJHxskwzzE_L8mmekE6HuZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciz744BuEkjKRpRov4VsfASJHxskwzzE_L8mmekE6HuZA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 01, 2023 at 01:04:30PM -0700, Namhyung Kim escreveu:
> On Wed, May 31, 2023 at 7:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Avoid scanning format list for each event parsed.
> 
> Maybe it's better to change the subject that it's about format..
> Other than that,

Ok, I can fix that, applying.
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> 
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 5 +++++
> >  tools/perf/util/pmu.h | 5 +++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 0520aa9fe991..204ce3f02e63 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -934,6 +934,11 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> >  {
> >         struct perf_pmu_format *format;
> >
> > +       if (pmu->formats_checked)
> > +               return;
> > +
> > +       pmu->formats_checked = true;
> > +
> >         /* fake pmu doesn't have format list */
> >         if (pmu == &perf_pmu__fake)
> >                 return;
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 287f593b15c7..7a1535dc1f12 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -76,6 +76,11 @@ struct perf_pmu {
> >          * specific code.
> >          */
> >         bool auxtrace;
> > +       /**
> > +        * @formats_checked: Only check PMU's formats are valid for
> > +        * perf_event_attr once.
> > +        */
> > +       bool formats_checked;
> >         /**
> >          * @max_precise: Number of levels of :ppp precision supported by the
> >          * PMU, read from
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >

-- 

- Arnaldo
