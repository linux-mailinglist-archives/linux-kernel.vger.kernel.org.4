Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873463B21C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiK1TVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiK1TV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:21:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21321176
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:21:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E69FB80FA1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2A6C433C1;
        Mon, 28 Nov 2022 19:21:25 +0000 (UTC)
Date:   Mon, 28 Nov 2022 14:21:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix check for probe enabled in kill_kprobe()
Message-ID: <20221128142123.5b5570bc@gandalf.local.home>
In-Reply-To: <20221128174843.244d5485156daf53b6406482@kernel.org>
References: <20221126114316.201857-1-lihuafei1@huawei.com>
        <20221128174843.244d5485156daf53b6406482@kernel.org>
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

On Mon, 28 Nov 2022 17:48:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 26 Nov 2022 19:43:16 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
> > In kill_kprobe(), the check whether disarm_kprobe_ftrace() needs to be
> > called always fails. This is because before that we set the
> > KPROBE_FLAG_GONE flag for kprobe so that "!kprobe_disabled(p)" is always
> > false.  
> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you!

Looks good.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
