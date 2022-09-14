Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560D5B86E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiINLBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiINLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:01:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFD3CBCF;
        Wed, 14 Sep 2022 04:01:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E489660201C;
        Wed, 14 Sep 2022 12:01:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663153272;
        bh=+oritojqCO8DEgbEjdeplXhbt1Fs4LI2IwrWyEO+7yo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CmA7McZJrKu/LJ1dL5OZKk3zC2UGvVxiuV+jzi2JSfUdEIQQ6pcDDUlNIWWaLnXvm
         BvhBEC6EtZa8DZ7k7LZjCk1vmKQ7h/haNidlrY996NxwHS4IqLXMiUF59sKqvn+MJ6
         iLnoXKDaOLA+DpU6apMGtFSVbsgFYZeE8MjhLwNKZlR1U0fBiPjTflYKsO8e8kNsTu
         +TiKRLHx6ICjxgB6/RGhioE+yW8ZhKJIgi+ynNK5W8+ul+AmY7ZovnJJ1oPJVkcrju
         ELxIKCiThJJRpVn373S0BJvUyQ082WV5T65l22yInFtlFIJhPJSi4roS6Vrhv0Hr+R
         cykx0cm7qrMIA==
Message-ID: <3a91e743-2b8f-51b6-9ac1-adc3e7ec8cc4@collabora.com>
Date:   Wed, 14 Sep 2022 13:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt6795: Add CPUX system timer node
Content-Language: en-US
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220729093536.27623-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220729093536.27623-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/07/22 11:35, AngeloGioacchino Del Regno ha scritto:
> Add a node for mt6795-systimer: this is necessary to start the
> System Timer(s) for all cores, finally making CNTVCT_EL0 usable.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello Matthias,

gentle ping for this one - this has no floating dependencies and it's
verified to work as expected.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index d4842b4a4eb7..46f0e54be766 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -230,6 +230,14 @@ sysirq: intpol-controller@10200620 {
>   			reg = <0 0x10200620 0 0x20>;
>   		};
>   
> +		systimer: timer@10200670 {
> +			compatible = "mediatek,mt6795-systimer";
> +			reg = <0 0x10200670 0 0x10>;
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&system_clk>;
> +			clock-names = "clk13m";
> +		};
> +
>   		gic: interrupt-controller@10221000 {
>   			compatible = "arm,gic-400";
>   			#interrupt-cells = <3>;


