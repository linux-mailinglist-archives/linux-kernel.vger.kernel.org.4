Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74927701CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjENJxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjENJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:53:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CBE60
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:53:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so102637507a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684057989; x=1686649989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5td1zFzjwswdtQUzZm2qAYTb8ma7e15DGPOsN8yybJM=;
        b=l7IkWqf7it6z5yyMPRfguVicyVGXYVQQqJACIRbu6caKtShQVVJWXDGnE7qzDKr1DT
         1pqkEOQSZAYQAA5pvFvInzyzyQENqajcbE/fEKlfdA/512f/ItLq07GwfBHC09jHmfGU
         lAbJHoW2UNaRdRPxB7/SF/0mRs08zL0ZwilP/SfneLADWKPbi3B3vocLbfYwYfc3stvU
         dBiVPVAM99DEyLRC1LeDFaPGjKI7E4FL9BSHWEuCRBGDZlABiUUEPpwvZImLshoUQT+L
         /XRs3TYZmSJzfKRUf7vpfrs4wP9TpXkVLXc8FLWNAVXNIiqdJz1gn+B2I4RWJawxPMRo
         yqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684057989; x=1686649989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5td1zFzjwswdtQUzZm2qAYTb8ma7e15DGPOsN8yybJM=;
        b=j8JRn2Cj01ag04HtTJMrP3OqoM61jlclY9dxY1Dl61zmXzxubyczu7UaQFX7XOUEZX
         rM47pyxZX5UH/t1lqq/6ciuSpv57wmWyvId32P7T7YYqQrkPxKZvJEIDBJwPegE0521T
         o80B7jkszhnNGIXp8W+0kuNyjxtMgpIunXp1gUHOhv7b87vKM+JkvAHbDtWp9nCp6Oxm
         0kYcDgosXwazTeBUkZBDyPkwcCRhNArZBnhgAg/4xvfrRqQ6K8sLxffA2JgRlZcogzVr
         KtBacB6FEN9XEpycboUjBZW1KfebrfCw7+G0PRTQHLtaH8wSzePGCQ5dogcIgHhKaSDK
         WXHA==
X-Gm-Message-State: AC+VfDz9U/9tbinRECCYDNaROgdpgbuENvNcRc+jq+nMnEjhbx2DSlH/
        Ba7J22E0bQt6CXo60M4oHcScaQ==
X-Google-Smtp-Source: ACHHUZ6CkXWd/pZpqvfVoXJ5tZLiTdhX5tO5tmv1SAUtxGzZlxT8mwVGfi0k090uOBPNv69O2GtcDg==
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id y6-20020aa7ccc6000000b0050bdfe20091mr26633387edt.7.1684057989471;
        Sun, 14 May 2023 02:53:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:715f:ddce:f2ba:123b? ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7d157000000b0050bfed94702sm5715746edo.77.2023.05.14.02.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 02:53:08 -0700 (PDT)
Message-ID: <37db7c8e-a715-61a1-159b-0ffe15f1c7c2@linaro.org>
Date:   Sun, 14 May 2023 11:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: net: realtek-bluetooth: Add RTL8822BS
Content-Language: en-US
To:     Rudi Heitbaum <rudi@heitbaum.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org
References: <20230514074731.70614-1-rudi@heitbaum.com>
 <20230514074731.70614-2-rudi@heitbaum.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514074731.70614-2-rudi@heitbaum.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2023 09:47, Rudi Heitbaum wrote:
> Add compatible string for RTL8822BS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>  .../devicetree/bindings/net/realtek-bluetooth.yaml  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> index 8cc2b9924680..d2103931fc1c 100644
> --- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> @@ -4,16 +4,16 @@
>  $id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
> +title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822BS/RTL8822CS Bluetooth
>  
>  maintainers:
>    - Vasily Khoruzhick <anarsoul@gmail.com>
>    - Alistair Francis <alistair@alistair23.me>
>  
>  description:
> -  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
> -  is connected over SDIO, while BT is connected over serial. It speaks
> -  H5 protocol with few extra commands to upload firmware and change
> +  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822BS/RTL8822CS is a WiFi + BT chip.
> +  WiFi part is connected over SDIO, while BT is connected over serial. It
> +  speaks H5 protocol with few extra commands to upload firmware and change
>    module speed.
>  
>  properties:
> @@ -23,11 +23,14 @@ properties:
>            - realtek,rtl8723bs-bt
>            - realtek,rtl8723cs-bt
>            - realtek,rtl8723ds-bt
> +          - realtek,rtl8822bs-bt
>            - realtek,rtl8822cs-bt
>        - items:
>            - enum:
>                - realtek,rtl8821cs-bt
> -          - const: realtek,rtl8822cs-bt
> +          - const:
> +              - realtek,rtl8822bs-bt
> +              - realtek,rtl8822cs-bt

This won't work, wasn't tested and does not actually make sense.
Depending on your goal this could be added to the enum above... or
anything else.

Best regards,
Krzysztof

