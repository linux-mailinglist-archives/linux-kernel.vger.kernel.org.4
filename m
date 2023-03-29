Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94BB6CD977
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC2MjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjC2MjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798349D5;
        Wed, 29 Mar 2023 05:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B8DB61CDE;
        Wed, 29 Mar 2023 12:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA7C433D2;
        Wed, 29 Mar 2023 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680093554;
        bh=nPaKhtIYesO46HY2QS1NeA6vtt1FAYgHFmEMunGB8IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOJi7qd9K7GS61grFmdjpnUmvE60jk9jOEHxXY7plG60Ga0ttExs7A9F4uSKCfjDn
         mBmstFF6nPRyJqXSBf3yHErX2GRBgop2790JHtF0baZAWH1OW8r1a1/OaxMvIflghJ
         6nx2ShjisVX3H1nzOa+WU3zl9B5pMj//k5KSI5PRRlO4l2+cs3HWtKK2mr8MY1YHDl
         hYNpfosRRegx8KtOmB0nr/Hc70s6IKbg3ylHXDSTIzBOdSSzyPyiZHXpfPs2Vplmy+
         hBhqXvxLR123ovROgatKxdRVgyja5UJry23gRzWHL4VVQHysWQql5ud6theqG+ExfN
         3S09HmFNhHsSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53DAC4052D; Wed, 29 Mar 2023 09:39:11 -0300 (-03)
Date:   Wed, 29 Mar 2023 09:39:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Address fixes
Message-ID: <ZCQxbxVmUtiCi09I@kernel.org>
References: <20230316194156.8320-1-adrian.hunter@intel.com>
 <1e2d77df-da40-0a06-0401-e15af96fe811@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2d77df-da40-0a06-0401-e15af96fe811@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 08:07:42AM +0300, Adrian Hunter escreveu:
> On 16/03/23 21:41, Adrian Hunter wrote:
> > Hi
> > 
> > Here are 3 small fixes resulting from a report from a
> > kernel test robot:
> > 
> > https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
> > 
> > Issues were revealed due to the use of build
> > option:
> > 
> > 	EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"
> > 
> > 
> > Adrian Hunter (3):
> >       perf symbols: Fix use-after-free in get_plt_got_name()
> >       perf symbols: Fix unaligned access in get_x86_64_plt_disp()
> >       perf tools: Avoid warning in do_realloc_array_as_needed()
> > 
> >  tools/perf/util/symbol-elf.c | 10 ++++++++--
> >  tools/perf/util/util.c       |  3 ++-
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> These seem to be still outstanding.

Thanks for the reminder, applied.

- Arnaldo

