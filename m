Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C206FE323
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjEJRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjEJRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63B8A72;
        Wed, 10 May 2023 10:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CBB63411;
        Wed, 10 May 2023 17:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E789FC433EF;
        Wed, 10 May 2023 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738945;
        bh=kwBbgP+5vBJThrO7fvCQXHQgjr8ifqeicGUxMgkRj1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqPBZp9kPhRac09GVfnCv7Ls0QdW8Jmk9xVg+frOfrtMQlP6TwOvMRU/tNSemPL27
         W0plD+neghYgRbjFpDbJThmRRuEk37ye7q0WvhYhHA49uUXwHGOkA4xNFSbe+dPuN5
         NdgIbJvRJH2q3ZBSQpP4eg6qojR0lddbefp/Gut4DmdRw0ieOqU/S7Rk3VNOWOk9nA
         ar792Tan7siN112zdA/7mVFVPWfKMBVDYj92vVrCvxoOEzgLsaYAsFWDOHz/Ei36v1
         jvhHrhdWR/tZDu9O2WYb5v6xGdTKW/4IpHkJNp0vabseH2TkwkOzxib8xGU9TPUXUo
         TwdPZya4+J8iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86860403B5; Wed, 10 May 2023 14:15:42 -0300 (-03)
Date:   Wed, 10 May 2023 14:15:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 0/2] perf parse-events: Do not break up AUX event group
Message-ID: <ZFvRPsrI5SVcyrU4@kernel.org>
References: <20230508093952.27482-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508093952.27482-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 08, 2023 at 12:39:50PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is a fix needed in v6.4, but dependent on Ian's patch
> "perf evsel: Modify group pmu name for software events", refer:

Thanks, applied to perf-core, for v6.4.

- Arnaldo
 
> https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/
> 
> There is also a test amendment to test the AUX event group fix for
> Intel PT.
> 
> 
> Changes in V2:
> 
>    Add an Intel PT test amendment for the AUX event group fix
>    Change AUX event group fix as suggested by Ian
> 
> 
> Adrian Hunter (2):
>       perf test: test_intel_pt.sh: Test sample mode with named PMU
>       perf parse-events: Do not break up AUX event group
> 
>  tools/perf/tests/shell/test_intel_pt.sh | 7 +++++++
>  tools/perf/util/evsel.c                 | 9 +++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
