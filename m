Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B606BA74D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjCOFnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCOFnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:43:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E03630EB0;
        Tue, 14 Mar 2023 22:43:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g17so22893674lfv.4;
        Tue, 14 Mar 2023 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678858989;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Co5Fsb6UYHT3jKPf/J3YdTeZmb+e4VYPFsJZlTA13k=;
        b=h4+JJE54R/tsnM3ZqLltjdV/INxZwW+tXjOxM4ggeXyzvxS3tSNx/eLU+dy7UXouA3
         VO89StJ+Fu2rMPSzIGRbgMwTACK/58ZdEQvGsth5OgWXLdH/NQzZ8vEceYxCyZnWVTmY
         cYvaLFtwn4qnF4K/cYGOLRw4EDK5NNc4PYkvPhelUo1t9WkMCCJffYgeDjQ/ivuo0arc
         yhQS8FGFblPVKRbsbe6JXZAEvr2aD5R0CYT/x1an7J2+Ac/Ao5vkfgWNI3BJsr84HNdY
         dggkZHbX63zU5+HMsilOTMW5NU9Y45gBD+2N+w/ccwjk/pg7mH4rLb1tUyXox7oXgcwS
         LBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678858989;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Co5Fsb6UYHT3jKPf/J3YdTeZmb+e4VYPFsJZlTA13k=;
        b=xX7yNyNLs0uOilLgG8nJi+W5HK9V6VGNsFjMRR2IzsCsUP9JeXO/C0nv8yk7NQqxza
         L8PNGWepBMjBYe3ztuq7TUgZdbYtPAIKQJkgwb4alRBDekZmNEqFt/BcDIxmxZou2TN1
         uaw5JkwiUoAOK3hNffGXBWrne6PKhpaK9NeRTVc975SR9tGKQtU15qsI5wtqRvPpAYvy
         zTTTpfrcCRqXca4H4iW7Ai9pxWFhNCJu+vee7S4ProBO0G7dOfkvX8HK2ovoguwG3S5u
         T937A1xgS3We41Vp94hHelk6Y1fx31zlRD9Phob4zxfNUhxqgD7amAacPGtLedvaf1SI
         qx0w==
X-Gm-Message-State: AO0yUKWVpl6xvE0+hmZHwRZAOIUgSJBra7lgnpBoj0XRjIkiKAjg521j
        YdV89Z+XKfafdGEjRqx1pzf6WrQf4NQ=
X-Google-Smtp-Source: AK7set+7drS4YyFEmRHKxZz0WOyPhi9hG9lRa87pk5ANt9koHTv0NwLw5MuKp58DtNl2qfwzsaLRAg==
X-Received: by 2002:ac2:5519:0:b0:4b4:f9df:c6ab with SMTP id j25-20020ac25519000000b004b4f9dfc6abmr1212724lfk.60.1678858988694;
        Tue, 14 Mar 2023 22:43:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id d27-20020ac24c9b000000b004e7fa99f2b5sm681372lfl.186.2023.03.14.22.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 22:43:08 -0700 (PDT)
Message-ID: <47f9e288-6c1b-6205-8538-303b65ff160d@gmail.com>
Date:   Wed, 15 Mar 2023 07:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-2-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCHv2 01/12] dt-bindings: power: supply: adc-battery: add
 binding
In-Reply-To: <20230314225535.1321736-2-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 00:55, Sebastian Reichel wrote:
> Add binding for a battery that is only monitored via ADC
> channels and simple status GPIOs.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   .../bindings/power/supply/adc-battery.yaml    | 70 +++++++++++++++++++
>   1 file changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adc-battery.yaml b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> new file mode 100644
> index 000000000000..ed9702caedff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adc-battery.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adc-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC battery
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  Basic battery capacity meter, which only reports basic battery data
> +  via ADC channels and optionally indicate that the battery is full by
> +  polling a GPIO line.
> +
> +  The voltage is expected to be measured between the battery terminals
> +  and mandatory. The optional current/power channel is expected to
> +  monitor the current/power flowing out of the battery. Last but not
> +  least the temperature channel is supposed to measure the battery
> +  temperature.

This looks very good to me. Even I fell under the illusion I know what 
these bindings mean and how the hardware looks like ;)

I am terrible with the bindings syntax so this is not worth much but:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

