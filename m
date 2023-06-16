Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD07334AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjFPP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjFPP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:26:01 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA7A2720;
        Fri, 16 Jun 2023 08:26:00 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77de8cc13b4so13219839f.2;
        Fri, 16 Jun 2023 08:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929160; x=1689521160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igH/dcK7UCcdt51JQqBje+biMdflRhWO8VW1mIDbaBA=;
        b=f+73uRlkoYcZGAhspS+c4nsczw9PillUir9KmeUrPSpSKEtInOwjHyZPzfGGCoAGaH
         gQpbExYChVPPDlf4iNd39uJm/8TOHMgL3t+76rFWJoslEFZH8MvrxReiB3j7uTrDEWMh
         tOCp/gi8MrIRmg/BvPQ/YAl7NPLfCXyTfvIc2u/Kx3Ufjor+BTxGqsKQHumJuWaQbhw6
         u8Qf72YO7G1bCxMPENBgLkNLQofxAMn6JtnCx91GpsyDVyHLdmvFXErYqwBf+LZIhzgg
         6oQHX+gJjpc4NlukklgmAc0FmcnU4NH57Wxa5N36XqO+8ziyacbMKpnpopK+5anO0HNz
         XR7w==
X-Gm-Message-State: AC+VfDyshThT506Q423Zlzp+rPEYQbKg1GHqhxFA4Mt863j/8GuAiELT
        R7MLvdrkkGPYDTixBy4z3w==
X-Google-Smtp-Source: ACHHUZ48fTuGjPo4zir12/6NYrJyr89szhEMf/qHhpj1EgSvzOKpkzcISzefuE043NmgDCj+Lqk36g==
X-Received: by 2002:a5d:8b99:0:b0:776:bfbe:a72b with SMTP id p25-20020a5d8b99000000b00776bfbea72bmr2873779iol.14.1686929159875;
        Fri, 16 Jun 2023 08:25:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r18-20020a02c6d2000000b003e8a17d7b1fsm6401676jan.27.2023.06.16.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:25:59 -0700 (PDT)
Received: (nullmailer pid 442105 invoked by uid 1000);
        Fri, 16 Jun 2023 15:25:56 -0000
Date:   Fri, 16 Jun 2023 09:25:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        git@amd.com, michael@walle.cc, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
Message-ID: <20230616152556.GA440257-robh@kernel.org>
References: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
 <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:25:12PM +0530, Amit Kumar Mahapatra wrote:
> If the WP signal of the flash device is not connected and the software sets
> the status register write disable (SRWD) bit in the status register then
> thestatus register permanently becomes read-only. To avoid this added a new
> boolean DT property "broken-wp". If WP signal is not connected, then this
> property should be set in the DT to avoid setting the SRWD during status
> register write operation.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 89959e5c47ba..10a6df752f6f 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,21 @@ properties:
>        be used on such systems, to denote the absence of a reliable reset
>        mechanism.
>  
> +  broken-wp:

In the tied low case, that's designed behavior rather than broken. The 
name should reflect that.

> +    type: boolean
> +    description:
> +      The status register write disable (SRWD) bit in status register, combined
> +      with the WP signal, provides hardware data protection for the device. When
> +      the SRWD bit is set to 1, and the WP signal is either driven LOW or hard
> +      strapped to LOW, the status register nonvolatile bits become read-only and
> +      the WRITE STATUS REGISTER operation will not execute. The only way to exit
> +      this hardware-protected mode is to drive WP HIGH. If the WP signal of the
> +      flash device is not connected then status register permanently becomes
> +      read-only as the SRWD bit cannot be reset. This boolean flag can be used
> +      on systems in which WP signal is not connected, to avoid setting the SRWD
> +      bit while writing the status register. If the WP signal is hard strapped
> +      to LOW then it is not broken as it can be a valid use case.
> +
>    reset-gpios:
>      description:
>        A GPIO line connected to the RESET (active low) signal of the device.
> -- 
> 2.17.1
> 
