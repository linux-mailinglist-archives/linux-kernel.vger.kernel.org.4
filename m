Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F842637FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKXTwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKXTwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:52:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7D2AE3B;
        Thu, 24 Nov 2022 11:52:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B71B828FC;
        Thu, 24 Nov 2022 19:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658A3C433D6;
        Thu, 24 Nov 2022 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669319560;
        bh=hEIk4OHUWU0NzVkJWRgtpUsQoG9Otd0q92ku0LLOXiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP14ENjUJRtGK2NYT5uEXID4fr68u47NVOKJGsjz99zGQ7fhj17h+Qw97jNA2vs3d
         KzcPIvX/E7acsK1T5K5BhKmu9H6liKS+tgEi3s0WLuAVtTqlkQhPDhj+0OUVgESQsO
         hz2VgmVByDlX/aDZsaRLYqPrjbyChb5+hZutVYm+SINNa2eCPs7ho/D8Jwd21LcePC
         m5wdWW/Ar3rOlqbMAbC98AZ4v+JKZS+K1Z2VWPZKNj7l7dDZi//kLVuqH7xRJOc8dw
         nEKgthPa/lrGEUpVxc+zV/ulldt7DUZzRe6zhHxUsqf7JQYc0FOO/Dib3N8Z/EEqD9
         HW3hiboTey+Jw==
Date:   Thu, 24 Nov 2022 19:52:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
Message-ID: <Y3/LgZkR1hkblJ8D@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Introduce ALTERNATIVE_3() macro.

Bit perfunctory I think! There's a lovely comment down below that would
make for a better commit message if you were to yoink it.
Content looks about what I'd expect to see though.

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/alternative-macros.h | 94 +++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index ec2f3f1b836f..1caf4306b3d6 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -69,6 +69,34 @@
>  				   new_c_2, vendor_id_2, errata_id_2,	\
>  					IS_ENABLED(CONFIG_k_2)
>  
> +.macro __ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
> +				  new_c_2, vendor_id_2, errata_id_2, enable_2, \
> +				  new_c_3, vendor_id_3, errata_id_3, enable_3
> +886 :
> +	.option push
> +	.option norvc
> +	.option norelax
> +	\old_c
> +	.option pop
> +887 :
> +	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
> +	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> +	ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> +.endm
> +
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +	__ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					IS_ENABLED(CONFIG_k_1),		\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					IS_ENABLED(CONFIG_k_2),		\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					IS_ENABLED(CONFIG_k_3)
> +
>  #else /* !__ASSEMBLY__ */
>  
>  #include <asm/asm.h>
> @@ -135,6 +163,36 @@
>  				   new_c_2, vendor_id_2, errata_id_2,	\
>  					IS_ENABLED(CONFIG_k_2))
>  
> +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					enable_1,			\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					enable_2,			\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					enable_3)			\
> +	"886 :\n"							\
> +	".option push\n"						\
> +	".option norvc\n"						\
> +	".option norelax\n"						\
> +	old_c "\n"							\
> +	".option pop\n"							\
> +	"887 :\n"							\
> +	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
> +	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)	\
> +	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> +
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					IS_ENABLED(CONFIG_k_1),		\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					IS_ENABLED(CONFIG_k_2),	\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					IS_ENABLED(CONFIG_k_3))
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #else /* CONFIG_RISCV_ALTERNATIVE */
> @@ -153,6 +211,14 @@
>  					CONFIG_k_2)			\
>         __ALTERNATIVE_CFG old_c
>  
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +       __ALTERNATIVE_CFG old_c
> +
>  #else /* !__ASSEMBLY__ */
>  
>  #define __ALTERNATIVE_CFG(old_c)  \
> @@ -167,6 +233,14 @@
>  					CONFIG_k_2) \
>         __ALTERNATIVE_CFG(old_c)
>  
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3) \
> +       __ALTERNATIVE_CFG(old_c)
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_RISCV_ALTERNATIVE */
>  
> @@ -202,4 +276,24 @@
>  					new_content_2, vendor_id_2,	\
>  					    errata_id_2, CONFIG_k_2)
>  
> +/*
> + * A vendor wants to replace an old_content, but another vendor has used
> + * ALTERNATIVE_2() to patch its customized content at the same location. In
> + * this case, this vendor can create a new macro ALTERNATIVE_3() based
> + * on the following sample code and then replace ALTERNATIVE_2() with
> + * ALTERNATIVE_3() to append its customized content.
> + */
> +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1,		\
> +					errata_id_1, CONFIG_k_1,	\
> +				   new_content_2, vendor_id_2,		\
> +					errata_id_2, CONFIG_k_2,	\
> +				   new_content_3, vendor_id_3,		\
> +					errata_id_3, CONFIG_k_3)	\
> +	_ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1,	\
> +					    errata_id_1, CONFIG_k_1,	\
> +					new_content_2, vendor_id_2,	\
> +					    errata_id_2, CONFIG_k_2,	\
> +					new_content_3, vendor_id_3,	\
> +					    errata_id_3, CONFIG_k_3)
> +
>  #endif
> -- 
> 2.25.1
> 
