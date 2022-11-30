Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C463D876
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiK3Oqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK3Oqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:46:32 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937F2FC08;
        Wed, 30 Nov 2022 06:46:29 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd19c3b68so21210167fac.7;
        Wed, 30 Nov 2022 06:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz2Zju85pk6RM8ay+t4ZZMp7vPi+1UtgJxv5v1iOFoQ=;
        b=hKswxqL0mQZMN7I40fIMLw92nRBqkmnIO8lk/f7t3UHfjWA0CSR56InG13myRTq6gI
         XcbUImbCKlN0QAu1qUMvvjRFsTQw2A+zqR2+ySOUEgdz9D1QkCT6yS0ljMAPoWkRcPDo
         5lb2ZXKZrqw0VrryvVVjuzA8zYs/BjSyHuRm/1Y3tQQXgD98O6jLqVZAmYQQAJzmLkOo
         mw3gm5otainEAHoQ6Q2RMRRlkGqabvRgcoa7F8jUbW1w5o4WdhsJyUplnmYE2VbUrjHC
         qdhoONhNdrKE4Wg8s2n/PUnYkiMZo9wcAtBzMXDX/GAzm3FDrG8VoAvArkFTao9DYGGE
         M3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz2Zju85pk6RM8ay+t4ZZMp7vPi+1UtgJxv5v1iOFoQ=;
        b=H6V034Kdz60zZgSl2F6N0MCcVRW1TpwefbrTvkJJWscNTZFAASqXZfRT2ihi4fZ6Zf
         LiU7bBDCN90UKi8Mds0WW1fjFAhyKMbleRb7MlPmF2Q8EjtpysJIqedl2jzMHElcD55p
         xCEzDsWNyd2yJ7eVFHUbM0L2eXL8uwnPCup+ErBu3MQii+snxBXOiJ69HVBv9M26wKtj
         LsYeYBKQLtq3ARmfCBVl5hh5G0QrCv3+sNWj3EJvxre64WKFzeybRRlh7bhOH3/J0KHe
         ECbJC1iIxTVMTfYRcnjvhcDEPkmfDd0/P/vNRRmGFLEliUalFwyAN/Wk7rADMv299yKF
         GrNA==
X-Gm-Message-State: ANoB5pn5gaxtTfukdMiLoYtV7MtGDGuM2NLY6l3tstEs6KUKPIQhEPVN
        WvdpifAic3JlFucEE5sGEvs=
X-Google-Smtp-Source: AA0mqf4ixzUkoSU6MRES0SwcX528RMcs4hO6mghmHVHKToufdig484nOzJOgbmgVYuQYYFa2c3yTLQ==
X-Received: by 2002:a05:6870:2408:b0:132:1a61:8ed9 with SMTP id n8-20020a056870240800b001321a618ed9mr24354219oap.105.1669819588532;
        Wed, 30 Nov 2022 06:46:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h17-20020a056870171100b00136c20b1c59sm1216568oae.43.2022.11.30.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:46:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Nov 2022 06:46:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: hwmon: fan: Add Common Fan Properties
Message-ID: <20221130144626.GA2647609@roeck-us.net>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129161134.2672474-2-Naresh.Solanki@9elements.com>
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

On Tue, Nov 29, 2022 at 05:11:31PM +0100, Naresh Solanki wrote:
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
>  .../devicetree/bindings/hwmon/fan-common.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> new file mode 100644
> index 000000000000..330fb1552821
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Fan Properties
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
> +    maxItems: 1
> +    description:
> +      PWM signal for the fan
> +
> +  label:
> +    description:
> +      Optional fan label
> +
> +  fan-supply:
> +    description:
> +      Power supply for fan.
> +

I still don't see fan mode (DC or PWM). I understand that you don't care,
but from my perspective it must be addressed in generic fan properties,
especially to ensure agreement on how 'pwms' is handled on a system where
the fan mode is configurable, and how to select the fan speed on systems
supporting DC fans.

Guenter
