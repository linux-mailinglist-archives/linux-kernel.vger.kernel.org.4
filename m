Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FEB652069
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLTMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:34:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D326566;
        Tue, 20 Dec 2022 04:34:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so11975085pjm.2;
        Tue, 20 Dec 2022 04:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqu0/Qt0HIWTPrQ5AI2iKSepnaqwzAAmbIKhQba6Gd8=;
        b=Z8SwdS+qnItrM7Gtn89jjfxFwU1Sfr6Jb9RN5T84LQc3LP5AuPBrgt2bkxSsx4kxGl
         tTwMp629gMpSlr6mOVT8099BX8xpILtMprr5HzZ8yxt+7ICUJ35RSuVgeSERCDfU6a1H
         U0uzc3q5Kg7qlXv9CwvBE04hlGm/srh+PKfmPk0GWjQKz7/PzjezJ4SoLxMQMiM9BSvg
         FwUpatWxCTfTY3y/VLXbDb8IoZmbKP7NVDxzGTDFAvocFJXKcZIrJHsitB7vmONi3Xeo
         5lizfHJ8lqRJsQS5h99g+B4ivQRX46zAmVrFfOzhaFiSgd3vwTT3FnAKSkGJkEJ77mQh
         BALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nqu0/Qt0HIWTPrQ5AI2iKSepnaqwzAAmbIKhQba6Gd8=;
        b=ldph1xoWfHSus328FLDPi0BEIVoBeGO1OQ0+I4XRY/7cE3aWH+RYtQJNR7YdI1v7mT
         mywU1SxJA2yxyflsacxVDVJTzkOptmdYsclZoWB5h5bVgxuoy9DRmhSTuEiYYKHXe0iS
         f2igphMGGRE/98f3PwW0by4+AUkFQLI3fTUGrPBDgggDcU4Tbp3q56PX88aSKzM0Sd5F
         ELAcoYzqCedfvLuxsrALM6Sim8lJkxYBscT/Hdus9zwmYPAKM55AS1zFeRivHF10nmHO
         KEe9XukXRXpO+GK6kR202q0mWx7cvLCzjqXAfjEWuWnbEvrfcISke2wORvu9GkV0M8WX
         jCIA==
X-Gm-Message-State: ANoB5pmJbpTv/wDQJ655ENH6xzAwpbol3QKwsYWQoC3C04j2a8RDJV45
        av+kJIBj799qPew3XOEQL+7CRWMdvymXo8NRr+0=
X-Google-Smtp-Source: AA0mqf61XudZKB+l3rr/BDyKsVdWt5vzpWfkXuUEN3MkPjb8HIfkiMt/xaE8dizO9cZ1K+jtReZs7hGVSradsTj4OIc=
X-Received: by 2002:a17:903:40cb:b0:189:dd86:a1e0 with SMTP id
 t11-20020a17090340cb00b00189dd86a1e0mr17766130pld.78.1671539675200; Tue, 20
 Dec 2022 04:34:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221214044434epcas5p212735c11a8ff9f72e25742e4ac8a7794@epcas5p2.samsung.com>
 <20221214044342.49766-1-sriranjani.p@samsung.com> <20221214044342.49766-5-sriranjani.p@samsung.com>
In-Reply-To: <20221214044342.49766-5-sriranjani.p@samsung.com>
From:   Chanho Park <parkch98@gmail.com>
Date:   Tue, 20 Dec 2022 21:34:24 +0900
Message-ID: <CAPTzV14Got8JrN_OUnPjd30C1aYo8f3vyi5npZoRZqR1oFwmGA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: exynos: add dedicated SYSREG
 compatibles to Exynosautov9
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

On Wed, Dec 14, 2022 at 1:50 PM Sriranjani P <sriranjani.p@samsung.com> wrote:
>
> Exynosautov9 has several different SYSREGs, so use dedicated compatibles
> for them.
>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> ---
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> index 5dc361734cfe..d3c5cdeff47f 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -370,17 +370,20 @@
>                 };
>
>                 syscon_fsys2: syscon@17c20000 {
> -                       compatible = "samsung,exynosautov9-sysreg", "syscon";
> +                       compatible = "samsung,exynosautov9-fsys2-sysreg",
> +                                    "samsung,exynosautov9-sysreg", "syscon";
>                         reg = <0x17c20000 0x1000>;
>                 };
>
>                 syscon_peric0: syscon@10220000 {
> -                       compatible = "samsung,exynosautov9-sysreg", "syscon";
> +                       compatible = "samsung,exynosautov9-peric0-sysreg",
> +                                    "samsung,exynosautov9-sysreg", "syscon";
>                         reg = <0x10220000 0x2000>;
>                 };
>
>                 syscon_peric1: syscon@10820000 {
> -                       compatible = "samsung,exynosautov9-sysreg", "syscon";
> +                       compatible = "samsung,exynosautov9-peric1-sysreg",
> +                                    "samsung,exynosautov9-sysreg", "syscon";
>                         reg = <0x10820000 0x2000>;
>                 };
>
> --
> 2.17.1
>
