Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A185B682314
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjAaD6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAaD6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:58:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3F222F0;
        Mon, 30 Jan 2023 19:58:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D4061388;
        Tue, 31 Jan 2023 03:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D588C433EF;
        Tue, 31 Jan 2023 03:58:08 +0000 (UTC)
Date:   Mon, 30 Jan 2023 22:58:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] trace: acquire buffer from temparary trace sequence
Message-ID: <20230130225807.54446779@gandalf.local.home>
In-Reply-To: <5f37bdef-5447-8def-7bb0-a498879abc4c@quicinc.com>
References: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
        <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
        <20230130143041.713c4c7b@gandalf.local.home>
        <e2735a3a-4a9b-8b3a-0671-b3f56187cbe2@quicinc.com>
        <20230130213735.72cdcee4@gandalf.local.home>
        <5f37bdef-5447-8def-7bb0-a498879abc4c@quicinc.com>
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

On Tue, 31 Jan 2023 10:49:37 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> > A lot of systems that worry about hackers enable "panic_on_warn" which
> > means that if the WARN_ON() triggers, the machine will crash, which will at
> > most cause a DOS, but not something people can use to hack into the machine
> > with.  
> 
> 
> thanks, please help review the change.

I'm fine with it. I can pull this into my tree (after it goes through all
my testing with the other patches in queue).
