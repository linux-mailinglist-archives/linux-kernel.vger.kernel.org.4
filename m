Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EE717B96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjEaJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEaJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:17:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBCC0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:17:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so973811966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685524659; x=1688116659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OADC3RfZz8aGJuKXNoOKeJUa9cEawhPV5nN0Ge23Nzo=;
        b=Ff5Z9vs7m6+MWJxaKpqar6M9LALIChP6jBiwVtVzc3n81B4S6RoiYfhqOP9ZQc9L7O
         rZ5u0Q584Ng+8r4dGqx6ZmwULpo/ZwLqmQwRIXxmMpCZk62etI4oJ6VFEIgKKPKJlutf
         w0hZ55SSQ05ac0O3gXNybzXJVMaNAm/CgG9+KAONDSZDvxPdwo//S1wW29I/iLlatzkI
         SsF+EUEvnnGaeyzAKP8wfRFHMUQUNkXlfbFzCj8xM9SM8fbwUL4jP8YiRzzX1Gu1sDVu
         352fRp8qaqO5ANlDAbN1Lyxvm65fWCNG8Di7lWIuaTR3w8dmciNewyu1zGuLUvFq74Ye
         kccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524659; x=1688116659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OADC3RfZz8aGJuKXNoOKeJUa9cEawhPV5nN0Ge23Nzo=;
        b=E9Qa3gbT6hPbfWi3scps7dxQnoQP+kfSzEylbGl6nWmMSrIQ/osvpW3VxR4bHPC3Ur
         IhvggksQsjQzgyXgrqXqmLqecAhg322aZu+jMDOiUNwsD6NEyPChqnsTIi2V8+wMl901
         vYfA4l5p/VJt+IZXSUQfVZe2oJfqRgQOneZdwB0EY62dNMd7TtGqXOPdXzNgbZxttvwM
         LamdTxHt058rAJm5F9+DKfu5mvQ3ldo+mLToxGp40+4SP8IAoT2WMX7ppN/vjbVZfP9+
         v31lJsEeE+ENtDNdXOlwMf2b6HNWj6IKNU4rBk2ZM32NrZmP5me4r1h9Qf8dhi3zktR2
         peSA==
X-Gm-Message-State: AC+VfDwjlTIFL1draFQRBDBdiJ70q+TiToC0PeACidChCmknUEmLUDu3
        4q1YICAfBQmAYoueZxzjYnWFXw==
X-Google-Smtp-Source: ACHHUZ6Mwh1uhjbIvXzEqr7u6gpp/I8WIdGTzFCAjeE3E4N0lM8OSIEEpXCjuHkrdJ3YTuCvJFnGrg==
X-Received: by 2002:a17:906:6a0c:b0:973:daa0:2f6 with SMTP id qw12-20020a1709066a0c00b00973daa002f6mr4796212ejc.3.1685524659193;
        Wed, 31 May 2023 02:17:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906b28a00b00965d294e633sm8682465ejz.58.2023.05.31.02.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:17:38 -0700 (PDT)
Message-ID: <1f966e93-50c3-142e-620c-8fbb16e9b1a7@linaro.org>
Date:   Wed, 31 May 2023 11:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: power: supply: Fix rt9467 charger enable
 gpio active level
Content-Language: en-US
To:     cy_huang@richtek.com, sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     chiaen_wu@richtek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685522813-14481-1-git-send-email-cy_huang@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1685522813-14481-1-git-send-email-cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 10:46, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The RT9467 charger enable pin is an external signal that used to enable
> battery charging. From the datasheet, the active level is low. Although
> it's already configured to logic low at driver probe function, but the

NAK.

You mix two different things. Driver behavior and DTS. Driver can
operate either on real level - matching hardware - or on logical level
(high as enable, low as disable). First choice is usually wrong, because
it does not allow inverted signals.

'Correcting' bindings to wrong approach is wrong. If the signal is
active low, then the flag is active low. Simple as that.

> current binding example declared it as 'GPIO_ACTIVE_LOW', this causes
> this pin be output high and disable battery charging.
> 
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi,
> 
>   This patch is to fix the active level for charger enable gpio polarity.

This is just example - it does not fix anything...

> Currently, the wrong active level makes the user confused and
> unexpectedly disable battery charging by default.
> ---
>  Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
> index 3723717..cdc7678 100644
> --- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
> @@ -69,7 +69,7 @@ examples:
>          reg = <0x5b>;
>          wakeup-source;
>          interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
> -        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
> +        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_HIGH>;
>  
>          rt9467_otg_vbus: usb-otg-vbus-regulator {
>            regulator-name = "rt9467-usb-otg-vbus";

Best regards,
Krzysztof

