Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D836D0C83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC3RRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC3RRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:17:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485A198C;
        Thu, 30 Mar 2023 10:17:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so19830905wrr.12;
        Thu, 30 Mar 2023 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LA2IwV0qcolNLpB1WThWYRy5+wWU9V8bs2U66OhQBA=;
        b=J93NMGFeVYKEAydswJOWeQn7uOTHHaHwPHnMxNLbBnZY5llx4YPlkkfXPhH9r1dUfl
         K+JSR2TT+0Vz/JEGLx+X4k49Pui5CsP+7JVlD+VG1La7bGar1xxyfZUU4shACBypaMM5
         cwh63GiXqAIVe8o2dZm9M1SiPe6u9Obarf0RlindwdSet6HJhhK06JqjLnzqe1uhJAvW
         0VFUQqgQN2YsqGndsiaoLqWq2N12blhh0ZIIb86hGhFjL6Hwf5BxrItcyRY/Cf2vP2eQ
         jgLDDObaerOSC0vCGMeMiENZI6Ced0MRzsE/zy7e1jQ0kmzTiae5PB9/HbDTXsn4uV7y
         7RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LA2IwV0qcolNLpB1WThWYRy5+wWU9V8bs2U66OhQBA=;
        b=oCuCiQ1BoovUYFXYZOn9CJuxQt5ikrtSBPhVWZFc5QDCeokLrt/4mk7qmRKwL1W8Ch
         T/igrnhI4jerYFjZWDHsUVS5rHaRbaY7ObWLn+WszO0o6vtzccwTQe70wLL7EBH3RTkD
         wRSdghHZl82tdKrf4znvpOng78jkMq4ziK8jWIc/p6k2egF8JJOfC0C9S+ohHjGDaTFn
         l5YvvKLIEgRPfktYUP+Btiu4fpl6O7faFydB38+BDU5xDmeNv5sZu0xynWAbZWkSKEUS
         MlNZ+0psbpSYxLE9FbB/jSJaaWytZdX5BY31iGGmOl0XlXQbyc7YGDmGRxmtkPrC0aOp
         cNiQ==
X-Gm-Message-State: AAQBX9cVpM9p7H+Pyj5dqWkhlLC4mGSplt/U60feupuGDMSlR1vSY3WC
        TKGx2Onnz4FWQLgNIU/5o4c=
X-Google-Smtp-Source: AKy350ZICVwELuVoiqheQx2dXbJAbjZbwpXeu5bLm0jH0vGD3tsNDeyb3+BPitPCwxq1WSnym4K1+A==
X-Received: by 2002:a5d:62cd:0:b0:2e4:f53a:45a1 with SMTP id o13-20020a5d62cd000000b002e4f53a45a1mr1712752wrv.57.1680196650320;
        Thu, 30 Mar 2023 10:17:30 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b002c55521903bsm33155272wrt.51.2023.03.30.10.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:17:29 -0700 (PDT)
Message-ID: <b0ef2a0c-9390-65d5-56ec-f7293b87f20c@gmail.com>
Date:   Thu, 30 Mar 2023 19:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 02/17] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-2-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-2-0003e80e0095@baylibre.com>
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



On 29/03/2023 10:54, Alexandre Mergnat wrote:
> This SoC is able to drive the following output current:
> - 2 mA
> - 4 mA
> - 6 mA
> - 8 mA
> - 10 mA
> - 12 mA
> - 14 mA
> - 16 mA
> 
> Then drive-strength property is set with enum to reflect its HW capability.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> index 4b96884a1afc..101871ec6693 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> @@ -79,6 +79,9 @@ patternProperties:
>   
>             bias-pull-down: true
>   
> +          drive-strength:
> +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +
>             input-enable: true
>   
>             input-disable: true
> 
