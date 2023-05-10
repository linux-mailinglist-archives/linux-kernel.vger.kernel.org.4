Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676726FE31C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjEJROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbjEJROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749359EB;
        Wed, 10 May 2023 10:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48C83633CD;
        Wed, 10 May 2023 17:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853BBC433D2;
        Wed, 10 May 2023 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738792;
        bh=uwBVahIzAis+hKtabAV4C+jtkGBRRIeCGM+mjBTEncY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uc2uEkx+R4rVm5oGfMmAF2GSqn0P5S/XRjfWldOa+YT1cw7KX69NhCMaDFMoqem7v
         2zJMGmWguP4DtcBpuJRhfU25dNiVTt38/SkEZZU+fSkjPfY2sQULTbwloRrxLPB6Ow
         fjMCRbXZwOdObEO2ghIS6Y0bfJBgMVSCCGcIiSLIaz0rcx5FDJDMJnMTNRsckmn0I7
         uFLkwSNozieF5sJQBiqaXisa9ur6/I+fzn6zIz0jVSPiyi73vCS6MhENmaXyiWf6++
         Mrh5CxDzIE0WBEznw0+BBXf0BXmAecyb15bzVPiCC3J61hB9Y7YR+23Cz/GB1nxHMf
         A+CH6QMckLnqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB874403B5; Wed, 10 May 2023 14:13:09 -0300 (-03)
Date:   Wed, 10 May 2023 14:13:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 0/2] perf parse-events: Do not break up AUX event group
Message-ID: <ZFvQpZsvyEaHUjSq@kernel.org>
References: <20230508093952.27482-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508093952.27482-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> 
> https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/
> 
> There is also a test amendment to test the AUX event group fix for
> Intel PT.

Ok, so I think I can add your Tested-by for that "perf evsel: Modify
group pmu name for software events" patch, ok?

- Arnaldo
 
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
