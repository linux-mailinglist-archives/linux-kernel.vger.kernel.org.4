Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8764EA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLPL3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:29:48 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8947336;
        Fri, 16 Dec 2022 03:29:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3901932wmb.2;
        Fri, 16 Dec 2022 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eQToE6HYEXSjmjEz9Jwn20G/19K2LtofqYs+NdFsXk=;
        b=j8y5udIPLX/hAWg2cytn1YqmlvAGn8vXbrhcMxBw37fgakqfohqex/9DKsXoT1b4R5
         IGCUiBv8a/klIotJyQrTN0bht7j1md8dsSAl5K8ZP2V1WSLf/btkrUitgo/l7DSoOOpj
         FDgkSAtJEB1IZUGkDoeqqeQIxdcdx819+CK3pc5eaxuEKSOAs3zgTY7uqeHmKa3ipS7q
         WpjVCFe51HPqPNsqzvXKBzPHsvRyClPJyHP1XUCIGddpFwPKzC15Rhnwow40oWVprXt6
         A8ULQJJbeM/9baXI1koH5mpVTs6GpUt5qGnXVbs/+3JzjGqKh5wUxQOha+xfCE1l+vMg
         5gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eQToE6HYEXSjmjEz9Jwn20G/19K2LtofqYs+NdFsXk=;
        b=tM3M9xAnHmF/FN7XPdtWTN9lA/dzUJgZqV9i/N3+hJh3hi4k4ISd1/VWQH8SY3xiew
         zBuroBD04Y8GvAMSWPA/r2xCnY1FT18S/py0wN9jDcsk7pX+PbxWphMWJcFrDKPJpJIm
         TBhQNhCetNMeV/6MR3XAdrcg63D3bGLI04meGMYaZdi34b4iE5VzVoFSwx3qQ1tdB3Ir
         azgNB0HR04yugsthJ9qsVFgefTkiZh0mvAn5s8quloQIXCP1uhPwGLyWyO82iz8Zsk4p
         3samoWzWl1lrq5237vrL8kEEkvzYSVy1KMto0KBIKt8yNj4Xmx9kv4mkWMMTyVIP8L8D
         6lKw==
X-Gm-Message-State: ANoB5pkgMepH3sPpPvZIe805oXiDBHybwOE9g0e/vyVLAhsNg3YHYGc0
        Ttq/JdAvIhpm/jEL3rBaBb8=
X-Google-Smtp-Source: AA0mqf6DxqrvszFL9kf7adb8ttrB79MhtC5rbhg8MnyNBTwJSO6H1mtyRqK7RwTUw9hvEU2n4rmcKg==
X-Received: by 2002:a05:600c:5106:b0:3d1:c8e4:48d7 with SMTP id o6-20020a05600c510600b003d1c8e448d7mr34176670wms.40.1671190186151;
        Fri, 16 Dec 2022 03:29:46 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003cf9bf5208esm10657902wmq.19.2022.12.16.03.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:29:45 -0800 (PST)
Message-ID: <d7432483-7244-1c6e-cff7-ac56a67705a7@gmail.com>
Date:   Fri, 16 Dec 2022 12:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8195: Use P1 clocks for PCIe1
 controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221214131117.108008-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221214131117.108008-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2022 14:11, AngeloGioacchino Del Regno wrote:
> Despite there being some flexibility regarding the P0/P1 connections,
> especially for TL and PERI, we must use P1 clocks on pcie1 otherwise
> we'll be dealing with unclocked access.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Seems my mail got lost somewhere:
Both patches applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5d31536f4c48..e61944510b8e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1258,9 +1258,9 @@ pcie1: pcie@112f8000 {
>   
>   			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
>   				 <&clk26m>,
> -				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>,
>   				 <&clk26m>,
> -				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_PERI_26M>,
>   				 /* Designer has connect pcie1 with peri_mem_p0 clock */
>   				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
>   			clock-names = "pl_250m", "tl_26m", "tl_96m",
