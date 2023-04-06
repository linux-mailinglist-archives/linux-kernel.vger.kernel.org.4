Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9172D6D90AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjDFHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjDFHmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:42:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8C8685
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:41:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so147185442edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680766911;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpp+0JOz+FKGY7fsBLSsdfNUNXwCqAnXR6glr6qNRMw=;
        b=U9/EmzMV+No/XF5Nq4LYvmSGD7hlHQqob5/GLw7OH9v6PeKs+BIbVHC4yEqvo3zLIM
         ewwpZeEJXgJJICeVEqDaWdKohsl5KIMAZuYGR7CgDPjCq1y3vV8etQO+WiSNRj+qmNEW
         Rjf/rCSk22jFq/DmvYb2cnlASTRzytXbuTVClOVDAhm1CxAMtuLT6RgUnkxcSvKQj2Cn
         eV03fmlQsJ8QyuN+/0Ul+K5dZvyTx2+dhtU2prTABH4Bf/7VsuzHIEXHeW9mVABRH3fJ
         QK9U5oMPUAguypNu/vx3B8jF5ZlHBPKr9evFQieqkQKvQ0lHM3kaZNvm6ywNXt4uhuy5
         o3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680766911;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpp+0JOz+FKGY7fsBLSsdfNUNXwCqAnXR6glr6qNRMw=;
        b=uxgzntJouabbp84a3EIQm4UFQcn3BnYz7F6/uVjctRXL/wgHKbf1ajwep494Ou8cLz
         8JMuReV52P8hurKbCvbxs3Wg+VOG1R+Yphco0pW/utOy4gCwEE393aTzMvYkW89N+/2T
         iweiKDLL9MB9mv//dGxH5PSZR8Pf/Notwt4Y8cEPK0kYj2/ahXcipieMnpbbNUVYyjge
         jcg5PN+NSBgf2ZbgIgSvorvaZ1WeEu2eT08EYoYVs53r3SwYjM0mVddfcBQOiaV3mKGN
         VuXM19PVqSaiZ1zAiFVFZOH1nnynmGKdWAqZi+5jOqz23GNtnOTNRzqZ29ug2BdTdx0C
         XhQg==
X-Gm-Message-State: AAQBX9deeNIjjbwri1DOtXKxKX07uEKHmpqGo6eXu1BY4qguLrBF+SYV
        ltYMcsAXsvYkOPsLqqCKarYz1A==
X-Google-Smtp-Source: AKy350bkNdf5O2eZ4KmOp+DCXA33pjr3OARoKNaTAwi7CozBGDwR42LmdRmdeTHeYyrr7Aa+Kp1SBA==
X-Received: by 2002:a17:906:c014:b0:947:c8d5:bfab with SMTP id e20-20020a170906c01400b00947c8d5bfabmr5034771ejz.35.1680766910962;
        Thu, 06 Apr 2023 00:41:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b00949173c1dcfsm455419eje.18.2023.04.06.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:41:50 -0700 (PDT)
Message-ID: <0a66e291-a86d-1ff9-e674-839b8cc8f1da@linaro.org>
Date:   Thu, 6 Apr 2023 09:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
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
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <1efa9a64499767d939efadd0aef897ac4a6e54eb.1680693149.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1efa9a64499767d939efadd0aef897ac4a6e54eb.1680693149.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 13:41, Varadarajan Narayanan wrote:
> Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v8:
> 	- Update clock names for ipq9574
> 
>  Changes in v6:
> 	- Made power-domains optional
> 
> Note: In the earlier patch sets, had used the (legacy)
> specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
> to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> ---
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index 16fce10..e902a0d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,ipq9574-qmp-usb3-phy
>        - qcom,sc8280xp-qmp-usb3-uni-phy
>  
>    reg:
> @@ -25,11 +26,7 @@ properties:
>      maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: aux
> -      - const: ref
> -      - const: com_aux
> -      - const: pipe
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1
> @@ -60,7 +57,6 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - power-domains
>    - resets
>    - reset-names
>    - vdda-phy-supply
> @@ -71,6 +67,41 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:

As you can see in example-schema, allOf goes before
additionalProperties: false.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4

Don't need clocks here.

> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: cfg_ahb
> +            - const: pipe
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-qmp-usb3-uni-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4

Neither here.

> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: com_aux

Can anyone explain me why do we name these (here and other Qualcomm
bindings) based on clock name, not input? Just because different clock
is fed to the block, does not necessarily mean the input should be named
differently.

> +            - const: pipe
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>

Best regards,
Krzysztof

