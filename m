Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882675EAE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIZRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiIZRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E35C98753
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA36760DB7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11E0C433D6;
        Mon, 26 Sep 2022 17:20:52 +0000 (UTC)
Date:   Mon, 26 Sep 2022 13:22:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     <mingo@redhat.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <mhiramat@kernel.org>, <peterz@infradead.org>, <ast@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Remove unused declarations for x86/trace
Message-ID: <20220926132201.6aedae95@gandalf.local.home>
In-Reply-To: <20220914110437.1436353-1-cuigaosheng1@huawei.com>
References: <20220914110437.1436353-1-cuigaosheng1@huawei.com>
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

On Wed, 14 Sep 2022 19:04:35 +0800
Gaosheng Cui <cuigaosheng1@huawei.com> wrote:

> This series contains a few cleanup patches, to remove unused
> declarations which have been removed. Thanks!
> 
> Gaosheng Cui (2):
>   x86/ftrace: remove unused modifying_ftrace_code declaration
>   x86/kprobes: remove unused arch_kprobe_override_function() declaration
> 
>  arch/x86/include/asm/ftrace.h  | 1 -
>  arch/x86/include/asm/kprobes.h | 2 --
>  2 files changed, 3 deletions(-)
> 

Applied. Thanks Gaosheng!

-- Steve
