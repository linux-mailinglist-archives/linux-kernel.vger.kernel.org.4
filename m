Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89DF64AAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiLLW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiLLW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:56:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB77616F;
        Mon, 12 Dec 2022 14:56:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BFA5B80E9E;
        Mon, 12 Dec 2022 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E324C433F0;
        Mon, 12 Dec 2022 22:56:43 +0000 (UTC)
Date:   Mon, 12 Dec 2022 17:56:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-ID: <20221212175642.77cba577@gandalf.local.home>
In-Reply-To: <20221213085200.772ddd94@canb.auug.org.au>
References: <20221213085200.772ddd94@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 08:52:00 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commits
> 
>   fff1787adaee ("trace/kprobe: remove duplicated calls of ring_buffer_event_data")
>   8c2b99790196 ("tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'")
>   ccf47f5cc4ce ("tracing: Add nohitcount option for suppressing display of raw hitcount")
>   a2c54256dec7 ("tracing: Add .graph suffix option to histogram value")
>   abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
>   5f2e094ed259 ("tracing: Allow multiple hitcount values in histograms")
> 
> are missing a Signed-off-by from their committers.
> 

Bah, not sure how this happened. I thought I pulled these patches directly
from Masami. Does a rebase change the committer tags? As I probably rebased
them on top of my branch.

-- Steve
