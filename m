Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FAE60CDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiJYNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJYNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:49:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FC188125
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:49:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a5so8047123qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpMsl6jm+Q7wCngrxA8V9e6lKIjDRsrhMdY0rEbcY7k=;
        b=U25Lit/LeZq5grDHi3qdKXiEeX7SVegjsBdlFQVNI8Y/+CIItKiDh/VkZYmlMZhCcj
         wrhzatMIAIUCQBMENZQJ1PTw4YWCloorh2VrLys91yDQf5I6xnvCdRMK5smFHchImufk
         95NBA1uQDv1buxBEzMJ0rnCSFJ1nLAxGg4SGrUFhmn8W1dHNVI93vCwfz6owyWZ6uEPJ
         P8etiuR77cLMRq9F+uhi2LFGN9PG1swq6k7Mh65wvvAbRsOWUeMJ2ZZi7fWK3v7APd9C
         DkM/x6h8zI7lp0fj+9G27S+GiXnqRElbUUsm4lhmzM32HTO2g1yXMFub8uD56uM7nB2C
         Cmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpMsl6jm+Q7wCngrxA8V9e6lKIjDRsrhMdY0rEbcY7k=;
        b=q5l+NFW8wMpPcJCu0CPcbz4oIQvkYVR6W2sRkJDO0z2p3u2cb8M0j0a6bHZTRP3kIg
         bQdg69Hbju1UmNyMmXe3uMu19nRUaX0cx7WAVDJVgGMg+fnrgcYGVyR4nOitF9rW8OaQ
         mnZmef4uxusT1WQ9QuNGbcsm1lmJ15bhtXD6RA7ojy4SC6wEAQ32iODnpvWzjKn/BzzV
         rP1Hd33gpctq1R+lX9lYwfrKwNSUpFUYl2a9cYoK4wEPOlNdD7myJvCOe5T8OmgnReAg
         f39xK+udXO3+vZ9QhrvA5F9VxK65Xpz0wncaHXVopI166Assfm3EhOdg4wQEcOaaSnOd
         7qnw==
X-Gm-Message-State: ACrzQf3xCr9W6FXZTrVBwbtz9lwg8og8WaYDug0GmHxi8lFIb43EwIUX
        lvahNR3pAqGA78yay/+U69jbQA==
X-Google-Smtp-Source: AMsMyM46KU+z6yR+3aORkIfcWMzu0fiRjDj+ptUTf2IKXwGOYGCiiSoLHuVOkQ6CBKhP+B9aesllxg==
X-Received: by 2002:ae9:e718:0:b0:6ee:8335:4191 with SMTP id m24-20020ae9e718000000b006ee83354191mr26880375qka.83.1666705739392;
        Tue, 25 Oct 2022 06:48:59 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006f16148fa96sm2045473qkm.91.2022.10.25.06.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:48:58 -0700 (PDT)
Message-ID: <ca484809-07e4-44ca-0ab3-26947bda7fa8@linaro.org>
Date:   Tue, 25 Oct 2022 09:48:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-3-andrej.picej@norik.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025072533.2980154-3-andrej.picej@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 03:25, Andrej Picej wrote:
> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
> set and the device is put into Suspend-to-Idle mode, the watchdog
> triggers a reset after 128 seconds.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes in v2:
>  - add a commit message,
>  - add a list of devices which support this functionality
> ---
>  .../bindings/watchdog/fsl-imx-wdt.yaml        | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> index fb7695515be1..9289de97859b 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
> @@ -55,6 +55,28 @@ properties:
>        If present, the watchdog device is configured to assert its
>        external reset (WDOG_B) instead of issuing a software reset.
>  
> +  fsl,suspend-in-wait:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      If present, the watchdog device is suspended in WAIT mode
> +      (Suspend-to-Idle). Only supported on following devices:
> +        - "fsl,imx25-wdt",

You need to define such allow/disallow in allOf:if:then, instead. Like
example-schema is doing for foo-supply, just disallow it for some types
or use "if: not: ..."

Best regards,
Krzysztof

