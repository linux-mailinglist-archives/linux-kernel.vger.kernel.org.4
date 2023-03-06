Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567926AB67C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCFGnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCFGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:43:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FD1FF0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:43:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so33986173edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 22:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678084988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rsbgKfx5oRfoFWITv64T8EhxzFwoZLrxr8at+4hbXY=;
        b=SjS9N9zqbR7+pNvp6fmo2JrOEWch7IVeWcDwB6G1bloOfWtUJImtsYskrZNYCE7LXy
         rXZ6eC2qrK9eOnx/GQUj8p987jkkFsvo2zsV4nhGALkFDJdUummT050nZ/nDrSi6OTMR
         7tUVcxmelrjyMHE6ChOsHBpmatDj3RwZDLsxA3/vBtOS8ErP3oUjLOCGVPE5UYQMeqE7
         kMY5DXPJWNMuX3SsoJV6d+gZ7E/7bTItC6SHL4h5Ale1vTd72ov010tkHM4SUvB3aamY
         ZuE9A55EcaRtkN6bauoX0ShzzY6rkxhFoIFqJgZekgFjHXTKMjyPMQYFlK988mWw4Fgm
         k+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678084988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rsbgKfx5oRfoFWITv64T8EhxzFwoZLrxr8at+4hbXY=;
        b=7M7M9vboVCq0ZkKHI31fE1tGKnC8JhbfmEgFg6BWBxsw2VKsU7XSpIpHQZAVcN2Cwx
         ZtxMkyRnuO/UC89INgiov+vm0yv13N5noIRB/qqYjai1m5w9LZxLfeIRjJ2AK8EYgtk5
         GiI6FeZa3IHI3vqa72aSTnAKOX+HHS5d0QO9sgTFCFrF/+YoAlvBfQ4bOti5+wzNMqgN
         Myu1kFjL9XcQfdI5b0J3ueIe0QBhwYGmGEr6VcXQUrOY4P6/UDkaGCMwnTeXaVazHN32
         vKQ5qzFnHm09TFFQeNS4Jnxal0G+oGI9Mv6wSsu+tmS3053y+Y0PDLe1laUOmrpxgqI5
         Yaeg==
X-Gm-Message-State: AO0yUKWgit6vBPFEgs094kOBWrPr+UBzSij8MFlkHgx4fyQUNfB8D5RC
        G5hr28lB8RRYgq/Q3WbGR3dL3g==
X-Google-Smtp-Source: AK7set9ygQqXUbsXZAna3Ki9edltMlfwQDPJUhL6neXwBtJMBkPR4IVrgJ0+T0oqQ76UqJPMKLk7bQ==
X-Received: by 2002:a17:907:8b16:b0:8b1:2e7c:df49 with SMTP id sz22-20020a1709078b1600b008b12e7cdf49mr10966072ejc.7.1678084988184;
        Sun, 05 Mar 2023 22:43:08 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id ke18-20020a17090798f200b008c06de45e75sm4116049ejc.107.2023.03.05.22.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:43:07 -0800 (PST)
Message-ID: <fecb3d5c-86b7-f052-6cba-f92b45714665@linaro.org>
Date:   Mon, 6 Mar 2023 07:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3] arm64: dts: sprd: Add support for Unisoc's UMS512
Content-Language: en-US
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230306060446.414986-1-chunyan.zhang@unisoc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306060446.414986-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 07:04, Chunyan Zhang wrote:
> Add basic support for Unisoc's UMS512, with this patch,
> the board ums512-1h10 can run into console.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Changes since V2:
> * Removed redundant gpio.h from ums512-1h10.dts
> 
> Changes since v1:
> * Addressed comments:
>   - Removed earlycon bootargs;
>   - Moved up gic reg as second property;
>   - Moved two sdio nodes under to the apb bus node;
>   - Renamed node name of all fixed clocks;
>   - Fixed warnings reported by dtbs_check.

Please always mention  under --- why you do not send a binding for new
board compatible.

> ---
>  arch/arm64/boot/dts/sprd/Makefile        |   3 +-
>  arch/arm64/boot/dts/sprd/ums512-1h10.dts |  61 ++
>  arch/arm64/boot/dts/sprd/ums512.dtsi     | 911 +++++++++++++++++++++++
>  3 files changed, 974 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
>  create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi
> 

(...)
		};
> +
> +		apb@70000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0 0x70000000 0x10000000>;
> +
> +			uart0: serial@0 {
> +				compatible = "sprd,ums512-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x0 0x100>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			uart1: serial@100000 {
> +				compatible = "sprd,ums512-uart",
> +					     "sprd,sc9836-uart";
> +				reg = <0x100000 0x100>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&ext_26m>;
> +				status = "disabled";
> +			};
> +
> +			sdio0: sdio@1100000 {

Isn't the node name required to be "mmc"?

> +				compatible = "sprd,sdhci-r11";
> +				reg = <0x1100000 0x1000>;
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "sdio", "enable";
> +				clocks = <&ap_clk CLK_SDIO0_2X>,
> +					 <&apapb_gate CLK_SDIO0_EB>;
> +				assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
> +				assigned-clock-parents = <&pll1 CLK_RPLL>;
> +				status = "disabled";
> +			};
> +
> +			sdio3: sdio@1400000 {

Same problem.


Best regards,
Krzysztof

