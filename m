Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4616DB3D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjDGTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjDGTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:00:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCFDCA22
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:59:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l17so10304540ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680893959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4gXxWAEpg5Rm1Rq7UASr1bTHF5oTI5KWV+ZISdckLc=;
        b=oRK9lLC6UbmvHYcXRo+sAjYUYUuyKkcnbOrbut/Q0Snt5P5eCzm7ach3k+or2N8DMt
         wqYYqGmbYYuZHciMqTw9VehAG2Rme8jw0EGReCe+bJLeNn4mRGRfFU6EWYP5nlUJkk53
         NJtyiNa/13SsE97ykYwiT5Xh9VwLGpTfqEV98ktoaz4aCJIRSapZgZ4gGsLuEvLRLEWu
         WiIx8/BA6i1f2IdPYGLVwhIisvU1Vzez/kqWE1IaGEnB3/zqxUq37vLYQPtZzb5JPem2
         kgaFozT42Bzn0JHFEzvHKU9PEoEGTNFiiJ/u+Xox2dvBnhl3G6tA5RxLEF8lZs6y5Ba6
         geJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4gXxWAEpg5Rm1Rq7UASr1bTHF5oTI5KWV+ZISdckLc=;
        b=1dSFZ2mYtCmXCRxKHuOFNazMWauH0l4W5C39jXSgGWoz8PssMVRTZZbxTGth9yezH8
         jnDuxHN4Sg1T9JxwrdeU69CmeSkAbQ/UmCVAV5+SQLoHp0vk6eQAaRGBfTCcZKpCkxGB
         3W6p0IGs/6pAl2WB2X2p5jJX61/pBpoj7fN8+LDFNQSkUAZe/xmKhGiVQy9qOGBVZk3G
         IiWWkx3GbRaBHziL3EzRyQeRObcOwLR1CM3ujmWgIlhIcF5JHSPetRMUIUVheIvGNLsa
         3FALs8MUWPqeynhFnpK9QNrLPdgFkbskKrI4aLXQBzEMnnDp5KA32sLxETz/AJHMYlt1
         DtfQ==
X-Gm-Message-State: AAQBX9fKYBsqNppEqDoDIeyJ6xyPzhE/8WT9IA4AT/K6OKs11can6ShK
        ZCwq9YFMNwrU+pxkym2cNODA5g==
X-Google-Smtp-Source: AKy350bn9QHX7GytRyUeXRQIA9pOfMk4oATxEKgAnxVxIoAdHvM+67FAlVkn//GHTP+qA57YsQAKqA==
X-Received: by 2002:a17:906:2658:b0:878:61d8:d7c2 with SMTP id i24-20020a170906265800b0087861d8d7c2mr404580ejc.39.1680893959662;
        Fri, 07 Apr 2023 11:59:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b20f:8824:c926:8299? ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709060b4100b00932ebffdf4esm2313044ejg.214.2023.04.07.11.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:59:19 -0700 (PDT)
Message-ID: <94e4ed7e-501d-11fd-ff69-69c81902deb4@linaro.org>
Date:   Fri, 7 Apr 2023 20:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: qcom: Add QRB2210/QCM2290 and
 RB1 board
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v2-0-dae06f8830dc@linaro.org>
 <20230403-topic-rb1_qcm-v2-2-dae06f8830dc@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v2-2-dae06f8830dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 17:50, Konrad Dybcio wrote:
> Document QRB210, a QRB version of QCM2290.
> 
> Document QTI Robotics RB1 as a QRB2210 device.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 05badce5fedc..236ea55aee96 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -47,6 +47,8 @@ description: |
>          msm8996
>          msm8998
>          qcs404
> +        qcm2290
> +        qrb2210
>          qdu1000
>          qru1000
>          sa8155p
> @@ -353,6 +355,13 @@ properties:
>            - const: swir,wp8548
>            - const: qcom,mdm9615
>  
> +      - description: Qualcomm Technologies, Inc. Robotics RB1

The title should be now different, e.g.
	Qualcomm Technologies, Inc. QRB2210-based boards
or even dropped entirely.

Anyway, this can be fixed when a new entry appears here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

