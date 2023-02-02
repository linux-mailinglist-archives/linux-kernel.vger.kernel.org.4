Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B368732F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBBBxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBBxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:53:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E537F1D;
        Wed,  1 Feb 2023 17:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 707E5B821D8;
        Thu,  2 Feb 2023 01:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D88C433D2;
        Thu,  2 Feb 2023 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675302796;
        bh=mY52l58h/KxD+hCgCm1hAJRXAVjQz04OhKXZcJdu+Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OORaJbFaQ4a+Fslx90v97m0abgaw27ZO8hvgOZ9ErinM6671jWhn709SyA11fgij/
         6lTehdH2EQF/F2tWfx0YeDDGh4dRgGtevAItH9Y4Y2vamGLrN0h7Boye53+HRSmSwT
         uJO1MrVBKpG0RCyT5INi63PJjtgspk+REkpNN6Cylm4ShwNdfrbee2bapU+c1AbMjP
         Bb6enmmwwG5+4x/gKPO0vsiJ5fAG7bEouzxkJNdntx4+q+RZ2SpR/PKUmaE7kU3b1E
         6VqaNAvfKYwH3x4aiPX+4OY3FyZGj24kYcwQGoDwnuZh7vs919OL+HCG8IiTVfYPW+
         PuxJzJzltIQpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E13F405BE; Wed,  1 Feb 2023 22:53:13 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:53:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Script style improvements in lib/coresight.sh
Message-ID: <Y9sXiRPNoo03YRyq@kernel.org>
References: <20230201214945.127474-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201214945.127474-1-didi.debian@cknow.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 01, 2023 at 10:49:43PM +0100, Diederik de Haas escreveu:
> These 2 patches improve the efficiency and quality of the
> lib/coresight.sh script.
> 
> The first one uses grep's `-c` parameter to count the results instead of
> piping it to `wc -l`.
> The second one replaces the use of backticks (`...`) with $(...) as the
> former has several potential issues while the latter does not.
> 
> Diederik de Haas (2):
>   perf test: Replace 'grep | wc -l' with 'grep -c'
>   perf test: Replace legacy `...` with $(...)



Thanks, applied.

- Arnaldo

