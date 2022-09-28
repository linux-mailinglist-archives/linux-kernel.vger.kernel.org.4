Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120005EDC83
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiI1MZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiI1MZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56C814C1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6979561D15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70834C433C1;
        Wed, 28 Sep 2022 12:25:06 +0000 (UTC)
Date:   Wed, 28 Sep 2022 08:26:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add myself as a tracing reviewer
Message-ID: <20220928082617.059ab6f2@gandalf.local.home>
In-Reply-To: <20220928114621.248038-1-mark.rutland@arm.com>
References: <20220928114621.248038-1-mark.rutland@arm.com>
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

On Wed, 28 Sep 2022 12:46:21 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Since I'm actively involved in a number of arch bits that intersect
> ftrace (e.g. the actual arch implementation on arm64, stacktracing,
> entry management, and general instrumentation safety), add myself as a
> reviewer of the core ftrace code so that I have the change to catch any
> potential problems early.
> 
> I spoke with Steven about this at LPC, and it seemed to make sense to
> add me as a reviewer.
> 

I have no issues with this. I'll pull it into my queue.

Thanks Mark!

-- Steve

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56ff555ed5a4b..945d4130a1a2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20615,6 +20615,7 @@ F:	drivers/char/tpm/
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Ingo Molnar <mingo@redhat.com>
> +R:	Mark Rutland <mark.rutland@arm.com>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>  F:	Documentation/trace/ftrace.rst

