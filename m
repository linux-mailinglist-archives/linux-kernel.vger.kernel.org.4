Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245E69D616
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjBTWBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBTWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:01:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA90222D5;
        Mon, 20 Feb 2023 14:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EF160F2F;
        Mon, 20 Feb 2023 22:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863D7C4339B;
        Mon, 20 Feb 2023 22:01:37 +0000 (UTC)
Date:   Mon, 20 Feb 2023 17:01:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] tracing/user_events: Remote write ABI
Message-ID: <20230220170135.3c9bea01@rorschach.local.home>
In-Reply-To: <20230120230518.17697-1-beaub@linux.microsoft.com>
References: <20230120230518.17697-1-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 15:05:07 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:


>  Documentation/trace/user_events.rst           | 177 ++--
>  fs/exec.c                                     |   2 +
>  include/linux/sched.h                         |   5 +
>  include/linux/user_events.h                   | 101 +-
>  include/uapi/linux/user_events.h              |  81 ++
>  kernel/exit.c                                 |   2 +
>  kernel/fork.c                                 |   2 +

There's several files that are touched outside of the tracing
subsystem. You may need to run get_maintainers on this to get their
input. I started playing a little with this, but it won't mean anything
if we get push back from these maintainers.

-- Steve


>  kernel/trace/Kconfig                          |   5 +-
>  kernel/trace/trace_events_user.c              | 863 +++++++++++++++---
>  samples/user_events/example.c                 |  47 +-
>  tools/testing/selftests/user_events/Makefile  |   2 +-
>  .../testing/selftests/user_events/abi_test.c  | 226 +++++
>  .../testing/selftests/user_events/dyn_test.c  |   2 +-
>  .../selftests/user_events/ftrace_test.c       | 162 ++--
>  .../testing/selftests/user_events/perf_test.c |  39 +-
>  15 files changed, 1317 insertions(+), 399 deletions(-)
>  create mode 100644 include/uapi/linux/user_events.h
>  create mode 100644 tools/testing/selftests/user_events/abi_test.c
> 
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

