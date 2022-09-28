Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474E5EDE71
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiI1OIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiI1OH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE8901A2;
        Wed, 28 Sep 2022 07:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F3AB820D2;
        Wed, 28 Sep 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E01C433D6;
        Wed, 28 Sep 2022 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664374075;
        bh=OE89uXq223LS1VLMazZYaPzc1wXRR0cnJ5t0n1HEET4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw8TOttcu+SjWnPYnVuwIzw0nQy5dwuJkVHpRcc55n/wGxBPaDYqCLaLM3iP2x/RD
         8VY71zeDk6jVs9R6fr89WVRp4KmHcPh9aq+PiO0lvRF64cBEk8JVPMvlyRlrR0p+Nl
         5fkJC7jseNKR+tKAm3Lsg73eJqeitiLb4YMdWeTrZsgpXV7B0T+iUS5NOg1sjvb2jl
         +Oq2JPsbhX7MInPU1FxnAmYqcYGMSn2dcFCdAAL6W+TbWrHhDHJXPReN75bncmFuBP
         gK36L+w+DYbpuP9Kw+SgtXCEzmQHm5oiYuHvacNYAw7x2dXehacbhSCyMj5O7ytdK4
         lSHFF0mgSNTWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAAC2405F0; Wed, 28 Sep 2022 11:07:52 -0300 (-03)
Date:   Wed, 28 Sep 2022 11:07:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <YzRVOD4u2SI0K29Y@kernel.org>
References: <20220928072204.1613330-1-irogers@google.com>
 <20220928072204.1613330-6-irogers@google.com>
 <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f59d7c-ced7-2d74-edbc-f354047339fe@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 28, 2022 at 04:22:53PM +0800, Xing Zhengjun escreveu:
> On 9/28/2022 3:21 PM, Ian Rogers wrote:
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > index 7f2d777fd97f..594c6e96f0ce 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -1,5 +1,5 @@
> >   Family-model,Version,Filename,EventType
> > -GenuineIntel-6-9[7A],v1.13,alderlake,core
> > +GenuineIntel-6-(97|9A|B7|BA|BF),v1.15,alderlake,core
> 
> The commit description should mention this change "Add more CPUID support
> for ADL"

I added this note, with that can I have your Reviewed-by or Acked-by?

- Arnaldo
 
> >   GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> >   GenuineIntel-6-(3D|47),v26,broadwell,core
> >   GenuineIntel-6-56,v23,broadwellde,core
> 
> -- 
> Zhengjun Xing

-- 

- Arnaldo
