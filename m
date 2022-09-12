Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156FE5B5BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiILODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiILOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:02:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAA6532B8D;
        Mon, 12 Sep 2022 07:02:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oXk1M-0007Yg-03; Mon, 12 Sep 2022 16:02:44 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3CC74C1291; Mon, 12 Sep 2022 15:41:10 +0200 (CEST)
Date:   Mon, 12 Sep 2022 15:41:10 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix comment typo
Message-ID: <20220912134110.GD9232@alpha.franken.de>
References: <20220811121450.24057-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811121450.24057-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 08:14:50PM +0800, Jason Wang wrote:
> The double `it' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/math-emu/cp1emu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 587cf1d115e8..265bc57819df 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -1032,7 +1032,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
>  	 */
>  	if (dec_insn.micro_mips_mode) {
>  		/*
> -		 * If next instruction is a 16-bit instruction, then it
> +		 * If next instruction is a 16-bit instruction, then
>  		 * it cannot be a FPU instruction. This could happen
>  		 * since we can be called for non-FPU instructions.
>  		 */
> -- 
> 2.36.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
