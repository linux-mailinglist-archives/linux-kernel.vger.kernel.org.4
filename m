Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545569D845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjBUCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjBUCCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:02:16 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990601E1E9;
        Mon, 20 Feb 2023 18:02:15 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-172242a14d4so1336588fac.9;
        Mon, 20 Feb 2023 18:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMcK4eVefoc0Zhwd8hmnE5qeueS3m0fxi4LfUG7S7H8=;
        b=rk0BE3nDT2V6NJaNZD++Mss9AO4y8aS8gTAMoIdpZ9gfbEgcvEBghVYyRziswM4BQ9
         Sbu/kJic+dybI1O2mNJJeVTu9cM4mfBXCoHJ5limsLLbODhjyOvcsnAK1/+62y7HkbS8
         HaZFXuK96+x8UfClNR/c9Kxkz7F69gmS6FMzbrTmetsgOd7jv0TFuBUp4trajX44RPC7
         ly3w9sPfmFP0F9e7B2OGJriBwKCvf6u1Q29jy0qow9/CDLR7cSDDfL5vTKNRPfkK7AhN
         TKBUEIuxA0HRR26RAEAAB+fPjHnaiMC0rbWEJ5kD8wB3i/1akK9j4q8CZQS/fDfQzB1o
         7V5g==
X-Gm-Message-State: AO0yUKWNQvmyIIDJfdPKL48Fx+kDA4uKAr+4Aha1hYM5ZnOx8HnwEoUb
        qU9sgcJoIWbEU1aYFgXwHQ==
X-Google-Smtp-Source: AK7set+QlFpQTPnylWNS6bv4ET5B+hDnax1NroqOLf/d/sCFoYvfaZQaKKoxK8KklFExukAD8YDppA==
X-Received: by 2002:a05:6870:808c:b0:172:2b8a:fe96 with SMTP id q12-20020a056870808c00b001722b8afe96mr267327oab.20.1676944934858;
        Mon, 20 Feb 2023 18:02:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i3-20020a056870864300b001631c92e8b6sm4936445oal.4.2023.02.20.18.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:02:14 -0800 (PST)
Received: (nullmailer pid 812234 invoked by uid 1000);
        Tue, 21 Feb 2023 02:02:13 -0000
Date:   Mon, 20 Feb 2023 20:02:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v3 5/7] media: dt-bindings: samsung,exynos4212-is:
 convert to dtschema
Message-ID: <167694493273.812178.8499940973016911398.robh@kernel.org>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
 <20230216142204.48394-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216142204.48394-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2023 15:22:02 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
> bindings to DT schema.  Changes during conversion - adjust to existing
> DTS and Linux driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Move size-cells next to address-cells.
> 2. Drop dead/debug code.
> ---
>  .../bindings/media/exynos4-fimc-is.txt        |  50 ----
>  .../media/samsung,exynos4212-fimc-is.yaml     | 220 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 221 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/exynos4-fimc-is.txt
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

