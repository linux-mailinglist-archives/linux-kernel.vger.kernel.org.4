Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0E604C62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiJSPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiJSPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:54:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459215A317
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:51:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i9so11669262qvu.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFqLEGUzpiVO1+2P52g6TS8O0gkAqr8zlFG6DWw04Gs=;
        b=JJW6jtt3ZMWkdIABGoHVnFfx6CZE87gFuMr0b9unxJyBPg+JUQoakx4dWxJrGzX9d9
         OZANzSdANQ+k3dOKcy25LJfUFGPFF6OPZuCyLMBzYkj+VeWnwjbLm2BMzUadK+OdPJ4M
         YqhMg+y+KWzmUKgrpGdEfBmlp4ovkncAg3jfslrUN4tjMLNiiijB9CKxYWzaJA94juf2
         bnkD50cJaMCeXA5A00/5YxXYyvDdTPgeQNw224KAfNAtx060aT/yutpFNyeL2rRyPCVC
         EAuU4NdXb0/jIT+J/pWnZKP0R2RjE2FY2nULpVoYygr5XlHCBRszM8AVuHZDuao5Ifcv
         L1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFqLEGUzpiVO1+2P52g6TS8O0gkAqr8zlFG6DWw04Gs=;
        b=hZrvvivd8O7tXmHYrlZtpTefmZEPAQse+V40UDS0qjQMXXhWim8evMiQCtpouCQ4bk
         3r83S45UIWNJgkQBSFi9c9WN77nmI+GvsWdZ/5W2UK+2bbF2yMLTTtzlumKClGVIzhbJ
         541QPXMx6Sa0rpnwj/lq7cheOHbDlr9UkJaClC/lPvK2VOsuyS/BgzUG2BBJaBoy4Qqp
         lXi0B2JRyeZ5uIBM8RWFT9wyfZSC5asEXiBIgN4xDLKSIJ2f2K/5jvGl0jl52AHiecc1
         ni1QNK3s4aX3kBeD0ymr6eORY5EIdiR/pS3IJ0e8WdHLZFjIJY/xZx2KFkNLemh0Ou+h
         z1BQ==
X-Gm-Message-State: ACrzQf0I32VOH4Qs85QlMTytwpTHXsnCRMsNPCmQBG0AaVMkZiwwaXxg
        n1WwxSJLtbgqjk1qAtr01gzz2Q==
X-Google-Smtp-Source: AMsMyM4/vU9X/eTGGnSWw6kfOlAWtgN1f8wnRekjRIM1GmBfWGM+ONIx108lZzbU1PEmcIcGvoM0AQ==
X-Received: by 2002:a0c:df11:0:b0:4b4:ccd:ad5a with SMTP id g17-20020a0cdf11000000b004b40ccdad5amr7096319qvl.111.1666194688485;
        Wed, 19 Oct 2022 08:51:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id g22-20020ac84696000000b0039d03f69cf5sm714630qto.72.2022.10.19.08.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:51:27 -0700 (PDT)
Message-ID: <56118d35-dfe6-f46b-9fc7-28aca6530fb5@linaro.org>
Date:   Wed, 19 Oct 2022 11:51:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: fsl-imx: document suspend in
 wait mode
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <20221019111714.1953262-3-andrej.picej@norik.com>
 <7508670.GXAFRqVoOG@steina-w>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7508670.GXAFRqVoOG@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 09:00, Alexander Stein wrote:
> Hello Andrej,
> 
> Am Mittwoch, 19. Oktober 2022, 13:17:13 CEST schrieb Andrej Picej:

Missing commit msg.

>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml index
>> fb7695515be1..01b3e04e7e65 100644
>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> @@ -55,6 +55,11 @@ properties:
>>        If present, the watchdog device is configured to assert its
>>        external reset (WDOG_B) instead of issuing a software reset.
>>
>> +  fsl,suspend-in-wait:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      If present, the watchdog device is suspended in WAIT mode.
>> +
>>  required:
>>    - compatible
>>    - interrupts
> 
> What is the condition the watchdog is suspended in WAIT mode? Is this specific 
> to SoC or platform or something else?
>

And what happens else? When it is not suspended in WAIT mode?

Best regards,
Krzysztof

