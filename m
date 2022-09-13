Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD275B6AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIMJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiIMJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:27:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FF5D10B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:27:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso9073939wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A4LqlvJqTCL3K7F8VdDe86oF1VVPopXq7gBGt91lvWY=;
        b=hG+a7+eAc1zS3/eRlTBCKgxZTUc0mspGCSwL0YIhLdJb4l+3+qrMBkdZZ0rhHBSl9c
         XkAsLl4GHX1icsnSpDk6+e374y3DUGw6rtTBlAVvKfv59hYc8DRZUhMonOcZPLyUiTVw
         NvqGHxHzvabcynkcekZ/NVToPkrquGRP+kvEGhKgp99aR+RKr2ys+aDj8nphB1HBtQO+
         qQMKzMId3x+Qf989VuCKdwPt3VKjCIqMjqHzJFW3vi00I+dTmz9o+XIIpKJwj8DzIDWH
         LH3nMjOICAfYY5Fc+7LvyAbSKhptGuhTZ9wKlzIQ6zgd8QRlBiPxBBs97Jy5283NkKZ+
         l6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A4LqlvJqTCL3K7F8VdDe86oF1VVPopXq7gBGt91lvWY=;
        b=I+Y/uzugdIl+bjPnYA8Fc3MvjLkH13N466jq8oXRgDxHqAHm41YOYBjB0cGx/DVvfv
         KLq0Z3C6zxbkUd81dXL+i91GZe16O5O2qvxjLEpy1+oxQSQ8BePgyOHzPBV82POjo2rQ
         /q7YQXS4hhYO8oGUA3KI+uto1fLlzMRxrIy7uZUNwPFQkdSR/9OYovAF9KlmLF8uuSEk
         5M+TL2Eq10EU3K2F+HTzBb5DwNBjgA/Y0OveEMPnA3lG5HetINjuBt1gQMXCoogjZM3L
         luASVKF28vGM/C1oDfZHif3m8ltE6n3AiiSQAEAv9GWnctY1dzH57/eFA6TOPs7/IE6Q
         JqfQ==
X-Gm-Message-State: ACgBeo2zITQgWBLMkb1dyGKeQdnlpfmYyT1O32nl1NIoWzgpwAl3EEmg
        KTIUUoR22nUjhuFqhZ8d+yQ6MQ==
X-Google-Smtp-Source: AA6agR5p/qbPuVvy9m1Yt1iIXxn5YpCz5ncjcdjDVD5Pt0QNGXf/4iK5GiwHzR06XFGIWqe9dELkLQ==
X-Received: by 2002:a1c:7916:0:b0:3b4:7575:d2f9 with SMTP id l22-20020a1c7916000000b003b47575d2f9mr1653598wme.27.1663061229054;
        Tue, 13 Sep 2022 02:27:09 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id c16-20020adfef50000000b0021f131de6aesm9884628wrp.34.2022.09.13.02.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:27:08 -0700 (PDT)
Message-ID: <7a673b7c-9e04-2a23-98b9-243696597bba@linaro.org>
Date:   Tue, 13 Sep 2022 11:27:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20220912085650.83263-1-s-vadapalli@ti.com>
 <20220912085650.83263-3-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912085650.83263-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 10:56, Siddharth Vadapalli wrote:

>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index 016a37db1ea1..da7cac537e15 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -53,12 +53,25 @@ properties:
>        - ti,am43xx-phy-gmii-sel
>        - ti,dm814-phy-gmii-sel
>        - ti,am654-phy-gmii-sel
> +      - ti,j7200-cpsw5g-phy-gmii-sel
>  
>    reg:
>      maxItems: 1
>  
>    '#phy-cells': true
>  
> +  ti,qsgmii-main-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Required only for QSGMII mode. Array to select the port for

Not really an array...

> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
> +      main port with the rest of them being the QSGMII_SUB ports.
> +    maxItems: 1


You say it is an array, but you have here just one item, so it is just
uint32. Do you expect it to grow? If so, when? Why it cannot grow now?



Best regards,
Krzysztof
