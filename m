Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F36314DC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKTPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKTPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:25:16 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF171F9E6;
        Sun, 20 Nov 2022 07:25:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id jr19so5989600qtb.7;
        Sun, 20 Nov 2022 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+/Aw8lmVI6gvOs4GOlG63zrNeHjc0UvuCCC5lTTgjw=;
        b=cjg/33zAOEaPXT1FnU+ga7d5pq+b7zKUTOtrq6yfQsuQvr7GF57DULR3odyVCzDdH2
         bElrehzZKD2Sv3agBvdHL6ASbuXY0Zc2sCB24yR74DNpslg+tRC82K6IHn7VwlFsrdqE
         RrWkONH6bCb+WfHEq9+XJ44TrS09hX6tQDBbc5/E8DoGLyYHJeAvguKi11jN8+tzc2Ej
         yKoYLqLntNsotDADch3paZNZ2Sk92S87sM8HR45rYVmDWVyq5/RC4xuYXM/sfWUws6Oo
         doba6pIFvh5qfkOishi66Zv+9pD/a+6b9RwGq0dm4D9vwc4nQ4JFADgXLkqpGspWEg5K
         hbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+/Aw8lmVI6gvOs4GOlG63zrNeHjc0UvuCCC5lTTgjw=;
        b=whI+qYmWBWNLLXlfp40VnaSjOy4Rb9m3W6ren64/r58nFRj+MVNTL68LOa25qV1hM8
         /9Ikg54aU2euP7k2PcJpZTzKPjm1rbjCtXL02H0D4vFCHfmbk7WCaoE9kJ7n+yJ+4MWm
         aYyvbcP5B8AXxEYym8p97uBRnyUQHuaeBttxDpU6AfVHZuI22SjNdy9aVu2X+5+hkhWJ
         U1jsroRIyZ/+/bF2ejsjboWB36IqHK6Lomgbop2N3KqFdEvS6P3siXr450r7VL5cRZ48
         R6KWeddClvvkLWILMVpARojMNaDesDRD+Jr13xKDDmNkSvlwtkpJWKs0PCi+oHEfc/ZA
         qhIA==
X-Gm-Message-State: ANoB5pnNJ+yR4xSolZ4z7nMBSaA5U6/+dBuDzeHFFA9iKnYhbxxgwH/m
        KNelqwjXIrrBYZXyyPAOVO4=
X-Google-Smtp-Source: AA0mqf4WQB3q0Oa8lzcKAX8RG8gZ3BDk88Uh6DWdsLLajIQv1RI5uy09GBI9d8QnOjYxZwV435168g==
X-Received: by 2002:ac8:4649:0:b0:3a5:8ea9:34f5 with SMTP id f9-20020ac84649000000b003a58ea934f5mr14188053qto.420.1668957914021;
        Sun, 20 Nov 2022 07:25:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cc16-20020a05622a411000b003a606428a59sm5346868qtb.91.2022.11.20.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:25:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 07:25:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221120152512.GA1791758@roeck-us.net>
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

Another property which is definitely missing and needed
will be DC vs. PWM control. That is currently pwm[1-*]_mode
in sysfs attributes, but it is really a fan attribute.

Many fans are DC controlled, so this property is absolutely
necessary.

Guenter
