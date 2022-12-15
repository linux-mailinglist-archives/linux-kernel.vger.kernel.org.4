Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0164E358
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLOVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLOVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:39:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FC2C675
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:39:52 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so453703pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19xNB36z4ZF2bSOjVbfFWgPYWyBtIik4jiGmk9PMfXw=;
        b=RRk9pzsFQBiKFV3biL+KXLKYF02p/45lQPdYqs7nlVzrsFs454g+4bdGm8uM9DixI7
         Oz2JzWFwPF4eM7wyOV4AosMUj3bXhJ5jcz/zbc9GvzILjVRrOLryHGNYBJQP7QHna45H
         7zs2jcLM5zXZNC/jgW7SdkZJNgITl7MSVVXR//um8E5alg1f/1nRNSMvfQc3zAnQuK9j
         RUQ2KxZkVh5u4grEWMDiIdvvdE37xnQqg+XgTl0TwbZkQwMctl33SGI1By6OuxZ7SAOg
         VqREzBEBnqUUAz5moJ5dON8vch0ttXfxZtJWm4dCrapHeq5mL6qWO1FmXCHmi6db2o5D
         f7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19xNB36z4ZF2bSOjVbfFWgPYWyBtIik4jiGmk9PMfXw=;
        b=M9ktd8aZMVNBVK6TAiMB4+g8Bjwyr87i9qP8lR3ojKGwjqshOHOhBpteKQzHM3COUX
         s49GYMQxMzpKVCRug+1xlDBgf4JaHFReIiua2ELu8Vcih9oWCGPCgo/75snnR5ILYRe6
         wz6g2DMSfFb9BWk1nrcTxLSFuI0sg+KkzXzd675GPW8dRgwlGlLsEVaH6PC/gAxx1nuZ
         s1j1aoPE2buIWoe/kXejf5fk0s30EUSf8iv8CzJ+Z1T5Ll8bbYncpynAn7yQ32yFz1qA
         Fk0hVz6FVeKezIOkW6HvDxLemNbp7GNyJrTXEuFSdgLVWcnF58K9KJshHBLr8IPz31gb
         LGZA==
X-Gm-Message-State: AFqh2kq6fN3ZUKRfzVQiu+6lHLBPj+/cBDusawuBHLano0gZeFeepaUb
        OAJr/vpDrFB8Lbamtpo87SnmcbGrQb9N2REhF90ljA==
X-Google-Smtp-Source: AMrXdXtCpBntfTL1jGJNjn/ZrqmxPTpShg/Qixzul1m0G+k8RWaFw2Rz+RgOFA2O/fFU4iaHCHe8EO3I+LBYQxMdsDg=
X-Received: by 2002:a17:90a:5d93:b0:21f:eb8:f6f0 with SMTP id
 t19-20020a17090a5d9300b0021f0eb8f6f0mr703026pji.4.1671140391669; Thu, 15 Dec
 2022 13:39:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221214044427epcas5p39131549dc4529ea41d9916d81d3d5fce@epcas5p3.samsung.com>
 <20221214044342.49766-1-sriranjani.p@samsung.com> <20221214044342.49766-3-sriranjani.p@samsung.com>
In-Reply-To: <20221214044342.49766-3-sriranjani.p@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 15 Dec 2022 15:39:40 -0600
Message-ID: <CAPLW+4kez4s2QHH9PdfVq563_=Rg-LZw6o-QbdrhUX0kDfiMyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: exynos: add dedicated SYSREG
 compatibles to Exynos850
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 at 22:47, Sriranjani P <sriranjani.p@samsung.com> wrote:
>
> Exynos850 has two different SYSREGs, so use dedicated compatibles for them.
>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Thanks!

>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index c61441f3a89a..a38fe5129937 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -549,13 +549,15 @@
>                 };
>
>                 sysreg_peri: syscon@10020000 {
> -                       compatible = "samsung,exynos850-sysreg", "syscon";
> +                       compatible = "samsung,exynos850-peri-sysreg",
> +                                    "samsung,exynos850-sysreg", "syscon";
>                         reg = <0x10020000 0x10000>;
>                         clocks = <&cmu_peri CLK_GOUT_SYSREG_PERI_PCLK>;
>                 };
>
>                 sysreg_cmgp: syscon@11c20000 {
> -                       compatible = "samsung,exynos850-sysreg", "syscon";
> +                       compatible = "samsung,exynos850-cmgp-sysreg",
> +                                    "samsung,exynos850-sysreg", "syscon";
>                         reg = <0x11c20000 0x10000>;
>                         clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
>                 };
> --
> 2.17.1
>
