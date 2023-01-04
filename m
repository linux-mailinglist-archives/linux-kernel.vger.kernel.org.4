Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58165D7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjADQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjADQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:03:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EF02E1;
        Wed,  4 Jan 2023 08:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A137CB815C3;
        Wed,  4 Jan 2023 16:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA15AC433EF;
        Wed,  4 Jan 2023 16:03:26 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:03:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, revest@chromium.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ftrace: Export ftrace_free_filter() to modules
Message-ID: <20230104110323.166d44fa@gandalf.local.home>
In-Reply-To: <Y7WbiBXwdhwCMrEz@FVFF77S0Q05N>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
        <20230103124912.2948963-3-mark.rutland@arm.com>
        <20230104235149.2416d0b57f6fba0f2f31ba77@kernel.org>
        <Y7WbiBXwdhwCMrEz@FVFF77S0Q05N>
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

On Wed, 4 Jan 2023 15:30:16 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thanks!  
> 
> Thanks!
> 
> Assuming Steve is also happy with the series, I assume one of you two will pick
> this up and fold those in.
> 
> I've folded all those tags in my local branch (and pushed that to my
> ftrace/ops-sample branch on kernel.org), so if you'd prefer I post a v3 with
> those I'm quite happy to do so.

I was planning on looking at this today.

No need to post new patches for tags, that's easy to add. I only care about
code changes for new patches.

-- Steve
