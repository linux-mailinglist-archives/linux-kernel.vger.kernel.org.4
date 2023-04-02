Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AD6D3885
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDBOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:43:33 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9465AD;
        Sun,  2 Apr 2023 07:43:32 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l18so20012133oic.13;
        Sun, 02 Apr 2023 07:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680446612;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sUwmWgSfaGA5atDzRhwn1tpe5ebZkyiB77hJpeGdg84=;
        b=nv0XhA/T5AIkp1Qv7E1OpA0IV0oSHIFicHYSNN8j6NgJbyO7us4BReYOICj0gs6lOB
         OeyGV+IQTqbcy1O+C45fZxifIuS2dJvARn+MH3gphxHir3gMGC+DvBydE1AAWoxHAzNk
         8R5dvSa3Vog6Y7UyAUDBE6ZxUb4QhseNxvil0XhZdQ/FTSyDVRwCnxIy8zuWim/lPU7l
         yUZqOqf816TvsQwFa5pOnwQq+4VQOAW3T9pFzSRMgAzmtLbla6K8QkTGE63zmUCfCJHq
         205hIk5pRTAMQVRyNkBHcyCe7F18NEQ8gYViKEhWpsc5n5YFH4DQFUpZVW+Ij/buwyRK
         +/ng==
X-Gm-Message-State: AAQBX9d4XDwXs4bKs1b2n2P5vgWpti4Zd7OCTON5USJHPFNUgyojvM8d
        ns81tAUyN2vt8tcPrHdZkg==
X-Google-Smtp-Source: AKy350YWvZr3975Dnkh/gHPxxNhfiohDAWa1yAnyk7vbBz8LN5dXTp+7ALZnHhJdHNoSWB5sswMD6w==
X-Received: by 2002:a05:6808:12:b0:389:23e:45e0 with SMTP id u18-20020a056808001200b00389023e45e0mr13478672oic.11.1680446611708;
        Sun, 02 Apr 2023 07:43:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q189-20020acad9c6000000b0038756901d1esm2962147oig.35.2023.04.02.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:43:31 -0700 (PDT)
Received: (nullmailer pid 2422586 invoked by uid 1000);
        Sun, 02 Apr 2023 14:43:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Bondarenko <n2h9z4@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, rjui@broadcom.com,
        linux@roeck-us.net, f.fainelli@gmail.com, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, sbranden@broadcom.com,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230402135555.62507-1-n2h9z4@gmail.com>
References: <20230402135555.62507-1-n2h9z4@gmail.com>
Message-Id: <168044604098.2412538.8062482147729168054.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: watchdog: brcm,kona-wdt: convert txt
 file to yaml
Date:   Sun, 02 Apr 2023 09:43:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 02 Apr 2023 15:55:55 +0200, Nikita Bondarenko wrote:
> Remove device tree binding in txt
> Add device tree binding in json-schema

Write complete sentences. The commit msg purpose is not to explain the 
diff, we can read that. The purpose is to explain why though we don't 
need much reasoning why for conversions. What is useful is any fixes or 
changes you made to the binding (only because the existing binding 
didn't match reality). For example, there's a mismatch in the 
compatible. If you aren't adjusting the schema, then it means you think 
the .dts file is wrong and it needs to be fixed.

> 
> 

Single blank line here.

> Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
> ---
> 
> Changes in v2, according to review comments:
> - use subject prefixes matching the subsystem in patch subject
> - add commit message
> - update the list of maintainers: add here all maintainers returned by scripts/get_maintainer.p who are marked as "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX"
> - remove quotes in - $ref: watchdog.yaml#
> - remove description for reg
> - leave one example
> - add all SoCs mentioned in txt file description to compatible enum values
> 
> Both checks (dtbs_check, dt_binding_check) return no error:
> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json

Doesn't match what I get below...

> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
>   DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb
> 
>  .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
>  .../bindings/watchdog/brcm,kona-wdt.yaml      | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230402135555.62507-1-n2h9z4@gmail.com


watchdog@35002f40: compatible: ['brcm,bcm11351-wdt', 'brcm,kona-wdt'] is too long
	arch/arm/boot/dts/bcm28155-ap.dtb

watchdog@35002f40: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm/boot/dts/bcm28155-ap.dtb

