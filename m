Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2399764A849
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiLLTu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:50:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E301658E;
        Mon, 12 Dec 2022 11:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 517F2B80DE1;
        Mon, 12 Dec 2022 19:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EF8C433D2;
        Mon, 12 Dec 2022 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874651;
        bh=GWBSlK+jG0JiF9pGcNdW2eUoYopUOb6hhGgisKcKzjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/1mP/WGckFhesy8UZRRzumLWO5/MkqGC7elrabJcLmfIZ0hYSqr6DxPfKbUxq6MJ
         1N9CcCIbTKdUOFOH11grq5cucyaoupdQ/+ogNmhuPpl+da8lXl/sz3rCxtGB5nJWSu
         fU77envppwHa/6UlOIbRHLlcOwcsqu7QZdrZCtQQDH0C5CHqk8xgJjkdPoQ99xJB40
         Zl4AKsGboN+28rsxNnME5m3YYGngYnCp4l+gndMKlmmWjlar/k/MkUANI4KJLw8U1R
         ZyofQW/ovSnntONZudYfG9FRd/z8te1ZwtoSIYcJfyaYdPwV1NTp9+kIJjH9xZ5lGl
         ojI8QEXhzelig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DFC740483; Mon, 12 Dec 2022 16:50:49 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:50:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, Al.Grant@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH 0/5] perf: cs-etm: Print auxtrace info even if OpenCSD
 isn't linked
Message-ID: <Y5eGGb28EAK43j26@kernel.org>
References: <20221212155513.2259623-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212155513.2259623-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 12, 2022 at 03:55:08PM +0000, James Clark escreveu:
> The auxtrace info header can be useful for debugging, and at the
> moment it's possible to record a file without OpenCSD linked but
> not view the header even though it should be possible to do.
> 
> This patchset tidies up some of the related functions and
> improves some of the error messages before making the above
> possible in the last commit.
> 
> Testing done:
> 
>  * Compiled on x86 and Arm both with and without CORESIGHT=1
>  * Ran the Coresight tests
> 
> Applies to perf/core (0c3852adae8)

Thanks, applied.

- Arnaldo

 
> James Clark (5):
>   perf: cs-etm: Print unknown header version as an error
>   perf: cs-etm: Remove unused stub methods
>   perf: cs-etm: Tidy up auxtrace info header printing
>   perf: cs-etm: Cleanup cs_etm__process_auxtrace_info()
>   perf: cs-etm: Print auxtrace info even if OpenCSD isn't linked
> 
>  tools/perf/util/Build         |   1 +
>  tools/perf/util/cs-etm-base.c | 174 ++++++++++++++++++++++++++++
>  tools/perf/util/cs-etm.c      | 208 +++-------------------------------
>  tools/perf/util/cs-etm.h      |  46 ++------
>  4 files changed, 200 insertions(+), 229 deletions(-)
>  create mode 100644 tools/perf/util/cs-etm-base.c
> 
> -- 
> 2.25.1

-- 

- Arnaldo
