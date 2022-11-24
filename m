Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A0637FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKXT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:28:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE325C73
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4454862229
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D50C433D6;
        Thu, 24 Nov 2022 19:28:21 +0000 (UTC)
Date:   Thu, 24 Nov 2022 14:28:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [for-next][PATCH 05/11] tracing/osnoise: Add osnoise/options
 file
Message-ID: <20221124142819.44aeaed2@gandalf.local.home>
In-Reply-To: <8cc1c8a0-7d2c-e653-2ab9-40d040eebbb3@kernel.org>
References: <20221124145019.782980678@goodmis.org>
        <20221124145046.156919074@goodmis.org>
        <8cc1c8a0-7d2c-e653-2ab9-40d040eebbb3@kernel.org>
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

On Thu, 24 Nov 2022 18:31:22 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Hi Steve,

Hi Daniel,

> 
> Yesterday I sent a v2 of this patch series, adding some more options [1].

Heh, it came in the window of me triaging my patch queue and running my
tests.

> 
> But as you already queued these, and as there is no real difference from the
> v1 and v2 in these code patches, I think the best way is for me to send a v3
> with the additional patches, build on top of the ftrace/core.
> 
> (Is it a bad idea? let me know :-))

Just send patches on top, as these already went through testing, and I
don't want to rebase the branch.

Thanks!

-- Steve
