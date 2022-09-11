Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80D5B509E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIKSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:34:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E426AC8;
        Sun, 11 Sep 2022 11:34:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m15so11403320lfl.9;
        Sun, 11 Sep 2022 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Ow5gpV22zk0pMK0ScwSlmlMMm3s/uGPn53BIogCYbGI=;
        b=HA4X3gBrywaOJ7axHIuNEEIzDaODMRXkILQY3Kcr2vD+tr3G/rPjtmmdfGgC2dRU0K
         LuOMj1o+HyWsiG2k/bcChsM9JVeHFsB9wA+n9fCV++tHb5Ohu41VNK/O5iMTRAMasZ/O
         FjCHHv28tCIyFFqFYXU9qhpKSMKBFsGTS4VzucQ9RyzCxOYIFvmQOLAAGjQGbm9nRAOX
         G7YS5m7M3SUA0ydxoltj79DYdVnbXc+vxiXmWBIEJTITVOnKUCYI3qbQXD4I7tFeOURs
         WyI2aBRv63xGhttPIXmcwsNQSrghNTINZ318CKGhzB4zFMsTYD/IF4/SnFq//HEo831O
         +hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ow5gpV22zk0pMK0ScwSlmlMMm3s/uGPn53BIogCYbGI=;
        b=tkB+Yp6zgDxtb8GGb4nuBJBH9QrjQLlMgwdz6BAGhOKF3eEhBxSpagurBn3uNEOmNm
         Bx8OWnVxPq/yl6+hQMNApq1lA6FGgaR7/fhNuzItXiRVhcDqowhdw37GHgm6cEvkGblM
         x+tH0paLhi2ThLIkS2w6KFeHu3O5WmYUtLbeRHlh0RM6udsl3P7fPh6XSFsfc8+5Ptmo
         ZGo/POA8bHUjw1LECNyUGCBtFfhLU9qhgx5OMura6jyL1eld7hQ+xcuTFZVr7TL8aMNQ
         coHpMFWTtAtpQDIYZMijqsDUkL/5ntxuQsYNOy/CSx0YCW4pw67UZIzO49rLaYJfQrJF
         iy2Q==
X-Gm-Message-State: ACgBeo0bqQazLLqiMqtQIxznEYJ38/DEy1+uko30zO6BfolKYC+4nQRz
        QvpLcUOD6r6KbagGpgEtjAo=
X-Google-Smtp-Source: AA6agR6LKdDmr9mhSA/I0pJjCwsmNI//1gZT2puMU9F6WGm72PlfNLgLOAnzTEcBTwI/9Kn1qsldMA==
X-Received: by 2002:a05:6512:33d5:b0:49a:d2dc:e1e3 with SMTP id d21-20020a05651233d500b0049ad2dce1e3mr360799lfg.628.1662921258876;
        Sun, 11 Sep 2022 11:34:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b00496997176f9sm694356lfm.46.2022.09.11.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 11:34:18 -0700 (PDT)
Date:   Sun, 11 Sep 2022 21:34:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Larson, Bradley" <Bradley.Larson@amd.com>
Cc:     Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220911183415.ufeasmm3uev7wqx4@mobilestation>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
 <20220821174952.5i5pfftxt53dmqv3@mobilestation>
 <0c2ac76e-45ff-b5a1-f33a-177eea04c17d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c2ac76e-45ff-b5a1-f33a-177eea04c17d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 06:28:46PM +0000, Larson, Bradley wrote:
> On 8/21/22 10:49 AM, Serge Semin wrote:
> > On Sat, Aug 20, 2022 at 12:57:37PM -0700, Brad Larson wrote:
> >> From: Brad Larson <blarson@amd.com>
> >>
> >> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> >>
> >> Signed-off-by: Brad Larson <blarson@amd.com>
> >> ---
> >>   .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> index 37c3c272407d..403d6416f7ac 100644
> >> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> @@ -37,6 +37,15 @@ allOf:
> >>       else:
> >>         required:
> >>           - interrupts
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - amd,pensando-elba-spi
> >> +    then:
> >> +      required:
> >> +        - amd,pensando-elba-syscon
> > Please add the "amd,pensando-elba-syscon" property definition as I
> > asked here:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20220704131810.kabkuy6e4qmhfm3n%40mobilestation%2F&amp;data=05%7C01%7Cbradley.larson%40amd.com%7C1c4f822c81424048873508da839d90fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637967010019245894%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xl9OU9P9QK3wLHc25hQZK393ylULd41qc4HB2Zt%2F0BQ%3D&amp;reserved=0
> 

> Proposing this addition:
> 
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -148,6 +148,15 @@ properties:
>         of the designware controller, and the upper limit is also subject to
>         controller configuration.
> 
> +  amd,pensando-elba-syscon:
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    maxItems: 1
> +    description:
> +      A phandle to syscon used to access the spi chip-select override 
> register.
> +    items:
> +      - items:
> +        - description: phandle to the syscon node
> +

No. What Krzysztof and I asked was to add the property definition
into the allOf: [ if ...,  ] statement. Please read more carefully my
last comment:
https://lore.kernel.org/lkml/20220704131810.kabkuy6e4qmhfm3n@mobilestation/
The definition is supposed to look like this:

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-spi
> +    then:
  +      properties:
  +        amd,pensando-elba-syscon
  +          $ref: /schemas/types.yaml#/definitions/phandle
  +          description: AMD Pensando Elba SoC system controller
> +      required:
> +        - amd,pensando-elba-syscon

* Please also note that I've replaced "enum:" with "const:" in the if
statement above.

The difference with what you suggested is that my version is
applicable for the Pensando ELBA SPI controller only, while your
update will cause applying the "amd,pensando-elba-syscon" property
constraints for all DW SSI controllers which isn't what we would want.

-Sergey

>   patternProperties:
>     "^.*@[0-9a-f]+$":
>       type: object
> 
> Regards,
> Brad
