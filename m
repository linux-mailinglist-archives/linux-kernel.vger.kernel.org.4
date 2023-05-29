Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24343714B36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjE2N5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjE2N44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:56:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5610D9;
        Mon, 29 May 2023 06:56:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so3255944f8f.1;
        Mon, 29 May 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368499; x=1687960499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxF01hOJFWwqeJ5mF+InyarZkjvnXX1icR3jLwM6pIw=;
        b=Bt0Aszg9Rqb5zOu1MN8HeJXrz6mEjVF+eCPfGBuXKTcwLER/vanVda1+RWQ03bASjl
         x07VUdprCygZ0Y0p38AO4EYof/LD/2Joa5jTCigjXwMxxh+tOZoZnUu9zhcdEE3G2/sO
         fas84MgaOBG+QFPwRz3QV/4hAgjXh6Vk9p2K9FSOZw4yRaT8ROD1tKp9kk+XndaYV0xS
         j8ipOOESrDlLQsFFQYt7NrkW7dlByEZKuhIQ/TjsstzmRV/KZQSDKQV5YEXpIxJbObVE
         +7hndZ6H1iTJY9CtuKRgoO4AaHp/nTkKvoehx0s54IiNZN8HtctFeCz5v8cx/xx6tAOJ
         fTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368499; x=1687960499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxF01hOJFWwqeJ5mF+InyarZkjvnXX1icR3jLwM6pIw=;
        b=QWHetzGCZd5uNXisZK3k8iXt6KSQar0p36RJrOb/rgoMqcY3q5XFulc6vlUVrMbF+H
         Vi3NoKepi+5nG9w0THJgLzBI9d3WK8qQYMHVyDLwfMN7POMZ73EjV5RiKg2b84m4U+RE
         sMbqP0q1yDcKiGMktVMPKqMmGSXTYAeVfJAW4R9SuE/xaQYEyw2ifWCbiDL2UL9CZtc7
         eUbJMG3p7H4rfXe64rpH+c6k2zUhpRmr5ur4WS7WZiO7CrGUPRZA8yO8fxdTux28kQSh
         ByMwlI/WSsPyYsgqkOeIjxHHpiW5xf0ks4u9hiuAeXQR6UhPDPsR9qbxTo1280ywNGzM
         V3Wg==
X-Gm-Message-State: AC+VfDwwVtBC30uD05yTOMpN2cemqIgCMVmx1P/8w7UehqbObOhxBoQ6
        wwif/rZnJAJo8Edgv9D/kD4=
X-Google-Smtp-Source: ACHHUZ7m92JhOoSuT58IidM7J4/3EF7ZTdc7SnG4vzmODXGWQHCnYiTNtNtfeLeAW4fOuzUIVItl2g==
X-Received: by 2002:adf:d086:0:b0:30a:e7b6:52d6 with SMTP id y6-20020adfd086000000b0030ae7b652d6mr4346165wrh.52.1685368499381;
        Mon, 29 May 2023 06:54:59 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0030af20aaa3fsm26184wro.71.2023.05.29.06.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:54:58 -0700 (PDT)
Message-ID: <bdbc4e15-3cd9-ae93-fff7-6e323035c1d2@gmail.com>
Date:   Mon, 29 May 2023 15:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 16/27] arm64: dts: mediatek: mt6795: Add support for the
 CMDQ/GCE mailbox
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
 <20230412112739.160376-17-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-17-angelogioacchino.delregno@collabora.com>
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
> In preparation for adding multimedia blocks, add the CMDQ/GCE mailbox.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index 090400d7fd61..99cc4918e6ba 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/mediatek,mt6795-clk.h>
> +#include <dt-bindings/gce/mediatek,mt6795-gce.h>
>   #include <dt-bindings/pinctrl/mt6795-pinfunc.h>
>   #include <dt-bindings/power/mt6795-power.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
> @@ -401,6 +402,15 @@ fhctl: clock-controller@10209f00 {
>   			status = "disabled";
>   		};
>   
> +		gce: mailbox@10212000 {
> +			compatible = "mediatek,mt6795-gce", "mediatek,mt8173-gce";
> +			reg = <0 0x10212000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_GCE>;
> +			clock-names = "gce";
> +			#mbox-cells = <2>;
> +		};
> +
>   		gic: interrupt-controller@10221000 {
>   			compatible = "arm,gic-400";
>   			#interrupt-cells = <3>;
