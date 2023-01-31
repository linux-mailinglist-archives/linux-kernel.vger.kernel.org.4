Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6766838B0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAaVaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:30:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659D10DE;
        Tue, 31 Jan 2023 13:30:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34D1231A;
        Tue, 31 Jan 2023 21:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34D1231A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675200636; bh=9IVs2dCq4wVQ2FPxDzYjrro68HCOngD7XALZENWp4Qo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fAzkdRB3yhH3n+4DtyRJiVfFzwxLF7MHL/hrbEIq8zMUlpypjgB4x1CMT5ohH2tOH
         Ft5CYuMnjAmOQAZWRQR2bie+q56U0AhdfQz4wckiRmmw6KHClpc9kp8+Q/2Z2ptW81
         UcnM3Ejs00aa5oG597JR563ZqwjAjyL/QG+6E3/FlhbFYROklxSGZ8gjSS+n0xLvV7
         EBsujfyHNQdJ52nPT5wGLkuc2hbxWk443L3qwKnfqZtWgPSVPnEjXp0YscotlFAT9A
         mKeZh9FsunTansBbSNk2+USidjBw9t1TFbA10R0uEBhGuHlfP7ef7aNx8OjlezSvdy
         NhCG3Wi16hIAA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ross Zwisler <zwisler@chromium.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] docs: ftrace: always use canonical ftrace path
In-Reply-To: <20230125213251.2013791-1-zwisler@google.com>
References: <20230125213251.2013791-1-zwisler@google.com>
Date:   Tue, 31 Jan 2023 14:30:35 -0700
Message-ID: <87cz6u2xz8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Zwisler <zwisler@chromium.org> writes:

> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
>
> But, from Documentation/trace/ftrace.rst:
>
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
>
>   /sys/kernel/debug/tracing
>
> Many parts of Documentation still reference this older debugfs path, so
> let's update them to avoid confusion.
>
> Signed-off-by: Ross Zwisler <zwisler@google.com>

This is now applied, thanks.

jon
