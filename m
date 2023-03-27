Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9176C9CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjC0H43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjC0H4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:56:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD44EF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:55:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so32160431edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679903756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwlaCd9bwcVBPmqTzetjfmIJ2Ub/hypomr+bDIl9BSo=;
        b=Z0cxrLXdp6XGslPTQ6nU3hOBpfoLK6fS+6JH+S0PCwh8aVv6zw+O5EEbgGb183Fy3m
         0ZzOLl0Wo0U0RyMSV82XKdriLnh2IYPTDEmtFZxSFYpLfPo3TN5tL0bsDPpLo7mMCXwI
         De9hR/qpFvYlc7KJBsmufJVg/4ZRGiWiDmpNdvKLoakS0EpgwbeR3TYU240ai7480zqw
         pz2hig6jTxfkEJATUFbHB6/iNpOOHZcpALvbO5b1lFX8dnM8LsIZbtbixHPrxugXLyHZ
         avZYLpFZOWmX++k2BmAKQz0tFQysbZ4pddmFaKodeHFJebIWWqbl329ToIEyu8L3YLYY
         w+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwlaCd9bwcVBPmqTzetjfmIJ2Ub/hypomr+bDIl9BSo=;
        b=bqRH7sHtJelZEztdJE9ooMSUNgRBpOSr6nUt8TmeRu8iMGspgxCphvM/lE45KFNjkG
         B+r+hFvuN5YLUVEr7D+dfLAGaSCd/iRBtYIH7tbRPlMXS/2n4Zgwgd7h9AQL260xNq1j
         +6MKAPilLZdzu2FpCgw1F7kX9LnH5orpnqANs/Ci+FnJ/srnAwySM/kjFcRMOxK8dfUz
         cCN9rmleT8tmme5uy1TWTh5gHIb1IjoKst6KSLn09ojHFaLj5LA8vFlsUwA7261DMlry
         U4dxfb2mmrphyt+jTf8jAbOTxc6T4rfbyPDWtYTeO7rMMUUrsgH0pRkHRaE98Oi9IjFC
         f2Pw==
X-Gm-Message-State: AAQBX9cmeZbN3o5MATdpUNKC/EMwUHD1XftA+UjdyKSlBafNLWGPUmwW
        M9iRHMisrZXaXFgihvSm/Dqoww==
X-Google-Smtp-Source: AKy350as+f1xXBsoKi2jxKOkBMK1SX4Y9G5FGg+/W3+xqUhH74bBbr5yjjlAlMTZJUF2SYZC+zc5Dw==
X-Received: by 2002:a17:906:e294:b0:8b1:32b0:2a24 with SMTP id gg20-20020a170906e29400b008b132b02a24mr11492380ejb.47.1679903756537;
        Mon, 27 Mar 2023 00:55:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b0092595899cfcsm13779769eju.53.2023.03.27.00.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:55:56 -0700 (PDT)
Message-ID: <76b5c861-708f-c2ff-4eb8-9a868237b333@linaro.org>
Date:   Mon, 27 Mar 2023 09:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/12] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-5-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-5-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> Document the USB dwc3 controller for SC8180x SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 4875c5b7d5b5..54e24c3abd29 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,qcs404-dwc3
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
> +          - qcom,sc8180x-dwc3
>            - qcom,sc8280xp-dwc3
>            - qcom,sdm660-dwc3
>            - qcom,sdm670-dwc3
> @@ -324,6 +325,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sc8180x-dwc3
>                - qcom,sm8350-dwc3

You need to update/add also block for interrupts.

Best regards,
Krzysztof

