Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A718701CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjENJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjENJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD7E2107
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1746C61161
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2889C433EF;
        Sun, 14 May 2023 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684057593;
        bh=wGeoCKdWcLNGSz8WoWm3Y/aAAFpiDlIXI/v9WFuO9SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mp3GBAf3LzDUamiCidb3P3OlJifz+RcW8MqMVQ51d9JaEDeOIWVYR+xh7/f4e7S+y
         mEKhgR//b9STacoLXO56B975kgZv1Wr1K26aOpCOUuK20RHnQPkMlPl6wKg09N4s4l
         N5BbgmyFn2/aLOfArJnewwsr/GR3BnGpRJ7vd3aALF3dGmIEpC5MKz58G384oTJTVr
         /4EdaN3bCb0ogSPKozZ5h2rm6D9MtNBffpLLc1oi8JDU9nJaJ0DOPW1yCJvHrGtf/L
         XQ3zpXodU+inOapslWV0Je4cZGTHEiHJo5ogeDnNnobYeYiqTo4xO0hJuSJuQv6Ze+
         25PFIiRN/Go4Q==
Date:   Sun, 14 May 2023 12:46:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix some coding style errors in memblock.c
Message-ID: <ZGCt7hn9D114y0Ps@kernel.org>
References: <87r0sa7mm8.fsf@mail.polimi.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0sa7mm8.fsf@mail.polimi.it>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 03:29:35PM +0200, Claudio Migliorelli wrote:
> This patch removes the initialization of some static variables to 0 and
> `false` in the memblock source file, according to the coding style
> guidelines.
> 
> Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>

Sorry for the delay.
Applied, thanks!

>  mm/memblock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 25fd0626a9e7..6f0a2eda427c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -156,10 +156,10 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>  	} while (0)
>  
>  static int memblock_debug __initdata_memblock;
> -static bool system_has_some_mirror __initdata_memblock = false;
> +static bool system_has_some_mirror __initdata_memblock;
>  static int memblock_can_resize __initdata_memblock;
> -static int memblock_memory_in_slab __initdata_memblock = 0;
> -static int memblock_reserved_in_slab __initdata_memblock = 0;
> +static int memblock_memory_in_slab __initdata_memblock;
> +static int memblock_reserved_in_slab __initdata_memblock;
>  
>  static enum memblock_flags __init_memblock choose_memblock_flags(void)
>  {
> -- 
> 2.38.4
> 
> 

-- 
Sincerely yours,
Mike.
