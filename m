Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62F69A9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBQLFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBQLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:05:40 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4D9D642E9;
        Fri, 17 Feb 2023 03:05:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pSyXr-0008WE-02; Fri, 17 Feb 2023 12:04:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id ED554C28A0; Fri, 17 Feb 2023 12:04:37 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:04:37 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Genjian <zhanggenjian123@gmail.com>
Cc:     paulburton@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] MIPS: dts: Boston: Fix dtc 'pci_device_reg' warning
Message-ID: <20230217110437.GC7138@alpha.franken.de>
References: <20230213062451.1688755-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213062451.1688755-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:24:51PM +0800, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> dtbs_check currently complains that:
> arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg):
> /pci@14000000/pci2_root@0,0,0: PCI unit address format error,
> expected "0,0"
> The unit-address format should be '<device>,<function>'.
> Fix the unit-address accordingly.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/mips/boot/dts/img/boston.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
> index 84328afa3a55..72f7605d2e31 100644
> --- a/arch/mips/boot/dts/img/boston.dts
> +++ b/arch/mips/boot/dts/img/boston.dts
> @@ -125,7 +125,7 @@ pci2_intc: interrupt-controller {
>  			#interrupt-cells = <1>;
>  		};
>  
> -		pci2_root@0,0,0 {
> +		pci2_root@0,0 {
>  			compatible = "pci10ee,7021";
>  			reg = <0x00000000 0 0 0 0>;
>  
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
