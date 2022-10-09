Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31BF5F8B1E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJIMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJIMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:15:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873DD167D8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D761B80B98
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 12:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94930C433C1;
        Sun,  9 Oct 2022 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317696;
        bh=WciH6tNrDqXfLYWE0rrHdkoSqbQhPHlMKemmVdnXz9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biOwjMEvHuSIE8NarhntzD8o+TDadoik5XJpctzSEsicXDUIcdMF8Gyv693Mq+IVI
         z0AeKokLzZa0ug1Re1I7QehaU+dV4i27Twdu6i2oTzhFBvHy8Rd/m60PD06HnrYeDS
         anopKXF1bU6SvoeJa425Q3azSAiXTz0HRn2EzKdH3+OfseSOYY6L7GPR3dwm4clRhg
         UvjGVsDIpFiR/2riMRDuRpt7fBI8ZPuWRe9QHounnv7Yb7II56JK0e9ykxPepdXpEp
         Ykdyx7ne7aUA+er5Fd8X3FjLK/VKWKO5K+rm0TkucM/HUzCbg5YCbkk9mREv/SG0lV
         7NK+IgROko+bQ==
Date:   Sun, 9 Oct 2022 13:14:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Cleo John <waterdev@galaxycrow.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed styling in riscv ucontext header
Message-ID: <Y0K7PDzwuOPweYSm@spud>
References: <20221009120340.GA41243@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009120340.GA41243@watet-ms7b87>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Cleo,

On Sun, Oct 09, 2022 at 02:03:40PM +0200, Cleo John wrote:
> Fixed styling in riscv ucontext header

This should probably be "riscv: fix styling..."

> This patch changes the two comments in ucontext.h by getting them up to the cody style proposed by torwalds. 

s/This patch changes/Change

Looks like some typos here too & your lines need to be wrapped at 72
characters for commit messages. git usually enforces that automatically
when you do a `git commit`.

> In my opinion this also improves the readability so I think this is a useful change to do.
> Please also tell me if you have a different opinion.

FYI commentary on the patch should go below the ---.

> 
> Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> ---
>  arch/riscv/include/uapi/asm/ucontext.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
> index 44eb993950e5..0cd6f8616985 100644
> --- a/arch/riscv/include/uapi/asm/ucontext.h
> +++ b/arch/riscv/include/uapi/asm/ucontext.h
> @@ -18,7 +18,8 @@ struct ucontext {
>  	/* There's some padding here to allow sigset_t to be expanded in the

Why fix the closing comment but leave the opening ones incorrect?

Thanks,
Conor.

>  	 * future.  Though this is unlikely, other architectures put uc_sigmask
>  	 * at the end of this structure and explicitly state it can be
> -	 * expanded, so we didn't want to box ourselves in here. */
> +	 * expanded, so we didn't want to box ourselves in here.
> +	 */
>  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
>  	/* We can't put uc_sigmask at the end of this structure because we need
>  	 * to be able to expand sigcontext in the future.  For example, the
> @@ -27,7 +28,8 @@ struct ucontext {
>  	 * ucontext, so we're putting this at the end in order to allow for
>  	 * infinite extensibility.  Since we know this will be extended and we
>  	 * assume sigset_t won't be extended an extreme amount, we're
> -	 * prioritizing this. */
> +	 * prioritizing this.
> +	 */
>  	struct sigcontext uc_mcontext;
>  };
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
