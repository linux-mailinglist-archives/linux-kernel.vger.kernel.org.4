Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3005747D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGEGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:36:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D310CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:36:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so701105a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688538961; x=1691130961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhs9m6LdfQjO4hyKiJYh94d04C5WWilEh/gmMxzh7Mg=;
        b=OifH0PPU6stFG96GVTSC8B9P+NPfFo4gDZjXlCvglxsDaIqPyOK/Li14XPMY9HUzk3
         rTob8edPPRBSiGbRJl42wSU2MV8REYjGZU6gv0+2HD0Dy5/1haCfcAtU1WUXXfBAKT1o
         yI2bLfPqUAD5dHMvZciOaxxukTq7CEJwbDJu5fnGL8i1dq23HkUQs+EcBs++2YauQaSX
         UzlCzl4SNMtlUagtLuLXQNTgBJb9IgyHbqz1P+6QDLpFFCmKNupmE6opDV4S3/s7B/N/
         HD0pgzWaBc0lhGtlcFq5Q7+ehcNkzFscBqKV+D2JI1+9H/A0Bruhjtoq2U4YJoA5D1rv
         M1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538961; x=1691130961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhs9m6LdfQjO4hyKiJYh94d04C5WWilEh/gmMxzh7Mg=;
        b=P/4OZGUXqVqHT5wi7KvR5CZwfsTb+IfsZpizlczxZO0Wl7LIRxHL2J/ikgEFmUWAAc
         hJvO2bKw0LISovbyJQpcdBXPdTwryuvJUTYMqwTEmaSbFwNUDelywZ/+vCi0JsEJ8WHO
         Za5xEXC8NkjoU1DHbN3C974hfmZxhKUP+UAvG4/bA1sScn5Fc1R08Lna54zyVGI0Kl9C
         eulauJz/xOnMo1wecLUEVoeBHLZjAPp+kepoe4gH0PinbBdymxkiwfQEG2BubtXDP2Uo
         HxLbCqKdHYEC/OtHpbjzVrYwBQx/6Zq0PVCQnISDaIWwHz3vim5rA5PiqozgFFx1AYAW
         ++FA==
X-Gm-Message-State: ABy/qLZ+Pm/vwj9a2EVPAC+r4lUEIls8HuqP3Jxgx4kqzuBsZfL7vW1z
        7nJOSn5fATm3BhbegpbsoHAx6w==
X-Google-Smtp-Source: APBJJlFkwKF+LXGFkbwM7CB5YyL4871N5XksN0J/wVQgdLDYbFJN7dB7YfNLfHchdfPRO5trWXwhNQ==
X-Received: by 2002:a05:6402:274c:b0:51b:d59f:8518 with SMTP id z12-20020a056402274c00b0051bd59f8518mr1324811edd.16.1688538961304;
        Tue, 04 Jul 2023 23:36:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm12597752edb.39.2023.07.04.23.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:36:00 -0700 (PDT)
Message-ID: <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
Date:   Wed, 5 Jul 2023 08:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704184109.991104-1-m.felsch@pengutronix.de>
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

On 04/07/2023 20:41, Marco Felsch wrote:
> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> corresponding bindings by adding an own entry for it.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 15d4110840654..d9e763ef932e5 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1019,8 +1019,6 @@ properties:
>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
> @@ -1054,6 +1052,13 @@ properties:
>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>            - const: fsl,imx8mp
>  
> +      - description: Polyhex DEBIX i.MX8MP based SBCs
> +        items:
> +          - enum:
> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards

Same comments as for patch #2. I think this should be rather deprecated
- not a good pattern.

Best regards,
Krzysztof

