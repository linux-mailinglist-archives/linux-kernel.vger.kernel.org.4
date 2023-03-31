Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768E6D270E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCaRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCaRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:51:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BEBC65D;
        Fri, 31 Mar 2023 10:51:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v6-20020a05600c470600b003f034269c96so4163996wmo.4;
        Fri, 31 Mar 2023 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680285096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOsJVLNV3+8fzg2WVgYT6QH9y+i4e/+1YV4NKgsfyIU=;
        b=UQfsgOE9zWKSVm7VgqAUlMS6A5K0moAw7rhqbNGiP69ZoKSDDhgZXqEPnSsMQ68IJ7
         uWaRpgAIUiC9qAJqNAhYdVzfwr0h3JTrAtRrRFMh5YAzqTqGdOHZzKYQ9v+ZLFishvip
         b71sXRpxuQ2rEgDfYNljsi3yaGW3CbBDyHAz+hp7tq/EsoRZ0qwDVS0L5mAUAnUrHT1E
         g73XdSJ4NgCL5/1tnz8f+9e5oX1fNkp/uJtIN76/COQSV/tIO/avQYtEtbx0EA5px9ik
         wfAm7JraN/IiTaf+v6BJ4axOVJ/aC4DnzyyYTV17ZdHRSyp/oCx1zt/CHvhGlm2CKVpg
         h+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOsJVLNV3+8fzg2WVgYT6QH9y+i4e/+1YV4NKgsfyIU=;
        b=T/Lt/MAK16ulgaIEqyCLv9GWwwAuwtPRk6Rg58AbisgxOP0D6BJ6X9kZ5ca6DO16sp
         KcRwdCo5UlZsujivvkJywk/oLiWuS0/bX66iFUBbKmqRL7b68qUdJ0OWT1DSYcudJxDe
         TXa6BDnXCvyAsH6Ukj+0gcnMv+D7+MPDoHepTQwktN1OSxtwRK6qnFu0TJJ34iEvSiv2
         uFyVf5DzwSCPLCxTRzIB1YaWxMIXc+vpN/qbzfDhZj9GICjoWYnF1qYOL9OxkYlBU+M4
         TtS1FzaWGS+zColg4pmc4YtShyytZjfj6uUYyimCqR+2lkygUdX2pm1j24z5iT3XYwae
         sh9A==
X-Gm-Message-State: AO0yUKUo9N81QiZ41qd0F2wA+tUGzAuy3/v/nAesDngui8m70TyGrUzW
        /+mToE3IBQ+EfjUXEts8y0s=
X-Google-Smtp-Source: AK7set9qL57gN72OV9S+5J0UH2Mo0pOzFKVUyACDaKG9cENwMUTAiW0fK4UhZJR7VMOAvyIF4sA6Qg==
X-Received: by 2002:a7b:c850:0:b0:3ee:93c8:4a6f with SMTP id c16-20020a7bc850000000b003ee93c84a6fmr21425955wml.32.1680285096304;
        Fri, 31 Mar 2023 10:51:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003ef6f87118dsm10827597wmq.42.2023.03.31.10.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 10:51:35 -0700 (PDT)
Message-ID: <42193fd5-b1f3-81ff-f76f-b11490ef2a94@gmail.com>
Date:   Fri, 31 Mar 2023 19:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 15/21] dt-bindings: soc: mediatek: add display mutex for
 MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-15-45cbc68e188b@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230220-display-v1-15-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 15:23, Alexandre Mergnat wrote:
> Add compatible for the MT8365 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied, thanks!

> ---
>   Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index ca0ca549257d..931d66893dff 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -34,6 +34,7 @@ properties:
>         - mediatek,mt8186-mdp3-mutex
>         - mediatek,mt8192-disp-mutex
>         - mediatek,mt8195-disp-mutex
> +      - mediatek,mt8365-disp-mutex
>   
>     reg:
>       maxItems: 1
> 
