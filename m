Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88E67EF26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjA0UF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjA0UEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:04:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5A8B074
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:03:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so1881993wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reEnc4EOAASI0Khp6pR/r9Av8Biua9MumoNI5XALfvY=;
        b=AERwUFt1/QB4neVHHtnbkmA3v/kn9W/xkJO+ohHV+yUI/ZjsfVSObqYLnA9Onz7w+d
         /FZZQyn06DRK0zivM71Gt6ZoOcvqv36UJzlPJFIuGB9PiqFgfDmqmJBXMz3jhTVYS+Q3
         109CsZsJlhhb62GNcvOnQvSxtF3ZregYPC7+/nHuOI+hisVJV696zCXuQdcMA8WD7uuw
         zT56RDzALQ3LjdQbYgV4OhcJ9NJ2NrPaIxGgoXrIug0Ho4VTO8FtXB/1huPZAxMFvNU0
         dYCMu5jms/mxbaTid21JdgH4fkKR0ndeSwrM2gx7yrp6zdUNuG0mY4zMgaabz774d4mu
         cyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reEnc4EOAASI0Khp6pR/r9Av8Biua9MumoNI5XALfvY=;
        b=XyJjTbWjOXwWRhsnbcfPJ8ooxIaaMnw9pRMXcgddgQyWkSfhdzB5HguK8pJs+jvHdT
         RCTQf6Afy4IZ9T1TG8jAIzkoaLQlf2UCoRCMEVDdvI82o9sjf4H7sS3OD6WYqyXVxJTe
         t/iuvimLu6xEWRTWe4Yh/xHxFCOs3HrhjkDIoZ2rrhBEhJc8dqwj76v5poMqqPwS7B0u
         TV/skeXmGnMVVbP6Gfh9ODlz0PAPFy5NtkZsKrI8qmDYqX7O2gw7rI3SPf6/+jWLFiL5
         6IsHrbp1tVXqnf4y1AQd22G5jtxvqCEqKXHVjlZXqwIE71rEGaxDtwyc68GHGwf2ETfo
         JmlQ==
X-Gm-Message-State: AFqh2ko1XssKndFuEo8C4FzwJ/pFn1t/dpBLSVn0KcM2tFqH/9QrrM0i
        LFX78zD4k+cCnkLWkOS6uOVcaA==
X-Google-Smtp-Source: AMrXdXsASHraCdry4BHxBnY6w52haRZylQxGuF6RmkUFl4Ax5qoaKDhSkUSxOPl+HdLKwZM2OACqPA==
X-Received: by 2002:a05:600c:3b13:b0:3db:26b8:5023 with SMTP id m19-20020a05600c3b1300b003db26b85023mr33006741wms.10.1674849797768;
        Fri, 27 Jan 2023 12:03:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b003db2b81660esm9165980wmr.21.2023.01.27.12.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:03:17 -0800 (PST)
Message-ID: <637fe4cd-f9e9-ae22-0085-30ea3f1dd5af@linaro.org>
Date:   Fri, 27 Jan 2023 21:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 17:00, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a
> fixed and known location when read from the devicetree. This
> is not desirable in an environment where it is preferred the
> region to be dynamically allocated at runtime, as opposed to
> being fixed at compile time.
> 
> So, update the ramoops binding by inheriting some reserve memory
> property to allocate the ramoops region dynamically.

Where is the update which adds "inheriting"?

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v4:
>  - Addressed comment made by Krzysztof on ramoops node name.
> 
> Changes in v3:
>  - Fixed yaml error and updated commit text as per comment.
> 
> Change in v2:
>   - Added this patch as per changes going to be done in patch 3/3
> 
>  .../bindings/reserved-memory/ramoops.yaml          | 34 ++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> index 0391871..8741626 100644
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

This is okay, but:

> +
> +oneOf:
> +  - required:
> +      - reg
> +
> +  - required:
> +      - size

I now keep wondering - why do you need this?

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
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        reserved-memory {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            ramoops_region: ramoops {
> +                compatible = "ramoops";
> +                alloc-ranges = <0x00000000 0xffffffff>;
> +                size = <0x0 0x10000>;       /* 64kB */
> +                console-size = <0x8000>;    /* 32kB */
> +                record-size = <0x400>;      /*  1kB */
> +                ecc-size = <16>;
> +            };
> +        };
> +    };

This example does not bring anything new for the ramoops. It's an
example for reserved-memory to show usage with alloc-ranges. There is
nothing useful here in terms of ramoops, so I think it should be dropped.

Best regards,
Krzysztof

