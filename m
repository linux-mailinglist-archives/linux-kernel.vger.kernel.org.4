Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE66E5663
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDRBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDRBYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988F46A8;
        Mon, 17 Apr 2023 18:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD23962B8C;
        Tue, 18 Apr 2023 01:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0851CC433EF;
        Tue, 18 Apr 2023 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681781091;
        bh=32K0Q1HerQG3csJxlpFXO/0Ud2VIwzHH5+OXkXOd0/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOF+vm+sF4UcDMoaPWRO321Tj0buTOVFxEOsOk49qppbLCqvQoFqhbW8dFAwYobgj
         unEcgvnMNVectQ6qFCjDLIZNdjGzBAo8o1UFmAz3Sdf9DoEBFyM1YST3QSnSBTUCp3
         Sxgl5s9bW/SrjnoRWJcTtof5FjR8izX28SnNc/s9M3R1mpZ5qdsSv5uEAhTpOPh5cu
         M8ajK9Q7Tn4nR4ocPDoktgyBC5dijh0at4zF0C1yDS8FsrnUSnFb3ApPq6GeY3ytNM
         Fg93i/N5zvMUjOk3F255vIAT2/FS/Vi1V6J4R29r6Xr+mIiJSuGw28LnSqnbQqzlty
         vm8UZDYaMZ+oA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87605403B5; Mon, 17 Apr 2023 22:24:48 -0300 (-03)
Date:   Mon, 17 Apr 2023 22:24:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf script: task-analyzer: Fix spelling mistake
 "miliseconds" -> "millseconds"
Message-ID: <ZD3xYFRrdjEdzQJC@kernel.org>
References: <20230417174826.52963-1-colin.i.king@gmail.com>
 <20230417182707.bgvx2os4bbihjamb@ic1101>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417182707.bgvx2os4bbihjamb@ic1101>
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

Em Mon, Apr 17, 2023 at 08:27:07PM +0200, Hagen Paul Pfeifer escreveu:
> * Colin Ian King | 2023-04-17 18:48:26 [+0100]:
> 
> >There is a spelling mistake in the help for the --ms option. Fix it.
> >
> >Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Good catch - thank you Colin!
> 
> Acked-by: Hagen Paul Pfeifer <hagen@jauu.net>

Thanks, applied, and fixed the subject line typo.

- Arnaldo
