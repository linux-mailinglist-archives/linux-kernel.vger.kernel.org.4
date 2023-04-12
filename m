Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11C56DF5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDLMlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDLMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:41:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24B6E9A;
        Wed, 12 Apr 2023 05:41:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w24so1154894wra.10;
        Wed, 12 Apr 2023 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303285; x=1683895285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEHj125fFUHVqVSYxI2Iu4R8mwBu9xLsNlhlcbmp5rM=;
        b=llEetynzd9UPHbqm2DuZ2+4h9Q3PCWFOLHFsb0vOSnJYPAfCAO1R3XNmoKZJMwhBQC
         vILAF7oLkx35oAn4QQZ8feiPlgHUZyVqzYlVPvviSyOOaIXVD6/sdEW7kIDfuIu36t1Q
         BV3+QEpyAceCpr/CqnR2DQTdlps3ia+YVy+hXsNBIjJNSOnwwno7+vnUilo8JJuidsOx
         xF+jP1kAslYKyhJ65RH2Wh4UWQ0PDszOh+n7iT3D099hxVe/Dh5QPmuLZJA9ADqi/Egk
         +t+fgzr6O2apGbnbPnFhV3cikLdph/xyWZXNgCgnQXK6rogqkwqP0NQ4UEO/PLWc0wmV
         xnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303285; x=1683895285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEHj125fFUHVqVSYxI2Iu4R8mwBu9xLsNlhlcbmp5rM=;
        b=Hgnd9GLyz1+RWCtNAwAN09m8xOxKv7KOf4Peh5us/gRq+g21Tg+L6I+gkMK844mJTa
         mJMjR3XAHYCDU8LJ0ixGleNBJnsYctiC+BOiRfLuoD8V8LI6iRT2N8UKnQI5DNaSYgu0
         SIq2WYTGKhTafgKbdAZcEo11IUEW5tiRwZkFIXAqlhCAo/MuHCf3S6HcSnBgXIl6VYEi
         NSBraqVj1WaiNRgfPqOUdf2UxbC3ArnDPJphhm7wnw+B3cjuUeV98foeIGhJkXXOXPTS
         +fogQ2vZx2iR2qBqGmGjPLKND+LlvC/kdaF/yj/hJuHZU4YKdHs8Mk+XVjoI93tXNY/r
         +++Q==
X-Gm-Message-State: AAQBX9ebdHiyZ+6NIV2krt7HBjxXReejLAFfe43DKY+DyADtRePip4EJ
        oosAK+jhq1q/2O2cNCd1h3Q=
X-Google-Smtp-Source: AKy350aT31kI3WrPlyJemwrlllp01mZSGvhWt0uUtaz7CCjWzacgDuOrFbxL5IdxxVlheLDNfhc0UA==
X-Received: by 2002:a05:6000:11d1:b0:2f4:e8e3:ef62 with SMTP id i17-20020a05600011d100b002f4e8e3ef62mr1002128wrx.65.1681303285246;
        Wed, 12 Apr 2023 05:41:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d514b000000b002cefcac0c62sm17220111wrt.9.2023.04.12.05.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:41:24 -0700 (PDT)
Message-ID: <7466cf12-9411-cb35-8e8b-fa50f5efe492@gmail.com>
Date:   Wed, 12 Apr 2023 14:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 22/27] arm64: dts: mediatek: mt6795: Copyright header
 additions
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
 <20230412112739.160376-23-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-23-angelogioacchino.delregno@collabora.com>
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
> I have added more than 800 lines to this devicetree: adding myself to
> the copyright header.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index 29ca9a7bf0b3..a4c950b65006 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -2,6 +2,9 @@
>   /*
>    * Copyright (c) 2015 MediaTek Inc.
>    * Author: Mars.C <mars.cheng@mediatek.com>
> + *
> + * Copyright (C) 2023 Collabora Ltd.
> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Indentation?

BTW from what I understand the copyright will be by your employer, Collabora not 
you, but I'm not an legal expert :)

>    */
>   
>   #include <dt-bindings/interrupt-controller/irq.h>
