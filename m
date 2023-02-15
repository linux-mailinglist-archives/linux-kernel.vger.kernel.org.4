Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960B6986C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBOVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBOVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:01:21 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939F44A1DC;
        Wed, 15 Feb 2023 12:59:32 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-169ba826189so288713fac.2;
        Wed, 15 Feb 2023 12:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw9OhJnxeQFlsW9jvyuNMcqkjGN1aTOGkoDw5pqCb9o=;
        b=HZHl930/ywWpWQKCvOhxnl6RWzlpjW+YbQIoz24zUYgtdfe7WYtJH8zHyDoylwP/pc
         HxH030JjKK2LqdiN+tAovTj7vCj+BXuLx6Gf9+/cA6nqbti1uC2ewAWDD/sEzpyzGbKv
         Hv9+9snDjIBibF9YLpKP3W/p6DW5j+gHXPxpHVODsNd5uS5iRMD4WgRqhAx09m3pW+77
         Qyrc2lU7j934lsn95M385c9D1riyNRdgF3j/d2O6r+q8O6PxSNotx64lCVSoAwIKO2n9
         s26uWa4/6XPG+NhIk69ieHlZfw4qco3/I59txS3tPytqJ61PO4s4POEwldablpwi4rN7
         sGgw==
X-Gm-Message-State: AO0yUKWCyqbXgVigO8dial041pZxgkPQG14C6gqytmvEjEK1os1x5KWH
        mdVSqrctfNpE9NbiSt55SA==
X-Google-Smtp-Source: AK7set9M4FGavB03rwsaWL2L1uUYbnrQE7G57IZ20xvgfBAijJwqzmOA3u/kSDSS1hgAhDH/NmTJ/A==
X-Received: by 2002:a05:6870:1708:b0:16d:bbb9:9693 with SMTP id h8-20020a056870170800b0016dbbb99693mr1929202oae.57.1676494753835;
        Wed, 15 Feb 2023 12:59:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z22-20020a05687042d600b0016e09b1d89asm3562617oah.32.2023.02.15.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:59:13 -0800 (PST)
Received: (nullmailer pid 539254 invoked by uid 1000);
        Wed, 15 Feb 2023 20:59:12 -0000
Date:   Wed, 15 Feb 2023 14:59:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 6/7] media: dt-bindings: samsung,fimc: convert to
 dtschema
Message-ID: <167649475143.539185.16766908819491171181.robh@kernel.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
 <20230214104508.51955-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214104508.51955-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Feb 2023 11:45:07 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung S5P/Exynos Camera Subsystem (FIMC) bindings to DT
> schema.  Changes during conversion - adjust to existing DTS and Linux
> driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> The patch depends on:
> https://lore.kernel.org/all/20230207205834.673163-1-krzysztof.kozlowski@linaro.org/
> ---
>  .../media/samsung,exynos4210-fimc.yaml        | 152 ++++++++++
>  .../bindings/media/samsung,fimc.yaml          | 279 ++++++++++++++++++
>  .../bindings/media/samsung-fimc.txt           | 210 -------------
>  MAINTAINERS                                   |   2 +
>  4 files changed, 433 insertions(+), 210 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,fimc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/samsung-fimc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

