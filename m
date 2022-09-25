Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726165E91F3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIYJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 05:56:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE732EEB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 02:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78F8DCE0BB0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8342FC433C1;
        Sun, 25 Sep 2022 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664099795;
        bh=m5ZvaOY1yNIGujLkDMj9U05VMTl6/h4zxsF9bxZObFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcJrbxOjw+FvjJN38b1OZUgznru2uPnxI+odurUM8zH73fiXkSauXV+aIi5jviBAE
         bsbcrtKuVJS0M6+ZEx3C8zVwPfQXWv3mJkcpls3Fg1vtzJBVgUIcUGp+VqCQxtemaa
         4mFDd1qQTQWoU0A2nelVn72rRlji1N62P3Usnr2uu9SFWkmVKplZN6HWUh6qvfdi0o
         ZqSaDyeKEU7OBr/UxojjAyDIcn8UtmgoG7TGQdJbV0vcVi2e0YMJTi8vEZCgAergcc
         zhjmMpmYJ2mBTRvwKmzv4gn+Or1IGzrsuZfjLxpt2B4P7fH8cnRpcyBPj9wBi2vR0D
         yR7b9bXQQLOkg==
Date:   Sun, 25 Sep 2022 10:56:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv/vdso: typo therefor
Message-ID: <YzAlz6BJhNC5fX/Y@spud>
References: <20220925004757.9089-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925004757.9089-1-heinrich.schuchardt@canonical.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 02:47:57AM +0200, Heinrich Schuchardt wrote:
> The adverbs 'therefor' and 'therefore' have different meaning.
> As the meaning here is 'consequently' the spelling should be 'therefore'.

Heh, had to go look that one up!
https://www.grammarly.com/blog/therefore-vs-therefor/

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/include/asm/vdso.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index af981426fe0f..a7644f46d0e5 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -10,7 +10,7 @@
>  
>  /*
>   * All systems with an MMU have a VDSO, but systems without an MMU don't
> - * support shared libraries and therefor don't have one.
> + * support shared libraries and therefore don't have one.
>   */
>  #ifdef CONFIG_MMU
>  
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
