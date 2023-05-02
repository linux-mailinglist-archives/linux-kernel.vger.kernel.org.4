Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8D6F3E89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjEBHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjEBHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:48:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC630C6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:48:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so6328082a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683013693; x=1685605693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ri28WKi8g60FGcODKDV4M0qSpJXtQBhdjEjPzYhCyQw=;
        b=XCrWnUbEmnTP/VzJ7Njt+yNpMhtlt6XsmPPSMBXwc4+Hf2QiHzh6RRwV8JIjkLy3Eu
         kH5n1Ulrk6McpeFITt7ySMPOgSbBHerHJSdvpM8orfy1EdOqitFY8sUrBI2oOZo7IUSF
         ZeXOlzDyXSC+Ujt4UQSAlG8NhtejqrBYgSBPhi3BifjpDN7xg44gJtlZUmGvYtcmIIy1
         13jq4ofVuyPJ9+WtWKfugkzUAB7OD6kFtesqqlDQZF0R8cCIwZVU17NuFCHt35GxTZAj
         fD5P8yao3w8cDJDnCtswcEgyoBoR/UvsokbRyYwuF5AaTT1wIfHBLtV0E8kCk0PyFUhS
         BbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013693; x=1685605693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri28WKi8g60FGcODKDV4M0qSpJXtQBhdjEjPzYhCyQw=;
        b=EP2eMmAPje7UZUlQxd+r7pLhm8EdCAlNx8SjGvwSTGz9WHKVqgmNqS1JE7jnaGWiwA
         gN0E+se2A1K/b4ikatC6MTuXz0UCVorQl7NxUyZJ0Bx0TyCcRP9E/87TIBObXv2EfZQw
         DiMRln/pwp4REeVJG2hSETONOALXj2rBADVzm40bVLP71Ids9xXDDPfG7wzwAedRBFYa
         ECMZvaH9NV7FdriWHz4KaZUf9HKzQ9x5mx37nvx4fTeQYn9go8zx+jy6nQ/uK462rJy7
         dKuyMSFhRJzaefSvktG1YsFuCXJTBKQgH3MuTatzMhaiUgNHbA9n18rd3FdoOikDuOyQ
         Re3Q==
X-Gm-Message-State: AC+VfDxoAGspbciXCWblO6Pm4v2V7Q3K+ZKk4LvMJOs5vhzPKcCMggT4
        gR+fJtBWt80LGbHRxJng4MLgag==
X-Google-Smtp-Source: ACHHUZ5wDbWsUU3czgLFdDuWS088iTvgN2ifq6a0oUVuJqPNLsonmjIFerBqVo7aTSGBSp5rBjBwkw==
X-Received: by 2002:a17:907:7ea9:b0:959:9d8d:e992 with SMTP id qb41-20020a1709077ea900b009599d8de992mr15325837ejc.8.1683013693103;
        Tue, 02 May 2023 00:48:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709063b1100b0094e6db4d4a1sm15637585ejf.186.2023.05.02.00.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 00:48:12 -0700 (PDT)
Message-ID: <df24efb2-8279-ef15-a118-2a24885288c8@linaro.org>
Date:   Tue, 2 May 2023 09:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-2-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501143445.3851-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 16:34, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event irq interrupts supported by this controller
> (one for each port of multiport). Added all the 4 as non-optional
> interrupts for SC8280XP-MP
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index d84281926f10..2c96da1ce5b8 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
>            - qcom,sc8280xp-dwc3
> +          - qcom,sc8280xp-dwc3-mp

SC8280xp comes with two USB controllers: one single-port and one multi-port?
>            - qcom,sdm660-dwc3
>            - qcom,sdm670-dwc3
>            - qcom,sdm845-dwc3
> @@ -455,6 +456,26 @@ allOf:
>              - const: dm_hs_phy_irq
>              - const: ss_phy_irq
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-dwc3-mp

You miss entries for all other constraints.


Best regards,
Krzysztof

