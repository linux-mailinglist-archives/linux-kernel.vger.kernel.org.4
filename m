Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332D63FA16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLAVvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiLAVv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:51:27 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F28C3FCC;
        Thu,  1 Dec 2022 13:51:24 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1441d7d40c6so3706146fac.8;
        Thu, 01 Dec 2022 13:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HtBFyN71AxhRfW6SrsXoFEr2LiCu7MkoyuD2siCuUk=;
        b=DGa0D8i8n3hEzN9+Xw9A+z4EgkxzgElAjAbfY6TuXeixaScqSZ9hIwtUpLaggUjlNK
         gSrW0V6SJ7zDqxs3fywn6WWH2nFjIz6dPOV1mFSJy/hxK6z7j5NyGJX2fiXacb+EFfWF
         hZ2rn4G4cPaCF7dLnUikhkvyYhwl4y6k3swV3hdBbdyG3DJRMEArnVWJldpsM6cYnTBg
         3WJs3s0m844TNGHd0KCOkEMVcOth+ZIoF/OrA2+/vmgL0CH2AJuXVE9Q1xZziHJc9q1F
         qhwLVXD3m1DIgcqfaTiWSkRiy0sYJslyoyNKHEASc0vnnR3BIi5tI+NwPULUEOsYipc5
         kztQ==
X-Gm-Message-State: ANoB5plwsgVMYmU5hYP+4mfZFmli3w2ls2txhTyrMiw17VE+6Cpf4TmM
        8qSEOVqyWxY32QEbSakSDA==
X-Google-Smtp-Source: AA0mqf538+c00avPSXUcim+hp9vyuiAEuGHMlzFNgQ8aM/rvv0dvAfPWUaN+XTE+PprL6YoS9rh36A==
X-Received: by 2002:a05:6870:8183:b0:137:5344:7776 with SMTP id k3-20020a056870818300b0013753447776mr37209550oae.208.1669931484053;
        Thu, 01 Dec 2022 13:51:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a4adbc4000000b0049f5ce88583sm2210680oou.7.2022.12.01.13.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:51:23 -0800 (PST)
Received: (nullmailer pid 1509225 invoked by uid 1000);
        Thu, 01 Dec 2022 21:51:22 -0000
Date:   Thu, 1 Dec 2022 15:51:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: soc: samsung: exynos-sysreg: add
 clocks for Exynos850
Message-ID: <166993148201.1509163.10833414082996882314.robh@kernel.org>
References: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
 <20221127123259.20339-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127123259.20339-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Nov 2022 13:32:59 +0100, Krzysztof Kozlowski wrote:
> Exynos850 has dedicated clock for accessing SYSREGs.  Allow it, even
> though Linux currently does not enable them and relies on bootloader.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Make clocks required on Exynos850.
> 2. Due to above change, do not add Rb tags.
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
