Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BE5BC606
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiISKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiISKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:06:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32B626C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:06:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so46074587lfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E/6rguEg/ZdWc1ukf7xlwUxy6XdvsLO+DoWiEuYD7Kc=;
        b=R/d5F8iQ5A3MJQq2a2urDyF3hOpf96JRd6MMVeuZytNnN38d+CMzYHcqO67WLlgjrF
         1YOTkwdBXx89EEa5IHZCIOnsH/D7ixYq0fnqz7E6WzF9juomojx3oI04uV+WLIpC7pSq
         VUlPCpXDbtXt1bOBZICVgjdP5lDuEF6FW9ya//+jjjjvV4Rdu1Io9wwK6PShHtWVk05C
         myyCftKiYalXiuQf3wsSfCHOD5hrDwaw9Dy4z1o7/Lkli8O3u6KPW46z/bDhJILuJ5Ea
         qFQ/gGWd+eX6p+JCLsf4mZezgCkL2wP/f0kkg5zBeR73KILKAfNYbrWR6TYXWl5SvOyO
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E/6rguEg/ZdWc1ukf7xlwUxy6XdvsLO+DoWiEuYD7Kc=;
        b=yiW4OlWG5rfn7AoA8fMULE+PP82wI2meBEXfx37EXpnS0ZAxQUXcV3BVssfobMhsFn
         cjweQR0bUC6qEA+e5ZVOC9xNczJP6QRBLLidhdfytpIL/KhgDODA6hnrjtY2x1j+NSLN
         AlseP+v+8ZqkJUub1Xn9SkkhhPFbZdpU5TQExYR92Aa3acigkwb2pZWrIIP4Xl6YqBQw
         mI4u5HNu2/t/lT6gy9LRs3l/eUt2K5zg9AquJdAJMS32VGYail4O8Fxu/ZvxryK2EbuI
         jc347mfBjQVzMrBlelHg1hEen3f7UCY4wgqBgYzgKaEtknrqimsQwn/s4MQ3vKRna68C
         vB6w==
X-Gm-Message-State: ACrzQf0I1WMHREf3tYPKvPXNQm/5TYd3Z6SpexwhpjsPqtJbwRykuDuq
        Ww/CmWoB8tJfo+CQn9zV+FIM0A==
X-Google-Smtp-Source: AMsMyM7gfRP2Gkver1jK03ZgtDxTkEMoPJyKiDo+jioBxtwYyq894VSIuGwOrIApkwapq8djpspI7g==
X-Received: by 2002:a05:6512:e9a:b0:498:ff3b:4639 with SMTP id bi26-20020a0565120e9a00b00498ff3b4639mr5805175lfb.388.1663581966082;
        Mon, 19 Sep 2022 03:06:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n4-20020a05651203e400b00492d064e8f8sm5141134lfq.263.2022.09.19.03.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:06:05 -0700 (PDT)
Message-ID: <b343e4c7-a247-28b8-3d16-cb7cea7ba36b@linaro.org>
Date:   Mon, 19 Sep 2022 12:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] stmmac: dwmac-mediatek: add support for mt8188
Content-Language: en-US
To:     Jianguo Zhang <jianguo.zhang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220919080410.11270-1-jianguo.zhang@mediatek.com>
 <20220919080410.11270-2-jianguo.zhang@mediatek.com>
 <d28ce676-ed6e-98da-9761-ed46f2fa4a95@linaro.org>
 <4c537b63f609ae974dfb468ebc31225d45f785e8.camel@mediatek.com>
 <88412fcc-96be-cd9d-8805-086c7f09c03b@linaro.org>
 <f72e133e9aec70724702054e5f6a8712b649d34f.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f72e133e9aec70724702054e5f6a8712b649d34f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 11:56, Jianguo Zhang wrote:
>> No, this does not justify new entry. You need specific compatible,
>> but
>> not new entry.
>>
>>> On the other hand, mt8188 and mt8195 have same ethernet design, so
>>> the
>>> private data "mt8195_gmac_variant" can be resued to reduce
>>> redundant
>>> info in driver.
>>
>> And you do not need new entry in the driver.
> Do you mean that I can use "mediatek,mt8195-gmac" as compatible for
> ethernet in mt8188 DTS file?

Yes, as a fallback. Example schema describes such case.

Best regards,
Krzysztof
