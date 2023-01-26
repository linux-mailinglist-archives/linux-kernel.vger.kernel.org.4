Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567B67D42E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjAZS2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAZS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:28:54 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909F4223;
        Thu, 26 Jan 2023 10:28:40 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CCF58381;
        Thu, 26 Jan 2023 18:28:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CCF58381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674757720; bh=2cXOpmydo6IbnqPWfG54GoA7mCmCJ+XaUATvFmJ7/jo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dBrEs2Ewou/LckVBWbyt+0rmPcdu6S/rA0cMbmqGMoWyLKj7ok63SFcCiDM87xWXc
         hyccUY9h3IXee/dw1/ojDC+Smu+I9frIGT2mXYOoD3AfXCJ9U2DzDvGtwTQ/I1QvEh
         XHhVk+HVZ/QNC1j8ycUzhNXXYFexNiAVO0YBvyUV/T3XFTXkNFVrEdwWZgkUyuFhrN
         Ppge+OGkqvrkzWZaH84FZNN7E6+syu/bvjqVfPFvaJf7KQKK72wqNlY1hl2LgBaZTU
         pGrT9KsA4pm5ikhi38zhqx+cUCkXkdml0XTOJz9pm7egt/nfmJfzi1oHGG8i0xXQa/
         tDpaZ0o2MmugQ==
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
Date:   Thu, 26 Jan 2023 11:28:38 -0700
Message-ID: <87a6259mll.fsf@meer.lwn.net>
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

So this seems like a good cleanup to me.  Unless somebody objects, I'll
apply it to the docs tree in the near future.

Thanks,

jon
