Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866E6FE8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEKAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjEKAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:54:27 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71F61727
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 17:54:25 -0700 (PDT)
Date:   Thu, 11 May 2023 08:54:19 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <ZFw8u9uqaRvCEQCI@ofant>
References: <20230510204456.57202-1-frank.li@vivo.com>
 <20230510204456.57202-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510204456.57202-5-frank.li@vivo.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao:

On 04:44 Thu 11 May     , Yangtao Li wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Jisheng:
> I would like to temporarily maintain the T-HEAD RISC-V SoC support.
> 
> Yangtao:
> Wei and me would like to help support and maintain too.
> 
> Cc: Icenowy Zheng <uwu@icenowy.me>
> Cc: Wei Fu <wefu@redhat.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add Yangtao and Wei
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..592769efd1d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18155,6 +18155,14 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/riscv/
>  F:	arch/riscv/boot/dts/
>  
> +RISC-V T-HEAD SoC SUPPORT
> +M:	Jisheng Zhang <jszhang@kernel.org>
> +M:	Wei Fu <wefu@redhat.com>
> +M:	Yangtao Li <frank.li@vivo.com>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	arch/riscv/boot/dts/thead/
> +
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:	Jack Wang <jinpu.wang@ionos.com>
> -- 
> 2.34.1
> 

Don't get yourself wrong, no objection personally..

But as I saw, none of contributors has affinity with T-Head, so no idea how this will
work well.. always better to take over maintainership after show enough commitment..

Anyway, raise your comments, and I'd more than happy to be proved I'm wrong

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
