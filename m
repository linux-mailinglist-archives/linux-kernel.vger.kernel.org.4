Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD47615B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKBEnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBEng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34FD8D;
        Tue,  1 Nov 2022 21:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700B961799;
        Wed,  2 Nov 2022 04:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0FCC433D6;
        Wed,  2 Nov 2022 04:43:33 +0000 (UTC)
Date:   Wed, 2 Nov 2022 00:43:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221102004331.2181b9a7@rorschach.local.home>
In-Reply-To: <20221101230716.22c7b52728990f6b192795c0@kernel.org>
References: <20221101064146.69551-1-lihuafei1@huawei.com>
        <20221101230716.22c7b52728990f6b192795c0@kernel.org>
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

On Tue, 1 Nov 2022 23:07:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> But I'm not sure what commit this is fixed. Maybe commit a4c35ed24112
> ("ftrace: Fix synchronization location disabling and freeing ftrace_ops").
> Steve, can you add Fixed: ?

I'll take a deeper look at this when lore and vger start talking
together and it shows up on patchwork :-/

-- Steve
