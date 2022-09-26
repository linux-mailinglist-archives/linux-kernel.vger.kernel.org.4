Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61825EAB63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiIZPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiIZPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DF71BC7;
        Mon, 26 Sep 2022 07:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883E060DCC;
        Mon, 26 Sep 2022 14:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287B2C433C1;
        Mon, 26 Sep 2022 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664202337;
        bh=i0QpRzGRA2rDR7NbBJ5UC/fP24jdvmEaI0H/Ga7DsD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YwuAYueMhTweZzn89xe2NbJV5TaqM+xvx6K+4UCMjbs+SqI7HTjuv5/RVWoBHsWFT
         IGzBHEWI2hAWzxvLoVzdVC24G/GCINxYdlGORrcoCTBxrUspXJcCh7z+TyAfZOHwyt
         0orykjGrk4Z34LhKVFZSuEzpcM1Zs0cgAcQxsQtm2LuPkQF9AB5lYAcF+jXPVVVF4T
         1cQnGpmWfXLlTvj4TjDoLgDXmt6nKOy7BqH5XVnIs37EdrgtsdxkSRz/wb2uoKp0cR
         b0w3iphYsHy3l6hGzyrNk1+z6tIhpQyPCTeblODvauRog2MZHZJSPLm3Ss/7DTn3yf
         N/YGFXujiEk9Q==
Message-ID: <59c1196d-7b0e-9f50-03e8-a741adc6d91c@kernel.org>
Date:   Mon, 26 Sep 2022 09:25:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: socfpga: arria10: Increase NAND boot partition
 size
Content-Language: en-US
To:     ji.sheng.teoh@intel.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220921024519.92827-1-ji.sheng.teoh@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220921024519.92827-1-ji.sheng.teoh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/22 21:45, ji.sheng.teoh@intel.com wrote:
> From: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> 
> Content in NAND boot partition have exceeded 32MB defined in device
> tree node.
> Increase boot partition size to 37MB to support larger kernel Image
> and FPGA bitstream.
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> ---
>   arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
> index 9aa897b79544..a662df319a84 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
> +++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
> @@ -16,11 +16,11 @@
>   
>   		partition@0 {
>   			label = "Boot and fpga data";
> -			reg = <0x0 0x02000000>;
> +			reg = <0x0 0x02500000>;
>   		};
>   		partition@1c00000 {
>   			label = "Root Filesystem - JFFS2";
> -			reg = <0x02000000 0x06000000>;
> +			reg = <0x02500000 0x05500000>;
>   		};
>   	};
>   };


Applied!

Thanks,
Dinh
