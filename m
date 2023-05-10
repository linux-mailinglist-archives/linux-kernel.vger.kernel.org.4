Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A546FE830
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjEJXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjEJXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:50:08 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48526AF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:50:05 -0700 (PDT)
Date:   Thu, 11 May 2023 07:49:51 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] riscv: Add the T-HEAD SoC family Kconfig option
Message-ID: <ZFwtn2amurR-qKuB@ofant>
References: <20230510204456.57202-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510204456.57202-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Yangtao:

On 04:44 Thu 11 May     , Yangtao Li wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> The first SoC in the T-HEAD series is light(a.k.a th1520), containing
> quad T-HEAD C910 cores.
> 
> Cc: Icenowy Zheng <uwu@icenowy.me>
> Cc: Wei Fu <wefu@redhat.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1cf69f958f10..ce10a38dff37 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -41,6 +41,12 @@ config ARCH_SUNXI
>  	  This enables support for Allwinner sun20i platform hardware,
>  	  including boards based on the D1 and D1s SoCs.
>  
> +config ARCH_THEAD
> +	bool "T-HEAD RISC-V SoCs"
> +	select ERRATA_THEAD
> +	help
> +	  This enables support for the RISC-V based T-HEAD SoCs.
This help section is a little bit short.. better to provide more
information about the T-Head's SoC series you want to cover?
> +
>  config ARCH_VIRT
>  	def_bool SOC_VIRT
>  
> -- 
> 2.34.1
> 

It would be great to have a cover letter for this series plus having an overall
history changes

Just curious, so you've taked to Jisheng, to take over this series? and will do
follow-up version bump?

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
