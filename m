Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCC6DA0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjDFTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDFTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:08:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F03C19A7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:08:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso2302882a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680808135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjIeWljkDiGyVmX8p5PiMW5AuNIJngh/JEy2k4kLvdY=;
        b=Lx3ugf/d11TNRbx8QoXYNh2DV52F69YHH1k8fmUCKqy5Yv1vwlecJ2GMKtqL17fuWu
         U/gxeR51c6dX346UvGryYnG4TsJjKpISIKh0IXjMQv4sFxbrKmUplnpkMOyKGQ3oihBm
         JmO14GNMY6yvTk8gI3YiKgOizcGkjzh71fD6UvJLJED+pjoApwXwmgCoZVCH4TejvtLg
         Xgrk1ncncV+PAStXrbgkLuvEoKDByI3cvBcSkwJIrcXJIg6NL6lxRoXVeg2UFJU+ap8u
         6ptcU3bmgij726ejGmGfdXlu1XkLpe36ahIJoGLp8gAuH/X3DhRnOD4iVl1OqL3ClEtU
         B+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680808135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjIeWljkDiGyVmX8p5PiMW5AuNIJngh/JEy2k4kLvdY=;
        b=72fh7zGBgLiZcUK+/dZe4EjZWx8DDpe2I0xG8fkHQxAqtPD4OP5adXkubpoFtgPVvd
         z1A32nzwaGdbQXjvEP8IX4JaXPv/5iluSmub9sHgt2glm3BgH19tuLTpr7H0V0BLC7y9
         nNFcKrsQpolqrMqw9+z8tn9wE/r0BNaofd4vl4EWhVSHLrlcKv78deoCBSvsuF93ED/D
         uc5C7pjTlbfUAziB81nEpMU0hcR1JRIfnePSGUhZVVnfi2oZD0vu7hX5R0OmpWBEchx8
         7bm2uDuOkeM4M88i79ry4YlbZMqVxUERDDWZA1VEnOk2A47fJkrm/wLPDwkhWRCQuWwo
         hfeg==
X-Gm-Message-State: AAQBX9f4O+60gjrIcJClZYjtJtRt5lZrx2ecyRKQcertXZVoHDPvna6b
        DOY0XMf1M7lQ4QVQUeWhy0Oj5A==
X-Google-Smtp-Source: AKy350b2MQipma8N3wDe2Xv4yTaCDB5UeFUQNpadW9SOXDpVOEm+DLx1Mh2NrS3v/9rJea1inAeWag==
X-Received: by 2002:aa7:d948:0:b0:502:7d43:2ce0 with SMTP id l8-20020aa7d948000000b005027d432ce0mr5234051eds.13.1680808135616;
        Thu, 06 Apr 2023 12:08:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s19-20020a508d13000000b005023dc49bdasm1048166eds.83.2023.04.06.12.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:08:55 -0700 (PDT)
Message-ID: <d5769d8f-29f3-063e-0562-487b1b509d3c@linaro.org>
Date:   Thu, 6 Apr 2023 21:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] dt-bindings: net: dsa: mediatek,mt7530: disallow
 reset without mediatek,mcm
Content-Language: en-US
To:     arinc9.unal@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230406080141.22924-1-arinc.unal@arinc9.com>
 <20230406080141.22924-5-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406080141.22924-5-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 10:01, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The resets and reset-names properties are used only if mediatek,mcm is
> used. Set them to false if mediatek,mcm is not used.
> 
> Remove now unnecessary 'reset-names: false' from MT7988.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 9d99f7303453..3fd953b1453e 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -282,6 +282,10 @@ allOf:
>        required:
>          - resets
>          - reset-names
> +    else:
> +      properties:
> +        resets: false
> +        reset-names: false
>  
>    - dependencies:
>        interrupt-controller: [ interrupts ]
> @@ -324,7 +328,6 @@ allOf:
>        properties:
>          gpio-controller: false
>          mediatek,mcm: false
> -        reset-names: false

I don't see such hunk in linux-next.


Best regards,
Krzysztof

