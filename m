Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD56DA924
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDGG5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDGG5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A17ED3;
        Thu,  6 Apr 2023 23:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC2A364BFB;
        Fri,  7 Apr 2023 06:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC037C433EF;
        Fri,  7 Apr 2023 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680850631;
        bh=7cl3v4AXJfZGQXFXyOhSiMfqM/SLo6NUO9Nao4OF0Uo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hHm2QSd2DrIiJw6VNoKnu7BZ/etYO3XG3PLebM6OfITywxKR5d3MYZe4flvpsil+n
         N+zxwoejyzgwzcVeHe6pc+fsMR70CbXM2URNVpkZU0/JKTcZDvNrLj41a3lAqufRKh
         me33pED/HCrUYQGtdLC38axFpHpZ4YCxBmWlVGpoDRdGRV9sMb6Bpg3fgNAi66TuAJ
         dWL2gwFJ0VA/q3PtR5lJaJOQCdMmIjJ3XYYOp/EFnyLTZwg9mvWbfZn0vCNUltAdLI
         b9QV6Ti3uERfzZIUJps0PcMCzzbJWwL568InGDtjWkR9PeTXscGSNRu0taLnEVly9T
         X9YByXonKgjVQ==
Message-ID: <7bd74002-cc15-ab59-4fd6-ff948cbcdb68@kernel.org>
Date:   Fri, 7 Apr 2023 08:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 3/4] ARM: dts: imx6ull-dhcor: Remove mmc aliases from
 SoM
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406215315.13280-1-cniedermaier@dh-electronics.com>
 <20230406215315.13280-3-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230406215315.13280-3-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 23:53, Christoph Niedermaier wrote:
> Remove mmc aliases to be able to define them correctly in the board file.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V3: - Add this patch to the series
> ---
>  arch/arm/boot/dts/imx6ull-dhcor-som.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
> index 5882c7565f64..a386c1e9bed3 100644
> --- a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
> @@ -11,6 +11,11 @@
>  #include "imx6ull.dtsi"
>  
>  / {
> +	aliases {
> +		/delete-property/ mmc0;
> +		/delete-property/ mmc1;
> +	};

You need to re-add them in respective boards: drc02, pdk2 and picoitx.
Otherwise you just removed that functionality without any explanation in
commit msg.

Best regards,
Krzysztof

