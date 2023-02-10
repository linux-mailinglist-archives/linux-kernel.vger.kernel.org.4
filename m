Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40E692963
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjBJVh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjBJVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:37:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64A658C1;
        Fri, 10 Feb 2023 13:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47BE561E9C;
        Fri, 10 Feb 2023 21:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D8AC433EF;
        Fri, 10 Feb 2023 21:37:22 +0000 (UTC)
Date:   Fri, 10 Feb 2023 16:37:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 19/24] Documentation: tools/rtla: correct spelling
Message-ID: <20230210163719.0a2a20e2@gandalf.local.home>
In-Reply-To: <20230209071400.31476-20-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
        <20230209071400.31476-20-rdunlap@infradead.org>
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

On Wed,  8 Feb 2023 23:13:55 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Correct spelling problems for Documentation/tools/rtla/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-trace-devel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/tools/rtla/rtla-timerlat-top.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
> --- a/Documentation/tools/rtla/rtla-timerlat-top.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
> @@ -128,7 +128,7 @@ and then when the *timerlat* thread was
>  then be used as the starting point of a more fine-grained analysis.
>  
>  Note that **rtla timerlat** was dispatched without changing *timerlat* tracer
> -threads' priority. That is generally not needed because these threads hava
> +threads' priority. That is generally not needed because these threads have
>  priority *FIFO:95* by default, which is a common priority used by real-time
>  kernel developers to analyze scheduling delays.
>  

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
