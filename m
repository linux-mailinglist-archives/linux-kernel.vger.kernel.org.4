Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E5687CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBBMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjBBMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:13:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B46A732;
        Thu,  2 Feb 2023 04:13:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q10so1518553wrm.4;
        Thu, 02 Feb 2023 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JFY/1NaFcQJxriJ5Nglyu5euCxsa3XuMh1hTRdAMO8=;
        b=Gb6wv+fems3L4HhTw7k9YzFTd1lY070awJ4ifr/28qS7RWw6W6s5FTPBGe7IyzrJzS
         MMLvZCfq2xIu87rzSPKdtyCVh5lC950V5hPtEvTRgalo6dzUqnxYPyhxgRdk3nxgXuza
         kdcoOsbB9oOERE1H6DIomSCMRl2fuP/Zltdc0HtIkCF8IP2NLmP6oFA7xcAbGCeTb386
         Ar4YryeVON/rFJIbzt8fwbb8hO16bVOuiZBIHEpc+ee2j9sjODNrnJNPVMuxCE8Rsg+y
         WaZL/MW1hT0Ho+NpOhVQh1J3ygBVm8zVQOhfaeHjOyOjDF92EOs/JvMrXuqRTzen/nJs
         sIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JFY/1NaFcQJxriJ5Nglyu5euCxsa3XuMh1hTRdAMO8=;
        b=diRQN6bCLkvfaiC304kiy08ulf3ckmG/ELckxfFVMtIMbGlDuoQ3oaelGIhpmYZVK9
         weSZPrBRBkZ8OW3JIz25eAEEEs/Ay7NaQd8vMYT5tqQnS21U30CQtz41b9mqPY6qsE0z
         1V+xh1RorKea6SPWYjrKpOjmrFFNchiHAMwDz3Pzj1WNBWrJmX/fvMZAfFfsYvjyKAcW
         H67EJUjlM9N8JU2RuMdsVMteoDFg9d/1zWzWyMKLQKPnx19km6UWOSmYlQ5pPdO1RK24
         8FXxsddD8+JHLqTsVrCVDplk/psloq0Ffgo8IkzX4D1IC784d2hXCkan+lIwD0+WxVHY
         2Epg==
X-Gm-Message-State: AO0yUKVlqSFxYbe3AzCvYdryA1Onz6O9C2MiepamRf3lu/Hqc1oSnANd
        FT+x1VEKudgVCpYSrKaMxE0=
X-Google-Smtp-Source: AK7set9tRKVVWu4q2LyASgx0E1BBc2t6l0gIfR1ti+UZFp/4PhRDKlvvVgTj8Rk4DWgGoBILlDqjHA==
X-Received: by 2002:a5d:604c:0:b0:2bf:c31b:1922 with SMTP id j12-20020a5d604c000000b002bfc31b1922mr5102901wrt.3.1675339987722;
        Thu, 02 Feb 2023 04:13:07 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d64c7000000b002bdfe3aca17sm21470152wri.51.2023.02.02.04.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:13:07 -0800 (PST)
Message-ID: <eea6f2f1-9f07-0bb8-50af-c1daf5131357@gmail.com>
Date:   Thu, 2 Feb 2023 13:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 2/5] arm64: dts: mediatek: Fix existing NAND controller
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
 <20230201021500.26769-3-xiangsheng.hou@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230201021500.26769-3-xiangsheng.hou@mediatek.com>
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
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 879dff24dcd3..ed1a9d319415 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -559,7 +559,7 @@ spi0: spi@1100a000 {
>   		status = "disabled";
>   	};
>   
> -	nandc: nfi@1100e000 {
> +	nandc: nand-controller@1100e000 {
>   		compatible = "mediatek,mt2712-nfc";
>   		reg = <0 0x1100e000 0 0x1000>;
>   		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 62487a3c4db1..eb4e4638b548 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -538,7 +538,7 @@ bluetooth {
>   		};
>   	};
>   
> -	nandc: nfi@1100d000 {
> +	nandc: nand-controller@1100d000 {
>   		compatible = "mediatek,mt7622-nfc";
>   		reg = <0 0x1100D000 0 0x1000>;
>   		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
