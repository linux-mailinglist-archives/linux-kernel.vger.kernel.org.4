Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED966A2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAMT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAMT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:04 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE885C95;
        Fri, 13 Jan 2023 11:27:03 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id d188so7326081oia.3;
        Fri, 13 Jan 2023 11:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxiI08RgxuWuPZoqrBZbQGFb0NvzSt2qHf8gPfZ+oBY=;
        b=p5wFnI/Co3WWzobI3UkFoLBSHlwKWklYYLbKXCJxDIHMq9eT44aVtGOAtXsI8xzq6q
         qasgIXN9dTsHMFqYARP42GUtK4kcLzDINAVkT2O3i3/opsCjE9H8QS8aKaoDbPe0mxZO
         DEVWCq35gS6gHjMe6fWqY31ooVYFMA6PlJmbY97hj070pTZ80bqGHsSffvdobzfJ5osn
         zrZd5+dcAfEkIFHfL9Kymwzxc8TQEUCXl2qt4dv6Cv5OMLhF53XrLJsTQWpPHvMwD9R3
         YJZ9bBL8NwB4wlJPBjzjbZ2bBD/noHeD+RWflc8ErESL/dFwIHq5nzwGi7T7cUk087jE
         66Sw==
X-Gm-Message-State: AFqh2koCyRV3+6Kn+/eut/PQOPcqNZ3zHXG6evG3PjcjuZ3d9sj1O+L5
        KyHM65ovqQa311bRBcIoMA==
X-Google-Smtp-Source: AMrXdXuojOLfEbXw+gZXCJ5FPbxqXJVO0vJTHqQPSUqBq8aWx/h8biMMtBRBnsOlPCO2VTrVhEcfQw==
X-Received: by 2002:aca:f187:0:b0:364:70d:a13f with SMTP id p129-20020acaf187000000b00364070da13fmr11831152oih.14.1673638021419;
        Fri, 13 Jan 2023 11:27:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u30-20020a056808151e00b0035bd65b776bsm9698040oiw.2.2023.01.13.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:27:01 -0800 (PST)
Received: (nullmailer pid 2806014 invoked by uid 1000);
        Fri, 13 Jan 2023 19:27:00 -0000
Date:   Fri, 13 Jan 2023 13:27:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible
 fallbacks
Message-ID: <20230113192700.GA2804258-robh@kernel.org>
References: <20230111204634.2104690-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111204634.2104690-1-andreas@kemnade.info>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:46:33PM +0100, Andreas Kemnade wrote:
> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> not use single compatibles but combinations of them.
> 
> Add fallbacks for imx6sll/ull which are useful for U-Boot.
> 
> This will significantly reduce noise on make dtbs_check.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - allow only combinations with fallback compatible
> - reduce them to the cases where they are actually useful
> 
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b42..be6caa25c57d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -29,14 +29,18 @@ properties:
>            - fsl,imx53-esdhc
>            - fsl,imx6q-usdhc
>            - fsl,imx6sl-usdhc
> -          - fsl,imx6sll-usdhc
>            - fsl,imx6sx-usdhc
> -          - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - const: fsl,imx6sll-usdhc
> +          - const: fsl,imx6sx-usdhc
> +      - items:
> +          - const: fsl,imx6ull-usdhc
> +          - const: fsl,imx6sx-usdhc

Can be simplified to:

- items:
    - enum:
        - fsl,imx6sll-usdhc
        - fsl,imx6ull-usdhc
    - const: fsl,imx6sx-usdhc

