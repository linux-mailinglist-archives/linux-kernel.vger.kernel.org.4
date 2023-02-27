Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918CD6A3C32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjB0ISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjB0IST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:18:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5318A279
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:18:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so3664997wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmsXqGpstaDNW1rYeO8j3Cmpj7EBNxqayPxfTCKvPnk=;
        b=uCy8R3eUrhut5ajrvRwfcweUpiEmd6SZUU1Q4SaIKe2z0F8/YXupCUZyXtyeTDbjLL
         S+hxrOlTRUkX8LteNyL4osBBaAXwovNwQLKXQiGtZzGojjWKx/an0lnnT2RzNSyH+UdR
         qoLka3mBKnQJduBih32Di4477u2bjhCFMt0rEWDtpOgNsR6CJRQWz/eFwD/n259ehJa/
         9ch27VJh/VIrLigFtlQHnPn7ZPcrJG5O3LTknywrPq2qP7//L9wHHOqN6DsFc8+i2O9q
         QtWu36dlkSXnkj0RQH2Lvhs/GG7lNuXsxF6lsP+cYQ8/iUg+y5lntSodutq5nE+mtjIE
         FMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmsXqGpstaDNW1rYeO8j3Cmpj7EBNxqayPxfTCKvPnk=;
        b=BjPbjGeky3Bguw3/+WPfzxXnqyhHxokUhy1xRZWAWm6SbXtuwNcr48ly31ypEdMon0
         o3PyffjSFLhmWX+wwsueowfGgVc+J+it5AhfK9kUSuV4Uuq+Cy3S8MCsHvnfsmldWXbq
         ogbDo4oeDEdN6KAdRJh1UjevbjwrVwDEGgvxr6q6AtSBMyFKO+E2wpOM3nVadREsD1Tq
         5dP5KaHfMJk/kgwh/h2EVWh+QvcbnYu+PbOqECMHnqqd5dsaswNFOAsmnaFqXqk9aXrZ
         U2X0gWOcEROvt8ElYCunGHcwoUc+tzSuc90H+TYmnv+/GXy55V7mFVmo/Hvs/DG5/HTU
         5Rwg==
X-Gm-Message-State: AO0yUKVZpIVW4dBw+A//TxgSDboc+fwzn5xblzcHh4XnVSoQfzNVBkFo
        Gjo0Hdj5/PB58PmXdnjX1S2v6g==
X-Google-Smtp-Source: AK7set9iwF1Of26EjPuUp+IirohBujP4YEwmcDqQ2+5/f3vTpYb09Hw40limy8H2jFYw55cq3FBGfQ==
X-Received: by 2002:a05:600c:1d09:b0:3ea:d611:f8 with SMTP id l9-20020a05600c1d0900b003ead61100f8mr10353121wms.38.1677485894351;
        Mon, 27 Feb 2023 00:18:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b002c4084d3472sm6322620wrq.58.2023.02.27.00.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:18:14 -0800 (PST)
Message-ID: <49ec87c5-5f02-ae07-464b-3b9d22c5a6d7@linaro.org>
Date:   Mon, 27 Feb 2023 09:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: mediatek: Add MT6735 clock
 controller compatibles
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
 <20230225094246.261697-4-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230225094246.261697-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 10:42, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add compatible strings for MT6735 apmixedsys, topckgen, infracfg
> and pericfg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/mediatek/mediatek,infracfg.yaml          | 8 +++++---
>  .../bindings/arm/mediatek/mediatek,pericfg.yaml           | 1 +
>  .../devicetree/bindings/clock/mediatek,apmixedsys.yaml    | 4 +++-
>  .../devicetree/bindings/clock/mediatek,topckgen.yaml      | 4 +++-
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> index e997635e4fe4..715e24a4ddda 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml

All the previous patches should be squashed here. There is no reason to
split adding new binding for clock into two separate patches. It is
still one new binding for clock.



Best regards,
Krzysztof

