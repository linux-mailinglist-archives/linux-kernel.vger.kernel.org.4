Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9A6890B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjBCHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBCHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:22:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FE719B1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:22:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso5353515wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMUKuwLWcXuKBGcI4B6z2PT7CL6DcvJ4tQBIJBVQHHY=;
        b=cuoOXD5C0i4TVLYIPQ/C2YPE2pKmmpwifQ9338wofR0Tt4uOKvvz0zZ5MRob+tqK/D
         mVsGaMX1IaSMpjt1aLSvFKDItUTTBrmFvXtQHBRnpOc8kwRDdsgB1AJNOFaqWcHQBH/Z
         AjreU0cAnlwd9/cA96r5bRgSZH9psYQi/9qOHF78Tef0YuwBUzcU0dkGC3fHO2wtsjRt
         oK224/F00ousL0F7Cl7bf3cNeA7gl5wEQ3h+JsJI42J9FB6KJlVnE+EqrO1168LMziHz
         k5PcGSBEPW05tU46AX8NXjCstRYbQgFS53//vs9zSVvkN02wgagXcZMS3n+jc+RzzdtX
         Uurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMUKuwLWcXuKBGcI4B6z2PT7CL6DcvJ4tQBIJBVQHHY=;
        b=R//tFFLwp9ZTWHWKbOzGDV6lDPHOKVGCjS4ifvSjFkYs/7HL1/GiQWwQpCxq0tyDce
         UW6/QoJnjarGu/KzGi6YAKQLk52yknOxuYVJL+nqguM0iSoIaJTXGcIbarV9JML81Wl2
         chHeLNZnl+d9lORzaCJK3jy+gUAjzyYCU4CwxZIbixkM+t55bQbCYDzq6CSQiyVTW9uE
         HRhEviGKVHlkGM/AZQmEM+uUXjQRtwEyMxJngI+UBIaiNkSSsH5wScUbOEWPncSPnKU3
         HFxvDLOyuATt2bjXsPqY8N252STS9utdWzQBkBTiaHi9UiFQ/YRs1pENppj4/YP2wz4Q
         vMqQ==
X-Gm-Message-State: AO0yUKUYy8rtvPSr5GA7moRoG3vZECobu2+GUHEDW9yQ9sqXzkNCksza
        vIlLv0SHj5P82gh4IBpJ/v2WxQ==
X-Google-Smtp-Source: AK7set8M5YvmBYjZHpqWR6IT8n27amwIXMRHmX4a+Rq88JpeWBIC0RdQZKbZHddovpkh2czzD5YQaA==
X-Received: by 2002:a05:600c:19ca:b0:3d9:f85c:97ff with SMTP id u10-20020a05600c19ca00b003d9f85c97ffmr8608373wmq.16.1675408962337;
        Thu, 02 Feb 2023 23:22:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003dc54eef495sm1977767wms.24.2023.02.02.23.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:22:42 -0800 (PST)
Message-ID: <f87ba1db-6722-070a-79c5-6a25f9c4ce94@linaro.org>
Date:   Fri, 3 Feb 2023 08:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv2 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 documentation
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-4-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202143305.21789-4-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:33, Martin Zaťovič wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO
> lines to be used on top of the common Wiegand properties. Wiegand
> utilizes two such lines - D0(low data line) and D1(high data line).

Subject: drop second/last, redundant "bindings". The "documentation"
prefix is already stating that these are bindings.

You already got almost same comment with your v1.

> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> new file mode 100644
> index 000000000000..3af0b7e04b3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO bitbanged Wiegand interface devicetree bindings

Drop "devicetree bindings"

You already got almost same comment with your v1.

> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description:
> +  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
> +  lines.
> +
> +allOf:
> +  - $ref: "/schemas/wiegand/wiegand-controller.yaml#"

Drop quotes

> +
> +properties:
> +  compatible:
> +    const: wiegand-gpio
> +
> +  data-hi-gpios:
> +    description: GPIO used as Wiegands data-hi line.
> +    maxItems: 1
> +
> +  data-lo-gpios:
> +    description: GPIO used as Wiegands data-lo line.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - data-hi-gpios
> +  - data-lo-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    wiegand@f00 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

