Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6652266880D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjAMAAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAMAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:00:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564F59334;
        Thu, 12 Jan 2023 16:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6600621C9;
        Fri, 13 Jan 2023 00:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70176C433D2;
        Fri, 13 Jan 2023 00:00:32 +0000 (UTC)
Date:   Thu, 12 Jan 2023 19:00:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] tracing: Add trace_array_puts() to write into
 instance
Message-ID: <20230112190030.0c1fc121@gandalf.local.home>
In-Reply-To: <Y8CXI1h9hsPeiu6u@google.com>
References: <20230111145636.450953217@goodmis.org>
        <20230111145842.694147820@goodmis.org>
        <Y8CXI1h9hsPeiu6u@google.com>
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

On Thu, 12 Jan 2023 16:26:27 -0700
Ross Zwisler <zwisler@google.com> wrote:

> > +/**
> > + * trace_array_puts - write a constant string into the trace buffer.
> > + * @tr:    The trace array to write to
> > + * @ip:	   The address of the caller  
> 
> @ip is not an arg to trace_array_puts(), an can be dropped from the comment.

Good catch.

My first version had it, and then I realized I didn't like it (to be in
sync with the internal version of __trace_puts()". But I forgot to update
the kernel doc. Thanks for pointing that out.

> 
> Other than that, you can add:
> 
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Thanks,

-- Steve
