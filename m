Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845366767A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjAURZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAURZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:25:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32718B0E;
        Sat, 21 Jan 2023 09:25:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8532D60B4B;
        Sat, 21 Jan 2023 17:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF49C433D2;
        Sat, 21 Jan 2023 17:25:21 +0000 (UTC)
Date:   Sat, 21 Jan 2023 12:25:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Documentation: kprobetrace: Fix some typos
Message-ID: <20230121122519.17eebdc9@gandalf.local.home>
In-Reply-To: <20230121143110.1706962-1-yoann.congal@smile.fr>
References: <20230121142242.1706081-1-yoann.congal@smile.fr>
        <20230121143110.1706962-1-yoann.congal@smile.fr>
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

On Sat, 21 Jan 2023 15:31:08 +0100
Yoann Congal <yoann.congal@smile.fr> wrote:

> @@ -76,14 +76,15 @@ or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
>  x86-64 uses x64).
>  These value types can be an array. To record array data, you can add '[N]'
>  (where N is a fixed number, less than 64) to the base type.
> -E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
> +E.g. 'x16[4]' means an array of x16 (2-bytes hex) with 4 elements.

As we are correcting this, let's correct it correctly ;-)

Adjectives do not turn into plurals. It's "2-byte hex" not "2-bytes hex".

Thanks,

-- Steve


>  Note that the array can be applied to memory type fetchargs, you can not
>  apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
>  wrong, but '+8($stack):x8[8]' is OK.)
>  String type is a special type, which fetches a "null-terminated" string from
>  kernel space. This means it will fail and store NULL if the string container
>  has been paged out. "ustring" type is an alternative of string for user-space.
> -See :ref:`user_mem_access` for more info..
> +See :ref:`user_mem_access` for more info.
> +
>  The string array type is a bit different from other types. For other base
>  types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
>  as +0(%di):x32.) But string[1] is not equal to string. The string type itself
> @@ -120,8 +121,8 @@ space. 'ustring' is a shortcut way of performing the same task. That is,
>  
>  Note that kprobe-event provides the user-memory access syntax but it doesn't
>  use it transparently. This means if you use normal dereference or string type
> -for user memory, it might fail, and may always fail on some archs. The user
> -has to carefully check if the target data is in kernel or user space.
> +for user memory, it might fail, and may always fail on some architectures. The
> +user has to carefully check if the target data is in kernel or user space.
>  
>  Per-Probe Event Filtering
>  -------------------------
> -- 
