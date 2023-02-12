Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C102A693848
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBLQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBLQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:02:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662DE113F7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:02:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so9651134wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSnlPEa/GZ306LzfSFRqnTcacQyMt4zeeEJhoYj2tJk=;
        b=FkOjwC+bx0624CDwF5SPs/JA4cYCyFQTb9ZL8q1Ef7C9ZbrXDoAOYsOxPQ0GO1INhB
         ddy1gji4F8ILapVHrhnS8/+qM2VwbaCSMmtgy8+rSz4CLMSWEjxmdLH+ztqW9qSfHGP5
         I8mfcA3HMvVulHUHKJ28StXGLb4f1Srj11sDtMl9Ft+7Cd4MfujWBh9vxHVyRFOMJvCl
         DZN7bvRejB0vDy2yttEBR2jByP0Xyymyd4murQGVg1R9ycym0U/gBOY7tgNdBuCgc+OP
         AiLyBNb7Tzd5d8tw7Cix+flY3LeSlOlNTYDJx0NO1Wf3sZNjIhmU0af0zt/IURgd6oLf
         Xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSnlPEa/GZ306LzfSFRqnTcacQyMt4zeeEJhoYj2tJk=;
        b=PD1AuMx+m1NE13gp2kWIm3z8S398dWXP2tR1DIvA3JPvhpLuXHOXsdzwjuTiwcd3i+
         6vVW6OmGcgIhg3O2676m0uSybSlun+IWmoQACtczx+zDU1A/+iaG50Mh7eBCi7QCmloS
         sZIn2a8VaDeB4LP2Zwd1L9nhTcW1MkCH+T4nhxlxlFUF0Hnwpr5njolyALD/Jwzd0+qi
         yS4DZdQYdir3KXPOS69DbFVgtYYFAQNVXyQw77GFu/fGLWe7ujoIupYRZ7F8pHeTQ1Rw
         eJvc0/7vcfaFF6EsiUz1TzqVSyl2T3TQ368mXsDbephaygnucABEN3B+8kuyKT6mQhHm
         detA==
X-Gm-Message-State: AO0yUKVoWL4148yV17WQtx+wpkV2x9Tb5cYubJVyU7Agzu6Hk8fL5Iwc
        W+tPuXei/EcbfNu7hbV6Kd8wVg==
X-Google-Smtp-Source: AK7set8HoAqggtYb7RT9GySmXzmLnCR+WeyDp2jQIVdN0zyTlNhuLtCH37o3FwHqtZl6ycvfIlf6SA==
X-Received: by 2002:a05:600c:16d6:b0:3e1:541:2b55 with SMTP id l22-20020a05600c16d600b003e105412b55mr12731591wmn.16.1676217740002;
        Sun, 12 Feb 2023 08:02:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003db1ca20170sm12245741wmq.37.2023.02.12.08.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:02:19 -0800 (PST)
Message-ID: <35ac595b-a451-870c-6e1c-613d1e817591@linaro.org>
Date:   Sun, 12 Feb 2023 17:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] dt-bindings: arm: sti: add sti boards and remove
 stih415/stih416
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211210500.9919-1-avolmat@me.com>
 <20230211210500.9919-2-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211210500.9919-2-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 22:04, Alain Volmat wrote:
> Add bindings for STi platform boards and remove stih415/stih416 items.
> This commit also moves the sti.yaml binding file within the arm/sti/
> folder instead of arm/
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../devicetree/bindings/arm/sti.yaml          | 26 ---------------
>  .../devicetree/bindings/arm/sti/sti.yaml      | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/sti/sti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> deleted file mode 100644
> index 3ca054c64377..000000000000
> --- a/Documentation/devicetree/bindings/arm/sti.yaml
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/arm/sti.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: ST STi Platforms
> -
> -maintainers:
> -  - Patrice Chotard <patrice.chotard@foss.st.com>
> -
> -properties:
> -  $nodename:
> -    const: '/'
> -  compatible:
> -    items:
> -      - enum:
> -          - st,stih415
> -          - st,stih416
> -          - st,stih407
> -          - st,stih410
> -          - st,stih418
> -
> -additionalProperties: true
> -
> -...
> diff --git a/Documentation/devicetree/bindings/arm/sti/sti.yaml b/Documentation/devicetree/bindings/arm/sti/sti.yaml
> new file mode 100644
> index 000000000000..aefa1919207c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sti/sti.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual-license. I don't think there is anything from old binding being
copied here (you can as well start from scratch from other binding and
result will be the same).

Best regards,
Krzysztof

