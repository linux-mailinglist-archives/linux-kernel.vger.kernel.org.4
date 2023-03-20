Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291406C0AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCTG4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCTG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:56:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C315C8A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:56:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b20so9651420edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679295398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfLXUx+fo1d9D24eInD6agATEFZbbnm2b1x2hRrynjc=;
        b=WmgeT1VbmEwuWwx3DdsvKVOfiv+2YAjbT+eIbMM+TCeEBqgzCxeP+bq7Mhsru2qKNe
         stMevTmKALpZSrZr8J2AABqJTUAJg6vZy3can26JzN1tVL0ED2urd6w4DBxJvkL0Q8/X
         0PmsxOhEjDh+GJGGlkl51nC0NlqQQa2tIR/rJ1Wkrx+wyCwd0p8LVW2e7eqtvYTyqFVS
         +/WwBeh5v/VvbzFDSUoCab3OAV55efT9jDlruR27rzTMDVdmlmu48l+yjej0MsO3ZzVf
         F/CJpzfhqd8pis8RaM7KwjsuhGL3YwLOERotFI0Sj+xUmKR0wYLD/GL/Pka4ENTE6Zd+
         IicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679295398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfLXUx+fo1d9D24eInD6agATEFZbbnm2b1x2hRrynjc=;
        b=3jgwHrSlVmBjWm6Mdp58woiHUkw/hct7hWRpFAoc38m7gd40cgb0HWVBP+C4t1BfFI
         JQFIAtrBFP4ufTptL4P4pJDCQxdBIpQRnqBNlSTXxzfZ0Y8TQx88kL6Tr5I4ohosyBT8
         qOzf/HiXs8pQ/GozzauOiXasJm9J+W6+L9ReLAVEOQiT/oWt9AnK1EdmbX7CJKBhMafE
         VATG3eBjvGaiAV8KHP6lzb06fbygXy1XqrHaHx9j+y0pBfun7c1znSiPymuz50o+cTLB
         DJHwwaHEEoQGqfdn/TZXCS/WmK/qWpcCf+gflUgDm9O8tOkCMmCG6HPq9aYmk4dnSjtc
         n8/A==
X-Gm-Message-State: AO0yUKUOV7WlW/Pby1wfDOom7BKy+KmZzs3DFYoo3QzCKVEijKEMuN+O
        Q49uoqxq2r7/GTSPFEmsf+PcHA==
X-Google-Smtp-Source: AK7set+eelwgbHAfQDS1bd88SeVWm0S+doVlMXVqJxptbcf3JDl94fX2visYiyudEs6esSi3ew68Qg==
X-Received: by 2002:a17:906:8cd:b0:922:446b:105a with SMTP id o13-20020a17090608cd00b00922446b105amr7847083eje.19.1679295398508;
        Sun, 19 Mar 2023 23:56:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906379200b0093237bd4bc3sm3521846ejc.116.2023.03.19.23.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 23:56:37 -0700 (PDT)
Message-ID: <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
Date:   Mon, 20 Mar 2023 07:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20230320020714.955800-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320020714.955800-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 03:07, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The previous i.MX8MQ support breaks rockchip,dwc3 support,
> so use select to restrict i.MX8MQ support and avoid break others.
> 
> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 16c7d06c9172..6347a6769ee3 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -28,15 +28,22 @@ allOf:
>      else:
>        $ref: usb-xhci.yaml#
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx8mq-dwc3

And what about all snps,dwc3 devices there (without specific
compatible)? Previously they were selected and now they are not... so
you just disabled schema for all of them.

> +  required:
> +    - compatible
> +
>  properties:
>    compatible:
> -    oneOf:
> -      - items:
> -          - const: fsl,imx8mq-dwc3

I don't understand why you remove your compatible.

Best regards,
Krzysztof

