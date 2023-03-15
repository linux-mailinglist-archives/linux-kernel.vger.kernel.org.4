Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6827C6BB802
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCOPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:36:49 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83379B07;
        Wed, 15 Mar 2023 08:36:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y12so6339750ilq.4;
        Wed, 15 Mar 2023 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678894576;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms6fv+hw5MJ/w0++av6ZjeeiPsBlOux2GXBW4FkF2c8=;
        b=lLFWgW4eFpcFBnLNyCxROzsHTGzOm+csYYsZtLHvd9YKlCK19/RDEhA6yYhgGBDr4Y
         4EKTdLHMXlcZyIUbj/W8N4rMf6Zdawye63tQZrY0fKWGrAWujB5YkkO6InZRcIs1AG04
         xZ0Wu0fx6j+Btv/ueQZJ+eH4U3WmpJ1MVhl+2sWXAkcDKG8DRUUPXOvbi5YKXyQulKir
         CcxLTPDh4N308pIceUAZdrhTGTzw9akPuxtT4YOetzElCJtJMvBUsSf64Nt/Z5tx2+sh
         7AYG1qY8QgaJWEVQKiMUx7dUiLBuGWzVH94bSzpKBPdguqlXBDwUQol86KepmLMr1ztz
         9lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894576;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms6fv+hw5MJ/w0++av6ZjeeiPsBlOux2GXBW4FkF2c8=;
        b=dKYkpOcHdOwz+DyhfZ7aTgT+JAAYVySok4H9Zj7pm1DSUGbahGhwJOb+hawiIKuV/N
         XjmSpHZH/aPcyyXUyoddnFcIE7lA2L5zbBruSN4y5xP3a3kbKMJIH9bKtrQznMDpc2oc
         FsRtfMn9AZlbqQid8UbpOz5m68sMVomwlG278u/mQDrRQvFLebXK+p77rc/gL9yYGPpK
         xcSxmJUTEiOwLmn0FxOuuRZTwM7OgSrXdvGwAOOAzfB+LJCF/kiDiAXiSN0jHUoYFG3N
         IW1V9pzxJud28etoui9wr8g1sMZkC3Jip6lsU9jouZkGMLhmkfaREZH9g9zaNP5cEIjX
         oWdg==
X-Gm-Message-State: AO0yUKXKhY2R2H6WDDfQw3GzHvSrkYPwUS0tWEWYaKEXKw9Rk4008EUw
        a2vsYueq901hDO+wqVG8bWmh/CLeXLI=
X-Google-Smtp-Source: AK7set9r9nmgdmFk3SESGK1SvIGeRVbj8PBfT/V09jQ5sEtE04xQqqz5BzD4wi2eaUbE3PT+1shVaQ==
X-Received: by 2002:a92:d58a:0:b0:315:8bc0:1d85 with SMTP id a10-20020a92d58a000000b003158bc01d85mr4395086iln.11.1678894576122;
        Wed, 15 Mar 2023 08:36:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a02b384000000b00406101d2dcbsm1210651jan.125.2023.03.15.08.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:36:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
Date:   Wed, 15 Mar 2023 08:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     phinex <phinex@realtek.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315121606.GA71707@threadripper>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
In-Reply-To: <20230315121606.GA71707@threadripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 05:16, phinex wrote:
> Support thermal zone so that we can just rely on dts to describe a
> thermal zone and do the cooling operations.
> 
> You can define a comptible string "drivetemp,hdd-sensors" to enable
> this, such as
> 
> 	sata_port0: sata-port@0 {
> 		compatible = "drivetemp,hdd-sensors";
> 		#thermal-sensor-cells = <0>;
> 	}
> 
> Then define a thermal with this sensor to get it work.
> 
>                 hdd_thermal: hdd-thermal {
>                         thermal-sensors = <&sata_port0>;
> 		}
> 
> In most of the SoC systems, using dts to handle cooling is common.
> This can eliminate the usage of user space application to check
> the value exported in hwmon and then through sysfs to cooling.
> 
> Signed-off-by: phinex <phinex@realtek.com>
> 
> ---
>   .../bindings/hwmon/drivetemp,hdd-sensors.yaml |  35 ++++++
>   drivers/hwmon/drivetemp.c                     | 102 +++++++++++++++++-
>   2 files changed, 133 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> new file mode 100644
> index 000000000000..939d7a923e94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/drivetemp,hdd-sensors.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Drivetemp Temperature Monitor
> +
> +maintainers:
> +  - Phinex <phinex@realtek.com>
> +
> +description: |
> +  Drivetemp Temperature Monitor that support a single thermal zone
> +  This single thermal zone can support multiple hard drives,
> +  it uses maximal temperature of these hard drivers as its temp value.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - drivetemp,hdd-sensors
> +
> +  '#thermal-sensor-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata_port0: sata-port@0 {
> +        ompatible = "drivetemp,hdd-sensors";
> +        #thermal-sensor-cells = <0>;
> +    };
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 1eb37106a220..9a60315d732c 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -107,6 +107,14 @@
>   #include <scsi/scsi_device.h>
>   #include <scsi/scsi_driver.h>
>   #include <scsi/scsi_proto.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +#include <linux/libata.h>
> +
> +/*A single thermal_zone for all HDD sensors */
> +static struct thermal_zone_device *tz;


This is conceptually wrong. It returns the maximum temperature from all drives,
not the temperature from a single drive.

This is not much different from collecting all temperatures from all sensors
in the system and declaring the maximum of those as single thermal zone.

If anything, each drive would have to reflect a thermal zone. The big question
is how to determine the associated devicetree property.

Also, essentially your patch claims that arch/arm/boot/dts/kirkwood-nsa310s.dts
doesn't work and no one ever noticed. I would like to see that confirmed.

Thanks,
Guenter

