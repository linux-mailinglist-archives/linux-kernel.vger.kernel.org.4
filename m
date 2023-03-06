Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDE6ACC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCFSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCFSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:15:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364366423A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678126523; x=1709662523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QBKCuwRTWEWe9JLzCDJ0AOkPJXI0vK4swr9jbHIDC0o=;
  b=i7oRaHVQxuf/WL7+0lZJboXg/PBQANfNEurwHmjm2mg+CeFPQhwMKxfV
   qMwEZY2kSbF1lnTbFn4cypkeXMoSM62eMfjs2rIUnifDIkoFLCVVWxRpr
   fC/5LEBx7+tAUoPhGfn73y+Zh7+wSvi5J8/uBrL4yh3iJT8shRnp/8fvW
   FZXFBnSoasl0QtIm/HLR4NUkC9SdkACZ9UJjHxhKd9P6Zjm24kVkh+vwO
   jRb647J/yE+Kji2pXhBtiL7RocsvP9AXdgaO/Rr/zofnKXrVnAz/KQ948
   eSNOW4CxLYs5UVwgorWb8oAmgpYB9dSlqWVprLSN/0IQP+5D6a59Uaz62
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421907852"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421907852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669547209"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669547209"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.82])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:12:48 -0800
Message-ID: <a316176e-35ce-38da-8054-cda7fd2e2a0a@intel.com>
Date:   Mon, 6 Mar 2023 20:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] perf tools: Add Adrian Hunter to MAINTAINERS as a
 reviewer
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZAYosCjlzO9plAYO@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZAYosCjlzO9plAYO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 19:53, Arnaldo Carvalho de Melo wrote:
> Please ack :-)
> 
> --
> 
> Adrian is the main author of the Intel PT codebase and has been
> reviewing perf tooling patches consistently for a long time, so lets
> reflect that in the MAINTAINERS file so that contributors add him to the
> CC list in patch submissions.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66b5d5a51d5b1110..8e46fa10a631e4d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16425,6 +16425,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Namhyung Kim <namhyung@kernel.org>
>  R:	Ian Rogers <irogers@google.com>
> +R:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported

