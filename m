Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D15B6C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIMLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiIMLiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:38:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8624558ED
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:38:49 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oY4FR-0004VS-Mb; Tue, 13 Sep 2022 13:38:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     samuel@sholland.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: make t-head erratas depend on MMU
Date:   Tue, 13 Sep 2022 13:38:36 +0200
Message-ID: <3452718.iIbC2pHGDl@phil>
In-Reply-To: <20220907154932.2858518-1-heiko@sntech.de>
References: <20220907154932.2858518-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Am Mittwoch, 7. September 2022, 17:49:32 CEST schrieb Heiko Stuebner:
> Both basic extensions of SVPBMT and ZICBOM depend on CONFIG_MMU.
> Make the T-Head errata implementations of the similar functionality
> also depend on it to prevent build errors.
> 
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Fixes: d20ec7529236 ("riscv: implement cache-management errata for T-Head SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

could you take a look at this too please?

As it would make the lkp robot happy :-)


Thanks
Heiko

> ---
>  arch/riscv/Kconfig.erratas | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 6850e9389930..f3623df23b5f 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -46,7 +46,7 @@ config ERRATA_THEAD
>  
>  config ERRATA_THEAD_PBMT
>  	bool "Apply T-Head memory type errata"
> -	depends on ERRATA_THEAD && 64BIT
> +	depends on ERRATA_THEAD && 64BIT && MMU
>  	select RISCV_ALTERNATIVE_EARLY
>  	default y
>  	help
> @@ -57,7 +57,7 @@ config ERRATA_THEAD_PBMT
>  
>  config ERRATA_THEAD_CMO
>  	bool "Apply T-Head cache management errata"
> -	depends on ERRATA_THEAD
> +	depends on ERRATA_THEAD && MMU
>  	select RISCV_DMA_NONCOHERENT
>  	default y
>  	help
> 




