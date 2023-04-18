Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB86E6984
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDRQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjDRQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:28:41 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356DA7;
        Tue, 18 Apr 2023 09:28:38 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5f7d10dd5so635892a34.0;
        Tue, 18 Apr 2023 09:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835318; x=1684427318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTdlBH7gDMe1gwvvIrce6g7Kee26bgpxsr6cq5gCaQM=;
        b=IQ6ZtEC4puIKE94yBiaFXY9lvvBWMvyr4WKHUr9yIg3rqnA2EoH+zfAKqLjGQU0Npf
         k9Xz0YKXTZG4cejTPyZl5N8XrRAiDiZMa2H2yMPOWH55T853n4XzkG6Hxovi0RM7K65f
         gpW7ECdZ0ZfxS2WS5Ftt14bwrWZBzwngAz6O1PG5yAfPER2fTWPUX3WPxhb9MEUZmW5m
         yOz8wfeT9A6R5uJZVi3BJDtFuMVOPBDOIe0aQkhCEqDRUoWjhiPqzC2ajUDUiOCpfvmw
         TwBa0vY4rLZ65SxfiBFP9IXZkctid678vocz8kXBF0b87Fmdwv6IgTFRAAtyybZsAhkM
         hXkA==
X-Gm-Message-State: AAQBX9eCfCqtkBYlbkoVFozbfqqNfyjyYpucTOpVuffI9B4T9zJi1zxI
        cVHMKOmw3OSUyngCksbplJq3yF8Oig==
X-Google-Smtp-Source: AKy350ZFkf368usk4zZSQ/xerYs5DI4VOYXV+JxF5CSCs1hhDwPdmg4CpIlRzCupHO97xwwOs5n1Dw==
X-Received: by 2002:a9d:7b45:0:b0:6a5:fdec:e1 with SMTP id f5-20020a9d7b45000000b006a5fdec00e1mr1075466oto.16.1681835318049;
        Tue, 18 Apr 2023 09:28:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l23-20020a9d7a97000000b006864b5f4650sm5788490otn.46.2023.04.18.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:28:37 -0700 (PDT)
Received: (nullmailer pid 1811524 invoked by uid 1000);
        Tue, 18 Apr 2023 16:28:36 -0000
Date:   Tue, 18 Apr 2023 11:28:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: mediatek: Use of_address_to_resource()
Message-ID: <20230418162836.GG1764573-robh@kernel.org>
References: <20230319163231.226738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319163231.226738-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 11:32:31AM -0500, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Ping!

> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index ab730f9552d0..c8a3acaf56c1 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -897,14 +897,12 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  
>  static u64 of_get_phys_base(struct device_node *np)
>  {
> -	u64 size64;
> -	const __be32 *regaddr_p;
> +	struct resource res;
>  
> -	regaddr_p = of_get_address(np, 0, &size64, NULL);
> -	if (!regaddr_p)
> +	if (of_address_to_resource(np, 0, &res))
>  		return OF_BAD_ADDR;
>  
> -	return of_translate_address(np, regaddr_p);
> +	return res.start;
>  }
>  
>  static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf)
> -- 
> 2.39.2
> 
