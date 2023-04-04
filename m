Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB86D6DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjDDUWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjDDUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5C4205
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DFB63001
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 20:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE0C433D2;
        Tue,  4 Apr 2023 20:22:42 +0000 (UTC)
Date:   Tue, 4 Apr 2023 16:22:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] tracepoint: Fix CFI failures with tp_sub_func
Message-ID: <20230404162232.1b2f4c2f@gandalf.local.home>
In-Reply-To: <ZCwDAnRHjNr9ZftR@FVFF77S0Q05N>
References: <20230324123142.7463-1-mathieu.desnoyers@efficios.com>
        <75dbeff6-fd0c-aec1-5821-919088eda6c4@efficios.com>
        <ZCwDAnRHjNr9ZftR@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 11:59:26 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Sorry to ping, but are you planning to pick this up, and/or did you want this
> resent with the Testing-by typo fixed?
> 
> I couldn't spot it in the tracing tree, and I'm not sure if it's still on your
> TODO list for review or has just been missed.

Actually, we may be going back to your original patches, as having a stub
function for every trace event will allow us to attach fprobes to them. And
we actually have a need to do that (connecting to tracepoints to get more
info than the trace event gives).

Masami is currently working on this.

-- Steve
