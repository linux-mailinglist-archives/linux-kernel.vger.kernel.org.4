Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3656D90BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjDFHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjDFHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:44:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3891D10C4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:43:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fi11so23673232edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680767030;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaae/Gf1/6wg+LDa+ygkgJGlypxcIUaHAsaoRhlT34o=;
        b=oXPhlK+Jp0n/xdreEycT0BU+UJH6W9xVaby3EULDTFHAz2yHsR8lYbX8zW4k/44/7H
         GMVW8mvM+/g/uyhBGczPsO9l7u07KGv0QeMItpug//0pEAuiGM4IPWtekhOpZGn9TPmx
         nvpx0JHMZQFQFIp/mjEtPutTlrQFx9MvZnb6hCPJaQniZQu5sC1yOXJ8kJDMRyxjkSiQ
         T0Fwx6nxyQ/LYMsDppw5D0vfEh9+DCA3wTdIorI6tB4uf2wF8Pjy8PysVe6Dq3fSVAm6
         tnckOPPaimKZUKnnIma4C8oKxdM0jrqhhyf86omiQZnZmlMBU2wTTsGN4Tr8Z3KMfcs6
         3VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767030;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaae/Gf1/6wg+LDa+ygkgJGlypxcIUaHAsaoRhlT34o=;
        b=CR1BRPk6H5dTzAYL8fZOk7E/Qx3Oofbp73aIJyUJFEeb0KJYwILf7XBKtJeIboMd87
         z/nI1ca7GpGd9i4PD6RsMUMW0hzcza0l/5R8uDrUeGktp+/NfPuSKWav4I2rXhokvOpb
         MHtOEuwF1l1JQ4eediuugrO/C7Q96UzFzd+jVKb/wsVh27XAYRiVWwltw2Tae7SpGiaw
         hQ4SR48CcBYub1aJqh9IjhxsxYEQVdaiqR74AOAWOQ1HihIV6WE6D8C1l1EF8qrlESnX
         FHSU8Am4+C8MMNTEvR9ItkmJH+2WqaPuKNYkLxjnBsVP9w+0ESbPxw9B9ZmzjOU74B3z
         FZvw==
X-Gm-Message-State: AAQBX9dtZUsdhvdmYlCwIQlxTiExGcx46Cx+ozj+bguMuqyBVG10lbrl
        ZQLf+6dk+yt93TUlSm3iqAKklQ==
X-Google-Smtp-Source: AKy350aoGvLE98pNqsudQV1mmoNS4KNifIl0+eEz3ycTrvouiOMXIacvp9zYbbwm8qYxno+2SD352A==
X-Received: by 2002:a17:907:118a:b0:948:aac6:7def with SMTP id uz10-20020a170907118a00b00948aac67defmr4854533ejb.19.1680767030731;
        Thu, 06 Apr 2023 00:43:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id h7-20020a50cdc7000000b004fa99a22c3bsm359770edj.61.2023.04.06.00.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:43:49 -0700 (PDT)
Message-ID: <533651bb-e72a-c899-5b64-16d000819e20@linaro.org>
Date:   Thu, 6 Apr 2023 09:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
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
 <3ee3163e6933b52e3eb4144c8041062dbd15e6c2.1680693149.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3ee3163e6933b52e3eb4144c8041062dbd15e6c2.1680693149.git.quic_varada@quicinc.com>
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
> Document the IPQ9574 dwc3 compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v6:
> 	- Made power-domains as optional
> 	- Resolved all 'make dtbs_check' messages
> 
>  Changes in v5:
> 	- Restore removed constraints
> 
>  Changes in v4:
> 	- Update other relevant sections
> 	- Remove constraints not applicable to IPQ9574
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index d842819..f5dd268 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -17,6 +17,7 @@ properties:
>            - qcom,ipq6018-dwc3
>            - qcom,ipq8064-dwc3
>            - qcom,ipq8074-dwc3
> +          - qcom,ipq9574-dwc3
>            - qcom,msm8953-dwc3
>            - qcom,msm8994-dwc3
>            - qcom,msm8996-dwc3
> @@ -133,7 +134,6 @@ required:
>    - "#address-cells"
>    - "#size-cells"
>    - ranges
> -  - power-domains


Power domains are required. Commit msg does not explain why this should
be now optional.

>    - clocks
>    - clock-names
>    - interrupts
> @@ -197,6 +197,26 @@ allOf:
>              - const: iface
>              - const: sleep
>              - const: mock_utmi
> +      required:
> +        - power-domains
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-dwc3

You do not need new entry. Just open the file and file respective
existing if.

Best regards,
Krzysztof

