Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7968D49B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjBGKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjBGKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:41:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B00728C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:40:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so12811051wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/upuEtRcIb7t8jvkFIGw73o4E9xTmHLpfwjgu7vvog=;
        b=xw6a313nqg5Vp68/k8JMPw+tYjF7bi9pacjL76AWkrjYhX+Rler2qrkyV0uEt8nzvn
         K/WGubh5JJ53381qBwcTKN7uXou4K3un/bPCLYKK8P+TO6iVo0K/rR9+SJuKnfuCmKqt
         vfkrj+yWRJfF+ZOOw6atQ6BotdDd4OKunjxwBn7C493WRS5ygMhiuVnXefqNZt7RAoDJ
         ktvypPe3pyI2w5ftH/dZRkcoOMbjqGbBCq0VDQ4T6Rg3pq7QXPYkKFMg8Wkn2MLA2Clv
         EdSrOLL9IqsdqlzK4juFevOmk974/ZlVwfET6wdR5vF9imwKGzSIMd7Iz0tb4S9kDj/4
         fpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/upuEtRcIb7t8jvkFIGw73o4E9xTmHLpfwjgu7vvog=;
        b=2DoObz6dAfKKEu9tKDBShSl941AcE5e72f9VgAgg2hF94N326ZfGVBLZwe+NVFI2mc
         QAjTCr+4RtAqxnib9kcNEVtBiQjPrDzaqv7DHUelv3G6HeVOOpginkEQrBhZNh1o8mVe
         F5on20fsv8naKsbTWWO9ez8CN1QPAFf2yYptrrC1WIp90+ndlSJDzcCO4+vA1iOyQ8Ae
         TjvmrkwK0xHDPzXAPBn6OR+SiqAW99Q+CBBrRFn65AByp1dV9+4dUtNrLZU7Hg3WX1US
         Uv5LsJ4+wgjWFxdc/AcVbNvnfLMcBqH5MYZW3Uee3UyDPIPTvIOh28FuOTPalB1wbWi7
         jgBQ==
X-Gm-Message-State: AO0yUKU1q7IuII4/vtvOKdXk+lyif0jsycxG9KeYj9eXLvrpwOQtkyQz
        hSD3Wu6WYlA7fK4JRGjCURAOLg==
X-Google-Smtp-Source: AK7set++tMAbtKYfer3K/a6e0NKT20sj2Nwd4RyicjOcCLQfigzIPlZVwOvPItlJKobUBErghQxVbA==
X-Received: by 2002:a05:600c:4a9a:b0:3dc:46f6:e607 with SMTP id b26-20020a05600c4a9a00b003dc46f6e607mr2689936wmp.3.1675766453918;
        Tue, 07 Feb 2023 02:40:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b003dc492e4430sm14092696wmq.28.2023.02.07.02.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:40:53 -0800 (PST)
Message-ID: <fe3673d9-b921-c445-0f5f-a6bc824e8582@linaro.org>
Date:   Tue, 7 Feb 2023 11:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mt76: add active-low property to led
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230207102501.11418-1-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207102501.11418-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 11:25, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> LEDs can be in low-active mode, so add dt property for it.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index f0c78f994491..212508672979 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -112,6 +112,11 @@ properties:
>      $ref: /schemas/leds/common.yaml#
>      additionalProperties: false
>      properties:
> +      led-active-low:
> +        description:
> +          LED is enabled with ground signal.

What does it mean? You set voltage of regulator to 0? Or you set GPIO as
0? If the latter, it's not the property of LED...

Best regards,
Krzysztof

