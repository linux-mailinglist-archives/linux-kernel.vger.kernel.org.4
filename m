Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0B6314D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKTPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:13:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B001E24;
        Sun, 20 Nov 2022 07:13:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x21so6619631qkj.0;
        Sun, 20 Nov 2022 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEet9JOPoIEWCj66kbNHR0+VF60oaaiZgJIJ3wRRyjk=;
        b=qMPD3RVHdnExh63OwxFip+MsErULfaa4b3a6xJv6BeVIN3Jm8JzzL0hF4WkqyKI/SP
         RVfJbmZxNgJQshyGm8fFgryrZaJB1eje9RStDBapPy/gI2nwjjQqZmaVFuiWe3Vcxw1T
         /SyJJblI24MFj135f0vMwRxM+ovuMVT54kIJ0BQAgjdTYwGohYlfk4gwBns0bHPNnHOI
         Zxsct3yemewU6OEXptzsiX7XBmQBP+Xb1cu83rDSzch9RwD5NC33MXe25tvkSLlSqjC1
         8y14bD5uztjSSXUeae9KHxh//GmhMlP+6/keyp1/vj+ylwXBYPZoXdPEuP7xjty3Bgwx
         vUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEet9JOPoIEWCj66kbNHR0+VF60oaaiZgJIJ3wRRyjk=;
        b=mOYv8moDFA819o2cALhHCL7vlExub+FsF9fMM3VpULXMLi5724HscY89wDzlKF6T2H
         lU744grDWaFs4J3GTd94Z01wA+B4vzDEIpkn2HRrKOe4SWxeqcnNbGtRMYCNlDD5m0+I
         cTYrhqOdpG0WG9w4fP881EwKedW+heQONTHmydgr6gPnZ8nFF3XVAdYaMJIrfQS5En5w
         C1RuhUrpDKrFGRNmYsk3ZOr0IIjtLjxYBDSLNYJ24qW690xpqkNBCPtLc06NvmzaRUU5
         OibRXQDqDKqCgw/aLwD04rUybpu1S+cHKIOsyQw0HU6Lv21bClldhlA7484mLwdeyKC9
         qODQ==
X-Gm-Message-State: ANoB5pnKKy6TnCQSvH4fXv9d406TKmL0TbkpZBrm497b6+t/Bw4MQ3Lc
        f10W+482deRsIxHFhoEnPyXC3Aq+H1Q=
X-Google-Smtp-Source: AA0mqf5vMOcNnxUvZnFESz7Fv2ej3UR5hHdpCkWO51OtX+PJIkWRBXw3iyvV17EVOpIZiGaQ4NyH8g==
X-Received: by 2002:a05:620a:22d6:b0:6fa:2cb5:8b4b with SMTP id o22-20020a05620a22d600b006fa2cb58b4bmr12976298qki.348.1668957214274;
        Sun, 20 Nov 2022 07:13:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14-20020ac85b0e000000b003a591194221sm5526496qtw.7.2022.11.20.07.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:13:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 07:13:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221120151331.GA1791561@roeck-us.net>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:36:13PM +0100, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..1954882eed77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,42 @@
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

I still think that at least min-rpm should be added. It is just as common
as max-rpm.

Guenter

> +additionalProperties: true
> +
> +...
