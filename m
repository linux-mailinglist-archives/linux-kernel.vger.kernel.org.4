Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA56669689
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjAMMMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjAMMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:11:34 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8B7CDD6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:05:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so51821862ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXHybJ2mJD6aa8TvSwEacdirC05VvD7/mmGN0WSC+vw=;
        b=QvjvtNTf6/c/WYoFYhk46x+H2YhZBKQBg620l4RhwiX74ErRSQSNzqunYHdo4GaKj7
         W18ixbG6yEniU4KsVAiBHHWba/xKipCDS2GL/0FEB7BLhPHMD0FgirXaNwkkkiRwoJ3t
         kpi+qkgjwZ6o7WcgMdN9fHoLspRM0kaL9VbY5aiTAIOnFNAw+A8R3lXW70zejxUNCFZR
         L6icKZ2GdzNdmwI9Y2mP9R5sAuD5xw0ZdAnmxJlkH480HWdLCxrkz7lZtdnCEYx14qbe
         f/6IwD25mR6BcVWDnvXjB49k//bl/vS1wc/qQ6Hwy6xPrVPDbL9fX4WiySKva6mERgf0
         16cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXHybJ2mJD6aa8TvSwEacdirC05VvD7/mmGN0WSC+vw=;
        b=vplYgicpINW13AdB4Uia8Ejgu1lQXnaVGiQF4KC2gouf1RARCbg3QZ2CXtxcD79myV
         qmXzYk1gt8NpqsrzPhDxrhWD/E3E2b/zqY0KiL9m19TUQ5tmQnWiTjgCqUcH4XAjBiz1
         PPP72uSrqm/MrAdO6dQqUH7V1KINkGWUk0OopJEA3orK5DsYphfV8rzyqLyAaYDSw/0D
         MlVMWQr4YN8pgpJrg2oTS/rxJNiRf4/5QmN+t66BB1zg5iWZhCoSU8C+a8sUabh0AYtx
         ZeqedZdJBUNr8CEzyXSr1JWqUCWZyhDMMgdQxDECfn+crKhbG3kS1h5bip/MDDUAKdwo
         3oBg==
X-Gm-Message-State: AFqh2krDfppN6rM3BrqW7FjdCE9Ji5CiU6Erqyrufh7e0I/9VKA/KtHt
        6VHxEe2Tfe8zlubS3rs+1WTFUA==
X-Google-Smtp-Source: AMrXdXt/AzW14h8l94Wqnw6m53vrD1GcILvRAidaUWScS+ZS45P5oisNr9+yWakUYg6jOlAzSZU3OA==
X-Received: by 2002:a17:906:abc6:b0:7ad:d835:e822 with SMTP id kq6-20020a170906abc600b007add835e822mr71763506ejb.42.1673611501624;
        Fri, 13 Jan 2023 04:05:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id og5-20020a1709071dc500b0084d420503a3sm6715352ejc.178.2023.01.13.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 04:05:01 -0800 (PST)
Message-ID: <7cb96551-094c-1a68-cc3f-31e4e2e94518@linaro.org>
Date:   Fri, 13 Jan 2023 13:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: ramoops: Update the
 binding
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, keescook@chromium.org,
        gpiccoli@igalia.com, corbet@lwn.net, tony.luck@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
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

Subject: drop second/last, redundant "binding". The "dt-bindings" prefix
is already stating that these are bindings.

Your subject says nothing. Everything is "update".

On 13/01/2023 12:58, Mukesh Ojha wrote:
> Update the ramoops region binding document with details
> like region can also be reserved dynamically apart from
> reserving it statically.

So what exactly can be here reserved dynamically? And what does it mean
'dynamically'? By whom? How is this property of hardware (not OS)?

> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
> 
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> index 0391871..54e46e8 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> @@ -10,7 +10,8 @@ description: |
>    ramoops provides persistent RAM storage for oops and panics, so they can be
>    recovered after a reboot. This is a child-node of "/reserved-memory", and
>    is named "ramoops" after the backend, rather than "pstore" which is the
> -  subsystem.
> +  subsystem. This region can be reserved both statically or dynamically by
> +  using appropriate property in device tree.
>  
>    Parts of this storage may be set aside for other persistent log buffers, such
>    as kernel log messages, or for optional ECC error-correction data.  The total
> @@ -112,7 +113,13 @@ unevaluatedProperties: false
>  
>  required:
>    - compatible
> -  - reg
> +
> +oneOf:
> +  - required:
> +      - reg
> +
> +  - required:
> +      - size

There is no such property. You cannot require it.

>  
>  anyOf:
>    - required: [record-size]
> @@ -142,3 +149,26 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    / {
> +        compatible = "foo";
> +        model = "foo";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        reserved-memory {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            ramoops: ramoops_region {

Node names should be generic, no underscores in node names.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Any reason in naming it differently then existing one? You have there
example.

> +                compatible = "ramoops";
> +                alloc-ranges = <0x0 0x00000000 0xffffffff 0xffffffff>;
> +                size = <0x0 0x10000>;       /* 64kB */
> +                console-size = <0x8000>;    /* 32kB */
> +                record-size = <0x400>;      /*  1kB */
> +                ecc-size = <16>;
> +            };
> +        };
> +    };

Best regards,
Krzysztof

