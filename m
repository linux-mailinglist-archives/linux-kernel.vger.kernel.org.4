Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449D65315B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLUNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLUNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:09:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3E233AE;
        Wed, 21 Dec 2022 05:09:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id co23so14882769wrb.4;
        Wed, 21 Dec 2022 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXjpXLe9mgiApgIbTmRMbphiVnCRik02qaboGCfPONQ=;
        b=M7178wDTVfuF1NioRuQyTx5mcAuQtYNPlvTKzXMfRbtojUvkbjYVuMBJOYcMBKcwDs
         wkRevUabFeyaKAPghZinbZqelErbpnOIXkqqSFGtw+o88FJm6JWuLDk0Gng//EZHgzrA
         Zkrl0cR4G9LPbVmuojoU3EOjV91BkpCHmub59lPCpKrzSiOQrlLMGRrxxKM4bMhMFYsq
         cmViJyryZRwl2Pd4ZNdl0c6PlBT3ArVs1pGY3nlTll30ctSejlbR9QZ8duwcXalw8Pgq
         UB9u7VowEnlfB9hUhnEuAgXoASTyQEEJo1HX+0oJCXPZStgx6iVmdZ/blXx1h4K9ui4U
         3tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXjpXLe9mgiApgIbTmRMbphiVnCRik02qaboGCfPONQ=;
        b=TmSvb/Gd1OzYUjFK3BaNZW/Q7VdxjUzX4GriLzZ2TkzppQ3XPgmK6dFlA6nKlHg4lK
         5whaF6Ezswa8YX0hwds+pdrJyTi9Nv+ZrN0UH4LFHJ2lMsjyKJverF6IiGwbA4OFJv6Y
         b0eF3+2y14pSVS+/XHzB3L+Ub2enHPjQuYMzMLI4MGE07O4kqWSQZOooppCfhDQ6U66N
         TkoHERgZqRo0EnnNkVR+SYqvWb802i7qaup+4ZdYgYUOhlXS+Ihy2mxoBYO5xkm4hqDo
         wsS7WBvI3JqGZ54lInNh6QNPd1aYdBiARipXWpyjLDv3dznuTst9ys62H5RWMjGzWMK4
         gqlg==
X-Gm-Message-State: AFqh2kryrwkld3+wx/WjIo2EI56zVWIxbmsVjNXwYKxn3wQULa3MGq/V
        3J8w2hzTVEif1Wh2apNyCqY=
X-Google-Smtp-Source: AMrXdXt34seS76I5wKWpG0iDY/k47uo19TsAkkzErrtNF9fHlYY/F4sERUh6Vm+TsdJq+xb44K/8mg==
X-Received: by 2002:adf:ee12:0:b0:242:61ab:5973 with SMTP id y18-20020adfee12000000b0024261ab5973mr1225372wrn.11.1671628173445;
        Wed, 21 Dec 2022 05:09:33 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d1-20020adffbc1000000b002364c77bcacsm15264996wrs.38.2022.12.21.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 05:09:32 -0800 (PST)
Message-ID: <6b650bcd-d063-9998-442a-3705c0654d73@gmail.com>
Date:   Wed, 21 Dec 2022 14:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add crypto support for eMMC
 controller
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20221221104856.28770-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221221104856.28770-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2022 11:48, Allen-KH Cheng wrote:
> For crypto support, add a crypto clock of the inline crypto engine and
> expand the register size in the eMMC controller.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c326aeb33a10..88b6191e1aa0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -662,12 +662,13 @@
>   		mmc0: mmc@11230000 {
>   			compatible = "mediatek,mt8186-mmc",
>   				     "mediatek,mt8183-mmc";
> -			reg = <0 0x11230000 0 0x1000>,
> +			reg = <0 0x11230000 0 0x10000>,
>   			      <0 0x11cd0000 0 0x1000>;
>   			clocks = <&topckgen CLK_TOP_MSDC50_0>,
>   				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> -				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> -			clock-names = "source", "hclk", "source_cg";
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDCFDE>;
> +			clock-names = "source", "hclk", "source_cg", "crypto";
>   			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
>   			assigned-clocks = <&topckgen CLK_TOP_MSDC50_0>;
>   			assigned-clock-parents = <&apmixedsys CLK_APMIXED_MSDCPLL>;
