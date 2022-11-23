Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4B636067
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiKWNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiKWNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:49:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F5905AA;
        Wed, 23 Nov 2022 05:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A904361CAD;
        Wed, 23 Nov 2022 13:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E51C433C1;
        Wed, 23 Nov 2022 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669210802;
        bh=9IWoY03SQ8VMLyG2yQnC7CcbMaAaF1wV7YxwcUuakkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCEmMytE/QgsnVzMgklE3GqXFOoGwDXj2RCeJlq5CQlo15TUWqPtAz+QrrpMaE3s5
         ZbsvWmMviaXALaRy6GWsQ1QUAJ5VXT4voUDHRppevuuFd2kZnKGsqTd07Hax826q5m
         huy6VASwWmdb+nekkZtxoSJQ/4jvUIumWAxHvvnvPL0WclbNt1AM/50sbfBqm4Yttq
         KeocdNxd8sVvaHkW+5bk+f+3jGNU2KwpzwmGTKmbaM4NMM5dTaRj31t7pG/u9xca3Q
         l5eDUWQxxXQnth5JOgnZWHPa9V2/uxO4PR9aBeX8IIBf4fYwTvXVCibetZWGgwFJqf
         Z9RVOXFs2jCuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86D884034E; Wed, 23 Nov 2022 10:39:59 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:39:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     zhengjun.xing@linux.intel.com, Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v2 1/5] perf vendor events intel: Add core event list for
 Alderlake-N
Message-ID: <Y34irx0jffj8NXRY@kernel.org>
References: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUQUe0UvLhaSBnm-dAPHc3_k8vZWNxhZajg8mg6R8og0g@mail.gmail.com>
 <Y34iAVLGAGhVH/ta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y34iAVLGAGhVH/ta@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 23, 2022 at 10:37:05AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 21, 2022 at 01:17:12PM -0800, Ian Rogers escreveu:
> > On Mon, Nov 21, 2022 at 12:19 AM <zhengjun.xing@linux.intel.com> wrote:
> > >
> > > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > >
> > > Alderlake-N only has E-core, it has been moved to non-hybrid code path on
> > > the kernel side. Add core event list for Alderlake-N, it is based on the
> > > ADL gracemont v1.16 JSON file.
> > >
> > > https://github.com/intel/perfmon/tree/main/ADL/events/
> > >
> > > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Is this just for 1/5? Or can I stick it to the whole series?

But, after applying 1/5 I get:

  CC      /tmp/build/perf/util/data-convert-bt.o
  CC      /tmp/build/perf/util/data-convert-json.o
/tmp/build/perf/pmu-events/pmu-events.c:55354:39: error: ‘pme_alderlaken’ defined but not used [-Werror=unused-const-variable=]
55354 | static const struct compact_pmu_event pme_alderlaken[] = {
      |                                       ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:711: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/util/lzma.o
  CC      /tmp/build/perf/util/zlib.o
  CC      /tmp/build/perf/util/jitdump.o
  CC      /tmp/build/perf/util/bpf-event.o
  LD      /tmp/build/perf/util/perf-in.o
  LD      /tmp/build/perf/perf-in.o
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':

    26,049,918,108      cycles:u
    47,580,273,158      instructions:u                   #    1.83  insn per cycle

       4.655423698 seconds time elapsed

       6.211852000 seconds user
       5.060661000 seconds sys


⬢[acme@toolbox perf]$

Please fix it and send a v2.

- Arnaldo
