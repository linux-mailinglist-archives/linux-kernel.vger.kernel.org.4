Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC46B6BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjCLVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:42:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F636452;
        Sun, 12 Mar 2023 14:42:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m6so13376258lfq.5;
        Sun, 12 Mar 2023 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678657328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3rijjmcd0H9JBLz+kOnyMNiTilGp+r33BtDPyjKasc=;
        b=I++jHapzTgT8ulnNiHlEeUUovVAe1EuX7MeM98wmpamJlI0jzO9Pkbq5/aQPOhJZVR
         834eq51o68Qkq7WLAsij7+XueV6+/LMeNzeWGoiBVD7zupVpqXz6xNxkPIeULwZPjiIM
         uyCSdT1S5j2l7h6f4otCyn6ESaxcqy9RQGFAJsG8UKiyc6lIdkkTIDuXHPcR/eR51vAa
         XlxZj8TsOrU/2icEw2aieDrDlpKhaCpnRdB10CSCuhlpIkVkxGQGQPsESso2OQA/VCWd
         qlHDc0NfohNxhcv4pO4lF8zza1dj9aaTePIKaazamlW1qy403jHVl8pK1fSFE72HV7g+
         Cy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678657328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3rijjmcd0H9JBLz+kOnyMNiTilGp+r33BtDPyjKasc=;
        b=11DpAVmXUkvtRWJfy/yLKP8502JVWcBPkuuEZvh91FGN3ERTpHWcmAsQZTfoLwfYXv
         K0LoAL1SJNkHWnAB9IX3QD4jJCpwKjbSR1sMcVfzPXKTwxtOSer3YlhZZlTpxyqcucVB
         YuaNt1joScR5UUAXV+339/CRYGpXT31UNWyD71IkcqkQwJPHYYA8xWhpwlkMImypEb0Y
         61+0arq/qhOmN4iVDIDDZO0xB0cHRA3jI3Rmc5WdmERbaXMl/srpyAPS+niRG9hI/Kr2
         riJwxieYH+ch7thJ3BAjr/5c/iJM4ZOOZIBOO36P1tkir3D6mnxWnC9TMY0/XHUAgObY
         I3JA==
X-Gm-Message-State: AO0yUKUWEPYBGYD0nRECm6fpOSmD1CzbBJ5DqXCw6HeiYv+7JxD/wTAL
        rFyrzSZUwApSYwsKRZYF1XU=
X-Google-Smtp-Source: AK7set9xDWFn1iZwRkOPYUXEj8c4lqqoFbz9NkTxgaALsntAQ75+QHJ3xpNXMEt6Ohxe7GWyNUwIUw==
X-Received: by 2002:a05:6512:21d:b0:4c6:4ff7:ba04 with SMTP id a29-20020a056512021d00b004c64ff7ba04mr9509778lfo.2.1678657328312;
        Sun, 12 Mar 2023 14:42:08 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a22-20020a2eb176000000b0029870223d23sm767676ljm.73.2023.03.12.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:42:07 -0700 (PDT)
Date:   Mon, 13 Mar 2023 00:42:04 +0300
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
Subject: Re: [PATCH v11 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba
 SoC SPI Controller
Message-ID: <20230312214204.sjycq3xyk56ny2on@mobilestation>
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-5-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312004445.15913-5-blarson@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 04:44:34PM -0800, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
                    ^
     +--------------+
This + modifier is redundant.

> +      Block address to control SPI chip-selects.  The Elba SoC
> +      does not use ssi.                          ^
                                                    |
1. Drop one of the whitespaces ---------------------+
2. The description is misleading. SSI means "Synchronous Serial
Interface" which basically means SPI. If you meant SS (slave-select)
signals then Elba SoC do use them. What would sound correctly here is
that Elba SoC system controller provides an interface to override the
native DWC SSI CS control.

Please fix the notes above. Then feel free to add
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> -- 
> 2.17.1
> 
