Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE71602E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJROYQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Oct 2022 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJROYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BEF1E715;
        Tue, 18 Oct 2022 07:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 693A1B81BE1;
        Tue, 18 Oct 2022 14:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C117C433C1;
        Tue, 18 Oct 2022 14:24:08 +0000 (UTC)
Date:   Tue, 18 Oct 2022 10:24:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: Add trace events for rate requests
Message-ID: <20221018102409.594be3e4@gandalf.local.home>
In-Reply-To: <20221018-clk-rate-request-tracing-v1-2-6f3aa0b0b9de@cerno.tech>
References: <20221018-clk-rate-request-tracing-v1-0-6f3aa0b0b9de@cerno.tech>
        <20221018-clk-rate-request-tracing-v1-2-6f3aa0b0b9de@cerno.tech>
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

On Tue, 18 Oct 2022 15:56:42 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> It is currently fairly difficult to follow what clk_rate_request are
> issued, and how they have been modified once done.
> 
> Indeed, there's multiple paths that can be taken, some functions are
> recursive and will just forward the request to its parent, etc.
> 
> Adding a lot of debug prints is just not very convenient, so let's add
> trace events for the clock requests, one before they are submitted and
> one after they are returned.
> 
> That way we can simply toggle the tracing on without modifying the
> kernel code and without affecting performances or the kernel logs too
> much.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

From a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/clk/clk.c          | 31 +++++++++++++++++++++++++++++++
>  include/trace/events/clk.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)

