Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB26B64F1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCLKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:34:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646B38021
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:34:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y15so2665880lfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1678617293;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+5NjeFdwlyNeSLCFXY+XpjZWno9lnlrc/1OmtKHyQfQ=;
        b=b+IxIOrtxlSRaT2Tdxzvl7iucWQz+o+YdTNpv7ySD284AzTsfoOYfuy/M58yHAhSHN
         vjueTRrSEW4PxamcGl+xKeGP8knABaG7m2la4FkNn8mIL9b9uzi8zDe2fdwY53xPDHJu
         XBZhdfx6ZgMu7rphPT2SSFmvxDh2VeJTzhqx7WCZNDhAbwqKtOMYxdhpf8WF20SMBZzS
         NITOhOsb7eh0PJ4KHiKxTNU/Ub0wMqEjJdw1fyAmr3PkAr016+UvQhOMjX4oFVCDDRGw
         SXtoYo5ABjZzOtZ+ug3TrjiFo5H8/4uuYBnVDDQe/+Yq1RFS9Ab7l9/wlfWw+WBfLEq+
         S1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678617293;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5NjeFdwlyNeSLCFXY+XpjZWno9lnlrc/1OmtKHyQfQ=;
        b=SGfVKpXLC33FOWH5ljCHrIn+JDPo1BxqPOwJVKWqo9PSgYgSuWNnDOG4BajU/EJbim
         ElkABB+ry4w+RRGhE5NtUpgk1xgrAd0v6/1HZiSRiPUW6/1iTLFBkHPfPqQvxGb5iBBR
         JD72jYBhpkmPiyE9RirgODkcnuiI2doQ1/LMK9lFVOtktlcrpG1+ET85m8fcvNAc4gyG
         8EV2TPg1R2oE1ajkwvBvQKyGV0BkK5n4ynzF1IAgnBMYGY3a/1sSymr+qeQwiixFA+rZ
         UckcHCh1O18Sw363WUddN3ruHMVBDSW21SQYHSXtq6+EjxX5V6+39+MOgbX63wPxITj1
         1IBA==
X-Gm-Message-State: AO0yUKVku+Rb8zES4kpP3CpZlMmVwAIlXYVUH1k9QNDCEEAmcNZYgKG4
        gXMrVaxFSOoreGfPESR7K4AOiQ==
X-Google-Smtp-Source: AK7set+bWpKE1JVSk+k/Kfxq9TW5LJUYzgbfVe3UJsr8ox7SC3pzNIE44qA/3RKXbFNx3X80mp8ySg==
X-Received: by 2002:a05:6512:118d:b0:4dc:75c3:9a90 with SMTP id g13-20020a056512118d00b004dc75c39a90mr2099908lfr.11.1678617293367;
        Sun, 12 Mar 2023 03:34:53 -0700 (PDT)
Received: from [192.168.1.9] ([78.109.72.44])
        by smtp.googlemail.com with ESMTPSA id w6-20020a05651203c600b004cc7acfbd2bsm606884lfp.287.2023.03.12.03.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:34:52 -0700 (PDT)
Message-ID: <4821b498-ceff-ca61-db94-29839cf5e0be@wirenboard.com>
Date:   Sun, 12 Mar 2023 13:34:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv3 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 controller
Content-Language: en-GB
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-4-m.zatovic1@gmail.com>
From:   Evgeny Boger <boger@wirenboard.com>
Organization: Wiren Board
In-Reply-To: <20230301142835.19614-4-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 17:28, Martin Zaťovič wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO
> lines to be used on top of the common Wiegand properties. Wiegand
> utilizes two such lines - D0(low data line) and D1(high data line).
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>   .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
>   MAINTAINERS                                   |  5 ++
>   2 files changed, 56 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
>
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> new file mode 100644
> index 000000000000..df28929f6dae
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
> +
> +maintainers:
> +  - Martin Zaťovič <m.zatovic1@gmail.com>
> +
> +description:
> +  This represents the GPIO lines used for bit-banged Wiegand on dedicated GPIO
> +  lines.
> +
> +allOf:
> +  - $ref: /schemas/wiegand/wiegand-controller.yaml#
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
In my experience, the data lines are usually labeled D0/D1, sometimes 
DATA0/DATA1. Data high/data low marking is very rare.
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    wiegand@f00 {
> +        compatible = "wiegand-gpio";
> +        pulse-len-us = <50>;
> +        interval-len-us = <2000>;
> +        frame-gap-us = <2000>;
> +        data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +
> +        /* devices */
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23a67b32f095..91e573466d6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22519,6 +22519,11 @@ F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
>   F:	drivers/wiegand/wiegand.c
>   F:	include/linux/wiegand.h
>   
> +WIEGAND GPIO BITBANG DRIVER
> +M:	Martin Zaťovič <m.zatovic1@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> +
>   WIIMOTE HID DRIVER
>   M:	David Rheinsberg <david.rheinsberg@gmail.com>
>   L:	linux-input@vger.kernel.org

-- 
Kind regards,
Evgeny Boger
CTO @ Wiren Board

