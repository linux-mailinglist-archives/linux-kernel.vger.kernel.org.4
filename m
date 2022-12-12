Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435864A455
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLLPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiLLPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:40:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19911C04;
        Mon, 12 Dec 2022 07:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE536112B;
        Mon, 12 Dec 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF40EC433D2;
        Mon, 12 Dec 2022 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859645;
        bh=PYPely3qOQWyWv/e5Pdt422ahT6SYCZQGHE5vP69vkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8veBx4KuVjJZCAz2OT/q7caXG/00dX50LGa5S+/jh62UZomlk+VTgKR/B/kDEH/e
         YFHuuTZmS43gz/VLrPTaIhNHUB0FkcHUuxS14TQdYWHDobTGVeTjpEWysCgxNt6yYL
         V8Yf4/jML98ohZnKInEpjA3mbOvbjkUVxiWFjhPZtsCk8Y6zdW3mCgKn96OZaBjXJ9
         +DbDKdLVQwyteIEp+MEMa6aR/VXg1tRpkcbYNvQppdzh4nhlUn3vR6NCEGVENmwwdY
         fOf9+NrdxFVk9oNQZnc4MUD6ChIGUIZWmwCwoGgkB6OlXiRGPrInc0FHD6SDi/RBxT
         oVlllmUg5Ergg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AFE840483; Mon, 12 Dec 2022 12:40:42 -0300 (-03)
Date:   Mon, 12 Dec 2022 12:40:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events powerpc: Fix spelling mistake "fpr"
 -> "for"
Message-ID: <Y5dLer9nOR6j0Xmb@kernel.org>
References: <20221207135645.2327224-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207135645.2327224-1-colin.i.king@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 07, 2022 at 01:56:45PM +0000, Colin Ian King escreveu:
> There is a spelling mistake in the description text. Fix it.

Sandipan,

	Is this generated from some other file? Or can I apply this one?

- Arnaldo
 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/perf/pmu-events/arch/powerpc/power8/other.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> index f1f2965f6775..6de8c472ec99 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> @@ -2996,7 +2996,7 @@
>    {
>      "EventCode": "0x308e",
>      "EventName": "PM_SWAP_COMPLETE_GPR",
> -    "BriefDescription": "swap cast in completed fpr gpr",
> +    "BriefDescription": "swap cast in completed for gpr",
>      "PublicDescription": ""
>    },
>    {
> -- 
> 2.38.1

-- 

- Arnaldo
