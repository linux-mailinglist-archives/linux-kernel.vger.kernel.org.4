Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590396A3C38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0IS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjB0ISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:18:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77408C162
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:18:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx12so2075693wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsW3cnQpkFobawAQ7KjeQDh+HS+MtSdRuN5mmJGO6qY=;
        b=AvK6jRRFSOt+n1ffk6vJiwQQbHRxm6AsUV4wS/6KkGBvs66zYKTlWus5yEfviTpYj6
         kJZmRRJHnVEhrYd6U5vOfL2OeeA6L8yxahgkOTypIndNySrIRwma+cFKU4gdmqzHhtba
         AQcZ53uLv8cR3wDcLmBxCw5q0AtqAd0sCWemgcLoCq4qw8Cw0mUwx5Gy9pampSN+hYwC
         KIErNwb/4X4n3mqxYKRlJBiKDTV9UAJu4J8qi0WnWHk1FBcdWeNCBk+UP1Wepv8rjP0A
         EYJlb3YLIayqD4oRkMCTU9DAcFg1tIWEZ9aLHKyexcBQNMxSW3WJEy8yrn+8KO2GG5Ig
         mpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsW3cnQpkFobawAQ7KjeQDh+HS+MtSdRuN5mmJGO6qY=;
        b=kfdsk/yIhKLMLdKbjKUMsllGfEeEp0gUqTwsJKZIaRc8cTwr+1CDcSXun/0o7WT1gN
         6QbdG6EgPvdcV1upV7zstVz9yvHKdkrhTcQz5In6tQM9RAc60P06FG6G7KgXlinOY8RT
         SObn79qgP/qtIUyInZoU6mVgKamoUv3fbcODQq1DbHd0MKFJ0eJJLAPvUzqT6LWEyXfk
         05DuvBgP9TXuCZR/cDdR3NoRTpKa+ve7KdSzCOT4mVG5EjW4lL6FS2sguz6WmjxeXlyv
         CCplA408DLPVEckGPpwIwTM4nabriyBXmWMWfm3ks505DrvhDpNgch8mffxJXjE2yzsY
         nNLg==
X-Gm-Message-State: AO0yUKWR4eqUNbo2fhtZ/UU2e979zDg1Q2PfrI/exTxzLF7qlgMIxd7F
        g/rtyuCm0+G3DIscScdOroBsbg==
X-Google-Smtp-Source: AK7set8ztKjRC0ujf94Tndq6Vka4BGloWzDiY0mYTjekowUIvGqF2ZicFqfLVVh6E3awOAZNvHwYrQ==
X-Received: by 2002:a5d:6d0b:0:b0:2c5:68a9:843f with SMTP id e11-20020a5d6d0b000000b002c568a9843fmr6963601wrq.4.1677485927974;
        Mon, 27 Feb 2023 00:18:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i12-20020adfefcc000000b002c54f4d0f71sm6314277wrp.38.2023.02.27.00.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:18:47 -0800 (PST)
Message-ID: <52d479ff-14c6-b65d-952b-e7753fee2dea@linaro.org>
Date:   Mon, 27 Feb 2023 09:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add MediaTek MT6735 clock
 bindings
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
 <20230225094246.261697-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230225094246.261697-2-y.oudjana@protonmail.com>
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

On 25/02/2023 10:42, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add clock definitions for the main clock controllers of MT6735 (apmixedsys,
> topckgen, infracfg and pericfg).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS                                   | 10 +++
>  .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
>  .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
>  .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
>  .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
>  5 files changed, 167 insertions(+)

You should squash it with other part of binding. What is the reason
behind splitting one binding into three patches?

Best regards,
Krzysztof

