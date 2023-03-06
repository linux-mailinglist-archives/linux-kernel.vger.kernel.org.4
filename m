Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A56AC59F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCFPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCFPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:38:08 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79273CA35;
        Mon,  6 Mar 2023 07:37:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f18so13313152lfa.3;
        Mon, 06 Mar 2023 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+6yc/IA9VHnC8pRgu9mfVgrlBPbE5fizj7nSsV8E5g=;
        b=c25DXBkA1fKBCQDejUspbB/QBrzWnK1DDLCQSlbyFSZy5E2XrYtc9eD+FIkRoTaTbX
         02Jmw6W7I+HHbBi6rbCJk89Zq6gPkhp2HM6YpW14m9KDSlzSkQW8zI7HbWRVPRs6ewRL
         L8e/a+rk4QE1amPPk2Cf/afm9cwqZF7K55P68TqgkJqWEdXTP33RVmeyGM5goHped1Fd
         NeySw4RZm2auNypOy/vihLdE2T6qD+VjYnywyTgjzenkI7RgO8kz8nnYXLK+ngDnQDMd
         s2DVcf3oaXWsXtLgCMJcUpPTH0+aPgGUVk4EYQAnEIt8Ey5rmSixz1/801CgFtDDk+pW
         oSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+6yc/IA9VHnC8pRgu9mfVgrlBPbE5fizj7nSsV8E5g=;
        b=T8UUVkhnxStuxN2wO3TaOfu2TNiyJ3nEOtpqAjfiZtncZJVX7beNurH1udfieOcnmM
         +heb7LVOmL2zcoMc23laLlWk+7LaUVsYNYsM15RrClIu01s7M5J2k/zVhVriKQToXu3/
         TfZlRFn0c2DfRuTTarrxyYW9lAi9zWMzIna3GpyTQiUKGouY7QCFu7Ca9SwG2wI5E3wd
         GLoaNXaTuWxiirxohcayR19rDchKWIG2ayD7teba4U6W2gWUTgyCppU5U3jVyPbQWB1v
         ELHGrmY8CiAQ1YIBvK4hIg1vGZoqI8gtOfgR4kuzaNn7wNNeyxD4nc1YOQxqoBD58DNc
         o7lg==
X-Gm-Message-State: AO0yUKVUlJWq1b5k9jFZ7uBFGFRFSCbPz0nBBt28zZBOkyqrePn13EPk
        PZq2Qna/Sa5oJy6UzlFulOA=
X-Google-Smtp-Source: AK7set/P9MuC7QjNHQu2OSksykfEn4TKWHwShmUSZNDa4bY/+Z6gtUpVsIzDKKxIDfMMUA8V15HsWQ==
X-Received: by 2002:ac2:558d:0:b0:4db:3882:8f42 with SMTP id v13-20020ac2558d000000b004db38828f42mr3451671lfg.45.1678116992425;
        Mon, 06 Mar 2023 07:36:32 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 21-20020ac24835000000b004db1d3bf9b4sm1675178lft.26.2023.03.06.07.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:36:31 -0800 (PST)
Date:   Mon, 6 Mar 2023 18:36:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
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
        robh+dt@kernel.org, samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba
 SoC SPI Controller
Message-ID: <20230306153628.kg7kzm52ft2j57fa@mobilestation>
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-5-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306040739.51488-5-blarson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 08:07:28PM -0800, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Looks good. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> 
> v10 changes:
> - Move definition of amd,pensando-elba-syscon into properties
>   with a better description
> - Add amd,pensando-elba-syscon: false for non elba designs
> 
> v9 changes:
> - Define property amd,pensando-elba-syscon
> - Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi
> 
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index a132b5fc56e0..2383d6497b1e 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,17 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-spi
> +    then:
> +      required:
> +        - amd,pensando-elba-syscon
> +    else:
> +      properties:
> +        amd,pensando-elba-syscon: false
>  
>  properties:
>    compatible:
> @@ -63,6 +74,8 @@ properties:
>          const: intel,keembay-ssi
>        - description: Intel Thunder Bay SPI Controller
>          const: intel,thunderbay-ssi
> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi
>        - description: Baikal-T1 SPI Controller
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller
> @@ -136,6 +149,12 @@ properties:
>        of the designware controller, and the upper limit is also subject to
>        controller configuration.
>  
> +  amd,pensando-elba-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Block address to control SPI chip-selects.  The Elba SoC
> +      does not use ssi.
> +
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> -- 
> 2.17.1
> 
