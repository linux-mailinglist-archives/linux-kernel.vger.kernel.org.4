Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0E61829E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKCPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiKCPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:25:03 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4322C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:24:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x18so1339961qki.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GK+kN47VRDh5Rd9IAtghxyhLdbPgGlBTCLcifjdKfY=;
        b=CuVdKrpYE2rQRg37FPIg+JZrk4NzKKxt219BGe3CMQvQo8Lmp2ckSDbzhj0bEEUIDL
         fxTOSuzkB/5KrS//gXY6ySrTmRgRg8/Y7fvynh6m65Zh2OXxQ4VX2GSRl9UBvObPXaiB
         +vOZCa0xjXVbfTNBKAzOFM+Bk77Hb1sPLlBuXe4pMZ5UDc+2YdWojicrTPpwK/H61Iio
         yq7H5MfkITJRWQYoPFpDcBb9983wRkk5uycAbX1edw4j+1IfEOYvTWUb0TabE5T1YL68
         HomjjXu09Q9xuXt2iGFj5ybrYfCG6zH2HK1fcjAIOuAUFslSMbvF1EvI5XH6vconk6NT
         K1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GK+kN47VRDh5Rd9IAtghxyhLdbPgGlBTCLcifjdKfY=;
        b=fx+7j2zD7SNZ9Ua6o9OUHIiP+QRB7gtPd1XzrAGOM1ZlEeqgXo47fVeMfLEEneYzwP
         O8Hkslp2l+ZGiYMqYZkGUQ3P5u4YdHC4A0pqgsLXJKRdJydEdidruZpJQ0/CQPr4nTUX
         F8jbX9utcUlmdB14BzurgPjlUViqyGnhG8ThaRg8n6/7zyepvjDit5J4YYyySNRobwyU
         PD9evdSF8AR0BX8BW+WjlDsbx8FJEHP/cmE3lpK5E3deDsZdJmRD500ZeFlWxqEme9ML
         riurRps6mqY+rXXy+LfT8Bd8t3mPIk2ebJY04fN+rXFxqk20vZd7tGER7Km1Xwf4/DJ1
         ha2w==
X-Gm-Message-State: ACrzQf2siDs288nK2THMaNQmUKibQKmSR935Ml0w3iASeNZBem9S08Cg
        yrU1PyZ20z3qft0QpeAlc9H87g==
X-Google-Smtp-Source: AMsMyM4JfQZmP8W7rxOWSLWL8ATCWGxBIJQoz0Nkbogfi2BmdP8tf0y5Xg2ivz3gto0bPNF2tfnghQ==
X-Received: by 2002:a05:620a:1256:b0:6fa:4c67:4d9c with SMTP id a22-20020a05620a125600b006fa4c674d9cmr10696457qkl.713.1667489095268;
        Thu, 03 Nov 2022 08:24:55 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a15f400b006b953a7929csm907379qkm.73.2022.11.03.08.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 08:24:54 -0700 (PDT)
Message-ID: <a2b1ffe3-e2bc-25d5-f665-363db09bd959@linaro.org>
Date:   Thu, 3 Nov 2022 11:24:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 02/12] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jitao shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     stuart.lee@mediatek.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, mac.shen@mediatek.com,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20220919-v2-0-8419dcf4f09d@baylibre.com>
 <20220919-v2-2-8419dcf4f09d@baylibre.com>
 <c91ee3ce-3f30-a3ef-bb38-8571e488b6b6@linaro.org>
 <CABnWg9t3w4o4rmNosvYCpqG-h8DESerajH7OsXEYofRf2kr1Xg@mail.gmail.com>
 <6bb3ab49-1c12-6863-a49a-2fd1f34de561@linaro.org>
 <CABnWg9uDki0ZtkxU1BPZq0ZU1mi4zFjasw+e3pQYb+Nv1MThLA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABnWg9uDki0ZtkxU1BPZq0ZU1mi4zFjasw+e3pQYb+Nv1MThLA@mail.gmail.com>
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

On 03/11/2022 11:17, Guillaume Ranquet wrote:
> On Thu, 03 Nov 2022 13:45, Krzysztof Kozlowski
>>> This is an i2c adapter, not a device.
>>> And as it lives inside the HDMI hw block, I've omitted using an address here.
>>>
>>> Is this valid? or should this be expressed differently?
>>
>> What is an I2C adapter? Did you mean I2C controller (master)?
> 
> Yes, a controller.
> This is an I2C controller connected to the HDMI connector, it is used
> to exchange data on the Display Data Channel with
> the display (such as EDID).

OK, then the node name is "i2c".

Best regards,
Krzysztof

