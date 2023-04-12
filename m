Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04256DF9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDLP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDLP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:28:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160AE8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:28:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os24so176104ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681313293; x=1683905293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/f8fWx95RPy53FPFSPsxhx2yeOjkbYiJk0FpqalEok=;
        b=vwS4hlPbleuafP0JkJ+DqcRIjQtLA+RHSlatsgZN0E376IXiO3XOWyduiOswxM5yrG
         EOYE7gyWI4GRdYBJe2ZGle0t8VTVfYdZr5a4EcY1+d0+NWJEhhbljBOfUFU/j5hs194W
         yIMPj/UVYbEyoIZZq1p63Zi8hmR5O3+TBYrPQoYhafZu4FQ3Hl02NXQHHOYSImfMDHIU
         qujYUuPaY6WTqd7i0LMv41bkm4I5GjqJrFoGmjk4aMBBnTenWTLbUCqIjA/1rboQbFoV
         UaIuhCa1UCxP8/3X7G3EeknkU3uofDWuG9a4/eA0rPrSAeCaoi9t+sGtcEW7GSe6oVf6
         eKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681313293; x=1683905293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/f8fWx95RPy53FPFSPsxhx2yeOjkbYiJk0FpqalEok=;
        b=S70uMEfEbvrqUyXNiMU9aLho4R4jhOUAGFp2hNcfxh86I03pNy2jDpEPzSzNmb+f/l
         pGYYJlEoaaDj3Fsk6N7DdGAwOJGNBGcQQCI+z6GRYzcdCe+BjfRxokufSzawSuAk5xN8
         q/3o1OMqUmU0Wubao5AcFTCn7BJkEB8bOW/dzauhxiXJF2lEZg26ZW9705FizBg3gRRL
         WautSWcOqYauRoRrMwNuRZU9rC/oC29NdXne5bNDFNKhG2Z+fsmx0r96ltfKQ+m6+hvf
         JY9iYUMuBSUn3s4itTQJhIyPYMwh0K4XznybN2MAX6QCeXHccMNB4m0hx0w+sjLU5OeL
         Zi7Q==
X-Gm-Message-State: AAQBX9eKkSghocO3nlFzr+HuG4Yqi09e0YWk+1+3ELwKYJPTFZP43I2J
        P2P9B8LePq2Y3nE9TTMYfG/MTQ==
X-Google-Smtp-Source: AKy350YX5t8yue2OQEKwTNFVa2OOh6bs2nxsXA+6DD5d1N6SAjVTtGtqlOTDFST8C47ZXLf29jFHnw==
X-Received: by 2002:a17:906:aac8:b0:94a:6f0d:389d with SMTP id kt8-20020a170906aac800b0094a6f0d389dmr7392883ejb.5.1681313293472;
        Wed, 12 Apr 2023 08:28:13 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e14-20020a50d4ce000000b00502b0b0d75csm7027802edj.46.2023.04.12.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 08:28:12 -0700 (PDT)
Message-ID: <94590a79-cae3-7b88-8f02-0c356adf06b7@linaro.org>
Date:   Wed, 12 Apr 2023 16:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/7] dt-bindings: soundwire: qcom: add 16-bit sample
 interval
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 03/04/2023 14:24, Krzysztof Kozlowski wrote:
> The port sample interval was always 16-bit, split into low and high
> bytes.  This split was unnecessary, although harmless for older devices
> because all of them used only lower byte (so values < 0xff).  With
> support for Soundwire controller on Qualcomm SM8550 and its devices,
> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
> to allow 16-bit sample intervals.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/soundwire/qcom,soundwire.yaml    | 22 +++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> index c283c594fb5c..883b8be9be1b 100644
> --- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -86,7 +86,7 @@ properties:
>     qcom,ports-sinterval-low:
>       $ref: /schemas/types.yaml#/definitions/uint8-array
>       description:
> -      Sample interval low of each data port.
> +      Sample interval (only lowest byte) of each data port.
>         Out ports followed by In ports. Used for Sample Interval calculation.
>         Value of 0xff indicates that this option is not implemented
>         or applicable for the respective data port.
> @@ -94,6 +94,19 @@ properties:
>       minItems: 3
>       maxItems: 16
>   
> +  qcom,ports-sinterval:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Should this not be ref: /schemas/types.yaml#/definitions/uint16-array ?


--srini
> +    description:
> +      Sample interval of each data port.
> +      Out ports followed by In ports. Used for Sample Interval calculation.
> +      Value of 0xffff indicates that this option is not implemented
> +      or applicable for the respective data port.
> +      More info in MIPI Alliance SoundWire 1.0 Specifications.
> +    minItems: 3
> +    maxItems: 16
> +    items:
> +      maximum: 0xffff
> +
>     qcom,ports-offset1:
>       $ref: /schemas/types.yaml#/definitions/uint8-array
>       description:
> @@ -219,10 +232,15 @@ required:
>     - '#size-cells'
>     - qcom,dout-ports
>     - qcom,din-ports
> -  - qcom,ports-sinterval-low
>     - qcom,ports-offset1
>     - qcom,ports-offset2
>   
> +oneOf:
> +  - required:
> +      - qcom,ports-sinterval-low
> +  - required:
> +      - qcom,ports-sinterval
> +
>   additionalProperties: false
>   
>   examples:
