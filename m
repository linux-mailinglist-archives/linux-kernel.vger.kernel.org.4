Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33B652649
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiLTSb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiLTSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A111DDE8;
        Tue, 20 Dec 2022 10:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9893361545;
        Tue, 20 Dec 2022 18:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC244C433D2;
        Tue, 20 Dec 2022 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671561077;
        bh=wfmGCuyQlVuAtk9Pjs3AE2rADCytSf8FXTcgm3KCAN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVKIDOgx0RzrxmyJ/0GRGeF6NplLGMY29uzAflPCGbrFEQNac9J/wPDpSmRxk6yo9
         nZIzKbub8syX1uEmhMq7Dp5bcVmUbM7JxrIL3Gzu6DO5+M/YNb1z4iqBhs+l5Cj7h1
         XN+YVXbLtdDcdrtcrle6IEsBbbvQRd/61v5uvO3CpTU/aRpkOrUE1zE/kJUVsQYqt6
         XL48Bw7vpTE+CFrnm9fr6vgSl9bfeYyLHppjuPYyx0rpIpXjpoGKbgNTH4jN0Qfz7/
         REl3d36dSDVvDkWxCU6eSJ6ML+mF5+k+EWlumx6Xxa07uVwVYK/3LVMEFCgmDx7rqN
         TH9Z87HzjS8kg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 819E140367; Tue, 20 Dec 2022 15:31:14 -0300 (-03)
Date:   Tue, 20 Dec 2022 15:31:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] perf: makefile: add .DELETE_ON_ERROR special target
Message-ID: <Y6H/cvw5QIIspqh/@kernel.org>
References: <20221217225151.90387-1-changbin.du@gmail.com>
 <Y6EWpXikuoxLnajU@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6EWpXikuoxLnajU@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 20, 2022 at 09:57:57AM +0800, Leo Yan escreveu:
> On Sun, Dec 18, 2022 at 06:51:51AM +0800, Changbin Du wrote:
> > As kbuild, this adds .DELETE_ON_ERROR special target to clean up
> > partially updated files on error. A known issue is the empty vmlinux.h
> > generted by bpftool if it failed to dump btf info.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

