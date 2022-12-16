Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E722964EB06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiLPL5u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Dec 2022 06:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPL5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:57:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246043845
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17BD3620C2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8E5C433EF;
        Fri, 16 Dec 2022 11:57:42 +0000 (UTC)
Date:   Fri, 16 Dec 2022 06:57:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
Subject: Re: [PATCH] cma:tracing: Print alloc result in
 trace_cma_alloc_finish
Message-ID: <20221216065739.30511197@gandalf.local.home>
In-Reply-To: <4e9f9b32-7835-e4c5-55cb-9db82c98f9c1@huawei.com>
References: <20221208142130.1501195-1-haowenchao@huawei.com>
        <4e9f9b32-7835-e4c5-55cb-9db82c98f9c1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 19:47:59 +0800
Wenchao Hao <haowenchao@huawei.com> wrote:

> On 2022/12/8 22:21, Wenchao Hao wrote:
> > The result of allocation is not printed in trace_cma_alloc_finish
> > now, while it's important to do it so we can set filters to catch
> > specific error on allocation or trigger some operations on specific
> > error.
> > 
> > Although we have printed the result in log, but the log is
> > conditional and could not be filtered by tracing event.
> > 
> > What's more, it introduce little overhead to print this result.
> > The result of allocation is named as errorno in trace.
> > 
> > Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> > ---

> 
> pinging


From a tracing point of view, I see nothing wrong with it.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

But I believe Andrew needs to take it.

-- Steve
