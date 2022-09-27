Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB985EC614
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiI0O31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiI0O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:29:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DD18B481
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:28:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k10so15997201lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=92yZ7qnRQqA49V70vN00C9HGqUmmV5lex66grIlTbSc=;
        b=t/zPAMSAQWX7Jp2Kkrznx3pd8BaYj/V4IovrZOP0p7CA9dHLcTpMosv+TEf82eIdQN
         ZzPiXw9rKlWK7dgrb/2R9JIb8zq9h17dOUBhdV7CLo6ItGSkQYBffOF2Ou5wtqP2NA3T
         N9rEoP+h50jfo80xq4j1r3mCJzXfyYlWLZNzw2x5BGe+XyxiWRwC+2x4+yiqv6IzriEM
         fuXrcHsauWPdkNwTqAUt31tFVgYpbwvnD8NThfc3Z4YxzLdIRb1JExpoeuZAlbZVjurb
         kbFPPAxHbGw01+RTl5nssKqglXejrUk6qW39J2Eas+i02imuJL8VJjhw11y61M81MWAG
         3WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=92yZ7qnRQqA49V70vN00C9HGqUmmV5lex66grIlTbSc=;
        b=chCUlEqeiZk58vD7Br2yM6k7gHFZypCNdzfrn75cE1Jh5C3TxBnk9njT4iWrB7H5yZ
         HwBM7DFLwrXWWpeXUZR2KOwszkkabKb9AN9yIvfFTX3t+GO+2msYkYMSiHprq6aZVZuQ
         W5vvJKJfCGzJbsQXHXldyTmRaBV8Bv/OQjkBy/HUVP5Bg/DdVpA7hgur9R4EGzbsXRD5
         8oC2Wxilks7b8rDLOGnw0FyrnfxHE25DJPQF/gX9lrPSXzdFIgs1NHlVcrqOhK/inbYP
         hW/4lzNN6dd5Cn4Jn5DYSws7RWJxVNLFUpJq3XrV927akHTHwvMJYsPJh22+RcZxbYeK
         c8CA==
X-Gm-Message-State: ACrzQf06Z+u9L22jF0BQLbSYUEFpqXr5ZDjKEo1HgucUJlYBfuJkTuLQ
        9A2uVEcCnMZRi+2DvxhrZnZj3A==
X-Google-Smtp-Source: AMsMyM53dC3y7erBKfzBQ+Nze0zZtnLF71JT4J25PfiX1YCvYNVOBA7+2R4vFWpiZCxVk3PBax4BpA==
X-Received: by 2002:a05:6512:308f:b0:49a:5a59:aa25 with SMTP id z15-20020a056512308f00b0049a5a59aa25mr10629204lfd.44.1664288937219;
        Tue, 27 Sep 2022 07:28:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b00494a1b242dasm182416lfn.14.2022.09.27.07.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:28:55 -0700 (PDT)
Message-ID: <bc64b69d-3d65-f5ca-a688-2ad1a055ba4b@linaro.org>
Date:   Tue, 27 Sep 2022 16:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 17/17] drm/mediatek: Add mt8195-dpi support to drm_drv
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-17-4844816c9808@baylibre.com>
 <a0a3c427-c851-ae5d-4010-e94740bf9f6e@linaro.org>
 <CABnWg9s3N_Ua9g0S3x0uj8PN4FtOX6DO+zQcBzGFqoLTL1J24A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABnWg9s3N_Ua9g0S3x0uj8PN4FtOX6DO+zQcBzGFqoLTL1J24A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 15:04, Guillaume Ranquet wrote:
> On Thu, 22 Sep 2022 09:20, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 19/09/2022 18:56, Guillaume Ranquet wrote:
>>> Add dpi support to enable the HDMI path.
>>>
>>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> index 72049a530ae1..27f029ca760b 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> @@ -820,6 +820,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>>>  	  .data = (void *)MTK_DPI },
>>>  	{ .compatible = "mediatek,mt8192-dpi",
>>>  	  .data = (void *)MTK_DPI },
>>> +	{ .compatible = "mediatek,mt8195-dpi",
>>> +	  .data = (void *)MTK_DPI },
>>
>> It's compatible with the others. You don't need more compatibles.
> 
> Hi Krzysztof,
> 
> It's a bit confusing, because this compatible is used in both
> mtk_drm_drv.c and in mtk_dpi.c
> 
> Albeit it's entirely the same thing regarding the mtk_drm_drv module,
> it's pretty different
> regarding the mtk_dpi module.

Sure, but this does not explain why do you need these entries here in
mtk_drm_drv.

Best regards,
Krzysztof

