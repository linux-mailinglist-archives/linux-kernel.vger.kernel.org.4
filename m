Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05F5FA3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJSvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:51:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED66C760
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6224B810BD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E6CC433D6;
        Mon, 10 Oct 2022 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665427860;
        bh=N5QrBTmFnyH8xUhHqZQhuPDkgjqzP+EJBJyGyVpO7xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX4kLR7VLMCIqktJr4p7CbiD1V4erh7c3CJL8lG7LZAUiOwugl898pvsuXCIpkiDo
         o+IpElOmPEwrpcNJxByELqokCtfI7Hc26oWEGPTcKudBNDm+yMxQsszcNwAFWcnhrY
         /ibJMUmsQhnYW+jSklSbQFiwfbmB7QgPgo/JV7ktv6EC+Kr3aUiZR7D51DeI51+6uY
         aOCKMYWY4W+odHniiWEHktFZSQVDUS03mk9/TMl5Em+H4sD3sxe6k8agisLZD0lGJt
         /sgaiB0PAV5ILzSWpUIK3GP/WltxqFn8QJVr3PqZ8gU62Hq17sUWVo+65/wknQ4dfQ
         jJfYHvcGijW4A==
Date:   Mon, 10 Oct 2022 19:50:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Cleo John <waterdev@galaxycrow.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: fix styling in ucontext header
Message-ID: <Y0RpkI66dwEKD9Kw@spud>
References: <20221010182848.GA28029@watet-ms7b87>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010182848.GA28029@watet-ms7b87>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 08:28:48PM +0200, Cleo John wrote:
> Change the two comments in ucontext.h by getting them up to
> the coding style proposed by torvalds.
> 
> Signed-off-by: Cleo John <waterdev@galaxycrow.de>
> ---
> In my opinion this also improves the readability so I think this is a useful change to do.
> Please also tell me if you have a different opinion.

I don't think it is all that /important/ of a change, but it does make
things match between this file and the other headers.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks.

> 
> Changes in v2:
>  - change the styling of the top comments too
> 
>  arch/riscv/include/uapi/asm/ucontext.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
> index 44eb993950e5..516bd0bb0da5 100644
> --- a/arch/riscv/include/uapi/asm/ucontext.h
> +++ b/arch/riscv/include/uapi/asm/ucontext.h
> @@ -15,19 +15,23 @@ struct ucontext {
>  	struct ucontext	 *uc_link;
>  	stack_t		  uc_stack;
>  	sigset_t	  uc_sigmask;
> -	/* There's some padding here to allow sigset_t to be expanded in the
> +	/*
> +	 * There's some padding here to allow sigset_t to be expanded in the
>  	 * future.  Though this is unlikely, other architectures put uc_sigmask
>  	 * at the end of this structure and explicitly state it can be
> -	 * expanded, so we didn't want to box ourselves in here. */
> +	 * expanded, so we didn't want to box ourselves in here.
> +	 */
>  	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> -	/* We can't put uc_sigmask at the end of this structure because we need
> +	/*
> +	 * We can't put uc_sigmask at the end of this structure because we need
>  	 * to be able to expand sigcontext in the future.  For example, the
>  	 * vector ISA extension will almost certainly add ISA state.  We want
>  	 * to ensure all user-visible ISA state can be saved and restored via a
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
