Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756C5EF3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiI2LFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiI2LFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:05:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFC8FD7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:05:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d11so949440pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yF0bUAb9e3HoD+z9QhDD/iTK1qOjet7jClHpQspWpbs=;
        b=TG+kTV4MscBuL/BeGN5x8R5RiLDNIyFFN5c6jSa6JPSNKBXl65277cbm+Z1C1HiOpY
         keyFP9EmFuc6eJJ+0dEB8pFAPd/1oM0Pv+AEh26OfyguHgIjOlUN9lCpXo48nkJFf+mP
         +18GSQgtLcghF1ouTFPFoFw5XS358kX7EMQgFMnPxgEwxDsfnWJBbHgFKgmSwCL1g5HV
         BAGdaHYNFS6J2zPP0WHItPjATKXuzOSMuPz8zfLKS0w6+a0vLZEvL1/m8ej75kYrEAXy
         Yf23Ir5ayE50dLGh3lUvAgyDzbU44t8hNAo+Pb4agxZuRry5zAmVofJ1fETUzMhD3OAE
         XScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yF0bUAb9e3HoD+z9QhDD/iTK1qOjet7jClHpQspWpbs=;
        b=RzDzQYRFZboXOPrZ3zNYucXkfK2osf4ubgNBnm+LAlPB0AngO8ULTdCF6Pz/6kX4fu
         f8sF00h29dZvPlrwdl2su7ZooAN4DlSGcbTs6f4aUgBtZDqx8k6odhC286WxiIfnFT62
         vCNAZjrI74++O7ZYYCZgJBahuwRh/bqBpixiYJxW0HZsX67t0kGdtPj8Jmbk4loJpd3i
         QZcqEgLokkfYJqywwB24W2ALoDMhuFWhQbrFGN+X5kZ7kInqSbqUKLzjhrLYAmsS3QBz
         UvjqWHWlrl0HNloGDgzl7xOoFrzbYfSgGrPZkiY/8rpEpWIJ+zX15wUJ9u3V0JlJLvUB
         NsbQ==
X-Gm-Message-State: ACrzQf1R77nO4khd2xnkeoQ6y//aPj7b9j4Uw6g30U7BZZqY+bfYh4y+
        NNNcxrdyF7qGByMRaJQXsKRuXGDw+48DzfXMd+MGVw==
X-Google-Smtp-Source: AMsMyM4LXTZNTpbaB2YmB8EbmJUv7BOvclWHiFwcjBsNhs0fFFq4epzNQM4I8A6yWcE4sNQYLNDKd0OitvJy0pbVQV0=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr3093514pjq.202.1664449533446; Thu, 29
 Sep 2022 04:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220928165420.1212284-1-dinguyen@kernel.org> <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
In-Reply-To: <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 13:04:57 +0200
Message-ID: <CAPDyKFohA9gKu8qwR+YUCy46tepO3k7fQqcHPvjYMznDmckLzg@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 11:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/09/2022 11:24, Ulf Hansson wrote:
> > On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>
> >> Document the optional "altr,sysmgr-syscon" binding that is used to
> >> access the System Manager register that controls the SDMMC clock
> >> phase.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >> ---
> >> v4: add else statement
> >> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
> >>     "altr,socfpga-dw-mshc"
> >> v2: document "altr,sysmgr-syscon" in the MMC section
> >> ---
> >>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> index ae6d6fca79e2..b73324273464 100644
> >> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >>  title: Synopsys Designware Mobile Storage Host Controller Binding
> >>
> >> -allOf:
> >> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> >> -
> >>  maintainers:
> >>    - Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> @@ -38,6 +35,34 @@ properties:
> >>        - const: biu
> >>        - const: ciu
> >>
> >> +  altr,sysmgr-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    items:
> >> +      - items:
> >> +          - description: phandle to the sysmgr node
> >> +          - description: register offset that controls the SDMMC clock phase
> >> +    description:
> >> +      Contains the phandle to System Manager block that contains
> >> +      the SDMMC clock-phase control register. The first value is the pointer
> >> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
> >> +      clock phase register.
> >> +
> >> +allOf:
> >> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const:
> >> +              - altr,socfpga-dw-mshc
> >> +    then:
> >> +      required:
> >> +        - altr,sysmgr-syscon
> >> +    else:
> >> +      properties:
> >> +        altr,sysmgr-syscon: false
> >
> > So this change will not be backwards compatible with existing DTBs. I
> > noticed that patch2 updates the DTS files for the arm64 platforms, but
> > there seems to be some arm32 platforms too. Isn't this going to be a
> > problem?
> >
>
> The backwards compatibility is actually expressed by the driver. If the
> driver keeps ABI, we can change bindings so that all DTS are being
> updated to pass the checks.

Right.

So, I should probably have responded to patch3 instead, as backwards
compatibility doesn't seem to be supported, unless I am mistaken. But
let's move the discussion over to that thread instead.

>
> On the other hand, the commit should express why it changes the bindings
> in incompatible way - this is lacking here.
>
> Best regards,
> Krzysztof
>

Kind regards
Uffe
