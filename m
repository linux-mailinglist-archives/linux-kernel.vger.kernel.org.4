Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEA602F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJRPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJRPWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC09D01AA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5EBE615CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78834C433C1;
        Tue, 18 Oct 2022 15:22:23 +0000 (UTC)
Date:   Tue, 18 Oct 2022 11:22:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
Message-ID: <20221018112224.372a3484@gandalf.local.home>
In-Reply-To: <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
        <20221017105103.540a87c7@gandalf.local.home>
        <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
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

On Wed, 19 Oct 2022 00:19:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > You need to make sure that the "pause-on-trace" option is set or tracing_on
> > is set to 0 (disabled). Otherwise, if the tracing is still active, then the
> > reading of the trace file could potentially never end.  
> 
> initialize_ftrace() does this setting. So it must be set.
> If you run the ftracetest on old kernel, this feature is not there and
> it may cause a trouble. Naveen, can you clarify it?

But for old kernels that do not have "pause-on-trace" it should be the
default. The "pause-on-trace" was added when the default was changed to not
pause the trace while reading it.

-- Steve
