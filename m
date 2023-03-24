Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F76C7548
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCXCAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354418B1C;
        Thu, 23 Mar 2023 19:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B136292E;
        Fri, 24 Mar 2023 02:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F1CC433EF;
        Fri, 24 Mar 2023 02:00:44 +0000 (UTC)
Date:   Thu, 23 Mar 2023 22:00:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, jolsa@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/7] Refactor ftrace direct call APIs
Message-ID: <20230323220042.40ec4904@gandalf.local.home>
In-Reply-To: <20230323194355.3f714774@gandalf.local.home>
References: <20230321140424.345218-1-revest@chromium.org>
        <20230323194355.3f714774@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 19:43:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Since that commit only contains the updates for the direct trampolines that
> ARM64 needs, and I'm not going to rebase that branch, you can just merge it
> into the ARM64 tree so that you can base your changes on it. Make sure you
> merge that commit, not the branch, as I have more tracing specific patches
> on top of that commit.

I just made it easier for you. I created a signed tag: trace-direct-v6.3-rc3

So just pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

tag: trace-direct-v6.3-rc3

-- Steve
