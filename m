Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A476E9885
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjDTPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjDTPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:40:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8D9F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:40:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso1075219a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005232; x=1684597232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng/7l5VlfjgvLBZOn+6emtZItxRcIQQXLL+YWHzwDfU=;
        b=QW3lu605jBMYSJRbLYIrS9IzJPjwoSJYKeCmncGY76yReh8FCCYyyql0pg9Ivr+ZkL
         937r9nGPBp8Fu/WKnoeGWLfok6zvZIZEir4Qs7el9vKsNfFPi2v9OG5JVM2k0KROyz/r
         bESc9mUVByXgcnV3eawwGu56f9WmN5pPd8JdFliTkT/7vXTN7FdN6wCu0iFzo+Ij98nF
         3LL/ZDek2x2U7WKhRHMbeMWe2GF7sS84jYezdtFY3kICzZQNSNtaRHGH9LGBSg14lv2u
         zyYcK27ckWHD3FZHIGg4EqYgxYCVumo5G6cFggF5QWERTL2DldXp1a7aYCvSuGOA7mn1
         Hy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005232; x=1684597232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng/7l5VlfjgvLBZOn+6emtZItxRcIQQXLL+YWHzwDfU=;
        b=FlGIBtQkqDnFu8cJf54hz9+ocnawF8jjcJO3vov1M3a8H/5+O6CQPsdD6gf/eZ9c1/
         iLCkDzaVLtubKMUy0snRqu9jwVYBpFDt/P5UH6c+7jZdHT+GarpXKQBU/OcpRD8ziE1n
         ufWbRDPfnliNbRCUpQUbV/mAqVu6501pE6Y6hAdzer8LK/iqNJfDegAFL7RuadfsgJFI
         1Jkzu17rvU23CA0hUywtcGqkjqIZs6pO/sDubC9Qcm1ZECbsgucwGSrkW5OnvBT6g1H/
         Oi7a4IKynFcVY9nLVzkv7Qem6OhcWyyxukvI2kfhMIvLJL2zWCwwP3HxyGWg034nHois
         a9BA==
X-Gm-Message-State: AAQBX9deih0s9+k58StPaZOLlQHhITKgABbkTfjQgtE+4sOffy6IgV1B
        x31C/LKqUGah8ria21V8KjsTrQ==
X-Google-Smtp-Source: AKy350atlvDRHpkArIMuqphydgSZ7Ju+vCaZdY3O2gF6jFZEWQy94BQRkh+vgJkjYC/ybSM9WBzcvg==
X-Received: by 2002:aa7:cb01:0:b0:506:a2bb:fc43 with SMTP id s1-20020aa7cb01000000b00506a2bbfc43mr2043394edt.15.1682005232101;
        Thu, 20 Apr 2023 08:40:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b004c2158e87e6sm853513edy.97.2023.04.20.08.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:40:31 -0700 (PDT)
Message-ID: <087ba4df-7575-acce-309a-efb5115a987d@linaro.org>
Date:   Thu, 20 Apr 2023 17:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
 <20230419060639.38853-2-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419060639.38853-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:06, Jaewon Kim wrote:
> Polling mode supported with qurik if there was no DMA in the SOC.
> However, there are cased where we cannot or do not want to use DMA.
> To support this case, if DMA is not set, it is switched to polling mode.
> 

(...)

>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> -#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
> +#define is_polling(x)	(x->cntrlr_info->polling)
>  
>  #define RXBUSY    (1<<2)
>  #define TXBUSY    (1<<3)
> @@ -1067,6 +1066,11 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
>  		sci->num_cs = temp;
>  	}
>  
> +	if (!of_find_property(dev->of_node, "dmas", NULL)) {

of_property_present()


Best regards,
Krzysztof

