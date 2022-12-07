Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBC645577
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLGIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLGIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:34:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132BC09
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:34:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so27565093lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 00:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsMHoSaJZ/RmJWdf5f3TFvZf4OfNz9sV6+JBNDP4JV8=;
        b=RS1tYNNTr4s5/nVaZsPTphJUqpmI0PC7gXP5BV7VNKTgvo0H59b/NZr8r4YH46ySv1
         VGfv9BCb6EOmvgp1Eq7H+qXfi+HLOuRctW+5HjzirRY9zHHYEiPXKPAAFlfP/Da7+kJm
         l2ISIXpW0vdyex6GvfAmtaIM3QV5I6YnRsQEZD6RP3uSfOCaC/7c2tLH6EX0Y47tuWH2
         GNXVXRaIWT+YGBcxKNmhBS/3uhB/NQo2YdiI9oPQKA0tasCQEG8W2fnRZyNPWTlgp1Tt
         vXg64YT7CKGsa45zYt0PJRFpGgUekQB1CUSM9bbYSiX8g9mZzeiC0PHk9MXPP3xHxhfm
         VY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsMHoSaJZ/RmJWdf5f3TFvZf4OfNz9sV6+JBNDP4JV8=;
        b=4iIXF+i199A6dtiiHY/MVbhk2KNGCcrtrkmXie/KjvefT6izwB07TJ4IyuINReEPhf
         yOjaI+/M1S3fxJ/b3TviS0XY2HBdublU/tIaOF7Nd2pTd+BixVy0Wq9Fi8oB2SdcnNK+
         Iw7W1E+ERmcrXTTUwW5nbx9RSeI6F+lpyE2MTD0fFklWk3dTRrruAVWsgez/042ikZVI
         EzbJ4xh1RDSyKqf63bET4KSYbup2WPRFa9EVh9WJceABBrcwul8Eu2QZZ8SkDv8BNJy7
         dTkO+MXJoABvfyKjcSx7Ce0R9uZMW3H2Uq14DtDoQn3E4a8TIvZ246tV8s9WkCo9mNWC
         gHuw==
X-Gm-Message-State: ANoB5pnSuwwDFyCjBBUhPZ8FXfbei2xgBfjwCXWm5AVUkOtrAB7tWTRM
        xmZaww3qTmV1J2rWYL/WMBukI/1gS8SqjNZ18LQ=
X-Google-Smtp-Source: AA0mqf7h5ps7QVnOjtRWOYiJ9KoucFsWpDpiwRb0Iry1x7BcWGRKX0PTDzE2sRvZRoqLdphHr0xT4w==
X-Received: by 2002:a19:c217:0:b0:4b5:88da:17e0 with SMTP id l23-20020a19c217000000b004b588da17e0mr1851841lfc.71.1670402040027;
        Wed, 07 Dec 2022 00:34:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o21-20020a05651205d500b004a62ff61b3dsm2777517lfo.252.2022.12.07.00.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 00:33:59 -0800 (PST)
Message-ID: <8b0ea3e8-1ae9-bb12-a468-f74f69983b8d@linaro.org>
Date:   Wed, 7 Dec 2022 09:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] dt-bindings: spi: spi-fsl-lpspi: add num-cs for lpspi
Content-Language: en-US
To:     Han Xu <han.xu@nxp.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20221206225410.604482-1-han.xu@nxp.com>
 <20221206225410.604482-2-han.xu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221206225410.604482-2-han.xu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 23:54, Han Xu wrote:
> Add num-cs property to support multiple cs for lpspi. This property is
> optional.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index 8b44284d30c6..94caa2b7e241 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -56,6 +56,13 @@ properties:
>        this property to re-config the chipselect value in the LPSPI driver.
>      type: boolean
>  
> +  num-cs:
> +    description:
> +      number of chip selects.

You do not need description, it's already in spi-controller.yaml.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

