Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD76E120B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDMQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjDMQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:17:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9117280
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:17:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f26so32675193ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681402631; x=1683994631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEOFxKNy3U0Hgu4EBIZNIx+9mDifLsjK29cZX/KJbkA=;
        b=K0rAxBszub74dCkhRGXZMGBJaRQlKup6HorTTNc5AbEVh92+AAOVjPcB4sEghRoSAx
         MqSP4jfNxZI2LffWurhn8/y0fBzGzT4mRT+XzJVCDAvBjuR+tdMkfC9fiMz+1/rQOAkY
         hKngEF6/jLVK8K43aw065epwWgILkqwbZ0ZaQ89+ojx8DlbE7kzuvSBopGOUK4A7idIc
         8LLyn25iqgsK6ArjS3oPJbqf8LDkVtjRfkIqFmu/vUUamfnGGiEm+hTuzV6Tw22F2DQV
         6yEF72MtFX+hmZ+So85NDphM2zUZnZfW8e1398WZpOBK+UfkRy0wIbKyEBHX0SYXpswn
         Pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402631; x=1683994631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEOFxKNy3U0Hgu4EBIZNIx+9mDifLsjK29cZX/KJbkA=;
        b=WmUlSpEzGiNfzy8HyGPjQtcGfwS3EHQaizDHhvRScDG3aivKhv/HUFBypc5KVrpA0r
         PPwO9sYmy1yOAXMeQq1PCacs/X59gZAJwGMlM/WjzYUN6VYGE3eN738Qlbyuo4arG3jh
         FV75vZuVV84t3ncMYpdMzJ0JUhwk2Fx5x+emEIWj0+RL8Zzqg4cVNxZHu4jg/k78+YIV
         7xtQwcwa2ufvVROsg0a2nsRB/08pzjrlV9dyo4oJJMtAvBKgfb4NIFhpqeEqqq05aksg
         O9+Zkl59UWZpiFmdZvfz0BE7Qr9nJkde/E1QrtjUx1eDdv7hNmIrYHG1E2TtL0vmyRgv
         cBiQ==
X-Gm-Message-State: AAQBX9c0EBF5TQopGCV3Xrii47enl8ea6UTW0NZm4S1ho8aMLE5rvWbV
        3eHh7u6IDmgSG5/v3l2V++DRQQ==
X-Google-Smtp-Source: AKy350Zeo4tNvuyj8lC6EBUYcdMn48Z6g3oSrpCwSIcWdbZYsDPng5J86Mqq3pWEbgJqhj5TZTigiw==
X-Received: by 2002:a17:906:3cf2:b0:94a:74b7:43e4 with SMTP id d18-20020a1709063cf200b0094a74b743e4mr3151258ejh.69.1681402631579;
        Thu, 13 Apr 2023 09:17:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00882f9130eafsm1170488eja.26.2023.04.13.09.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:17:11 -0700 (PDT)
Message-ID: <653a9c34-7699-13d4-7599-f64e43345b14@linaro.org>
Date:   Thu, 13 Apr 2023 18:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v9 1/2 RESEND] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        William Zhang <william.zhang@broadcom.com>,
        Tyrone Ting <kfting@nuvoton.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230413075327.1397306-1-ryan_chen@aspeedtech.com>
 <20230413075327.1397306-2-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413075327.1397306-2-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 09:53, Ryan Chen wrote:
> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,enable-dma
> and description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

>  required:
>    - reg
>    - compatible
> @@ -57,6 +73,26 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:

allOf goes before unevaluatedProperties. Use example-schema.yaml as your
template/guidance.

> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-i2cv2
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +      required:
> +        - aspeed,global-regs
> +    else:
> +      properties:
> +        aspeed,global-regs: false
> +        aspeed,enable-dma: false
> +
> +

Only one blank line.

Best regards,
Krzysztof

