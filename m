Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C362E253
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiKQQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiKQQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:55:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD60AA181
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:55:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F85B82101
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9AAC433D6;
        Thu, 17 Nov 2022 16:54:57 +0000 (UTC)
Date:   Thu, 17 Nov 2022 11:54:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: kprobe: Fix potential null-ptr-deref on
 trace_array in kprobe_event_gen_test_exit()
Message-ID: <20221117115455.74de4cdc@gandalf.local.home>
In-Reply-To: <20221117161453.e1dc1c98358017d86a4d5a11@kernel.org>
References: <20221108015130.28326-1-shangxiaojing@huawei.com>
        <20221108015130.28326-3-shangxiaojing@huawei.com>
        <20221108233846.fcff734a2f4b1a2a091fb831@kernel.org>
        <20221116215536.120b0b74@gandalf.local.home>
        <20221117161453.e1dc1c98358017d86a4d5a11@kernel.org>
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

On Thu, 17 Nov 2022 16:14:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> No, I think these patches are already queued on probes/urgent :)
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/trace/linux-trace.git/+/210880de4e3945d0ac028894df578063205bef61

Bah, for some reason, when I searched the git log of that branch, it didn't
show up :-/

-- Steve
