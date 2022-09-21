Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B015C02CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiIUPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiIUPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:53:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC913EAD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:50:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l12so7520452ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+AzyupcNcN5MuIw8piGTps3hiD8tmkzqA6nQdQZ9DjY=;
        b=FwV7oDNnArDuxhIOhFqBat34cQb+EoRojBTGwR2rkJ3S81FjwoFeNRutUfKOWH8RPV
         wr4RvDUwNQx4biKT0L0s2VDkjmIImIARlfB0QFTEzbqVLmbdwLoj9LO+Y7tcD818TyHh
         twRAvQT47whaquKJXTnU2TeS1FnDgusH16qCkcVw8bCa9g/T61IBvWJLRsodL+g2Vs5M
         b6wQnnMXGxizV6TXwPM6dQx8+nxv9DU9KGxVbYwfYrxvCSISkaFz5RpekAWfZdMesfRe
         KY4vsZLJG9xezuceQK5USilaZK3wGrw6se4jJ1CZswdcSs5UQDbQomfkG0VzvjcP0cDc
         yhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+AzyupcNcN5MuIw8piGTps3hiD8tmkzqA6nQdQZ9DjY=;
        b=J44pdxQaq/d4WeUMSZKHgSgIqx9RowsYEMpYYfMeppznebKnrjDC9OurouX7WA+fd7
         bdfn0NMy++xBY2yZ++Zb2cjNaZ89CqwoWJunEZh3e7KvPgIuYYgJxTVJz/KYbP1QNCkD
         Zem4/bGIzDx1B4x9GNxaTuLdek3fMFAhlzKUefBYzO6G7tl+f3WTeV1lebuuCpkIeMtq
         MbLBl12LVMk0mDWZvRw5aW5lt/qLXT1zJ5VfZhU2kUcimmJTq2AmtcgZzfP5nROS4oc4
         8WwdgYvnvPzgN2Q0dZk6rk5hKOi2HSz+Sp04prtiuSxWjpHXLIdq8FE8YldY7K6294/2
         cjtg==
X-Gm-Message-State: ACrzQf21k7XS3yRvBfPnufRwizI5tSnLcJQTu54hAihOpAa+ZtaHe5qs
        DNRjIQb+a3G8stbBAJ7tzlXepA==
X-Google-Smtp-Source: AMsMyM4XVPSoYlEMHI9YHOlR1MfJWaBYLiNgPJYRSS7Sd6sw+97LXpSFpbkAiJ4rGBTDeEPdvLEu1g==
X-Received: by 2002:a05:651c:128d:b0:26c:37f9:c8d8 with SMTP id 13-20020a05651c128d00b0026c37f9c8d8mr8635831ljc.97.1663775381270;
        Wed, 21 Sep 2022 08:49:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x25-20020a056512131900b00498f3ebffb2sm492365lfu.25.2022.09.21.08.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 08:49:40 -0700 (PDT)
Message-ID: <a565b1d3-6fbb-515d-9af3-6ffc95f0e48e@linaro.org>
Date:   Wed, 21 Sep 2022 17:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2
 block
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <961b4821-4111-b48e-1ae0-60da8c427fbb@linaro.org>
 <CA+V-a8vrixnR2fXv8a8YS+tfK3KHmO1qJxE=RaFw4FPopubdBA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8vrixnR2fXv8a8YS+tfK3KHmO1qJxE=RaFw4FPopubdBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 14:31, Lad, Prabhakar wrote:
>> One more: drop the "clk" suffixes. Remaining names could be made a bit
>> more readable.
>>
> The clock names are coming from the clock-list document provided along
> with the HW manual:
> 
> - CRU_SYSCLK
> - CRU_VCLK
> - CRU_PCLK
> 
> Ive dropped the CRU_ prefix, do you still want me to rename them?

Yes, that's the generic guideline, regardless how they are called in
datasheet.

Best regards,
Krzysztof

