Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA5714B48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjE2N7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjE2N7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:59:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B81B0;
        Mon, 29 May 2023 06:58:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so21647935e9.2;
        Mon, 29 May 2023 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368682; x=1687960682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8wXnB4iVuJZTN+eBti6PDoOXenSUwXL/Vym36+LG00=;
        b=sm2uEKOVz1LR9pGxAkNQfFiXAxvmi4hYDgkR9kD6JdRiHHy4EPhaw9sEP1fYAeoenp
         M2Cg67O83WRhdN4xlIqim6FNdFvn6VLlN41uZDSotHeVZy8a0B1aaDW6UTKXLqu3ersB
         i0dOnDDdExp33NKwxjKjpZYcVHODS3xliW13WGUCIUJqhKlYEKxx4cAV6m9n4WLsfFiZ
         RGjSa2sJp6Q7bfczan8yg+EU6miQRV1wf0+5J1c0+p+A8B4DA2EmmClbD6B6ajaFgoJW
         f5TMbprefeCG6ip5hcpgNMmsI5mCCzNOY1ZwJ5vDyJVDAka9y7JwRVGszwbKqMPQINhS
         VwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368682; x=1687960682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8wXnB4iVuJZTN+eBti6PDoOXenSUwXL/Vym36+LG00=;
        b=gt5SWn4pCJqK/yxUllpgYYqwVMNnFhf1IwF10yhm70m3/91xf6qMy5PAqHzK3Sjxus
         1RHtPYUB4mB+95op4TT+kEmfSVnWszPLI9q9lRDkCCjppL/eUcX74iHBc0ZSNqXBHBjr
         6Kn24ljOCbVQ/xuj+PZU9cccASbjR0oA+MKQCI3sDZb5v10xo2Ok5DamyTACPqOaBiwD
         EWnUnXGSTnIPJrIIs3XjXPI7lPGzFqBpXAbuZA+AcF8ggjeZd6u3G3G3Do3KCR+gLRp1
         iEYa0CVCluGdRJ8Jq1FxggVmiMSlTlc1rBDaKkrLpfgu8aWnJc5WKJx5mvNoMp5y/sz4
         2Dnw==
X-Gm-Message-State: AC+VfDzWIbNLFXn6fl49Y2BALXRvbJJFJNoNpaD2tAfkED6rIUBRtheB
        1+3AfVdlj8r53SC7pbZW9I0=
X-Google-Smtp-Source: ACHHUZ7H4VO6On4+LQ60ze6eygW9wgdySmljow50Ej5bjnq5xSK7lqfcpgSGf81iI1u261fmbaBI1Q==
X-Received: by 2002:a05:600c:2110:b0:3f6:f7c:b3fa with SMTP id u16-20020a05600c211000b003f60f7cb3famr8544858wml.31.1685368681822;
        Mon, 29 May 2023 06:58:01 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003f5ffba9ae1sm14431663wml.24.2023.05.29.06.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:58:00 -0700 (PDT)
Message-ID: <78d59502-313e-3b6b-d363-f6e105120abb@gmail.com>
Date:   Mon, 29 May 2023 15:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 21/27] arm64: dts: mediatek: mt6795: Add PMIC Wrapper node
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-22-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-22-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add the pwrap node: this is used to communicate with the PMIC(s).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index 50d9276d18c6..29ca9a7bf0b3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -391,6 +391,17 @@ timer: timer@10008000 {
>   			clocks = <&system_clk>, <&clk32k>;
>   		};
>   
> +		pwrap: pwrap@1000d000 {
> +			compatible = "mediatek,mt6795-pwrap";
> +			reg = <0 0x1000d000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&infracfg MT6795_INFRA_RST0_PMIC_WRAP_RST>;
> +			reset-names = "pwrap";
> +			clocks = <&topckgen CLK_TOP_PMICSPI_SEL>, <&clk26m>;
> +			clock-names = "spi", "wrap";
> +		};
> +
>   		sysirq: intpol-controller@10200620 {
>   			compatible = "mediatek,mt6795-sysirq",
>   				     "mediatek,mt6577-sysirq";
