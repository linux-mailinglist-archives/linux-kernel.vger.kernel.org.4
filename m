Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C577507F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjGLMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGLMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:16:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA07198B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:16:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991f956fb5aso795192766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689164203; x=1691756203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3tdXiD5wr9JnyQXntDLG7PAW3+GvtZ4ULR/Zqmp97Q=;
        b=GCdQl6RnbOvQWTWaWhs0iVW9kQZA2bgHR2Fn9V97rdMSEMmQNonrVfJIb+Y9T77v2F
         3x+EvtoHz5TmhqdxASdYEqvIA/vHqePLvCs8+6PdH+zA554vHgB3GVlvCAZ0HJtNgTxW
         ZqrITLV0NCkYw6ZlMxz+CVS+RoQyI+28MCxD2PgQzStFIObEfKySIXYsCgk7gAx9JFni
         bYyy9MvoHbE7dxIRQz9IZ8WN1tzmNCpsSqHFI+4bCYPw05xA+/Mr+XBir1eHuakVJIgx
         k5cL+THNW7keMTtPb3SSbtcaumy8/eDwkfjR+2t6rXLAivDNhNpMv0H8SiOUPeaky30g
         czsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164203; x=1691756203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3tdXiD5wr9JnyQXntDLG7PAW3+GvtZ4ULR/Zqmp97Q=;
        b=PC6ixxOxXN6BXhD3Ibqs4owu7NfQSF9Bv42BRkuS6Z68kMxsuC7oZ7UmzuaCNumWQH
         p+iu7Z2aMr3JXdfTeK6rB+cJM5Y513ooPbiGEZ+tRz6WuH86xRkA+mYkg2T8TN094H75
         Tj/Ga60QdErk/2777o3VlxLPFQ+SnKWoWCu622LjEIvPrr5WB8SEdiSePBK+Jl6y2ULC
         ulv4Si9jHlX1/U4sSIM8Rtfr/JiRMdpxHsvTfs/PGdP0onnlnhIbWSDQ83RHHL01ou9f
         Y1Dd7Tq89gOc3JEj6SnX42x85vOKDW9T1xxozfiuguxU7VipL+pLk58pOT/pR51yTOgJ
         k5LQ==
X-Gm-Message-State: ABy/qLYF7prtqfeAlIYVZ9mJtjwwSrRRiaxlzAVFkJhIf1X/YjGYCQ2Z
        40o7+pWquLAW518FWlUZ4djNHQ==
X-Google-Smtp-Source: APBJJlFx+jrZFyBuraqqdj0Id4oWo944sq2YX36L9OvynOWQaSrVLAOzGb+MkpUtb1189k+Nn2RyJA==
X-Received: by 2002:a17:907:8001:b0:96a:48ed:5333 with SMTP id ft1-20020a170907800100b0096a48ed5333mr15028000ejc.50.1689164203534;
        Wed, 12 Jul 2023 05:16:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906661300b009920e9a3a73sm2490505ejp.115.2023.07.12.05.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:16:43 -0700 (PDT)
Message-ID: <4747d535-43c5-6054-6823-c708c757fe6b@linaro.org>
Date:   Wed, 12 Jul 2023 14:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: cypress,cy8c95x0: Add reset
 pin
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230712085236.2496651-1-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712085236.2496651-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 10:52, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> This patch adds support for an optional reset pin.
> 
> The reset pin is used to bring the chip into a known state and has an
> internal pull-down, allowing it to be left floating if not needed.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V2:
> - Update subject
> - Update reset-gpios description.
> ---
>  .../devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> index 222d57541b65..2fa22160336f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> @@ -51,6 +51,10 @@ properties:
>      description:
>        Optional power supply.
>  
> +  reset-gpios:
> +    description: Reference to the GPIO connected to the XRES pin

I asked you to remove redundant part...

Best regards,
Krzysztof

