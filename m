Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C13638BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiKYOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiKYOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:15:18 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F921E01
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:15:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w129so4270915pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/617BJR3AxAjX3NPAcECKk88uzgNNQZ7+/ymtVAJWc=;
        b=DPX8gA6Ixvj1sHraj9uVz4imnR0p5it1SKCFly7A8rT/+jeI8P++q7KgmKFvAl7wsB
         k+cxZ+AUlBupu11cyAcf9ic+7nTqhXcYXVKqEhnD8J6ald4lh+JZcxap/Ky7CYsVpx75
         XY1sFYO6ERrlamhK1IO+ptAEhN3Yg0upfb9eN4pu31I/uwZ1CMliBYpWeuMvygLljbVb
         86qdzpcU27r5dcl7m1+sRWizykhPaRWFDzl+EPClI1j8gsimqtOytP4MF+VNPtQFwBWE
         zJEK8ew9VJCjeDrYp6aPEMTbZ46JR0D19flwOfINlpPc7S8Z2ubksjJciIERsgfr5RFl
         ZIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/617BJR3AxAjX3NPAcECKk88uzgNNQZ7+/ymtVAJWc=;
        b=uVnsWqJE6gaeOTwQo+No/AwyuC+/Fr0oB2SgvSXFSIg9ajLM9V7PTYmxaw0k8w7OnN
         gudxIt08veEypQEVJLZV1cTV5pX7tOmtMDnbVAvq6/2ShFdQV88jjbNqURSZRn1HKtQQ
         sBDvqaH20U9yVkwUJF1HIa8IGFwMsfmulFxtKtoygs6HRR75gNsnbptQ0dkS4hQHT5QX
         POqSWsD7mlgucgUTz4b8HmEs1cmwdQhf8N4xysQiqZ9ITaiUbxCrnj5lejD+lXB2D21e
         L94twjWu+xYCF9QqgAZawohESBA34yFgq8anG8Y0mHIYAJhqIdTLyeZANiru1BNUkwml
         ZyXw==
X-Gm-Message-State: ANoB5pkBomqO0TjLzsbpMJQ1jeKqqTWQolzICTBYR8uoYe0GCGeansbi
        QSCTu5gpubgemcp67wlJuCJTi4Tk+3XwJajwhwT/2A==
X-Google-Smtp-Source: AA0mqf6So6cRie6HhEzWSdJFgpZqNm19ZkFCQzm+lGVQCAAKnnMaxEf1S6OPjfhwzgUBpH8Z/S6USXAk+TjUuigh+DA=
X-Received: by 2002:aa7:854d:0:b0:56d:6e51:60ee with SMTP id
 y13-20020aa7854d000000b0056d6e5160eemr18571535pfn.25.1669385717125; Fri, 25
 Nov 2022 06:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org> <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 25 Nov 2022 08:15:04 -0600
Message-ID: <CAPLW+4keg-bxpMs0HZmy8W7V9rZHeaTUc_GQvyvhNx5JcqE8YQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split from syscon
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
> Split Samsung Exynos SoC SYSREG bindings to own file to narrow the
> bindings and do not allow other parts of syscon.yaml.  This allows
> further customization of Samsung SoC bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml    | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 1b01bd010431..b73ba1ea08f7 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -64,12 +64,6 @@ properties:
>                - rockchip,rk3568-qos
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
> -              - samsung,exynos3-sysreg
> -              - samsung,exynos4-sysreg
> -              - samsung,exynos5-sysreg
> -              - samsung,exynos5433-sysreg
> -              - samsung,exynos850-sysreg
> -              - samsung,exynosautov9-sysreg
>
>            - const: syscon
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> new file mode 100644
> index 000000000000..68064a5e339c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/samsung/samsung,exynos-sysreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC series System Registers (SYSREG)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - samsung,exynos3-sysreg
> +              - samsung,exynos4-sysreg
> +              - samsung,exynos5-sysreg
> +              - samsung,exynos5433-sysreg
> +              - samsung,exynos850-sysreg
> +              - samsung,exynosautov9-sysreg
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    system-controller@10010000 {
> +        compatible = "samsung,exynos4-sysreg", "syscon";
> +        reg = <0x10010000 0x400>;
> +    };
> --
> 2.34.1
>
