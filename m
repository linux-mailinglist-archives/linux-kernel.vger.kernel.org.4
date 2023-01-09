Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1BD661BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjAIBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjAIBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:16:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA4DFF;
        Sun,  8 Jan 2023 17:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E78760EA5;
        Mon,  9 Jan 2023 01:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27BC433F1;
        Mon,  9 Jan 2023 01:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673226969;
        bh=I7uRhzzKfn+fJFzre0fr0A96dZ17V23thWuW3j3BOQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pP+iQ+VXytwoQx8X5jton7J/vMtVUiABkGC0oVWf/hdfIfZWT1Bd0IS/BodfXs+gY
         Ih0w5IwQrz5V2gLfkriGJlNcOrVcbFpLZK2HzCdqUQpR3Y20/p34wTK+TX3nkYZX0C
         lZFfT2YjhZ6pc5yCfaN5fZRttiGfZXvHrziusCIcpC/xtVIHGgBnkpim26dRN5nbl3
         HUhX09BfNcZnXDPoMgi38OtizqXF/dl76Dktf3zgXJgX2HmNItXgMD+brCeI9HTKE/
         SKEwMpQcJvbeDN1HrOqeT+ewWlXJTJOmxiI1SNvcnkCBDJEpKNiDukceDmxlLzDu1k
         t1WkQgYg2iaGA==
Received: by mail-ua1-f48.google.com with SMTP id z23so1657446uae.7;
        Sun, 08 Jan 2023 17:16:09 -0800 (PST)
X-Gm-Message-State: AFqh2kp9Xd98qLKmQEXpZ93lGwnKpWRhcc59WfPTnMf++vzFTy40bDFX
        rZv9Is4UAb1urAid68jjqNY3keO74tZJbH/9Lg==
X-Google-Smtp-Source: AMrXdXtu1ZODwK9qx/LS3GDF1PgE1EtAbnaQtR39OMzYo0BRd36pFYWpqo21w8COL0zisKQVqz74Q2sk6UuNIqd7Ir0=
X-Received: by 2002:a05:6130:2ac:b0:573:d2a:e6cf with SMTP id
 q44-20020a05613002ac00b005730d2ae6cfmr3485209uac.36.1673226968780; Sun, 08
 Jan 2023 17:16:08 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221214044423epcas5p2920e87930665345169745002ec6993c3@epcas5p2.samsung.com>
 <20221214044342.49766-1-sriranjani.p@samsung.com> <20221214044342.49766-2-sriranjani.p@samsung.com>
In-Reply-To: <20221214044342.49766-2-sriranjani.p@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 8 Jan 2023 19:15:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAqSoVdExrHXZ4xVaY4Ut5R54izoumOY8zsXWN2e8++w@mail.gmail.com>
Message-ID: <CAL_JsqLAqSoVdExrHXZ4xVaY4Ut5R54izoumOY8zsXWN2e8++w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, sathya@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:47 PM Sriranjani P <sriranjani.p@samsung.com> wrote:
>
> Exynos850 has two different SYSREGs, hence add dedicated compatibles for
> them and deprecate usage of generic Exynos850 compatible alone.
>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 4954790eda6c..427df05224e5 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,7 +17,6 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
> @@ -33,9 +32,17 @@ properties:
>            - const: samsung,exynos5433-sysreg
>            - const: syscon
>        - items:
> -          - const: samsung,exynos5433-sysreg
> +          - enum:
> +              - samsung,exynos5433-sysreg
> +              - samsung,exynos850-sysreg
> +          - const: syscon
> +            deprecated: true

This is throwing an error in linux-next now.

How can 1 item in a list be deprecated? What's the not deprecated
value for the entry? Probably this needs to move up to 'items' as the
whole entry is deprecated.

> +      - items:
> +          - enum:
> +              - samsung,exynos850-cmgp-sysreg
> +              - samsung,exynos850-peri-sysreg
> +          - const: samsung,exynos850-sysreg
>            - const: syscon
> -        deprecated: true
>
>    reg:
>      maxItems: 1
> @@ -53,6 +60,8 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - samsung,exynos850-cmgp-sysreg
> +              - samsung,exynos850-peri-sysreg
>                - samsung,exynos850-sysreg
>      then:
>        required:
> --
> 2.17.1
>
