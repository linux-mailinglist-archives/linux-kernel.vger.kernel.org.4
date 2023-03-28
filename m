Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578626CB7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1HHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjC1HHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:07:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122262D40
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:07:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so45593597edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679987229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4ch23DrQsWHOR9SnPpFPwEYN9EwYbqlOi9orjMDJe4=;
        b=Tny7Ck2ytQInZa88ltoENG417Ja1fscKtnD1GDs58pdSZJ/IVSj8/UsWVhNeSneUz/
         8YvgGJJ3lFeVdUuBAzBRD2Xfp17sBlzFfs8EAVLZTNvHohM3QBxlEeE6Xn/v+yU3cko1
         iqcF4ptefuOZmgRjRQRRo2iXBt3qxSgpGvfV99avSulHtgtTRLJkPR0I0F55i3u2MQeu
         ycRfn9Am0945hrqeNyx7mzanityt6clb2X+F2BG9N9Ru1iIdebD6F/Ofsl8ADVqpA+9/
         uoSABKgpQ8mEl+OkxRZ278vABaKXzskqEJtx3QxNF4U623FECciajm6w9Ey8wNStjRg6
         KyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4ch23DrQsWHOR9SnPpFPwEYN9EwYbqlOi9orjMDJe4=;
        b=2+S2LCKxsCeuVsWsZ0O+coDPqHQ2d/0dWbZSJgQaXB4MBDKAmqS4amo3WQydE/b04D
         8VF2UFc/xbVtp3aFSqsyYZUyw9kYzwTmCIlAX1ZQLZrl4FecE0o/Js1SzuNrROLWU+9O
         9/S7DR1UT6tgDEf4vyM1gnZB8hWXqHmAMeihdsotXz1uCSjb4V1OqUXNOaSz1x1akPCo
         lNytx7k7xgh2C6pmsyZAG1CGbmbjIkVPOHGrTBlkFk4j9BYSIXRNuDgEx176TEDQWhWJ
         HErgyknF/jbc++aTlQsV1OXSxAug/7VSkHufVYNYeW8YDSKX6vCQNT21SvXTkbcPR963
         sFNQ==
X-Gm-Message-State: AAQBX9dJeaTUuyOW2ouUOAjqqcZ53usJp9vG/FHKc+ZvuS3I51ovWktz
        0zfFajIrUXyCY6LXflbfMwOa6A==
X-Google-Smtp-Source: AKy350bKhgmasZr9CpVxheey/53sUglV0Ce7vW/cC0O8O0yoA3cHNgz9FAmIy78efquiDIKZIIzJng==
X-Received: by 2002:a17:906:448e:b0:933:3cd8:a16f with SMTP id y14-20020a170906448e00b009333cd8a16fmr16877907ejo.75.1679987229556;
        Tue, 28 Mar 2023 00:07:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906b28700b00931c887372dsm14794198ejz.107.2023.03.28.00.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:07:09 -0700 (PDT)
Message-ID: <39356c59-7723-40df-08ba-cd563a7e066c@linaro.org>
Date:   Tue, 28 Mar 2023 09:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1679909245.git.quic_varada@quicinc.com>
 <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
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

On 27/03/2023 11:30, Varadarajan Narayanan wrote:
> Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v4:
> 	- Remove constraints not applicable to IPQ9574
>  Changes in v3:
> 	- Update other mandatory fields to accomodate IPQ9574
>  Changes in v2:
> 	- Updated sections missed in previous patch
> ---
>  .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> index e81a382..aa5b58c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - qcom,ipq6018-qmp-usb3-phy
>        - qcom,ipq8074-qmp-usb3-phy
> +      - qcom,ipq9574-qmp-usb3-phy
>        - qcom,msm8996-qmp-usb3-phy
>        - qcom,msm8998-qmp-usb3-phy
>        - qcom,qcm2290-qmp-usb3-phy
> @@ -122,8 +123,6 @@ required:
>    - clock-names
>    - resets
>    - reset-names
> -  - vdda-phy-supply
> -  - vdda-pll-supply
>  
>  additionalProperties: false
>  
> @@ -204,6 +203,28 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,ipq9574-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: pipe

Isn't pipe the clock for child node?

Best regards,
Krzysztof

