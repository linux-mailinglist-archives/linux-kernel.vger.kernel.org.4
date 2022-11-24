Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF163792A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKXMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:45:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30615FF2;
        Thu, 24 Nov 2022 04:45:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B07C62117;
        Thu, 24 Nov 2022 12:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49252C433C1;
        Thu, 24 Nov 2022 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669293921;
        bh=5P5a36o+5Kh0CDDFUyXBOexufHYJ5/CJJ26KIcTQDOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzdCw0opejG3yh4rP2Lg6DJdvz4ZY5rHmAu36sYRTFrJH0iamtUN+Vm9OAe+ymvVU
         9OdMUGeRpEHaHjBl4V4sJ1vM647deZSYUZXCjN70F0xu3JRcLyeyjnDWVmu4UCGJsx
         zygM+H48pLpjS97csZfON7921wvY9NOIWA01OorzWpnKq7++Wgglf/wqUyzvnhcBeV
         f0hJS5qc2GEQT+Y8kxHze10tiX9LVpmswWMcPa7+yrNl5zO+9+Tc1yroyYEg7Iw67Q
         mdvzvwdKryKZCTXpCbBqey3um5p98oRB+AT5IcKx2uV+X8vQw04pIW1R4R7TVgr2Ix
         UbWVsg2689l8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BB6F4034E; Thu, 24 Nov 2022 09:45:17 -0300 (-03)
Date:   Thu, 24 Nov 2022 09:45:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/15] perf stat: Fix cgroup display in JSON output
Message-ID: <Y39nXf8TkGfozIzo@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
 <20221123180208.2068936-2-namhyung@kernel.org>
 <CAP-5=fV-szgDP_QQuCHn49ZvNL6i1ZU9Wkb4bfKLavPzetqeFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV-szgDP_QQuCHn49ZvNL6i1ZU9Wkb4bfKLavPzetqeFA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 23, 2022 at 03:20:12PM -0800, Ian Rogers escreveu:
> On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It missed the 'else' keyword after checking json output mode.
> >
> > Fixes: 41cb875242e7 ("perf stat: Split print_cgroup() function")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied the series.

- Arnaldo
