Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBD5EAFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiIZSYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiIZSX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177ECF3;
        Mon, 26 Sep 2022 11:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D1C7611CD;
        Mon, 26 Sep 2022 18:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A841C433D6;
        Mon, 26 Sep 2022 18:21:09 +0000 (UTC)
Date:   Mon, 26 Sep 2022 14:22:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs, kprobes: Fix the wrong location of Kprobes
Message-ID: <20220926142218.100e0d9b@gandalf.local.home>
In-Reply-To: <1663322106-12178-1-git-send-email-yangtiezhu@loongson.cn>
References: <1663322106-12178-1-git-send-email-yangtiezhu@loongson.cn>
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

On Fri, 16 Sep 2022 17:55:06 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> After commit 22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce
> clutter"), the location of Kprobes is under "General architecture-dependent
> options" rather than "General setup".
> 

Probably add a "Fixes:" tag for the above mentioned commit.

Anyway, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/trace/kprobes.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index f318bce..48cf778 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -328,8 +328,8 @@ Configuring Kprobes
>  ===================
>  
>  When configuring the kernel using make menuconfig/xconfig/oldconfig,
> -ensure that CONFIG_KPROBES is set to "y". Under "General setup", look
> -for "Kprobes".
> +ensure that CONFIG_KPROBES is set to "y", look for "Kprobes" under
> +"General architecture-dependent options".
>  
>  So that you can load and unload Kprobes-based instrumentation modules,
>  make sure "Loadable module support" (CONFIG_MODULES) and "Module

