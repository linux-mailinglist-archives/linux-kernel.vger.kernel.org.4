Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614963447F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiKVTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVTZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:25:33 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C887FF21;
        Tue, 22 Nov 2022 11:25:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n186so16862400oih.7;
        Tue, 22 Nov 2022 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09Fo0rR4StbdjPIIvlInIxSHew0e7ivCTP8R8vAEZ3Y=;
        b=mUndDyNeXjHl/vP19NQ4bwpklc7wS/EV0Ci39R6mCfU+ZxAnNdZbU/36cdmGRifMcN
         xzeEa2uMwqa1dKwsoh3qKVaQkCDmsxgHNYC1mpbtCEZIt4ZZ7OGdgdd3YEbaWrhFwIuK
         4o45IeQ1Tmek/Jd6QWrtBJCLbIIYrJIOE6ClTzK7IauSF9VT5Yg3QoZQrObyxKe6yn0/
         jqejpCxPOIp4DtUn8CMbZjKoP/Mo+yyarmZni20JTDTVHkSIPapnC7r/X0y/3Cxa8N1F
         QvLN5GuMo+1ycb9EzV5h7bXZL/BA6gUFkbIzlxNz1zbJ+cvYGRARg3GuyBdgcx5qrnWQ
         IckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09Fo0rR4StbdjPIIvlInIxSHew0e7ivCTP8R8vAEZ3Y=;
        b=GInXFDXWz7Sk4S1UTP1A7x5CItkAoVvi2zW3Lw15YWhfbsKcYonOVBowgHtpfUCk6Y
         qRpt3mQ3SVbvGM4Gt1JezsNbl3fCEr7KogR9efF11mnSg7tEkvGLA4RbHIcWgUd51h7G
         6EPEfixNC6Sk/G4xTIZmCbxWW8HME1RmyMw4k7VneAlc1DZVsOgxUWI6ovlJIj/xpulC
         SuOzhgYej7H16gkA27kLmvOePmvaahgOYXUar1FHB5+XGCKbZb66WqoSCVMcM5iQLcNm
         vrMlL52MHmXwywilpghSf4TNOZBuwaRQBFnLZuYEQHnUSX2Ovvv1P8a0Evc4q/C1hE3E
         uZTQ==
X-Gm-Message-State: ANoB5pnCGGdqp3iD/LuPd1uoTw5pK94ux+DHDFDWu5pS8VW8TSG/2C90
        AmdQ4mkEQjJfXkqSfRYJ1Vbf/YuCoiE=
X-Google-Smtp-Source: AA0mqf6jwoymerXoL3TKr2O+FS3QfhwQkUTlFpCJoSPC9VFX60OhX6Tz5DTTYZX6ZvM7zf1RHow7+A==
X-Received: by 2002:a54:4399:0:b0:355:bceb:2606 with SMTP id u25-20020a544399000000b00355bceb2606mr7342032oiv.188.1669145131637;
        Tue, 22 Nov 2022 11:25:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a9d53cb000000b00667ff6b7e9esm6491267oth.40.2022.11.22.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 11:25:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <25b37a72-4415-2ed5-0415-040af174a70a@roeck-us.net>
Date:   Tue, 22 Nov 2022 11:25:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
 <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 1/4] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 04:29, Naresh Solanki wrote:
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
>        $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   .../devicetree/bindings/hwmon/fan-common.yaml | 47 +++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..0535d37624cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common fan properties
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +properties:
> +  max-rpm:
> +    description:
> +      Max RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  min-rpm:
> +    description:
> +      Min RPM supported by fan.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pulses-per-revolution:
> +    description:
> +      The number of pulse from fan sensor per revolution.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  target-rpm:
> +    description:
> +      Target RPM the fan should be configured during driver probe.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pwms:
> +    description:
> +      PWM provider.
> +
> +  label:
> +    description:
> +      Optional fan label
> +
> +  fan-supply:
> +    description:
> +      Power supply for fan.
> +
> +additionalProperties: true
> +
> +...

Still, from my second reply to v6:

 > Another property which is definitely missing and needed
 > will be DC vs. PWM control. That is currently pwm[1-*]_mode
 > in sysfs attributes, but it is really a fan attribute.
 >
 > Many fans are DC controlled, so this property is absolutely
 > necessary.

Plus, with DC control there is no pwm. It would be absolutely wrong
to declare that a fan controller MUST be pwm based.

Ultimately, there are three types of fan controllers:

- PWM control, such as MAX6639
- DC control, such as MAX6620 or MAX6650/6651
- Configurable, such as MAX1669 or pretty much all fan controllers
   included in SuperIO chips

Generic fan control bindings simply _have_ to take this into account.

Guenter

