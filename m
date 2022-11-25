Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB0F638C09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKYOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKYOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:22:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676DB1DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:22:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a9so841667pfr.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb6OAvNcPbIiStohJr2EfSLMgJE0aIxz3yM12gwheFY=;
        b=Bb7OOpXAaJFFBKWs/LFVLbuHWpCOay8V9IuuJ2hP5lCavGUQiQewRHSJzllwqUoeEe
         TwD1KMAksVNS/cCGAtvJNxcYBtstUF/jDxSgYQP33inOCp4dCEB2/xYPv2m7fz7uyS0x
         HIzGjYwlC6Y3C9jZKTWqmcRdL/tQtu3SRn4ll2jskglasdZ12a81/7gEr6fuMu5Jf1+F
         fEoOdqR1G/eGfdpknh8YPaS2H5skdIIZvbtAVKNf2x2K9G5MqTwlmWZ+43UX+ciT/ZKi
         a1cUvsK7QXpv/CgynDSXG3BaIVdt5MZ7+RF7QuYa++EqmLjFVd7vLG7gPUOFugQkhHL3
         wmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb6OAvNcPbIiStohJr2EfSLMgJE0aIxz3yM12gwheFY=;
        b=YD/IoIwcmN5S54i+FynqViA1C6ZcZRCxtmv2kMK+qPhl0kmTnhLdWnXD5MHkmHfCy8
         +vs7abkBq9RlQ/z81C45Djr7n8PKM7O2mO3CLuEZ3K9hAkrr3QaXj+rmUmsbMPpfoUvL
         6tU7B3YUYQ6i7gWz48dax8NWmcAg11NX9Gw3udMgrrSbRGiXd+itvnLcytZFlTb+/DHB
         HQFpzt1V1enKUNQ0WUCbpzptuL/HH5drz2vqqIvxCpTPF/UcturalWeWY+n8hbPiDGE/
         Qj7FqM4IQoe4JPQzOvr5IdCDDt3YaW9sRU25z1gdNlATLzNF9HIi26juQ3Wv800PrIpb
         EIaw==
X-Gm-Message-State: ANoB5pkVr4P2IWqdRIX/q2xZb8sEAeZmI3+6XxLHiJzcGaUKFsED/pbN
        cY+snSgB+yz0kRTGls6tkYZDtdB+Ho5ex9u0wSI+ow==
X-Google-Smtp-Source: AA0mqf4SASCGtN7jjhGQniRU+kCqkMRcJl/p66QUtfQ7Qmt+BHXhyNzQ8M4on7CigVIb82iIGZEH7erF3uBaohbrMvU=
X-Received: by 2002:aa7:9057:0:b0:573:1d31:2b78 with SMTP id
 n23-20020aa79057000000b005731d312b78mr20847975pfo.61.1669386152267; Fri, 25
 Nov 2022 06:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org> <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 25 Nov 2022 08:22:19 -0600
Message-ID: <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Exynos5433 has several different SYSREGs, so use dedicated compatibles
> for them.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Hi Krzysztof,

Just curious: what is the rationale for adding those more specific
sysregs? AFAIR, e.g. in Exynos850, different SysReg instances have
pretty much the same register layout.

Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 68064a5e339c..42357466005e 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,10 +17,21 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
>            - const: syscon
> +      - items:
> +          - enum:
> +              - samsung,exynos5433-cam0-sysreg
> +              - samsung,exynos5433-cam1-sysreg
> +              - samsung,exynos5433-disp-sysreg
> +              - samsung,exynos5433-fsys-sysreg
> +          - const: samsung,exynos5433-sysreg
> +          - const: syscon
> +      - items:
> +          - const: samsung,exynos5433-sysreg
> +          - const: syscon
> +        deprecated: true
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>
