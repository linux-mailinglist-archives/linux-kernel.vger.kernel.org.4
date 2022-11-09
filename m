Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD26F62324D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKISVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKISVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:21:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777A27DDA;
        Wed,  9 Nov 2022 10:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC777B81F6A;
        Wed,  9 Nov 2022 18:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B43C433D6;
        Wed,  9 Nov 2022 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668018091;
        bh=JydyiqWSrBJsGOyUV0/mvuFmyyGEnLF2W48C4pxZAUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4Tg86mtWcIx2gQeCbDzBEGjPU6j1LxBc3Df6DOEYmVJVGXLu5xQcDaGey2mhEHoH
         DapLCFM7taF2TNuqvRWi9Dr1M6SKMT74TSLav2bKBjml8+vJB0w0t5pl8jizCXeNET
         hrpohLYBxyHB8sYCLBPHuX0GzcHCcYenoEgqsXPMG8fiI3pEp6SSu8wPdRORBlZWwv
         U2oHSTgORulafMXZHI7SwHRHXLbUoofb6RtrH6Tqme2sWQQQEj6YfJb7DW3Gjvr21U
         PnCxnELMyI/TJQAzgkKjsjiSNmYvxszfDued7+Lu13h3TuRnyZR1tLcr3cOjBt+eUA
         kZ0WmUNZxgMLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 120A54034E; Wed,  9 Nov 2022 15:21:29 -0300 (-03)
Date:   Wed, 9 Nov 2022 15:21:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf: intel-pt: Add hybrid CPU compatibility test
Message-ID: <Y2vvqTOWRJMnDqIo@kernel.org>
References: <20221104121805.5264-1-adrian.hunter@intel.com>
 <CAM9d7cjHb4tKsuNjD+Mhj_4coO=H-822uBxpNAmnm6NN=Eavhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjHb4tKsuNjD+Mhj_4coO=H-822uBxpNAmnm6NN=Eavhw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 07, 2022 at 11:32:56AM -0800, Namhyung Kim escreveu:
> Hi Adrian,
> 
> On Fri, Nov 4, 2022 at 5:18 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > The kernel driver assumes hybrid CPUs will have Intel PT capabilities
> > that are compatible with the boot CPU. Add a test to check that is the
> > case.
> >
> > First 2 patches are preparation.
> >
> >
> > Adrian Hunter (3):
> >       perf: intel-pt: Rename intel-pt-pkt-decoder-test.c
> >       perf: intel-pt: Redefine test_suite
> >       perf: intel-pt: Add hybrid CPU compatibility test
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> >
> >  tools/perf/arch/x86/include/arch-tests.h           |   1 +
> >  tools/perf/arch/x86/tests/Build                    |   2 +-
> >  tools/perf/arch/x86/tests/arch-tests.c             |  15 +-
> >  ...intel-pt-pkt-decoder-test.c => intel-pt-test.c} | 154 +++++++++++++++++++++
> >  4 files changed, 169 insertions(+), 3 deletions(-)
> >  rename tools/perf/arch/x86/tests/{intel-pt-pkt-decoder-test.c => intel-pt-test.c} (80%)
> >
> >
> > Regards
> > Adrian

-- 

- Arnaldo
