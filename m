Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534F65345F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiLUQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiLUQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:52:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D561B79B;
        Wed, 21 Dec 2022 08:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2430D6186E;
        Wed, 21 Dec 2022 16:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A31C433EF;
        Wed, 21 Dec 2022 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671641575;
        bh=g/GsqyV3uErpMRQwxfVP4411/v4qwiMvBe7PcgSp8PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7/4TZsAFC2sp/ekFj4qAG9FIBbM0aPEDcX33HoLBsw1ivLHxYPZo02WYb3P+SfdW
         VvPubxp7fiZqAb8DlUUWqbMoFEJG7r6HPOmYgsmzRTDQokx63ZSzW3TTfQZKuhVB0e
         SVda+hXF3L6BuQzMrGDddsSmu7IGrIbDCae4f0guZ80Hm16yYjbzmuz0HdsdBvcOVq
         CJhI3lMUSWoH5cUpVozCEtd1SApyp5BrFR/ws30U5LvNW33iOMvvk7DQ3w6kvGcB6a
         q80O991bweQVZxibP8Fq3dH5qRVno2FTy5fsqGmyr/KWJrapA5TaeHpOHJSJur9b7d
         Rk0AUVBi2lUnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81C9D40367; Wed, 21 Dec 2022 13:52:52 -0300 (-03)
Date:   Wed, 21 Dec 2022 13:52:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1 00/32] Refresh Intel vendor events
Message-ID: <Y6M55I/gDRBAfPvc@kernel.org>
References: <20221215064755.1620246-1-irogers@google.com>
 <bbbe8cb7-bc12-537f-0977-e96ab7cf3cfa@linux.intel.com>
 <Y6M0zwN+1yovTeZH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6M0zwN+1yovTeZH@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 21, 2022 at 01:31:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 15, 2022 at 12:23:14PM -0500, Liang, Kan escreveu:
> > On 2022-12-15 1:47 a.m., Ian Rogers wrote:
> > > Use new repository [1] and converter script to regenerate Intel vendor
> > > metrics. In particular this change removes unnecessary json fields and
> > > correct uncore events that previously had a buggy converter.

> > Thanks Ian.

> > The patch series looks good to me.

> > Acked-by: Kan Liang <kan.liang@linux.intel.com>

> b4 doesn't like it, I'll apply it manually, probably some went over
> message size limits?

Had to adjust the first one manually due, IIRC, to the hashmap changes
that went upstream via the bpf tree, then use b4 3 times, cherrypicking
ranges of the series to get all merged.

Ian, please check what happened so that this isn't this manual next
time.

- Arnaldo
