Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8F5BED4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiITTEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiITTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:04:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E8E0D7;
        Tue, 20 Sep 2022 12:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43293B82C29;
        Tue, 20 Sep 2022 19:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925CCC433D6;
        Tue, 20 Sep 2022 19:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663700678;
        bh=kvsruh0WoeblnoHDEdOPPdmKpvzZcvA+fIKhnFGnW9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFw+4qq9ECby9II3tm0Gw5kZAI1itCOsXnI1OY2gs6VInItg7juMnRBLh64Iyv/gt
         3BAVkL/xZKPYW/OqMoptaVQgnKG4zfEl8ezZe2CCvxh3lMTih6I9U1fVl66e+KtKLZ
         nr3eLrthAXI2RbKooDp5+TWauVA9BnIiCn+EWT1jS2ogh4eWH+ZpmQeQ+gBM1gr6y8
         FmJjNwl62tYWu5u2CS0BaABUqPX9YvbaJz27pUjM0u7R5sVd6InfPcpqNNLEzsh/Se
         4gatbfzw/R4xBalNiuEXKq46oZr8VYO4I8WSj6M0px+au6vKC4t52TbMFQebYYfByO
         fJd2fZ34gvsKQ==
Date:   Tue, 20 Sep 2022 20:04:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 05/10] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig
 option
Message-ID: <YyoOv9Jx+h0JzfX0@spud>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220920184904.90495-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920184904.90495-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 07:48:59PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
> We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3 -> v4
> * Dropped SOC_RENESAS_RZFIVE config option
> * Dropped explicitly selecting SOC_BUS/GPIOLIB/PINCTRL configs
>   under ARCH_RENESAS
> * Updated commit message
> * Dropped RB tag
> * Used riscv instead of RISC-V in subject line
> 
> v2 -> v3
> * Included RB tag from Geert
> 
> v1 -> v2
> * No Change
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..5c420ed55ef9 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -80,4 +80,9 @@ config SOC_CANAAN_K210_DTB_SOURCE
>  
>  endif # SOC_CANAAN

I am not asking for a respin for this since no-one likely cares, but
I think a future goal would be to sort the file alphabetically. I'll
probably do it with the other 30-something patches my Kconfig.socs
rework series has got to now - but if you *are* respinning sorting
alphabetically (ignoring the CANAAN) would reduce future churn.

Thanks,
Conor.

>  
> +config ARCH_RENESAS
> +	bool "Renesas RISC-V SoCs"
> +	help
> +	  This enables support for the RISC-V based Renesas SoCs.
> +
>  endmenu # "SoC selection"
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
