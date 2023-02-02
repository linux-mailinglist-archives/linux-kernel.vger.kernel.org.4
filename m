Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD96872BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBBBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBBBFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD76A69;
        Wed,  1 Feb 2023 17:05:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA6C619BF;
        Thu,  2 Feb 2023 01:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CBC433D2;
        Thu,  2 Feb 2023 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675299919;
        bh=H1y6Z1HA81YIsbsvUefZwr5ZCwOaYjAnlrJr9bYlWwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZ8P9i6w0heFH3F+q8F9WsKxI4nZ9osUwXK2d3RPLUHWcHJWN/x9dSRK5+6sxe2ic
         aJcLPpOj2k4IQdD1P/Qow5YhljLokXRofP3843Tyzjid9an+lFaQwHv9wkk9KzA9t2
         tXrm8/SETneNP3YEpOP8iN/JTKga7F/Oje6THCdSPtf5X9OQ43vxfkCjwl+LjXqjoY
         1js/F2jXbG9h9NNxZLjkFOUea8fYIxoH2DR05EAjPee+/MAEwyPjebY+8uh5pV61zG
         5OmRZyuPa7i/limbKyJ+CXIOuDIsegys+wZ4+KFT7tD69eNBvFayUq9lO7OHWYo7c2
         ZILgA9s9TH9LQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59EB5405BE; Wed,  1 Feb 2023 22:05:16 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:05:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 0/2] tools perf: Add branch speculation info
Message-ID: <Y9sMTJpltOp43wy0@kernel.org>
References: <cover.1675057032.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675057032.git.sandipan.das@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 11:29:14AM +0530, Sandipan Das escreveu:
> AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
> speculation information and the perf UAPI is extended to provide this in
> a generic way. Make perf tool show this additional information.
> 
> The UAPI changes can be found in commit 93315e46b000 ("perf/core: Add
> speculation info to branch entries").
> 
> Previous versions can be found at:
> v2: https://lore.kernel.org/all/cover.1664356751.git.sandipan.das@amd.com/
> v1: https://lore.kernel.org/all/cover.1660217326.git.sandipan.das@amd.com/

Thanks, applied.

- Arnaldo

 
> Changes in v3:
> - Drop tools-side UAPI changes as they have already been added by other
>   commits.
> - Rebase on top of latest perf/core.
> 
> Changes in v2:
> - Drop msr-index.h related changes for now.
> - Rebase on top of latest perf/core.
> - Fix UAPI breakage introduced by the ARM64 BRBE changes to perf branch
>   entry.
> 
> Sandipan Das (2):
>   perf script: Show branch speculation info
>   perf session: Show branch speculation info in raw dump
> 
>  tools/perf/builtin-script.c |  5 +++--
>  tools/perf/util/branch.c    | 15 +++++++++++++++
>  tools/perf/util/branch.h    |  2 ++
>  tools/perf/util/evsel.c     | 15 ++++++++++++---
>  tools/perf/util/session.c   |  5 +++--
>  5 files changed, 35 insertions(+), 7 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 

- Arnaldo
