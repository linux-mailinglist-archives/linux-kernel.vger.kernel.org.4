Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C181D706B73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjEQOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjEQOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:43:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A81A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:43:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510c734fa2dso163694a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684334598; x=1686926598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZDD8upL/r+70rB2Afo4JoGPTnaEzVx0dEl4DiVOMWg=;
        b=iNuaz3gEZr/wsvXC1ba0asKS7gklttvKStIfxh8Qs0kkWE3Xjo04RWBvjg6nqKnxum
         6EJGM+jO4EYfehiDb2qqtu28a44G8ZeBvpm4tUWfcRSn3jz0LBbMbDfHfVT5H8fCEdgF
         0D1HaKoNJH++dItJPrhVhXCFjDpK0KmoqYMseXiRJb87xTuvAkJJDLN79nts5Lv+0lmd
         zCKooCbbXsLWVUal+iKWTLGxM170+hF6tYOTeDDSKR1M9Tz9IyYTHXkFaBuRp/3fSVfR
         ex/6uvzXapEoaRnwSrtqW2tiL/rK04iFNHTDR5zQ7F+XkdawN39mbfDrYDG1IG29PtSy
         jMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334598; x=1686926598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZDD8upL/r+70rB2Afo4JoGPTnaEzVx0dEl4DiVOMWg=;
        b=IBmW07ZwrDtvHoMC1QcN/P32U9+mNtusYvxAlBzXjWRwQnZn8izGYoptBqFPNnXvM3
         QxBBTJZXwoq4sNRKShVimoggS6DQg5EK0qiayQnqbYEuM1M2FS6uu0JP9k2GyLx7a3Cq
         KP28CtseWlSo0ofK76Y/1VGjf1VYyota471A0iH8YXl7OyTgsW6JfzBvfPNEDHEYBbk5
         hguuRejwT7vg0fQYU2DmrPBMojl29J1hXIm8fYHAgwUrSeEZnHOA3x0Vk5/0yMrU4DSI
         UTfZM54iSu0C/CnttmTHaZM9OkDjd0xnNuEDrQHeK2F4k/rVQJARftS0QyLhhoJ4AhBl
         RUUw==
X-Gm-Message-State: AC+VfDyX0ruDM5evtWl8/Ah7ZBCYxEkEQDdWjoiF9c/emp7hK16khdVs
        0ceiO2EWV+XzJ5O+Emee0VF+/Q==
X-Google-Smtp-Source: ACHHUZ4pYGjUVHIDzMVTFst1m4oKVnYh+z4Oa96EfEfP7Ed4lZHoKUEAgAScE6sd3/3n9e6WGRNDjg==
X-Received: by 2002:a05:6402:1e90:b0:506:72f8:eb10 with SMTP id f16-20020a0564021e9000b0050672f8eb10mr2673049edf.0.1684334597785;
        Wed, 17 May 2023 07:43:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7d38e000000b0050c0d651fb1sm9423734edq.75.2023.05.17.07.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:43:17 -0700 (PDT)
Message-ID: <9359c081-cd36-3e5b-a113-7600b4ba435e@linaro.org>
Date:   Wed, 17 May 2023 16:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: update
 properties
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
 <20230517111534.32630-6-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517111534.32630-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 13:15, Trevor Wu wrote:
> Add compatible string "mediatek,mt8188-nau8825" to support new board
> with nau8825 codec.

Subject: everything can be update of properties. Rephrase to focus on
actual change, e.g. on adding NAU8825.

> 
> ADDA_BE is used to connect to mt6359. For the machine, it must be
> fixed to the same codec and configured on the machine driver. Remove
> ADDA_BE from items of link-name.

I don't understand the justification for this. If this is not a correct
link name for MT6359 setup, then it should be removed in its own patch.
If this is removed because of adding NAU8825, then why does it affect
MT6359?

> 
> Introduce two properties "dai-format" and "mediatek,clk-provider" under
> dai-link subnode to configure dai-link parameters via dts.
> 
> "codec" property is removed from required property of dai-link subnode.
> For co-clock case, it's possible two dai-links should be configured to
> the same format, but only one dai-link builds link with codec.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../sound/mediatek,mt8188-mt6359.yaml         | 27 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> index 6640272b3f4f..05e532b5d50a 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -11,7 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8188-mt6359-evb
> +    enum:
> +      - mediatek,mt8188-mt6359-evb
> +      - mediatek,mt8188-nau8825
>  
>    model:
>      $ref: /schemas/types.yaml#/definitions/string
> @@ -42,7 +44,6 @@ patternProperties:
>            we are going to update parameters in this node.
>          items:
>            enum:
> -            - ADDA_BE


Best regards,
Krzysztof

