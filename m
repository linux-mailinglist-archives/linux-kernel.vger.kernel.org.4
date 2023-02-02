Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563CC687CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjBBMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjBBMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:13:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182689F98;
        Thu,  2 Feb 2023 04:13:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3578990wma.1;
        Thu, 02 Feb 2023 04:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaBK2gOP9VnPxAmCYXpgUSfZykqxTRkLrfI4y3qj9N8=;
        b=jTAx61SYlxZsQ6Nk2B9Y7Hcv3Cxv5gUh1nyzMz56+eVNc6/QrUxORNmgHLaUy/HHrC
         MTNnG1Sf+6k78VtBUjdWdJs7DBSWjuUYx4Lpl7P0IYguoW+VxS0i05ugVqJNEfvTl71W
         rzWr4e02xWPWjz4n0Qs1MgZp05OebBOza9SM0pERQiU+m6z+KcWr7AD0wPlUbVY+phDD
         CcPGOgfIsXwKyxfo9KBKziOcCNEOxaXWiZg/BSqlQi8U3+XQRnFwrB5CqJof48WGt7qU
         jzBTLgQoVdd6pQPz6e4QejJMa2KnvCUFBtM9Eu835wZsVsYXC8BfA4S3fe0Q1e7HMeSN
         Gcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaBK2gOP9VnPxAmCYXpgUSfZykqxTRkLrfI4y3qj9N8=;
        b=Bu8Tr4OHQEfsyy2btXEascGqjN9nPBv3opd714AQMVsSoSe4fEe/Rd1sjtinFilyW8
         SKUIK8hzuc6IbKvsNOA86BxB/BMFpZ2BFmVK7O4UxCLc+8wrjlvpPHUd49GzN1YmzyB9
         cbBi2Wx65mGPyTgQSMn8qx5nM6cgvZRmo+3WNy19npUpq61RsKlgj+0wC/yiR+Vd04Ul
         CUL6Pt7HYjYh06HoHbBiqAYcaPPbXt8Pg4/QorVqNrIGUadAmIWABbg9x12OUfBz76C7
         526OYBHMvPbSE8qvwfYMb06jK8zmDsCm9FttSzYINZG5riM+1ZqJPZLrpaLzNLrGo/NY
         FSlw==
X-Gm-Message-State: AO0yUKVPBCuEFAn1h34QaImx8zNHXCQqHTpBKu4VUoPzJTmkZ7WQ5Ka8
        3ajGvOyoPWJI4bqmXa0dxm8=
X-Google-Smtp-Source: AK7set/K5mj4/wx7pJ8+9P/uHlj+hV029sdbYt8ULlEf6QKGQmw01oKjkNMwb1PqVH9W+ma85Fgu/w==
X-Received: by 2002:a05:600c:4f41:b0:3d7:889:7496 with SMTP id m1-20020a05600c4f4100b003d708897496mr5473887wmq.17.1675339993794;
        Thu, 02 Feb 2023 04:13:13 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm4502198wmc.31.2023.02.02.04.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:13:13 -0800 (PST)
Message-ID: <64d05d48-8e12-602d-7f64-4f29b56011b7@gmail.com>
Date:   Thu, 2 Feb 2023 13:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/5] arm: dts: mediatek: Fix existing NAND controller
 node name
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        benliang.zhao@mediatek.com, bin.zhang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230201021500.26769-1-xiangsheng.hou@mediatek.com>
 <20230201021500.26769-4-xiangsheng.hou@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230201021500.26769-4-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2023 03:14, Xiangsheng Hou wrote:
> Change the existing node name in order to match NAND controller DT
> bindings.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Queued for the next merge window, thanks!

> ---
>   arch/arm/boot/dts/mt2701.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 0a0fe8c5a405..ce6a4015fed5 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -359,7 +359,7 @@ thermal: thermal@1100b000 {
>   		mediatek,apmixedsys = <&apmixedsys>;
>   	};
>   
> -	nandc: nfi@1100d000 {
> +	nandc: nand-controller@1100d000 {
>   		compatible = "mediatek,mt2701-nfc";
>   		reg = <0 0x1100d000 0 0x1000>;
>   		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
