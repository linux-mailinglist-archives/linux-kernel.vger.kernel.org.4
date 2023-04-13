Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E972A6E0DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDMMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDMMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:51:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00A8A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qb20so36723974ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681390293; x=1683982293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5a6F6EjtpQuuYBrblyKkvpovTCgK9Ou6bwQuEFgzR0c=;
        b=TIY/GXedrjbai91Z7jH/yVbScack8jNXsScEJjGfsCLHK5G7RJmn83IgTMZxILZDHs
         7Zp4bXPKQH5BFzscNfj3NPRTY3e0luXwEP/Bpcwou5Ll4ODXnPWOm0MwMwyMrHQrkPin
         pTWADuu7lDmkOugcnFjNs4prBD2D/ki39Pnjra1xMoOihaHDN9pteBQ+7Fn1549mDQLo
         cWOq0srGd+VBxB1C3g/IcmqyAiKckNqcGx6UQv/AclTiqzj+Bh9LQbAR107+Y4AujtTG
         2C4kmiQj/2FRse0scGrKIBUWvhsi3I4ToPwWfw6Sa/s24q8yHMm9y5KJlAr6w3ur4GOe
         Bd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390293; x=1683982293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5a6F6EjtpQuuYBrblyKkvpovTCgK9Ou6bwQuEFgzR0c=;
        b=hl0Yxuba4eOwV4O5yz1cNJxxske0ln58TuVFa2DGh3qthOch7uKB9au4dNQK79gux4
         C5w+sKVM7I6Nmt5y2eyuVVSYEO/RCnsOM3sQr+5CUVNdRQ6+Ec2oT97LWpgtSGDuWnzf
         rKecnYyh9TZ7hpejNUY6f+vvhsQSKEh159//crsRzd7uI2D5uTqJUcI1pKLVUrxCJsGe
         XgPZdQUYMNpGKAEtAhpa7RMKrR2CgU21RFtIaXJZX1nzEnEb2UrUZJv3np538fN+zIGN
         gzKCwBWgQ/e5j/2U4YOZ+Q37rvCvNEFH4JCiUZ0+JmCshFDMQzD8C+pZa+TNgw/KJDgy
         /CEg==
X-Gm-Message-State: AAQBX9drhZORMMDceoacQPsPRN9LXaMr7hnD9xY3WTbXBrCO04BPqA/M
        J71sdOJHXrBsN0vjr+hQ2QQGDg==
X-Google-Smtp-Source: AKy350Y8Lx5KHyZTys6FEbU91WQWHhK91LDJm3beK+Q/g1N1/oNpYDNhHXpWLTy+hVXx3aApKAaNJQ==
X-Received: by 2002:a17:906:5008:b0:88f:a236:69e6 with SMTP id s8-20020a170906500800b0088fa23669e6mr2637763ejj.7.1681390292745;
        Thu, 13 Apr 2023 05:51:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id b22-20020a1709062b5600b009306ebc79d3sm953937ejg.59.2023.04.13.05.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 05:51:32 -0700 (PDT)
Message-ID: <081a71b2-951b-76bc-82d5-687a9942450a@linaro.org>
Date:   Thu, 13 Apr 2023 14:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Unclear what to do with compatibility
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     corbet@lwn.net, devicetree@vger.kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org
References: <342b3e6c-fd1b-d256-bcc2-2b9bda206b60@linaro.org>
 <20230413123039.22473-1-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413123039.22473-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 14:30, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.

You sent a new patch. With a weird subject. I don't understand exactly
what is this.

> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> new file mode 100644
> index 000000000000..37177eb9c039
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,max31827.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch
> +
> +maintainers:
> +  - Daniel Matyas <daniel.matyas@analog.com>
> +
> +description: |
> +  Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch with
> +  I2C Interface
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max31827
> +      - adi,max31828
> +      - adi,max31829
> +
> 
> I am really sorry, but I do not understand what I should do.
> 
> Should I add oneOf or items to the compatibility property?

The devices should be marked as compatible with each other, so you can
drop useless match table entries.

https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

and fix this in the driver.


Best regards,
Krzysztof

