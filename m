Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF9676D8D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAVOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAVOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:16:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611751ABDA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:16:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so8603979wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hltLV3ya8ktIesbWW9B+JQxvC7+ys0Pz05F3BDmcVzQ=;
        b=a44FoSuX5jQrA63CqI55Xa498Vxdg/Tyc/vx0ArZx69NHf06EiaeeqYYYTD6nSB3M5
         AoRrEOOoHHuWaZphy/SEaHCfRu3yOY6NM1JGJ10LGJ6AHb5ZwtrtR7GhkW0h+eoU4O/V
         jYTrFyoL/BtKKyInYzziNGBSTg+2ArFNCZCEeHw4zZu83+QbfsdIk3YOCGZT+KtIDjpT
         A/4bKdz3YuaebBoipcG9xgBlmlRBTEVJH3TtJyCimA5zd8fDvYE30QqFXISaqSsRx6Yp
         brpEAryraPeICh5RlyJU5Qo7M2RiaQ0c6hkwTzeBoaMBxesGtxCWmAhqokq1T6F2SROn
         +vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hltLV3ya8ktIesbWW9B+JQxvC7+ys0Pz05F3BDmcVzQ=;
        b=WP4is0MYeSczSmVzstI75U49qd5E0/gYdXnBTgFg0LXxhvGfOsYjbra0cY1Og2ZMb/
         G6yacGUff4QB3Hndc1mvR0gtiVpNkjz/n4UdcDMt58yTXQ45qLO58ZFsv33YNn3wXVgC
         7nhgDbUi0l1v5FrguOwfmPSO6zIh+FK03Xo/s5XPYF1J9mEOxk5yYUvQs6MyQu9LeVGD
         XrLcNlFtju4wgAyNUQm9JzCW/9I34xb1VNYVlJlR6vhyxu/WcAssGPqvIpYbUc8Inyjh
         IDQ6cOsoTTv6zcrVzPocywf3VbXciOVo/KchdhcJCEwPYHrSRh2/ywXWwzoOTW4+JpCX
         VSPA==
X-Gm-Message-State: AFqh2kpalksdpIsfSLBs44Zwnw7Nlg7uvsaAh7Eop38rWFj0uih5nxDl
        dLE8vItjutMrLvJACod1aUHisQ==
X-Google-Smtp-Source: AMrXdXtU1a/dtmjJRUOHbLcFPO22+9D4XFjXFgfo5x1g6EzxrL/TMMrC9eQPuZR1P+f2mLUk2uRuug==
X-Received: by 2002:a05:6000:603:b0:2bd:f651:3a67 with SMTP id bn3-20020a056000060300b002bdf6513a67mr21144691wrb.64.1674396976540;
        Sun, 22 Jan 2023 06:16:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe843000000b00241bd7a7165sm2549584wrn.82.2023.01.22.06.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:16:16 -0800 (PST)
Message-ID: <2d05a943-3510-5ee9-9906-247a6344190a@linaro.org>
Date:   Sun, 22 Jan 2023 15:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
Cc:     kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230120102555.1523394-1-astrid.rost@axis.com>
 <20230120102555.1523394-5-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120102555.1523394-5-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 11:25, Astrid Rost wrote:
> Add jack-type: Bitmap value of snd_jack_type to allow combining
> card drivers to create a jack for it.

Subject: drop "yaml". We do not filename extensions to subject prefix.
Nowhere.

> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> index 785930658029..1d949b805f98 100644
> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> @@ -27,6 +27,14 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  jack-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Bitmap value of snd_jack_type to allow combining
> +      card drivers to create a jack for it. Supported is

Why the device would once support (allow) headphone and once not? Device
either always supports them or never...


> +        1 SND_JACK_HEADPHONE
> +        2 SND_JACK_MICROPHONE

minimum and maximum

> +    default: 3
> +
>    ti,micbias:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: Intended MICBIAS voltage (datasheet section 9.6.7).

Best regards,
Krzysztof

