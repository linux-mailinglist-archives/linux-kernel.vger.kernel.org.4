Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B926E4BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDQOyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjDQOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:54:48 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4286B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fb615ac3dso207322127b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743282; x=1684335282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R41AeUQLg4hcYgCBHVVzM5K8dJVEmg+tpTKo/58aTE0=;
        b=qp/RU/tZ8c9QibLLkfuRZKc4VV/Y3Sze5ebucqBO8DQnBcO1id9Z69kTSpJrNAhaJM
         6F/IR4pN7tefusqUJQ+W6669dl47+KPFRVh/07RGgRXA2UGEO9Iw4tiRHiyYa/fklI6p
         bHRDdpWYPnTS3KDarFqUzqHHuLCz22szD2xRPjoRbIZnYdIA9Qp3yghz/Obj7ZZKbNJE
         26MAaDWTRR67eU1Qj5Mb/WkRgkFwVC7keg2Himobd51My/K7Uo7loMevYKvKtjj53k9W
         xehufYih/4KwkiH3FOQR8zkNPAlEFvbJlvnBLlhmGegXWKew+Bg1sY5X8jMiRzEfDjIt
         qmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743282; x=1684335282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R41AeUQLg4hcYgCBHVVzM5K8dJVEmg+tpTKo/58aTE0=;
        b=fEt3fScTlwJ2/zAZSLXdHtMovSWuOYAAfCu11n59f/ro7PvtUnUR6lauF1fhCLEqfV
         SilZ1PzsD24axpPBQ9nVKbztbQc7WO9dEGcjQWcR0HA2TRhE70Wes0R5WlwgKS1BAZgE
         ot4lPu03z1j0CDJTvJahcr3xtYKA1q05c73O3fanvpmQNsGO7ut/0rzCE4O9oPzboHmr
         Fg10b2Z1kewrYpdrWUVkmbFcwFjZ1yxTWVo+7X9H+a+DTejnqpWjV6JTNdxFLe/isXlo
         /BSX+ayq81JO/3YGzrSHUV5GeCVnPAH4ewsqLVHNitkGJAn2O+SBfuO/OyezU/zQBl2Q
         ouGg==
X-Gm-Message-State: AAQBX9fUCHoRTyo9A6pEk3E9l2kp2zr/Zbem4/rTLaYM/KAGuian/6a9
        SHP2seX+s5PweF3TPaKOcfx0SPbZocbMG2dwNpBmrQ==
X-Google-Smtp-Source: AKy350bxc+yUnTMvf2f3Qjl/DLWjDhm1D86ReqCMeZQnOQNdBoVdL/OgE4TnolqgRqvLHc/aS6MlBtb231Frx6uhovQ=
X-Received: by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr9538060ywh.0.1681743281393; Mon, 17 Apr
 2023 07:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-3-blarson@amd.com>
In-Reply-To: <20230410184526.15990-3-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:05 +0200
Message-ID: <CAPDyKFr5g3NiarFVMtjUHMvjdcKc4m-EpcKZctfgNSQpK9e_-Q@mail.gmail.com>
Subject: Re: [PATCH v13 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 at 20:46, Brad Larson <blarson@amd.com> wrote:
>
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v12_changes:
> - Drop 'resets: false' in the amd,pensando-elba-sd4hc else properties. Passed
>   dtbs_check and dt_binding_check with both versions.
>
> v11 changes:
> - Remove resets description and reset-names
> - Add descriptions for amd,pensando-elba-sd4hc reg items
>
> v10 changes:
> - Move reset-names property definition next to existing resets prop
> - Move allOf to the bottom and set resets/reset-names required only for pensando
> - Fix reg maxItems for existing, must be 1
>
> v9 changes:
> - Add reset-names and resets properties
> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>   values for minItems and maxItems
>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 27 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index adacd0535c14..6c40611405a0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>
> -allOf:
> -  - $ref: mmc-controller.yaml
> -
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    interrupts:
>      maxItems: 1
> @@ -120,6 +119,26 @@ required:
>    - interrupts
>    - clocks
>
> +allOf:
> +  - $ref: mmc-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Host controller registers
> +            - description: Elba byte-lane enable register for writes
> +      required:
> +        - resets
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.17.1
>
