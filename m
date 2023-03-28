Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9A6CCDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC1XDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1XDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1182683;
        Tue, 28 Mar 2023 16:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA19DB81EEB;
        Tue, 28 Mar 2023 23:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D3C433EF;
        Tue, 28 Mar 2023 23:03:08 +0000 (UTC)
Date:   Tue, 28 Mar 2023 19:03:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     patchwork-bot+f2fs@kernel.org
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>, jaegeuk@kernel.org,
        chao@kernel.org, mhiramat@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace
 event
Message-ID: <20230328190306.3337b7b0@gandalf.local.home>
In-Reply-To: <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
        <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 17:40:24 +0000
patchwork-bot+f2fs@kernel.org wrote:

> Hello:
> 
> This patch was applied to jaegeuk/f2fs.git (dev)
> by Jaegeuk Kim <jaegeuk@kernel.org>:
> 
> On Mon,  6 Mar 2023 12:25:49 +0000 you wrote:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > Fix the nid_t field so that its size is correctly reported in the text
> > format embedded in trace.dat files. As it stands, it is reported as
> > being of size 4:
> > 
> >         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [f2fs-dev] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
>     https://git.kernel.org/jaegeuk/f2fs/c/3ccc99d5a4ea
> 
> You are awesome, thank you!

I'm hoping you are not waiting for the merge window to get this in. Please
get it to Linus before rc5 is out, because I plan on adding my patch[1]
which will cause this to fail the build at rc5.

The above is a fix to bug that causes unwanted results. Please get it into
mainline ASAP.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

-- Steve
