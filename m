Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DC6F2233
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbjD2B4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjD2B4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:56:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE91BF2;
        Fri, 28 Apr 2023 18:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C8B64602;
        Sat, 29 Apr 2023 01:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B1C433EF;
        Sat, 29 Apr 2023 01:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733393;
        bh=9PYdLXmuipg03ev+3KoyccFShDSp41u1IZ8Y+yfIiEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qjqv3LjV0Pfpq3X39Gr3tmCguQIhglndTj4nGpajXr2/+m6R7DdRb9GyCGeNzN15c
         ms7OojaRIZc8XF0ZHogX8mp59fnLmR/GyJNDg+cJ1/moY2qmJbobYo9M/42hCALcMi
         S8cI9a9Ebl8ufOkRFQbIK8EBj1oj4JXmS3akx7R71bPIgGRN65KVLC0CuppIZiWbhy
         tXjmdIMaFGPVIso/53aCTV/Wuf0RzYpACQIWxL1lg7NGsrYgd6iy0XXyuDcIf27aSd
         3OR0mMGp7z2c1ODy1MZqj0V6hAdoMrXk5SlyxWwTyuTwkIhH+YwBKCHwSbL55hTCdA
         fVj9ukUA6/F9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 615E6403B5; Fri, 28 Apr 2023 22:56:30 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:56:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH 0/2] perf script: Refine printing of dso offset (dsoff)
Message-ID: <ZEx5TuaDOov9f4aA@kernel.org>
References: <20230424055107.12105-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424055107.12105-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 24, 2023 at 08:51:05AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is a refinement to patches from Changbin Du <changbin.du@huawei.com>
> that add dsoff:
> 
> 	https://lore.kernel.org/linux-perf-users/20230418031825.1262579-1-changbin.du@huawei.com/T/#t
> 

Thanks, applied.

- Arnaldo

 
> Adrian Hunter (2):
>       perf dso: Declare dso const as needed
>       perf script: Refine printing of dso offset
> 
>  tools/perf/util/dso.c | 33 +++++++++++++++++++++++++++++++++
>  tools/perf/util/dso.h |  8 +++++---
>  tools/perf/util/map.c | 23 +++++++++++++++++++----
>  3 files changed, 57 insertions(+), 7 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
