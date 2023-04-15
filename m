Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF96E2FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDOJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:00:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299A131
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:00:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a342f7c4cso475668466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681549251; x=1684141251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7bWAyZyLD6uo7vF/WlVxj3C8Ki8eISz7a0rWcMvR1k=;
        b=Co0OwPVRZSFCKAUtHmKZxfLEAl4+Yk9tRoSp0clTuJuTTsTWsesS7PWBTgdyTOlyEd
         bvErnPDwam2MuQ/85GuljVZSjqxCU4lay98TPaSI6eh+3DbgqXhKiXdeP4hhJpLgBzPR
         QONKjBWMsLwAiAUmhgHneXIT4yUvIfDtAd04MVj6qXuGPQUYtah+cHnfkZdJ8xwDwzWf
         7Z9urp7g82zxPXKJlqXl+ZFL0g2kh8xhmkrijuXx0FCo30I0AJvnYWTlWadx5OQb7KT8
         1nGYSyuKtZOANDAyIr4QKAl1B3jd6va4NY5Nb/G/jEvrtXDSn+wV122H06cH5GFbxNPp
         XIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549251; x=1684141251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7bWAyZyLD6uo7vF/WlVxj3C8Ki8eISz7a0rWcMvR1k=;
        b=Y2w3SjstYYl0EN178KXQrcmLyg9CAxhqTRHeNX2+MzFsymHv8Tr9cHWl/ZztXJZo+W
         hr1XENhQbrsB1d/45YMkjV1ehNSiLbI3aGYVRH0HWxv36EskjfBxRTRlm8ywXFzwNFRs
         rQ9nL6Y37BKtvldBac2wN1Ta0drYZV+CmiNxPtEdjOR0OxBYYnKehbuSs2e5ikuC5GqY
         9cX0n2LUPg+1YHaE9Tjw/DuHpsabiJQI7H8Zv0jRtmam0oAcuOzjc1DxrXI46BgDvz/F
         B356eQNFl4FxN4pxKYi4eaTbhDj2bQGTTe1/aedYuvlb46dlFHXDznKOBJKHmXH3Pnh8
         RHVA==
X-Gm-Message-State: AAQBX9cwt+hMyyRV6vbn6WSv5dn036/Tm0RnBg7QTky0dNmtCEXOoXRy
        gHHCPGEZMUF6XaudpHk0cSYwug==
X-Google-Smtp-Source: AKy350aEJnSqnbH8WH/aQ9lyPmdapGYw/EYooeirvjzag7l10B9FqEzScCXV7gADNUZ63773fFSs4A==
X-Received: by 2002:a05:6402:1a2c:b0:506:7d14:984c with SMTP id be12-20020a0564021a2c00b005067d14984cmr6282723edb.19.1681549251217;
        Sat, 15 Apr 2023 02:00:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a3bf:4ed:6c53:2a36? ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id wt10-20020a170906ee8a00b0094f225c0cd3sm421385ejb.86.2023.04.15.02.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 02:00:50 -0700 (PDT)
Message-ID: <310e8979-de96-dda8-6c95-0e6033d8b403@linaro.org>
Date:   Sat, 15 Apr 2023 11:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
 <20230413104713.7174-8-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413104713.7174-8-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 12:47, Trevor Wu wrote:
> Assign top_a1sys_hp clock to 26M, and add apll1_d4 to clocks for switching
> the parent of top_a1sys_hp dynamically
> On the other hand, "mediatek,infracfg" is included for bus protection.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mediatek,mt8188-afe.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> index 82ccb32f08f2..03301d5082f3 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
> @@ -29,6 +29,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: The phandle of the mediatek topckgen controller
>  
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the mediatek infracfg controller
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -37,6 +41,7 @@ properties:
>        - description: 26M clock
>        - description: audio pll1 clock
>        - description: audio pll2 clock
> +      - description: audio pll1 divide 4
>        - description: clock divider for i2si1_mck
>        - description: clock divider for i2si2_mck
>        - description: clock divider for i2so1_mck
> @@ -58,6 +63,7 @@ properties:
>        - const: clk26m
>        - const: apll1
>        - const: apll2
> +      - const: apll1_d4

Why do you add clocks in the middle? The order is strict, so you just
broke all DTS.

>        - const: apll12_div0
>        - const: apll12_div1
>        - const: apll12_div2
> @@ -74,6 +80,12 @@ properties:
>        - const: i2si2_m_sel
>        - const: adsp_audio_26m
>  
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1

Usually these two are not needed.

> +
>    mediatek,etdm-in1-cowork-source:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> @@ -147,6 +159,8 @@ required:
>    - power-domains
>    - clocks
>    - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents

Why making them required?
Best regards,
Krzysztof

