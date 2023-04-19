Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE46E822C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDST4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDST4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:56:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1CA19BF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:56:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ud9so1157615ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681934177; x=1684526177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QK0RzTuumCQC1t5HnO9BC42T80LLGoNo/wFWeG++m3M=;
        b=ebupDPWi6a9ZIyC9OYScjcl9eatEyGRZmZp7E4aMGiqDLtmMmpbrrFhuODPR1S5mnb
         pDalxeHmsroNgY70X6di0JfdJpn9Hg22M/6rcqi8K4k8CF8mRM8KrtsK+r4CETIx8Znq
         J3cm1AZGHsR3VWRa0ASbHjoxxGc62mt9ZkHwGJLJa4WrISCXEgFKXBjZu7l40v4Ae5d8
         oLzslRBMW8EJ2U1hCnWpXFerRC2+SQYaBvZulj1A0JXxW+bEXwptjSJD6+RQSVTTHQUX
         qciNNcagu2Lp+PuPH5JxsPSfKsDnaKlECsVvDCrePC8lYKqhI4L+GF8fhHJ2MOfsM/hv
         I4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934177; x=1684526177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK0RzTuumCQC1t5HnO9BC42T80LLGoNo/wFWeG++m3M=;
        b=G1tEGYyRqEHqQOUlpz8Gq0W2jJ0ToVc1WLHYB/CZ3RjPRY0Vni37qUACMU56TPwagb
         8D8zuLPAnrwRsu97RKL9KK1e03X3mvv2X4RLrKX+DvIAXeCs2F8gVKxCcY4PsVH9Y0Sv
         m5+qWu9I6pNLMrzJXbaEzNqFROALdRT7Bp3ioD7xYKc/4HeqXmcap2f2Cn4hm3Qvrcml
         Oe+TipoqrXRl1Hu/tztaym0Sz0ZdMgWTHoc5gaP2t2ijLi1Vl7AduaT7f7ifqHsSkz+F
         MFlSjE6lEf1NdCWFNQ9A+pkMSWmD20NOiH60xCGX1q8C8gkQP0GQ6f6E9kYJtDa9Rxkq
         aWgA==
X-Gm-Message-State: AAQBX9dSIFFcCvkN3T8Ng8zJrTtx4bYcQ8Fc2EX9/yowu/gsspgzcSP/
        xywkPOXdIFdJYPB/uBQCvWLTfmJnobYcl+a8qzlong==
X-Google-Smtp-Source: AKy350bBRSdGMvjLXchuqeVbKmqng0UuuSmcvkfm/sGsi74okcHvgQ89ZbjMozDgThpDZ9T9YadAPQ==
X-Received: by 2002:a17:906:af63:b0:94e:6b12:caab with SMTP id os3-20020a170906af6300b0094e6b12caabmr18903719ejb.51.1681934177665;
        Wed, 19 Apr 2023 12:56:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id tg10-20020a1709078dca00b0094ef2003581sm7797154ejc.153.2023.04.19.12.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:56:17 -0700 (PDT)
Message-ID: <9543f619-88fa-8e54-6e9a-4334750e51b4@linaro.org>
Date:   Wed, 19 Apr 2023 21:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for
 "qcom,paired"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230418150606.1528107-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418150606.1528107-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:06, Rob Herring wrote:
> The "qcom,paired" schema is all wrong. First, it's a list rather than an
> object(dictionary). Second, it is missing a required type. The meta-schema
> normally catches this, but schemas under "$defs" was not getting checked.
> A fix for that is pending.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> index 9412b9362328..4c3e9ff82105 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> @@ -144,8 +144,9 @@ $defs:
>          enum: [0, 1, 2, 3, 4, 5, 6, 7]
>  
>        qcom,paired:
> -        - description:
> -            Indicates that the pin should be operating in paired mode.
> +        type: boolean
> +        description:
> +          Indicates that the pin should be operating in paired mode.

Current Linux implementation uses it as a generic pinconf param
pinconf_generic_params which is parsed by:

pinconf_generic_parse_dt_config() -> parse_dt_cfg() ->
of_property_read_u32()


The pinctrl-spmi-mpp.c driver, using this schema, treat it as a bool,
but I still wonder how the code will parse bool with
of_property_read_u32(). Maybe it should be uint32 with value of 0 and 1?

Best regards,
Krzysztof

