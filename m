Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97B06DF5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjDLMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:43:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1093F4;
        Wed, 12 Apr 2023 05:43:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so6095472wms.1;
        Wed, 12 Apr 2023 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303405; x=1683895405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUF7LoitQw5OkHRbbbgY1vxHPcwK0X9aUiqFfbPiOwE=;
        b=Ex9hVrKzu4VnZn/KwKympLWVqnLG00mRzfW1qoaZcqweDNRIjvzttcA6d175fMltO+
         s+44KFje1bNbbW1gDNTtg3qY1PPlw3F6d9BWgDp5ictRbUsF4ftSM4bJjPQMO6OS7krV
         WDqO6hovL/h7RbDXLeZqyLjg5Qml1ZqBKnYXAfpbj0yw6PJpcjNMTmPNNP+LuJE0Ksx4
         f2a3OtOGJpRCwm0v1TC3plUl5VKW2RjLu5fJ8uFc1o42cl7iQU1v2I1Iyp5y54YckBNf
         D0U3zJQ3MW5AoxCy1/Sr1gNtfHVX1dSBBiIJ4aSoCN9fzRfjxTDzAT7ZaF+BegoXfL2F
         Eceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303405; x=1683895405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUF7LoitQw5OkHRbbbgY1vxHPcwK0X9aUiqFfbPiOwE=;
        b=IR6M5EJx+qx5u16q0AY12d1dI8ZxGK0YsB66lZtWi6dXVvTxM/hdqeOmUeMo524qZT
         e5BImHE+U0t6mPqhzkZzV1Ej47hB4hg2pNUGYRHAWulPJia2ntEb14n4qfV9c3jeBNc+
         NE3Il/tZzUD0eJz5tJsutE9ow0Fr3bdmfDBfAPsMeCySUwJbvib6Ug18oiR/UWR7kkhE
         F3uKEzIIu6gc4xlMK9qmZ+CLOEzTcxQDOpSnzptcjhMXXSByHwxOQcjaPUuQfvwjpO5u
         H6fYCHQiU+Mad2ij69O6sSm+gv3gHB9L0rDi/Gari3FiSdwG+31aVXnXfYwfa0EWWW/k
         MTUA==
X-Gm-Message-State: AAQBX9dOHUxXXP1EQcncoZDUSVCYl2AracI/rT7LtMJ+veW782FKPxq/
        zkaxB+r3YusoKCpjdu/3kS8=
X-Google-Smtp-Source: AKy350aAVnydjEmaeKZAWvOiy1vncejnZ4Satpe9Geuus5lfYY1lSqu4hz+nbW5+onECFdEVwDSGCQ==
X-Received: by 2002:a05:600c:c1:b0:3ed:9ce3:4a39 with SMTP id u1-20020a05600c00c100b003ed9ce34a39mr9980309wmm.26.1681303405450;
        Wed, 12 Apr 2023 05:43:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c028600b003ee0d191539sm2269003wmk.10.2023.04.12.05.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:43:24 -0700 (PDT)
Message-ID: <95aec24f-b393-e36d-b4dd-4c0a228fc619@gmail.com>
Date:   Wed, 12 Apr 2023 14:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 20/27] arm64: dts: mediatek: mt6795: Add tertiary PWM node
Content-Language: en-US
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
 <20230412112739.160376-21-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-21-angelogioacchino.delregno@collabora.com>
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



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> The PWM at 0x11006000 is the tertiary PWM; unlike PWM0, PWM1, this is
> not display specific and can be used as a generic PWM controller.
> 
> This node is left disabled as usage is board-specific.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index cf45cb4ad3d2..50d9276d18c6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -583,6 +583,25 @@ uart3: serial@11005000 {
>   			status = "disabled";
>   		};
>   
> +		pwm2: pwm@11006000 {
> +			compatible = "mediatek,mt6795-pwm";
> +			reg = <0 0x11006000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_PWM_SEL>,
> +				 <&pericfg CLK_PERI_PWM>,
> +				 <&pericfg CLK_PERI_PWM1>,
> +				 <&pericfg CLK_PERI_PWM2>,
> +				 <&pericfg CLK_PERI_PWM3>,
> +				 <&pericfg CLK_PERI_PWM4>,
> +				 <&pericfg CLK_PERI_PWM5>,
> +				 <&pericfg CLK_PERI_PWM6>,
> +				 <&pericfg CLK_PERI_PWM7>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
> +				      "pwm4", "pwm5", "pwm6", "pwm7";
> +			status = "disabled";
> +		};
> +
>   		i2c0: i2c@11007000 {
>   			compatible = "mediatek,mt6795-i2c", "mediatek,mt8173-i2c";
>   			reg = <0 0x11007000 0 0x70>, <0 0x11000100 0 0x80>;
