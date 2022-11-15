Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E36629F48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiKOQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiKOQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:27 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07ED2E685
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u2so18269081ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbrz0ffG4H27ZPb4MADyTWhHSfZ848ODJdVufQ02RU4=;
        b=W7tIct2KhS2PIWxGPlRPh6rbyaHCWeiKuS2znccnngsN2gbKEyqgngc5Ls6zIBTdkh
         /VwpolO43W6YEKD9sSZwxQ1uJ8PT86MsGmFZ6idWiKQMP3bc7wDn6sWAOEm9+481vUpb
         wu1Sv8Uh/vmlHle6WXufYHWUwyfjzb575VsE/qPOvRvPIwXTHdoDih8WfBppTjNPLE3A
         3eY0LbVyq/Bv1uwJv+rksCreuqF7O1y8PEL+LMhqbLpmb2sUfmZNOAi+lDf0gG8mrx09
         VHF3zhht6AUl+FDLaVW/7tGo5Xn4iyHGpteAnt+2BV0wdhY7RZf9C4M1ad6ieJGIgEEe
         n3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbrz0ffG4H27ZPb4MADyTWhHSfZ848ODJdVufQ02RU4=;
        b=YkNowFGM0And2qSmbeaNfjZZzTbSv5z0Iy9ln5c9rETH0I23kLDL2w9xXajWKD8bfF
         ltI8QyJssDy1tUkk5T9MidLPs9S8miaLUwqpDXbpVe4q2VNWT//Ivdo2BXVQqDuMYeWo
         KaWY7zm76JHK07eGKsowQl0lrVcX0CIcAUjKeJgzfATgkSx2Ix3/E+x/YYVMzk3GmmbQ
         8MK5Nwzh7qYP5nsL7bjkC10csGIZNkZl0IA9X68LCJ7w72iZbsRsr/fGaNSMTsy+KJrE
         hbndYFCm9H0XDXr/3pvO7xE1k3cbwB0mlTmKXPGeam0kz/bRoskFy1RHqu+ZW6ZWnrtY
         cqEw==
X-Gm-Message-State: ANoB5pnI9UzOWUV9mw5/1ynO0/lTZW9nAG/5+ZOT1GLZJSwndj42Uy7J
        6o1CBs/rC8yggFsK/arU/tQ2zw==
X-Google-Smtp-Source: AA0mqf4VY+gdorXXpSVzCLd9Tk76uvlyTy3qQjabGoNTlptYT2xp20PME4oRDm/h0sk/eXqc2YGD4g==
X-Received: by 2002:a05:651c:10f:b0:277:3f37:a36b with SMTP id a15-20020a05651c010f00b002773f37a36bmr6469870ljb.324.1668530540075;
        Tue, 15 Nov 2022 08:42:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a1-20020a19ca01000000b004a03d5c2140sm2262297lfg.136.2022.11.15.08.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:42:19 -0800 (PST)
Message-ID: <d93ae067-5546-6e13-0ff0-48fda6c342c5@linaro.org>
Date:   Tue, 15 Nov 2022 17:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/11] dt-bindings: nvmem: Add compatible for MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Document generic QFPROM compatibility on MSM8976.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

