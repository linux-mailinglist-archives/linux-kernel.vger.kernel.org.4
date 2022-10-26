Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7260E2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiJZOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiJZOLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEFBDFC17;
        Wed, 26 Oct 2022 07:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6F461F1D;
        Wed, 26 Oct 2022 14:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B7C43470;
        Wed, 26 Oct 2022 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666793501;
        bh=A4HWxpOUTvcYoLIu6PA/gJqS6JUpPF+81q8U5rfVUjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgUlTSc4eoFdgnMKyupiYVziW+G8pwFArYWAfJ1NiOgm2l2slLNlu0k6JYdNw9VHZ
         1K1JwwfPFaVLTbOUNgdmPpiuc6zD3OW1WjtyBZJ4+IQGMtBuyakmYiDshjoSzCcswx
         1Mos7gKI/vXSZvLr1VLbAkHipisTkhiLliYoA6jKbl6y88yFCrd+TZRUiCEnk0bbY+
         glzjn/YbtSfJT7wgM+q4C3zXFMPu3abL9VzSJ6NMzYdS+yH5bfiUOzV7IgeRbOoMwQ
         hDyN5Wwywt3t1l1WvtU09VD+FfWqxAFnTDpqjdmOv7Ci/d6L/c/tiIVrFPgaqrgGsd
         ny+6/KaZ2Jc0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF4EA404BE; Wed, 26 Oct 2022 11:11:32 -0300 (-03)
Date:   Wed, 26 Oct 2022 11:11:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/8] perf test: Add system-wide mode in perf record tests
Message-ID: <Y1lAFJV3IO+P+3u2@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-6-namhyung@kernel.org>
 <CAP-5=fVDi8Cj2XenWDB_rENJPYj_Nafo7BE2c7XiOGYUh1QqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVDi8Cj2XenWDB_rENJPYj_Nafo7BE2c7XiOGYUh1QqLw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 20, 2022 at 05:00:39PM -0700, Ian Rogers escreveu:
> On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add system wide recording test with the same pattern.  It'd skip the
> > test when it failes to run perf record.  For system-wide mode, it needs
> 
> nit: s/failes/fails/
> 
> > to avoid build-id collection and synthesis because the test only cares
> > about the test program and kernel would generates necessary events as
> 
> nit: s/generates/generate the/

fixed
 
> > the process starts.
> >
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/record.sh | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index d1640d1daf2e..345764afb745 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -154,10 +154,31 @@ test_register_capture() {
> >    echo "Register capture test [Success]"
> >  }
> >
> > +test_system_wide() {
> > +  echo "Basic --system-wide mode test"
> > +  if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
> > +  then
> > +    echo "System-wide record [Skipped not supported]"
> > +    if [ $err -ne 1 ]
> > +    then
> > +      err=2
> > +    fi
> > +    return
> > +  fi
> > +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> > +  then
> > +    echo "System-wide record [Failed missing output]"
> > +    err=1
> > +    return
> > +  fi
> > +  echo "Basic --system-wide mode test [Success]"
> > +}
> > +
> >  build_test_program
> >
> >  test_per_thread
> >  test_register_capture
> > +test_system_wide
> >
> >  cleanup
> >  exit $err
> > --
> > 2.38.0.135.g90850a2211-goog
> >

-- 

- Arnaldo
