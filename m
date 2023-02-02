Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6983687E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBBNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBBNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:13:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687C8EB61
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:13:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3705242wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9yDCs0Y7OTh292qdnlfIHLlgC847OmMnA+2DT8LMRM=;
        b=z2AUD13ZMuUC17YZOhb2tKu6oBFqG5VaXt1eTel0LXhdVDQ0NMl2aMuHo61yeOJ2NP
         xOauqpFccCc0o1p+SKSA0GhJaH5CPeB/Xfl/nJqRN+SkH00Z3GdWk0q4bGv7Xjo65eD1
         /FFw/158mNLG0Fd9Z91n62/Jaj0S/V9Xk2HyFWkDT7R0K/wyYTsXg32Jq40/tQb7kO/R
         iq9BtvCsKYyQ2Lqs54/wesgvrtnuhLmU0+5UaK7+/pehLYXPIm55uinQOF2qq32NGigk
         fGa39U7vIgDuQgGm1poO+vfZ7bPUEfbI6ohqTgXs/yuxUNcU4Rlu44QFEVJJD5Geplu8
         U6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9yDCs0Y7OTh292qdnlfIHLlgC847OmMnA+2DT8LMRM=;
        b=pcLTzHi8YjqZOxYCDOPWsKC6ePecdftfyTjfzT+WEubZ22VPjJNMFZxg3Vg+TmtOzS
         5mRU9g7GjJTvs0rupPT17o/Fx+Zdv3deVPRRJPI2MDwpWNJzKQkOVz1mu/2yQohbEk5n
         pdRK/8oJPbNRPRNCjyYF8t9RvlqWEGOJiSQLlPkC9kygvsnQJ25ZKGI1wnASjs0BJrd8
         4xP85DZh2z/S+aA/4pic2s4qGZpi04tAjewlMDm5KH3+I4rIs+8TV6wJeHkH4mM+jtyG
         wPd53pFJCfkEQ/U9mZbaOQAEGYZCgF27CL0qXYUjIn4Vv6hOD2jPwP8DWnboKWMIq1WX
         IMKQ==
X-Gm-Message-State: AO0yUKVW9Yj7MX+2MbFu0fTsrmPCRBtNDgts92K+fv5IzdvQU6Ml7fQK
        UzfOrqq/Bzbhd7a9N7OrCmGHnw==
X-Google-Smtp-Source: AK7set+KODGDi2IxTwnwAsWZauQG0BT3oYD63HgP5RS89l7Z2Ot8fj4NDg2YKb5xDPONQiNhtdZNSQ==
X-Received: by 2002:a05:600c:3c85:b0:3df:7007:b289 with SMTP id bg5-20020a05600c3c8500b003df7007b289mr3584675wmb.19.1675343613235;
        Thu, 02 Feb 2023 05:13:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e38-20020a05600c4ba600b003dc434900e1sm4697535wmp.34.2023.02.02.05.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:13:32 -0800 (PST)
Message-ID: <bbd93ca7-4d8e-7d78-f560-9c50941e9052@linaro.org>
Date:   Thu, 2 Feb 2023 14:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202101032.26737-2-maarten.zanders@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 11:10, Maarten Zanders wrote:
> Add a binding to configure the internal charge pump for lp55xx.
> 
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---
> 
> Notes:
>     v1: implement as bool to disable charge pump
>     v2: rewrite to use string configuration, supporting all modes
>     v3: simplification by replacing string option by u8 constant,
>         removing previous Reviewed-by tags as it's a complete
>         rewrite of the patch.
>     v4: added notes


> 
>  .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
>  include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/leds/leds-lp55xx.h
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index ae607911f1db..22e63d89d770 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -66,6 +66,12 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  ti,charge-pump-mode:
> +    description:
> +      Set the operating mode of the internal charge pump as defined in
> +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +
>  patternProperties:
>    '^multi-led@[0-8]$':
>      type: object
> @@ -152,6 +158,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/leds/leds-lp55xx.h>
>  
>      i2c {
>          #address-cells = <1>;
> @@ -164,6 +171,7 @@ examples:
>              reg = <0x32>;
>              clock-mode = /bits/ 8 <2>;
>              pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
> +            ti,charge-pump-mode = /bits/ 8 <LP55XX_CP_BYPASS>;


No. V2 was correct. What happened here? You got review for v2, but
suddenly entire patch goes into other direction...

Best regards,
Krzysztof

