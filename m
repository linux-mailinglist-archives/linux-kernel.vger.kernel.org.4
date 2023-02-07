Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BAF68E1BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBGUP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBGUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:15:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134530B2B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:15:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3741616wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdinGgVazI5fUgZBgObY9YOTAF5gu6cqTGjYkW5HU9c=;
        b=tkPGpovGMEec0DDGESsbPR6aJLfnHktdEbfldpxzQqYpHdt/1Tu42rxfwAcpDF93qQ
         crEJ0DcNWGY2+z3oQJzXCZeVlUZ01jVAildSAMimonAgEqXobj440SE9w340FTDTRj3W
         +Ro/yeZw6f1murs6frpkTVBJRQxdI90dxw2CAl69pl9V14kDcoE5SJBhQe9O5+nvshnA
         XZQxtHeU3djbkPBA5sMxqeQ/pg+ZWvAEn66/soaf0Dun4Ss5KhhGADotpAVYssKRbRjb
         Uyy8O87oh1eUULJ+azD7Rj2mVQk6Q8RXCSTW3gOINHQaXxEvGcHv1fzWAdcH+ycjEdQu
         C1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdinGgVazI5fUgZBgObY9YOTAF5gu6cqTGjYkW5HU9c=;
        b=UGE4BkPWHn77Jl9y/sdvpTem2t03PH+vemUOITGhQ0wy555pR56jsnZjGYEZN7kIUH
         aqY7sVDahUUytU6mCMXKd+ZMxqiZAHA+2oOTmwOuIvVpR24skpNkJEHPFVe3OoCW4kL2
         BR8GrfGACTTlktbf2vzklKmYTc/3jMvf+uSWnEnJ3I7epPslSSEGOhFH3raWZYBz5m8W
         fm9bECuuBJS6bLq7xoHw7DxWH9GTO+4tT8P+3dwIr0X0WxVGbXtb4+lAvDhV/p5h0mw7
         fcFtd9dByHC9LFIDFDpIii/UjJD+It6JTorJEwmRlNOyX0NmqJD3Jfq5PXGcubXuTDkk
         OGWQ==
X-Gm-Message-State: AO0yUKWw/DrqahDpdwM0qF6YFa2AF7+OvrAa8FzB2J1ODfGqN7vR8LUC
        ue+2G3lA/auiKOM20w+FI95mwQ==
X-Google-Smtp-Source: AK7set/5h8OvHzwHdZa8t7WRpHyDlCmAbwfSNzSfFZWUQj5pO3yjNS+ImIIb15Q2AmvMbBLoFt9JVw==
X-Received: by 2002:a05:600c:331e:b0:3dc:5823:d6c0 with SMTP id q30-20020a05600c331e00b003dc5823d6c0mr4222460wmp.6.1675800923588;
        Tue, 07 Feb 2023 12:15:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003c6bbe910fdsm21958398wms.9.2023.02.07.12.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:15:23 -0800 (PST)
Message-ID: <6461a06b-55fa-e41a-0cf0-5a587ed2c389@linaro.org>
Date:   Tue, 7 Feb 2023 21:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] media: samsung: exynos4-is: drop simple-bus from
 compatibles
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230207192914.549309-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207192914.549309-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 20:29, Krzysztof Kozlowski wrote:
> The FIMC camera node wrapper is not a bus, so using simple-bus fallback
> compatible just to instantiate its children nodes was never correct.
> Driver should explicitly populate all its children devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/exynos4-is/media-dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
> index 98a60f01129d..70c4ca7844d3 100644
> --- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
> @@ -1440,6 +1440,10 @@ static int fimc_md_probe(struct platform_device *pdev)
>  	if (!fmd)
>  		return -ENOMEM;
>  
> +	ret = devm_of_platform_populate(dev);
> +	if (ret < 0)
> +		return -ENOMEM;
> +

This cannot be devm-like, because on errors unpopulating devices breaks
links and IOMMU. I will make it of_platform_populate() instead.

Best regards,
Krzysztof

