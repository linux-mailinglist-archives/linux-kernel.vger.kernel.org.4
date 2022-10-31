Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3506134E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJaLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiJaLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:48:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A73203
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:48:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E8531FB;
        Mon, 31 Oct 2022 04:48:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.5.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3F9B3F5A1;
        Mon, 31 Oct 2022 04:48:28 -0700 (PDT)
Date:   Mon, 31 Oct 2022 11:48:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: entry: Fix typo
Message-ID: <Y1+2A7ecKZ8YG+nu@FVFF77S0Q05N>
References: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 12:37:48PM +0530, Mukesh Ojha wrote:
> Fix the following typo in entry-common.c
> intrumentable => instrumentable
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/entry-common.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 9173fad..b694d8f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -30,7 +30,7 @@
>  /*
>   * Handle IRQ/context state management when entering from kernel mode.
>   * Before this function is called it is not safe to call regular kernel code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   *
>   * This is intended to match the logic in irqentry_enter(), handling the kernel
>   * mode transitions only.
> @@ -63,7 +63,7 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when exiting to kernel mode.
>   * After this function returns it is not safe to call regular kernel code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   *
>   * This is intended to match the logic in irqentry_exit(), handling the kernel
>   * mode transitions only, and with preemption handled elsewhere.
> @@ -97,7 +97,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when entering from user mode.
>   * Before this function is called it is not safe to call regular kernel code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   */
>  static __always_inline void __enter_from_user_mode(void)
>  {
> @@ -116,7 +116,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when exiting to user mode.
>   * After this function returns it is not safe to call regular kernel code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   */
>  static __always_inline void __exit_to_user_mode(void)
>  {
> @@ -152,7 +152,7 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when entering an NMI from user/kernel
>   * mode. Before this function is called it is not safe to call regular kernel
> - * code, intrumentable code, or any code which may trigger an exception.
> + * code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_enter_nmi(struct pt_regs *regs)
>  {
> @@ -170,7 +170,7 @@ static void noinstr arm64_enter_nmi(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when exiting an NMI from user/kernel
>   * mode. After this function returns it is not safe to call regular kernel
> - * code, intrumentable code, or any code which may trigger an exception.
> + * code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_exit_nmi(struct pt_regs *regs)
>  {
> @@ -192,7 +192,7 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when entering a debug exception from
>   * kernel mode. Before this function is called it is not safe to call regular
> - * kernel code, intrumentable code, or any code which may trigger an exception.
> + * kernel code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
>  {
> @@ -207,7 +207,7 @@ static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when exiting a debug exception from
>   * kernel mode. After this function returns it is not safe to call regular
> - * kernel code, intrumentable code, or any code which may trigger an exception.
> + * kernel code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  {
> -- 
> 2.7.4
> 
