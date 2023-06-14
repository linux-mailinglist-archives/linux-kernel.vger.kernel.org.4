Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084397300DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbjFNN4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245271AbjFNN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF289211F;
        Wed, 14 Jun 2023 06:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6556D64293;
        Wed, 14 Jun 2023 13:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F56FC433C8;
        Wed, 14 Jun 2023 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750953;
        bh=ydJV9XHoa04OrhiQ37+4pyUHb6RE0YFbBZb6xOO+JRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQ3+21tHUpnj1idv4OHC9GbiNa6kDI9BaxIHRg2c1uX1kBx81mniTRFUclAXjJcpm
         UAZDaJENjbcJd2TkQHNDsJKt5foS7Jj3Uu1E1l/WpNFLhZBpc+4SMqHz1M4YWDo45s
         MFUXmukWvoz3i4VP2ZSvt4F5bbocvmPBvbk/iJfC3X/j6Bb52CYtV3WwwtzHdVBEWB
         6SS4TE1rPpjx2TTdmQMsMcrev6QaaUIpqg3TmH9dTYFE/B45n/S0SUWv52vy8NPxoy
         5uxB+Xne8LhsUQuvtlQXNVugkXLkE8bDPzt2z/GbZY64FMCOoBXBfBiAitFSz9nnEg
         IM/Dik3xR/3pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3B9540692; Wed, 14 Jun 2023 10:55:50 -0300 (-03)
Date:   Wed, 14 Jun 2023 10:55:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Remove unneeded semicolon
Message-ID: <ZInG5t2brWyKzvhy@kernel.org>
References: <20230614080937.54937-1-luojianhong@cdjrlc.com>
 <2c733a91717eae93119ba2226420fd8f@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c733a91717eae93119ba2226420fd8f@208suo.com>
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

Em Wed, Jun 14, 2023 at 04:13:53PM +0800, baomingtong001@208suo.com escreveu:
> ./tools/perf/util/parse-events.c:1466:2-3: Unneeded semicolon

Was this detected by some tool? Which one?

- Arnaldo
 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 629f7bd9fd59..42f84f61fabc 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1463,7 +1463,7 @@ static int __parse_events_add_numeric(struct
> parse_events_state *parse_state,
>      if (extended_type && (type == PERF_TYPE_HARDWARE || type ==
> PERF_TYPE_HW_CACHE)) {
>          assert(perf_pmus__supports_extended_type());
>          attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
> -    };
> +    }
> 
>      if (head_config) {
>          if (config_attr(&attr, head_config, parse_state->error,

-- 

- Arnaldo
