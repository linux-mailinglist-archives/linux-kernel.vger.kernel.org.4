Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FAB652063
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiLTMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLTMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:32:50 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773562F7;
        Tue, 20 Dec 2022 04:32:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 82so8284025pgc.0;
        Tue, 20 Dec 2022 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4247CLx6gFYzZUaVHXmE9zScZpJiWQUyjfu3zqwr1o=;
        b=d2iSLqMcf1LwXRrMgfJsZPLl8GZMFPIdkG2SQ9hJYjfXAa2gjG7r7k+cYu+pSbQKjF
         0gvr1TMJlrmuTnrZnra1GD2lNQiHscdm0Yw07dMEe5R/FAGU3xOPoylJzCbT2AODobA2
         9uVdGJjpJkzQY0rSsHuHuutuJ0JO6zRbrtZxStZMpozvmn9tvUDUVTIIZ7FbTwPQhWsh
         6NE1bE8SA0J9inkGwy9vX4M02SsBk12wacLEYGXAXTpv9XT42k9gZwiq+VnNI2k4Hr1G
         AsDUX265S/Zyr50qqmqb7A9ULbo4L3venRTnl+SpuVlnC9J+bbJn/H8cveuL0qn1/MQ9
         Hdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4247CLx6gFYzZUaVHXmE9zScZpJiWQUyjfu3zqwr1o=;
        b=Th0dgFjnJI7SSf0KT9eKJPboZbetAx6IZB9PDTgU0mrrB0VyK5j5LReO1VT1JNcwo8
         a4diyrjYrha7pX/KmKz9PSpya/tx6iSUf0DVKtP2YTsZw4aOEXIGLGev3d1jjbUHUp6O
         UfadlgOQkS7a4gqNKMMIkg1D6eJoIDzQ9EXnXRMNE6cq4tDmX8ziIEeROs9l2KK2PmC6
         N6LwCBlfy3p4s1ll1Gb+1cgn3j7s0V7eQO4cK8L/lo3U8Y9v4CHxZTPmaEHXpp5pe5aT
         KlqyIyQFbiaEm0jSf5/2p7L1xPdoQo+2QT9KQwEK+jU12jocBGi6dXzUd9fyyoxH5Qkx
         NCIA==
X-Gm-Message-State: ANoB5plb/4DW3SHyJqJ/r119f1X2l8x0nopwxuSaZ6r76jFG3RjYlMBb
        jdz2b25Bw5hdcU9osEqibjvrxLIs7KGoBYM2tRE=
X-Google-Smtp-Source: AA0mqf5ORbhtsICJ6CWH4DXsTkp/tg1I1HWdntU0oEDsSF4ZLdYUMIACgQpc9ywBdnosZXcB5lcMsEncL/pCeKmGWAM=
X-Received: by 2002:aa7:8744:0:b0:576:af2d:4c4d with SMTP id
 g4-20020aa78744000000b00576af2d4c4dmr25669912pfo.69.1671539569206; Tue, 20
 Dec 2022 04:32:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221214044430epcas5p4c896fde60471fea774387bd74abe0ea5@epcas5p4.samsung.com>
 <20221214044342.49766-1-sriranjani.p@samsung.com> <20221214044342.49766-4-sriranjani.p@samsung.com>
In-Reply-To: <20221214044342.49766-4-sriranjani.p@samsung.com>
From:   Chanho Park <parkch98@gmail.com>
Date:   Tue, 20 Dec 2022 21:32:37 +0900
Message-ID: <CAPTzV151-v5Akb47uXrEOFrC2XdWCVztEwLiDrV-Zqq0yAtYTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynosautov9
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 1:49 PM Sriranjani P <sriranjani.p@samsung.com> wrote:
>
> Exynosautov9 has several different SYSREGs, so use dedicated compatibles
> for them and deprecate usage of generic Exynosautov9 compatible alone.
>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> ---
>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml      | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 427df05224e5..da43efb0ce80 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,7 +17,6 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynosautov9-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
>                - tesla,fsd-fsys1-sysreg
> @@ -35,6 +34,7 @@ properties:
>            - enum:
>                - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
> +              - samsung,exynosautov9-sysreg
>            - const: syscon
>              deprecated: true
>        - items:
> @@ -43,6 +43,13 @@ properties:
>                - samsung,exynos850-peri-sysreg
>            - const: samsung,exynos850-sysreg
>            - const: syscon
> +      - items:
> +          - enum:
> +              - samsung,exynosautov9-fsys2-sysreg
> +              - samsung,exynosautov9-peric0-sysreg
> +              - samsung,exynosautov9-peric1-sysreg
> +          - const: samsung,exynosautov9-sysreg
> +          - const: syscon
>
>    reg:
>      maxItems: 1
> --
> 2.17.1
>
