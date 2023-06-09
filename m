Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438A729571
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbjFIJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbjFIJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577A5270;
        Fri,  9 Jun 2023 02:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83E72655F0;
        Fri,  9 Jun 2023 09:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F6BC433EF;
        Fri,  9 Jun 2023 09:31:22 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:31:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, rmk+kernel@armlinux.org.uk,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
        hpa@zytor.com, chenhuacai@kernel.org, zhangqing@loongson.cn,
        kernel@xen0n.name, mingo@redhat.com, peterz@infradead.org,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/8] arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Message-ID: <ZILxZ6wrYUnnxT/E@arm.com>
References: <cover.1680954589.git.pengdonglin@sangfor.com.cn>
 <c78366416ce93f704ae7000c4ee60eb4258c38f7.1680954589.git.pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78366416ce93f704ae7000c4ee60eb4258c38f7.1680954589.git.pengdonglin@sangfor.com.cn>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 05:42:18AM -0700, Donglin Peng wrote:
> The previous patch ("function_graph: Support recording and printing
> the return value of function") has laid the groundwork for the for
> the funcgraph-retval, and this modification makes it available on
> the ARM64 platform.
> 
> We introduce a new structure called fgraph_ret_regs for the ARM64
> platform to hold return registers and the frame pointer. We then
> fill its content in the return_to_handler and pass its address to
> the function ftrace_return_to_handler to record the return value.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>

We fully trust Mark's reviews ;) but just in case you need an official
maintainer ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
