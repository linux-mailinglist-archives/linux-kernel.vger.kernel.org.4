Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E035B6CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiIMMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiIMMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:00:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB73167EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:00:12 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oY4aH-0004d9-8j; Tue, 13 Sep 2022 14:00:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Wei Fu <wefu@redhat.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
Date:   Tue, 13 Sep 2022 14:00:08 +0200
Message-ID: <3122575.5fSG56mABF@phil>
In-Reply-To: <20220709014929.14221-1-rdunlap@infradead.org>
References: <20220709014929.14221-1-rdunlap@infradead.org>
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

Am Samstag, 9. Juli 2022, 03:49:29 CEST schrieb Randy Dunlap:
> RISCV_ISA_SVPBMT selects RISCV_ALTERNATIVE which depends on !XIP_KERNEL.
> Therefore RISCV_ISA_SVPBMT should also depend on !XIP_KERNEL so
> quieten this kconfig warning:
> 
> WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
>   Depends on [n]: !XIP_KERNEL [=y]
>   Selected by [y]:
>   - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]
> 
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I think this should also be applied as fix?

Thanks
Heiko


> Cc: Wei Fu <wefu@redhat.com>
> Cc: Liu Shaohua <liush@allwinnertech.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -362,6 +362,7 @@ config RISCV_ISA_C
>  config RISCV_ISA_SVPBMT
>  	bool "SVPBMT extension support"
>  	depends on 64BIT && MMU
> +	depends on !XIP_KERNEL
>  	select RISCV_ALTERNATIVE
>  	default y
>  	help
> 




