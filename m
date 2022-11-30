Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5E63D408
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiK3LKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiK3LKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:10:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F074AAC;
        Wed, 30 Nov 2022 03:10:20 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27F4A6602B30;
        Wed, 30 Nov 2022 11:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669806618;
        bh=7oMfqslqjC4FH70ZlLLwmJ6wNhE3DEsyVazeisOoOzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iA46UbVmQiGhwuAjFApfJ0W5FpNTR2AkxX+XIKvJzDSmnIvsIZpEeijmxcyX4FM79
         3yOd71F23Yj+MK24QU535Eaau3j1PtDirFk44cHaBDPwG0Z3FqylNLfzxWXGMggOPH
         TCUGtMN1WJ7bRAmltM6DBu5ejg9ngyO/9cYngUFmFvEcEu7tgypho0BBsm6uM0hbj8
         C3haxogMkdTvsA+mY/VHa9GE5QgLGIG8bWq+r026Dw+k7O6QBV5RTegPW6Ks25CQTV
         08kEnRSQ7i50OhRFOerPxoT5MAmXoFN219edNQGp5dYECgfIbqhWy4m3raH3h29Ze0
         vuG6J/zwdZALQ==
Message-ID: <2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com>
Date:   Wed, 30 Nov 2022 12:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH resend] arm64: dts: mediatek: mt8192: Mark scp_adsp clock
 as broken
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
References: <20221130031741.3176853-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221130031741.3176853-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/22 04:17, Chen-Yu Tsai ha scritto:
> The scp_adsp clock controller is under the SCP_ADSP power domain. This
> power domain is currently not supported nor defined.
> 
> Mark the clock controller as broken for now, to avoid the system from
> trying to access it, and causing the CPU or bus to stall.
> 
> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

....or we can add the ADSP power domain to actually fix this properly, which looks
like being a generally good idea :-)

Allen, can you please take care of that?

Thank you,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b20376191a7..ef91941848ae 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -575,6 +575,8 @@ scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
>   			#clock-cells = <1>;
> +			/* power domain dependency not upstreamed */
> +			status = "broken";
>   		};
>   
>   		uart0: serial@11002000 {
> 

