Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBDC5B3901
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiIINaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiIINaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424734BD13;
        Fri,  9 Sep 2022 06:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02C7EB824F7;
        Fri,  9 Sep 2022 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36DC433D7;
        Fri,  9 Sep 2022 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662730215;
        bh=EEGq+IdvooaP0lFaWFPxgnWqvDpi0mvAYTKZobEYsM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3BTj5RdZWBa7U0ALppB4kpbvJVVC81AisTt8jG+FshRpNrilwNM3F/TJKSjQ5a86
         39biMVyb+9mOyRo7zM+5a7a+oBP3SdA5gqnBp89tclmSgDZ3ojcLHoSyt6f12AujhG
         dfvPlSVZIW+dwgLzkQZdOv+7XhhyMaqFxx7FdwmIkZh0L0MJal1uJFDSQiCXpEohce
         vc9GrRkIn5CNLXDxhrjTteeJ2Y83+nCGBuZno0NY8bhj0KHOMBEKfd0No4K6Mxzp+R
         PZ3jD2I7babtKxUIYy4Zijg6M1FHWU9QrxPEbAet8RgEaRREfsuFlTHdTKiuEFNVeR
         qauUQ9u/QF0WQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E596404A1; Fri,  9 Sep 2022 10:30:12 -0300 (-03)
Date:   Fri, 9 Sep 2022 10:30:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, atrajeev@linux.vnet.ibm.com,
        eranian@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unused declarations
Message-ID: <Yxs/5FvhOKg4i9lb@kernel.org>
References: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
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

Em Fri, Sep 09, 2022 at 12:45:40PM +0800, Gaosheng Cui escreveu:
> This series contains a few cleanup patches, to remove unused
> declarations which have been removed. Thanks!

Thanks, applied.

- Arnaldo

 
> Gaosheng Cui (2):
>   perf sort: remove hist_entry__sort_list and sort__first_dimension
>     declaration
>   perf tools: remove perf_pmu_lex declaration
> 
>  tools/perf/util/pmu.y  | 2 --
>  tools/perf/util/sort.h | 2 --
>  2 files changed, 4 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
