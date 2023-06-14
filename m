Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE41730169
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbjFNONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9910CB;
        Wed, 14 Jun 2023 07:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAFA642B4;
        Wed, 14 Jun 2023 14:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0235EC433C0;
        Wed, 14 Jun 2023 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686752009;
        bh=7X/7FbhsdfLkee3mZ9kgb5T8bIuZmrxVKElcUIpMAlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcdEj2Z9WffNM9+XinQtijiXSQ073qH+hLWAuICnJAhiUhA1kUj/Q9MvuJP26OBbv
         P3EtDrMNeYemtaMMbZmwLl0CMo/QmwCxZeEdFFcWpgubgyTxa9Qv19AmyE4WlM2WSM
         FFRvaZIGDiasKWMWLVmU0bNeYmsXMaKQqSnObGspkeI2+CYw/9wfzKrVCPg5unpI34
         9qqZ4d8pRpAAG+OFfJckoPEQxGdDWCZ8e/i+JzcrW3js7CYg4cjpJBiCj4oOrv3Uhx
         tuUbvvDVKVPUph1yrj8t7UPUvN5Y8wNoELAbo+8MVbnO7HeNfh1UPc56PYzi7Ug5uU
         05ol+qhg55v9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8EAE440692; Wed, 14 Jun 2023 11:13:26 -0300 (-03)
Date:   Wed, 14 Jun 2023 11:13:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf tools: Add a place to put kernel config
 fragments for test runs
Message-ID: <ZInLBt9q2F99gTg8@kernel.org>
References: <20230614140219.2335639-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614140219.2335639-1-james.clark@arm.com>
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

Em Wed, Jun 14, 2023 at 03:02:19PM +0100, James Clark escreveu:
> We are currently keeping something like this in our CI because defconfig
> doesn't give full coverage. It's not complete yet, but is a starting
> point as a place to add to when a specific test needs something extra to
> run.
> 
> The RFC is for discussion on folder placement and file naming etc.

Would be interesting to add the Kconfig maintainer to see if they have
an opinion, Masahiro?

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/config-fragments/README  |  7 +++++++
>  tools/perf/tests/config-fragments/aarch64 |  1 +
>  tools/perf/tests/config-fragments/config  | 11 +++++++++++
>  3 files changed, 19 insertions(+)
>  create mode 100644 tools/perf/tests/config-fragments/README
>  create mode 100644 tools/perf/tests/config-fragments/aarch64
>  create mode 100644 tools/perf/tests/config-fragments/config
> 
> diff --git a/tools/perf/tests/config-fragments/README b/tools/perf/tests/config-fragments/README
> new file mode 100644
> index 000000000000..e816cfb1b96d
> --- /dev/null
> +++ b/tools/perf/tests/config-fragments/README
> @@ -0,0 +1,7 @@
> +This folder is for kernel config fragments that can be merged with
> +defconfig to give full test coverage of a perf test run. This is only
> +an optimistic set as some features require hardware support in order to
> +pass and not skip.
> +
> +'config' is shared across all platforms, and for arch specific files,
> +the file name should match that returned by 'uname -m'.
> diff --git a/tools/perf/tests/config-fragments/aarch64 b/tools/perf/tests/config-fragments/aarch64
> new file mode 100644
> index 000000000000..64c4ab17cd58
> --- /dev/null
> +++ b/tools/perf/tests/config-fragments/aarch64
> @@ -0,0 +1 @@
> +CONFIG_CORESIGHT_SOURCE_ETM4X=y
> diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
> new file mode 100644
> index 000000000000..c340b3195fca
> --- /dev/null
> +++ b/tools/perf/tests/config-fragments/config
> @@ -0,0 +1,11 @@
> +CONFIG_TRACEPOINTS=y
> +CONFIG_STACKTRACE=y
> +CONFIG_NOP_TRACER=y
> +CONFIG_RING_BUFFER=y
> +CONFIG_EVENT_TRACING=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
> +CONFIG_TRACING=y
> +CONFIG_GENERIC_TRACER=y
> +CONFIG_FTRACE=y
> +CONFIG_FTRACE_SYSCALLS=y
> +CONFIG_BRANCH_PROFILE_NONE=y
> -- 
> 2.34.1
> 

-- 

- Arnaldo
