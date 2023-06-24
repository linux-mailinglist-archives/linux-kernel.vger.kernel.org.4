Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7480B73CBE6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjFXQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:36:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7621BC1;
        Sat, 24 Jun 2023 09:36:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so980703a12.0;
        Sat, 24 Jun 2023 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687624596; x=1690216596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uRjgTTn6+tocS1CfpT8NuIREsPyTbnswKwzAOlv1iic=;
        b=jdoCeBZ1J4orKGiyp+JSRSmfoZ8+awHUSu1nqW1OqM7Z1mrrXjZu2dBUaOVNeNX7o3
         Sbh5xhxKmng+peYZ67DqYKmXELFUATnLeA97IfLRxJxhJSxz/S/MWUthYUFDMZPSBVbk
         5jr36rX6q8fSShLk3UBU+YKn8rsLlzWgvqjbu2WW5cYl5BC2eP7mP/ILHgal1qtAjvuJ
         6C8AMAXL9CDjlxvmZJkm3or7Y0uN1PMPRRuk9k9Kmz+gDSCVHAmU+yqxrhYVt5O/a8S3
         JN1tCp21b3A0Pc47tqB/cauqtR1kBLI0ZoTK5J9r9r3zuKPriKvuBaJ9DIyhfsx+HxDc
         oTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687624596; x=1690216596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRjgTTn6+tocS1CfpT8NuIREsPyTbnswKwzAOlv1iic=;
        b=Czos03padTvUR8dqGTJKlR1gyrecY35YVD+GKU/pE/pcUR2dXo39pbHh1CT6eayolJ
         u1yeVbollvpe12ZjytT454SZQkjX2kdT3aQN6lVn/jUQLqMqG8Ehdp/I1T8zNTnr7oUX
         W7Kpz1SswdEbrQqu1bkISku1G/nNTVbpUgmcWaaY8Kr8Fr589KWF5v2LkCOgIZlOAnNj
         4Y8dZsURs0SLMHQTiED2y8bUkdd4WHj2VQWmxbpMIW990erXBybh5wkoUrSzt/sbW0Mb
         Buy2rc0m0tpse+C/Tr6qg2NIf5WnEd3m/aanj+/j/GouSWFZGRRBqJj5zJQd1aIBMWbT
         LLcA==
X-Gm-Message-State: AC+VfDzyoohBZeAnwROK48+QUV47GsXG1KbEAp9bX6ysCHTXXvV98x6X
        po6nXTgepPerDLtE8Ghia4M=
X-Google-Smtp-Source: ACHHUZ5h/5HUTSW8jLo+ZY+5wftB8H5U44rtouECIWXflqIwtonMxoggzU27S0M6KP1yvZLWdLq0bg==
X-Received: by 2002:a17:90a:d310:b0:25e:b5ba:8bb9 with SMTP id p16-20020a17090ad31000b0025eb5ba8bb9mr17991739pju.5.1687624596625;
        Sat, 24 Jun 2023 09:36:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b0025df695a02asm3279568pjb.17.2023.06.24.09.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 09:36:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c7422c2d-1a78-32a0-86a9-225d5880cbc2@roeck-us.net>
Date:   Sat, 24 Jun 2023 09:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] dt-bindings: <hwmon>: add sht3x devicetree binding
Content-Language: en-US
To:     JuenKit_Yip@hotmail.com, jdelvare@suse.com,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DB4PR10MB626179DE1C511B10ECA74D209220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 09:01, JuenKit_Yip@hotmail.com wrote:
> From: JuenKit Yip <JuenKit_Yip@hotmail.com>
> 
> add sht3x devicetree binding files
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>   .../devicetree/bindings/hwmon/sht3x.yaml      | 31 +++++++++++++++++++

This isn't needed if the compatibles are added to trivial-devices.yaml
(and it really only makes sense if there are additional properties
besides compatible).

Guenter

>   .../devicetree/bindings/trivial-devices.yaml  |  4 +++
>   2 files changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/sht3x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sht3x.yaml b/Documentation/devicetree/bindings/hwmon/sht3x.yaml
> new file mode 100644
> index 000000000000..8ff0b8d41f91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sht3x.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +% YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,sht3x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHT3x-DIS humidity and temperature sensor
> +
> +maintainers:
> +  - JuenKit Yip <JuenKit_Yip@hotmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sht3x
> +      - sensirion,sts3x
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +addtionalProperties: false
> +
> +examples:
> +  - |
> +    sensor@4a {
> +      compatible = "sensirion,sht3x";
> +      reg = <0x4a>;
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ba2bfb547909..b2369d1fad68 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -331,6 +331,10 @@ properties:
>             - sensirion,sgp30
>               # Sensirion gas sensor with I2C interface
>             - sensirion,sgp40
> +            # Sensirion SHT3x-DIS humidity and temperature sensor
> +          - sensirion,sht3x
> +            # Sensirion STS3x humidity sensor
> +          - sensirion,sts3x
>               # Sensirion temperature & humidity sensor with I2C interface
>             - sensirion,sht4x
>               # Sensortek 3 axis accelerometer

