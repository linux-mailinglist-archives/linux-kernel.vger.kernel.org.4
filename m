Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A766EE71C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjDYRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjDYRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091412C95;
        Tue, 25 Apr 2023 10:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADCF62F60;
        Tue, 25 Apr 2023 17:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873A1C433D2;
        Tue, 25 Apr 2023 17:48:26 +0000 (UTC)
Date:   Tue, 25 Apr 2023 13:48:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] docs: move tracing tools
Message-ID: <20230425134824.5d57c431@gandalf.local.home>
In-Reply-To: <20230425130231.912349-1-costa.shul@redhat.com>
References: <20230425130231.912349-1-costa.shul@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 16:02:30 +0300
Costa Shulyupin <costa.shul@redhat.com> wrote:

> from list of development tools to user tools
> because these tools work on running kernel
> and are invoked from user mode

Wait what? No!

The trace/ directory has a lot that is kernel internal only. Yes, it may
explain how user space can interact with it, but it's also how internal
kernel processes can use the ftrace infrastructure, and also explains a lot
of the kernel design of that code.

NACK!

-- Steve


> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/index.rst       | 1 -
>  Documentation/tools/index.rst | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..81e1af951731 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -56,7 +56,6 @@ Various other manuals with useful information for all kernel developers.
>     dev-tools/index
>     dev-tools/testing-overview
>     kernel-hacking/index
> -   trace/index
>     fault-injection/index
>     livepatch/index
>     rust/index
> diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
> index 80488e290e10..6a9a44f7f88a 100644
> --- a/Documentation/tools/index.rst
> +++ b/Documentation/tools/index.rst
> @@ -12,6 +12,7 @@ more additions are needed here:
>  
>     rtla/index
>     rv/index
> +   ../trace/index
>  
>  .. only::  subproject and html
>  

