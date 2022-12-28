Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5EC65852B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiL1ROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiL1ROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:14:42 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE278FD5;
        Wed, 28 Dec 2022 09:14:41 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-144bd860fdbso19223105fac.0;
        Wed, 28 Dec 2022 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03KMZFCCe036h3h9P6s+Dh+trLce2AP28tlgP7jhGys=;
        b=FayFoNZy9tmIj/uxpjvXCfll7Pozam9fETempZvgnYHIpZFy8Kuvj5UMbiwoQeN90I
         9iweoJwcwzMw3b6UcOS66dYh5qkfhKsA8evhv9JFb9Mcwwyq5yOcodqu4oVD6beKngDG
         S/7+mtMeB/e4El2tZ2Il/4YZqckoSiOQDg561AyUHyz0PSxjYnq5nE1EkVV+oL+xTH7J
         HYL5NkVAcGVNyOm0AKFLbDkaU1G4XlVuqzHCfDw6C6dg5TpKFUrFX0anKeVJQ/5ImjlH
         QNMZ5J4lELgPRpEPudvGfZMrQzG4YZzsRu7ztgcybzR1A6lsyz9GpT2cVXG2cJ1mkYyg
         IRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03KMZFCCe036h3h9P6s+Dh+trLce2AP28tlgP7jhGys=;
        b=MfBRTRc+9y2ODvECcSbpzzl1FHSY0Qm8oE5FybjC+hXYGx6fHyHlfKHBefC6QHWvnq
         b2riysI7XaQbmKHB63gZmXAcsDlN3XgShce+EVmi9hrt/n4qlDPj0eHEaod+ajUTypcx
         NjuLEC88n/z2Dt/INQqVQrGu/a8YXUHOip68WzvJucIkqtWe6ErJzVRVjJmwvPeF0cTU
         8dM9o0YXo6ekuB+c6ByrE3+NQECCVPOC9mzDUVub6ala1lf438lcaMOX/bfMMHPS6JOM
         zdTFMwQy4xVSejXl8ujWgyy0X6Z2w0u6TYuoBBJ3HZY9CllmH/7vKZcKfhawjLK+Lo5Z
         WShw==
X-Gm-Message-State: AFqh2ko/zEoowRQ3ocWLuhPr1wu9GgA7gXuXUKtEBOwbnuWx8VelWoRI
        XYbKGhAFZAaHNekHzIJgNsU=
X-Google-Smtp-Source: AMrXdXu6Bby8Ov7gR7/xph/6NGDlwqO7ov0mVggySzThdICeYFZbhzzcZ3v0igCKxzqacQ4moE8oFA==
X-Received: by 2002:a05:6871:590:b0:144:e4c9:41bb with SMTP id u16-20020a056871059000b00144e4c941bbmr14576912oan.43.1672247681184;
        Wed, 28 Dec 2022 09:14:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u19-20020a056870441300b00143824af059sm7595608oah.7.2022.12.28.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:14:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 09:14:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Message-ID: <20221228171439.GA2575640@roeck-us.net>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
 <20221130200846.4226-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200846.4226-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:08:43PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the binding to support control of the fans on
> HPE platforms.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> new file mode 100644
> index 000000000000..4a52aac6be72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/hpe,gxp-fan-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Fan Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description: |
> +  The HPE GXP fan controller controls the fans through an external CPLD
> +  device that connects to the fans.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-fan-ctrl
> +
> +  reg:
> +    items:
> +      - description: Fan controller PWM
> +      - description: Programmable logic
> +      - description: Function 2
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: pl
> +      - const: fn2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fan-controller@1000c00 {
> +      compatible = "hpe,gxp-fan-ctrl";
> +      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
> +      reg-names = "base", "pl", "fn2";
> +    };
