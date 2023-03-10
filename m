Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F466B38DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCJIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCJIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:36:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38767101F34
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so17357729edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJcUaaupxC0Cesm+olJlrB4JiVcGZmcF1bEfkcOLpFI=;
        b=zztfA9qPNw1B7ChjfD6USbohMrg+ZdoZ+JjKrIEDhaJERv9YNUUUQA1X1MYjz51uKR
         31cOuv6NTiT5mbHRx4VVFO/fLvmc6dEtsHOvB/JhvBKy/W3SfiRXVIxspinsqMKpHk71
         Ohyk5en+I2XdyMp7RQzAftVAY53VhRcipdTO/jpldfsrK3XqBiBRPT3D81j5DfxhhroN
         +UZsxlgxInFQQOlcNXCPbfakmwzJgJz4/fLsWn6a6gJkwKQkwF4lvwNb/Q1wCAIYfSGr
         mVYdb5SQwYtmu37jDJrzCVexyecDa1PMdsaS/6WHX+wtWHTghlwfYJqQ8Iy71DilruNc
         jL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJcUaaupxC0Cesm+olJlrB4JiVcGZmcF1bEfkcOLpFI=;
        b=3+YSh1HjCC1lGBRh3mkNrtWD0jex4a4ctncn6lgNVM8zHKumAZ95cS+nJNjWkvWTFK
         krjBJWIJySTsn33IVnvZVSi3C5SxBWPCNfwQAGpYEjokdxeqfnv30dKVeiyTDqvTDA57
         tJYm+8cZ1Qv2SQkrshIJiycVct7oulYyttZhTPq09NviBwey7BiEPA+Ak/WGNZZIzZg2
         QwHV5rQiYlpo0OCLxtENRUwE4oEeSjNjwP0HkXfNc+XiL6ewnBC6yc0Nt+C1Mtp+IaBw
         gYn4lFc1ykzX28+EhHZggPc2hQd/mt/HNBn1UjsJvmUGHJPG6g79ij6zetXuEJIVJfDV
         WpRg==
X-Gm-Message-State: AO0yUKUvi/0uMvsgq/mU4dOD3+ht1+5AWhr+0zYDoM/3YSAMmSMHaZiO
        NxlkblY1VaedSv7bzUqBGjKJFw==
X-Google-Smtp-Source: AK7set+DBGNE0cU7kyarjTZodaPg1LsewOJQmmlUqoGRgEFs7ZUUw7tEf5XmIBJ8/sY4WBxI3pQ6dA==
X-Received: by 2002:a17:906:6dd3:b0:878:8249:bef6 with SMTP id j19-20020a1709066dd300b008788249bef6mr24440085ejt.59.1678437327185;
        Fri, 10 Mar 2023 00:35:27 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id zg12-20020a170907248c00b008c76facbbf7sm679116ejb.171.2023.03.10.00.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:35:26 -0800 (PST)
Message-ID: <f76edb9c-a3e9-456d-30c8-bd1af074a0cc@linaro.org>
Date:   Fri, 10 Mar 2023 09:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/21] dt-bindings: display: mediatek: dither: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-4-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-4-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> Display Dither for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

