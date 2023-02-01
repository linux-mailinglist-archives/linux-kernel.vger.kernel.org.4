Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A82686B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjBAQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBAQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:15:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB110C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:15:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1809514wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Akhmn5actGLIdiBKY1RGD6tVXjYHB9tU5fwD4dusjfk=;
        b=zBQ73vo7dvJsJ+CtZXk/NRBVjxrmhbQUB76WVjxpO0oevyeVPpEwF9Lh7S3wdr2k/R
         7ziUWECCiCoJO25xCbmKULg+l7tOaIu9Pbw/UAEo50BJR7wfaKwwBo0hRBzYrncVnbJb
         VxZVQ3p3jwVzbZWyq0nFo5pOttVFu2u9HAJvzXMo2z1ueiwrsa6THSAmbiJsqh3IHiNS
         kq2oFtkDH9/t/7ri3Mmq0o3X+89mVhrfSJf/+Bn+A6UPCChcvX2vUsAwVxFaJUcNEoOw
         GVwryHvoEP6+stLVooB16s0HoiSWYMqMCs+798XWMu+1AQRZfOB69je8Z/EhwLnVQXtK
         3Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Akhmn5actGLIdiBKY1RGD6tVXjYHB9tU5fwD4dusjfk=;
        b=Z3+AAwS0zobjBCjoMMsiz4Le/HFR3/9xJ7FZo7JOksV1Ttjq395vSYToLbjm54/WhN
         TY6c+e53jXL5e/Meh/BwspsK62RoE01iVMAF7JF9aG94RRc1gfbpYMZ/oHTrupzn5Y+6
         A2hv648jFcA4gmffFpaLvjUNlTzPMxIRhuNqHWrBXPYS+nL0qenpz5X616T/jUVlvkJd
         NomXz+/I0SBow/yvWunPbsnUY+dZoDuvovwJw+ymreAoBjAq1a8QZn/0Ax9pqBrv2VTA
         2v9dTFK15tqiiso90JinydBwOq9EzHQxdz5CYfR94zhm27q/SslzIwooIr74zQykr2RE
         jxBw==
X-Gm-Message-State: AO0yUKXMbasBu/TlxGGtidA4d5yTmiN13uiPrgonACmvpn8EVGzBb4a4
        eoFzZHbRAJYjYXv0/EHN6nWF9g==
X-Google-Smtp-Source: AK7set9b2w9VpCLvBN3+NqeaahdJlaPN4olEcUe0FTfkdcB4Kt9xYgGmXdXsMwrGnwEQhDaVIJmfmA==
X-Received: by 2002:a05:600c:1e0b:b0:3da:1e35:dfec with SMTP id ay11-20020a05600c1e0b00b003da1e35dfecmr2773018wmb.4.1675268129611;
        Wed, 01 Feb 2023 08:15:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b002366e3f1497sm17683823wro.6.2023.02.01.08.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 08:15:29 -0800 (PST)
Message-ID: <d4c1da7b-5b49-6bbf-4470-b3f2eef7f745@linaro.org>
Date:   Wed, 1 Feb 2023 17:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 3/4] dt-bindings: input: pwm-beeper: add volume
Content-Language: en-US
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201152128.614439-1-manuel.traut@mt.com>
 <20230201152128.614439-4-manuel.traut@mt.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201152128.614439-4-manuel.traut@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 16:21, Manuel Traut wrote:
> Adds an array of supported volume levels and a default volume level.

Adds -> Add


> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> index 1ebc3a46d934..6599e28ba5e6 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -25,6 +25,21 @@ properties:
>    beeper-hz:
>      description: bell frequency in Hz
>  
> +  volume-levels-bp:
> +    description: >
> +      Array of PWM duty cycle values that correspond to
> +      linear volume levels. These need to be in the range of
> +      0 to 5000, while 0 means 0% duty cycle (mute) and 5000
> +      means 50% duty cycle (max volume).

Is range 0-5000 limitation of the device? If so, this should not be
free-form text, but "maximum: 5000" (minimum is 0 anyway).

> +      Please note that the actual volume of most beepers is
> +      highly non-linear, which means that low volume levels
> +      are probably somewhere in the range of 10 to 300 (0.1-3%
> +      duty cycle).


Best regards,
Krzysztof

