Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B7617B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKCKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:54:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375710FC5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:54:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v17so2348233edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYMVFsDFUtcWBoi5Ub0+JgvrJDXvnUpXM99R4TJjQzs=;
        b=SkX70McYfmMSGeAMWsjfYgMia6pyW6pz3RbCv/mALOtkOuW2IqJMy5XZIDzhE5WypE
         2NjaQB8CzCR1tSaVsyrrD022NvFT1iOOqYIIOF0TtGIpJqcY8bYuk/9OzVwUCGYrOXgb
         sgORXAgt20sVA4nNJJv38Ewsd2+OT2XMhPJno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYMVFsDFUtcWBoi5Ub0+JgvrJDXvnUpXM99R4TJjQzs=;
        b=j5T+MRBQEZ8Z8EtR8jB3lpEw/zK3O8fOfBDmedyIKNl4zvOGZbq5ARa+xKcsykR2nC
         rIhlLBMu0QE9JeQusysOt+Y1InBOp8QkkhZ99g0Ah701sgmpOGOK8KfjcA4Q/yqMtrHp
         voMbiKKOiQjclo/0GKg9lzTvzxrDZSEgoiJism3t7ruNrBhwz4G8/On9nrGun1TGO90l
         0Y53GQ7pX2RFH9UbpsOgVRe1SkJvJngnlbz3CMggBk8o8tKdaGEb4aXKszuUY3sFaHej
         WTno3dQIdSdMofZWvzDyHDOa0VA9MGYQBlw0NI+YglHzz8gIbpBVjlarfbhg7LwnT5QB
         iCXQ==
X-Gm-Message-State: ACrzQf1AChYPaqo0xq54U2sK0FJoszod2W5v4tzxZ21ybTZNn/vSCbAV
        ok9wGTIhIFaYdjtr/jH74EuYSqyOe0nnpw==
X-Google-Smtp-Source: AMsMyM4A41wsNapz3KJsWBntpCwima2ToPrxIuDvlX++qnpm8qT0btCquWidfFDoVrg0APSy+lMZrQ==
X-Received: by 2002:aa7:c1d9:0:b0:463:aeaf:3383 with SMTP id d25-20020aa7c1d9000000b00463aeaf3383mr14157655edp.253.1667472851107;
        Thu, 03 Nov 2022 03:54:11 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906b19900b007ad84cf1346sm342265ejy.110.2022.11.03.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:54:10 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:54:07 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Aakarsh Jain <aakarsh.jain@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
Subject: Re: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SOC
Message-ID: <20221103105407.GB4937@tom-ThinkPad-T14s-Gen-2i>
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
 <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
 <20221102130602.48969-2-aakarsh.jain@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102130602.48969-2-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aakarsh,

On Wed, Nov 02, 2022 at 06:36:01PM +0530, Aakarsh Jain wrote:
> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
> Exynos3250 and used the same compatible string as used by
> Exynos5240 but both the IPs are a bit different in terms of
> IP clock.
> Lets add variant driver data based on the new compatible string
> "samsung,exynos3250-mfc" for Exynos3250 SoC.
> 
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Fixes: 5441e9dafdfc ("[media] s5p-mfc: Core support for MFC v7")
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index fca5c6405eec..007c7dbee037 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -1576,8 +1576,18 @@ static struct s5p_mfc_variant mfc_drvdata_v7 = {
>  	.port_num	= MFC_NUM_PORTS_V7,
>  	.buf_size	= &buf_size_v7,
>  	.fw_name[0]     = "s5p-mfc-v7.fw",
> -	.clk_names	= {"mfc", "sclk_mfc"},
> -	.num_clocks	= 2,
> +	.clk_names	= {"mfc"},
> +	.num_clocks	= 1,
> +};
> +
> +static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
> +	.version        = MFC_VERSION_V7,
> +	.version_bit    = MFC_V7_BIT,
> +	.port_num       = MFC_NUM_PORTS_V7,
> +	.buf_size       = &buf_size_v7,
> +	.fw_name[0]     = "s5p-mfc-v7.fw",
> +	.clk_names      = {"mfc", "sclk_mfc"},
> +	.num_clocks     = 2,
>  };
>  
>  static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
> @@ -1647,6 +1657,9 @@ static const struct of_device_id exynos_mfc_match[] = {
>  	}, {
>  		.compatible = "samsung,mfc-v7",
>  		.data = &mfc_drvdata_v7,
> +	}, {
> +		.compatible = "samsung,exynos3250-mfc",
> +		.data = &mfc_drvdata_v7_3250,
>  	}, {
>  		.compatible = "samsung,mfc-v8",
>  		.data = &mfc_drvdata_v8,
> -- 
> 2.17.1
> 

Patch looks good to me, only one fix in commit body:

"... Exynos3250 and used the same compatible string..."

with:

"... Exynos3250 and use the same compatible string...

But this is a nitpicking :)

Regards,
Tommaso


-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
