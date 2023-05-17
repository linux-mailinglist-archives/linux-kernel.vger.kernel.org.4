Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F0706BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjEQOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:55:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD49019
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:55:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso937234a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684335310; x=1686927310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuaNZ4qT3VnOSKAHjsPxE9vvu/wKdQkttBJHmfbu46M=;
        b=YLMSz5sCr/yKeJHAUxPSPb2tqXm+IZeIWiqfkhSTMOozshLHws0by/v1Kw9Vv7Jq70
         IhkQvQUKHEDdv+MrPToptJnmeA+wbR3t7mft04XND43+PMHjblOr8oFPvbd5f3FG+FnW
         4mBmN6WiaPqEZIlQaYjqWSKqMpX0c6tk4ySutPkgaxORQ0uygdC2dX+1bs60O0LjwUo8
         y8NNuVuVbwE/4uuq/R9AXdjWGFYftW4uryXSYj1yBZ/cGnyLMUAzsPvheG2cXkv5ZmqQ
         ZPO6RGrlTLip3EjkwXcWsfH2Bb7rHkCU0SivjsSTSjpZ5d9HCRSo/QwiToxIwOMGpKwM
         5GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335310; x=1686927310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuaNZ4qT3VnOSKAHjsPxE9vvu/wKdQkttBJHmfbu46M=;
        b=K9eNDy+s6BXl5Td5XotCjHobhgrauabAylWSqRCnd4N/Qz9vbbWwX31IxgsT3SyYCJ
         eH6pejPhLv1cmWrpIMZ6qg9y8+gdOXWNdRxYN0d5rEMjpzgFbONSs/6//N4i7p6Ikl7s
         C6/P9h1XGR0PHYGdFPF/v0UaFEVTclvuwMN0luU4nAqoasCCRlEQMnp3N9DlAarQGWV2
         jta6+505zLptChh2+xF+Z1jAJFJ5g6G+B8IhTjf79a+sWm3ROD4r+u+ftMRy4yIeET9e
         ++iozyxmslMNPTZKess2vkzm0UUAj7DA2UVL0+hkiX71fRhZy4uSVbEp2YlNCCsTpeDH
         ZAuw==
X-Gm-Message-State: AC+VfDzbYuqrZvEsT53w7JvPdipGP60xtBow4/LVHFrTqRyPX3jyTGca
        SU6lW3IJeM+RG4WnhNgXyeSs3w==
X-Google-Smtp-Source: ACHHUZ7aBr3hTmUS/LPx8wWBXM9iju8dtYni/FIkn1fHA2UCheSCYCr+4Vq8hjAbA7eI7zTa6dqUEA==
X-Received: by 2002:a17:907:9347:b0:94f:322d:909c with SMTP id bv7-20020a170907934700b0094f322d909cmr34154508ejc.34.1684335309988;
        Wed, 17 May 2023 07:55:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ta26-20020a1709078c1a00b009663b1addb0sm12334186ejc.224.2023.05.17.07.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:55:09 -0700 (PDT)
Message-ID: <a82e553b-c21d-0955-be77-77028806b314@linaro.org>
Date:   Wed, 17 May 2023 16:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/5] dt-bindings: soc: qcom: eud: Add SM6115 / SM4250
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230516213308.2432018-1-bhupesh.sharma@linaro.org>
 <20230516213308.2432018-3-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516213308.2432018-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 23:33, Bhupesh Sharma wrote:
> Add dt-bindings for EUD found on Qualcomm SM6115 / SM4250 SoC.
> 
> On this SoC (and derivatives) the enable bit inside 'tcsr_check_reg'
> needs to be set first to 'enable' the eud module.
> 
> So, update the dt-bindings to accommodate the third register


> +    maxItems: 3
>  
>    interrupts:
>      description: EUD interrupt
> @@ -52,6 +56,38 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:

If there is going to be new version - put it before additionalProperties
above, just like in example-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

