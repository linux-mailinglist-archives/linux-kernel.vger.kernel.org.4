Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09E701416
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbjEMC5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMC5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C003C3D;
        Fri, 12 May 2023 19:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B415361ED3;
        Sat, 13 May 2023 02:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D739EC433D2;
        Sat, 13 May 2023 02:57:29 +0000 (UTC)
Date:   Fri, 12 May 2023 22:57:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, mark.rutland@arm.com,
        guoren@kernel.org, e.shatokhin@yadro.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V8 4/4] samples: ftrace: Add riscv support for
 SAMPLE_FTRACE_DIRECT[_MULTI]
Message-ID: <20230512225728.7b26caa1@rorschach.local.home>
In-Reply-To: <20230324033342.3177979-5-suagrfillet@gmail.com>
References: <20230324033342.3177979-1-suagrfillet@gmail.com>
        <20230324033342.3177979-5-suagrfillet@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 11:33:42 +0800
Song Shuai <suagrfillet@gmail.com> wrote:

> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> the ftrace-direct*.c files in samples/ftrace/.
> 
> Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 33 +++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 39 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 23 ++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 22 ++++++++++++

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I'm assuming this will go through the RISCV tree.

-- Steve

>  6 files changed, 145 insertions(+)

