Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD206342BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiKVRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKVRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:43:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51F82BD6;
        Tue, 22 Nov 2022 09:43:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t4so11252800wmj.5;
        Tue, 22 Nov 2022 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QiUhg3FHHbL4yCRYUiDHX0EGd7vPMcRRXz/Ys0GPzoA=;
        b=CdHYD/SYZJ9EVvNAFs8NUzwgDUesRc9t6zBFahz6oVfS3h82z2sduYPwvdOQW9hdDr
         ddUz7nPSjT3EiD2rj64TLMK/hmr2AsfujkOxJQCnl58gF8q6ah03sUD0XRXBoKcKaOdC
         d8kFjaF6l01ZT5TVq7oUHC/0juq6WezIArgbAkMjkifETlqZF/yAyWHFO8WgzB667FsQ
         fYOGjzYkuEL7bmYYkO6O/xQecuNz84+3il4y8AZGUZ9Rl39DIS5fO6tc+3X7f6J3HQLK
         MIDM/Alv/j3ov6oy5g88CkGJ/g7mtU4MaLLDGOxS1REnsfCAsqeVm6GFm0Lb4wwnVhCx
         cOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiUhg3FHHbL4yCRYUiDHX0EGd7vPMcRRXz/Ys0GPzoA=;
        b=HtjHo2tiG+exkQvqqP1qzBpUN/LEC43nkkbWIrwT1CSsHdQy70DkDN2cZ2dgoB4XwD
         jOpUTfv4TM3Vn0nyil4UPUixQ9qqzcqkt3JVKlhXaQ8VKsZIt53i4m80PEVLA1hroKUH
         wc/rH3cYIFbDXE8bef/5RnGFB5fan46Yj6slfn4V4YKUYIZ3rAD3cTYUT45TGVaMsqHa
         IxM2C6wJ4deN6E3TvmqFQcNpai/Gre7orntsFloduH48IR/RmMl1qEXs1AI6p2U3MNOp
         fPV0sU6ug5PMCHGgw1cdQNc5matfdgxleEdnvKdXGElOiRonkI1e8ahAoXmM/WEGLyr7
         5MHw==
X-Gm-Message-State: ANoB5pks8xUKbW6QRC5jsNdEnXXd43EK/eOFshTXSy/JeXjl2xv2ui3Q
        LtJk5HeLBYSg9Z7IPe8+3wo=
X-Google-Smtp-Source: AA0mqf7ouF49HDBxoi6CEP4X5o2rlfUkOmvfj65dtk7FUzN6WJ3TpQbjfDwvzGAdcSuiVoGRCcHRfg==
X-Received: by 2002:a05:600c:4894:b0:3b4:91f1:da83 with SMTP id j20-20020a05600c489400b003b491f1da83mr6850890wmp.127.1669139025009;
        Tue, 22 Nov 2022 09:43:45 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm24181615wmq.31.2022.11.22.09.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:43:43 -0800 (PST)
Message-ID: <0d5dd24c-2386-c3b1-8143-0a00eac44ad0@gmail.com>
Date:   Tue, 22 Nov 2022 18:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm: dts: mt7629: Remove extra interrupt from timer
 node
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
 <20220929122901.614315-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220929122901.614315-2-angelogioacchino.delregno@collabora.com>
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



On 29/09/2022 14:29, AngeloGioacchino Del Regno wrote:
> There's only one system timer event interrupt.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Queued now for the next merge window.

Matthias

> ---
>   arch/arm/boot/dts/mt7629.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
> index 46fc236e1b89..acab0883a3bb 100644
> --- a/arch/arm/boot/dts/mt7629.dtsi
> +++ b/arch/arm/boot/dts/mt7629.dtsi
> @@ -106,8 +106,7 @@ timer: timer@10009000 {
>   			compatible = "mediatek,mt7629-timer",
>   				     "mediatek,mt6765-timer";
>   			reg = <0x10009000 0x60>;
> -			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clk20m>;
>   			clock-names = "clk20m";
>   		};
