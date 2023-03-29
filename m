Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448466CDAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjC2NW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjC2NW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:22:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5049EC;
        Wed, 29 Mar 2023 06:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0275CB8232E;
        Wed, 29 Mar 2023 13:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76026C433D2;
        Wed, 29 Mar 2023 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680096160;
        bh=hf4DJ6f1B1ev4lIyxfuaOwJVWhFkylozyMz3i1aYje8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bjuv3yORuUe8fx2ZC8SCcfiRd7zejOiFkJ/BSQai9IPYqBIAMEsmNbcZ9hlh2Ctnl
         TvwghIwDifE4ieG9lNo0tcrTQjM+ap2Cm8szs3WCkJVXtZodASoeRD27yf8lsHKpKY
         z1MNMdC7nnhx2oVik+fom9dkqq9EOrB/3Y5F9ced2nunZYGc+lv+MbBeCDS8JF1dEb
         yQKanf6DbRQtf0efbpLYPF7DP/aWz/VdvaqmswQ9buFGGbD8+aXWsjBjS6+B9wn3mR
         fClNaKvs7ueeg/7ihMQeMlo+/gEilUufpuE1TiCqShbOWC2+BGR8fjitJezaY8XTSM
         A3CkZrPhsktAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91AE04052D; Wed, 29 Mar 2023 10:22:38 -0300 (-03)
Date:   Wed, 29 Mar 2023 10:22:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <ZCQ7nhrISA+jCfnI@kernel.org>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org>
 <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 01:59:10PM +0100, Mike Leach escreveu:
> Sorry - my error.
> 
> The same change is made in patch 3/3 of this set.
> 
> Looks like I didn't do a patch by patch build check when I was testing yesterday

np, its fixed now and pushed to tmp.perf-tools-next, please check, will
go to perf-tools-next later today after passing thru my set of container
build tests.

- Arnaldo
