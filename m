Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF528634A44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiKVWvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVWvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:51:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED746BDEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3783F61934
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0985C433C1;
        Tue, 22 Nov 2022 22:51:14 +0000 (UTC)
Date:   Tue, 22 Nov 2022 17:51:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 RESEND 2/9] LoongArch/ftrace: Add recordmcount
 support
Message-ID: <20221122175112.513531bd@gandalf.local.home>
In-Reply-To: <20221116082338.5145-3-zhangqing@loongson.cn>
References: <20221116082338.5145-1-zhangqing@loongson.cn>
        <20221116082338.5145-3-zhangqing@loongson.cn>
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

On Wed, 16 Nov 2022 16:23:31 +0800
Qing Zhang <zhangqing@loongson.cn> wrote:

> Recordmcount utility under scripts is run, after compiling each object,
> to find out all the locations of calling _mcount() and put them into
> specific seciton named __mcount_loc.
> Then linker collects all such information into a table in the kernel image
> (between __start_mcount_loc and __stop_mcount_loc) for later use by ftrace.
> 
> This patch adds loongarch specific definitions to identify such locations.
> On loongarch, only C version is used to build the kernel now that
> CONFIG_HAVE_C_RECORDMCOUNT is on.
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig |  2 ++
>  scripts/recordmcount.c | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
