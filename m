Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D975FAD26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJKHCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJKHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:01:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB203679D;
        Tue, 11 Oct 2022 00:01:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so12326684pjo.4;
        Tue, 11 Oct 2022 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x66dfSRCV3dCtMHTd3LbjqHcnrhyneK5yWaswp5xBuc=;
        b=QvjvKG9IHttYJEPkGBa9xI5CaVPqKIGNAG6QB7KWQt2/lr06PwL08iNpyhtkgxb+0L
         ItxMztCB87A07qBbyLhqlPGcidjoUCHfYj5q6Wkw/V7t1D/AaNw+KcdWrzUMULP2QfHu
         YJKCjPPCIkfZlnyqH1XJiIydTrKFoZd/V7MQc8ipLhcF5k1sR5abuHvwXOCBdgHGpbpf
         hRGrDP3ebrZ7T6SVafPlZ/Yx+m5juO173RRXQSNTcHjwYvsbGN55ju0wJoshJVde72i+
         FIstPW5NAWuxs9nQhSKTKRN3zK/tOsh+NZCT4V2ye33mjY6bufcFwpy4HwZTrtEMgb97
         5drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x66dfSRCV3dCtMHTd3LbjqHcnrhyneK5yWaswp5xBuc=;
        b=Qc/wsjRZIrDXMYpH5FiC/R7s/K7LE6Su140i/ypyRHobfK1kmdS9TSrpmaEDlg921L
         FTVal8iy32F/yHOfhUrIVx+2K9IXw9BdhybaTnZPWCsmr6SaXL7edBvIpK7Dc5yQVA1R
         w6r1LLzA5KXgdDwj0rn/WqP22vhWJ3ypL7mANEyPW1RTVN5io9qHheYWnic2o6KO2/q3
         PRhlCmnZ884hGNeUc+ITt+e0wiWfmINl3JzruYbWeymwmGlyC08QGoriHbJxQA/qI+rk
         hFNeTElMxTrZqMSqbPbumx6LcLicW4hHbRIIOEIyFr7RzF1THEhfPz2cY1r4rX7T8Wi9
         RWTQ==
X-Gm-Message-State: ACrzQf22p015BHsV4zuUZIdm764lpNBenMuJyU2atg9/u7Oj14NBqIpG
        ynD63+8nxLGog8BY1vKjBcg=
X-Google-Smtp-Source: AMsMyM6sHMvuP4e6cqdke+Ez6RmBUnvg3cSAnruZ5Xg2rpLPoO3nnInX1vRPy9NJ0wd1J6iPiS9YSg==
X-Received: by 2002:a17:902:e5cb:b0:178:192d:1fed with SMTP id u11-20020a170902e5cb00b00178192d1fedmr22887742plf.30.1665471715896;
        Tue, 11 Oct 2022 00:01:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001766a3b2a26sm7876345plh.105.2022.10.11.00.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:01:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <923707a6-7bc4-a435-5532-45fd44ab6d77@roeck-us.net>
Date:   Tue, 11 Oct 2022 00:01:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221010203046.3673663-1-Naresh.Solanki@9elements.com>
 <20221010203046.3673663-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221010203046.3673663-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 13:30, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>    patternProperties:
>      "^fan@[0-2]":
>        type: object
>        allOf:
>          - $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   .../devicetree/bindings/hwmon/fan-common.yaml | 77 +++++++++++++++++++
>   1 file changed, 77 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..6bb990f00e94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulse-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-frequency:
> +    description:
> +      PWM frequency for fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwm-polarity-inverse:
> +    description:
> +      PWM polarity for fan.
> +    type: boolean
> +
> +  label:
> +    description:
> +      Optional fan label
> +    $ref: /schemas/types.yaml#/definitions/string
> +

Question for Rob: If a fan controller has other properties, such
as fan-divider or min-rpm, would it be ok to add those in the fan
controller devicetree bindings, or should those be added here if/when
needed ?

Thanks,
Guenter

> +additionalProperties: true
> +
> +examples:
> +  - |
> +
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan-controller@30 {
> +            compatible = "maxim,max6639";
> +            reg = <0x30>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            fan@0 {
> +                reg = <0>;
> +                label = "CPU0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +
> +            fan@1 {
> +                reg = <1>;
> +                label = "PCIe0_Fan";
> +                max-rpm = <32000>;
> +                pulse-per-revolution = <2>;
> +                target-rpm = <2000>;
> +                pwm-frequency = <25000>;
> +            };
> +
> +        };
> +    };
> +
> +...

