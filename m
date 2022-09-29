Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA9A5EF5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiI2NBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiI2NA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:00:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC8113B5C;
        Thu, 29 Sep 2022 06:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0988CCE2196;
        Thu, 29 Sep 2022 13:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23482C433C1;
        Thu, 29 Sep 2022 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664456455;
        bh=yr5blIIs2XTqNNxMMpUECAM9ef10derN0Mf4+B4C+vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olgC40TKfr2+PtgEIojVSmiVRFHvAJq6h66DeBikgN6HRGllhGUO9vQO3QDNK7xX8
         3wXUCOLtUHf4sVv6wRzEPNJweh/QqSQB3794htNSTtCV7B98YYHv3cys5oOwFMn2zr
         82pAbuyPjHa8IUheOuJrms0Patd4MwIzUSyw5cfBWC2EAFExXLX3jVYg+st4hCcNDc
         fKuGWPhM+nzCFNbxDxVY1VdFP1dQrHlo3zUH49FaTBoyU4epKDTbHI/MWubUXWZ+Mt
         QW23c82k6Hwuplm7QO2PJUUs3KeB922CctZXa2s5542enunGmo9NyQKIENV4OPGOsS
         o7x6qGPDt3wsg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 292FD405F0; Thu, 29 Sep 2022 10:00:52 -0300 (-03)
Date:   Thu, 29 Sep 2022 10:00:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 05/22] perf vendor events: Update Intel alderlake
Message-ID: <YzWXBGyjs39cD7Cd@kernel.org>
References: <20220928072204.1613330-1-irogers@google.com>
 <20220928072204.1613330-6-irogers@google.com>
 <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com>
 <YzRVOD4u2SI0K29Y@kernel.org>
 <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUogKZx6JP_vg+6ti+BnbEcX+3Wnzi077s4VgxEKLpQeQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 28, 2022 at 07:23:37PM -0700, Ian Rogers escreveu:
> On Wed, Sep 28, 2022 at 7:08 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Sep 28, 2022 at 04:22:53PM +0800, Xing Zhengjun escreveu:
> > > On 9/28/2022 3:21 PM, Ian Rogers wrote:
> > > > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > > index 7f2d777fd97f..594c6e96f0ce 100644
> > > > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > > > @@ -1,5 +1,5 @@
> > > >   Family-model,Version,Filename,EventType
> > > > -GenuineIntel-6-9[7A],v1.13,alderlake,core
> > > > +GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
> > >
> > > The commit description should mention this change "Add more CPUID support
> > > for ADL"
> >
> > I added this note, with that can I have your Reviewed-by or Acked-by?
> >
> > - Arnaldo
> 
> I think I should send a v2. I can add this then. Other things for v2 are:

Ok, I'll drop v1 from my local, testing branch.

> - this week there will likely be an update to [1] which is implicitly
> integrated here.
> - the topdown metrics are all percentages but are currently values
> zero to 1. It is straightforward to add a ScaleUnit of 100% to them
> all.
> - eyeballing topdown event metrics like:
> 
>     {
>        "BriefDescription": "This category represents fraction of slots
> utilized by useful work i.e. issued uops that eventually get retired",
>        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound)",
>        "MetricGroup": "TopdownL1;tma_L1_group",
>        "MetricName": "tma_retiring",
> ...
> it looks like the group will fail due to the missing slots event. This
> can be fixed with:
>        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
> * TOPDOWN.SLOTS",
> 
> Thanks,
> Ian
> 
> [1] https://github.com/intel/perfmon-metrics
> 
> > > >   GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> > > >   GenuineIntel-6-(3D|47),v26,broadwell,core
> > > >   GenuineIntel-6-56,v23,broadwellde,core
> > >
> > > --
> > > Zhengjun Xing
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
