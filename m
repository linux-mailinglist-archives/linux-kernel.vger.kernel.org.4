Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875B6944D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjBMLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBMLs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:48:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFB1259F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:48:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso2618100wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pu3bp3zhZ06tjaJugEPKcBoKeuOKXsePEE4SOmhYvEg=;
        b=vpyujYDwtV7b1wUjjoSB89QIgtocHK0d7R2iISp/NW+xQJKywWq2SyNs0ACgPfq8/o
         YZKihy7kF70Fzonplh+saC8upLb/tqcowT60MVU+f9Dfs5fKMtezr/TMyEikE7KIm/F3
         5H+wR/jbmFEUU7/g9q1VIkGmtC/pOEphI0+QSb5L/RqO03gXhNIx6+SjUwqzV3fue12j
         7upIZi8U+sD3ktyz7mSWa0AZVDtHvrQA7Sv9RPpPpqA2X6ELBlt6lbzU99Gx8IIV2GUO
         mUs0NBTALAS2rp5o0uQsePXL0Rc7c+Cbbh0TRfZkiGv1eJj7jbfvbKwNxA7ya2ZaYK+u
         fTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu3bp3zhZ06tjaJugEPKcBoKeuOKXsePEE4SOmhYvEg=;
        b=aC6MXV8ighBzyTCIeZYEq/PET7qW42JGYpBi0IsFFajmNx0klANrvLsCFZX2gsn2A3
         QVwxxEyPBhB6mWYLE8twadwV2V6yABG4ktocc6VZeo8tSV31wy00yb9Rqfbee3g6TtAn
         AdyooVbH++c9NOuiJulXbVASEhVUn0YoqNvihb6alnC0kLJHZUwDC3cUgVqfkJh9VovU
         E0DclImFb2Sj9d42rVnHpVykEegzsKj/R4VUddZ7X+LJU0jYq+wg9f5kQQqHB+MJtE+3
         AFmRB8OHYNvhxKFGK1Vr8oqpByP+2331XmK3Z8FCcGsrmiQOZy8RyvieMvMCHfUq6TPd
         MF/Q==
X-Gm-Message-State: AO0yUKXNmrxUSyEFkUNZturg9cCezc6EwDLJ8JzTJWiTo7Smho7ZFkRM
        wBNXOrj3RM1Y/GmWwaIbA3NPcQ==
X-Google-Smtp-Source: AK7set/MN+9GgY4MfAr54dx3nzP6F0WirBm6MWw/C0HUyZap+4rfR6S8tBbwmDw/B73pn2WThgQLTQ==
X-Received: by 2002:a05:600c:3403:b0:3dc:572f:edb7 with SMTP id y3-20020a05600c340300b003dc572fedb7mr4256036wmp.1.1676288906641;
        Mon, 13 Feb 2023 03:48:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h33-20020a05600c49a100b003dc54eef495sm12887289wmp.24.2023.02.13.03.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:48:26 -0800 (PST)
Message-ID: <daf1686f-9e6f-a2d7-f2f6-0a8467a2c858@linaro.org>
Date:   Mon, 13 Feb 2023 12:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230210161925.32343-1-lujianhua000@gmail.com>
 <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org> <Y+oZOXyE8/a+vreS@Gentoo>
 <ad5dd369-842f-7301-e57d-d0445f0a5268@linaro.org> <Y+oc+kEDoiMsebWF@Gentoo>
 <4055b041-c012-3be6-0aef-085ec389aabd@linaro.org> <Y+ofLDV1nsQ/WUJs@Gentoo>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+ofLDV1nsQ/WUJs@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 12:29, Jianhua Lu wrote:
>>>>>>
>>>>>>> +  resolution of 1600x2560. It is a video mode DSI panel.
>>>>>>
>>>>>> The binding or hardware supports only 1600x2560? The how it can be
>>>>>> "right now"? It's defined, isn't it?
>>>>> Yes
>>>>
>>>> What yes? How it can be "right now"? It implies it will change, so how
>>>> hardware can change?
>>> sorry, my wrong. This binding only support 1600x2560.
>>
>> How binding can support only 1600x2560? How does it exactly work for
>> binding?
> the driver of this binding support 1600x2560 and panels are 1600x2560.

OK, so the driver has limited support. It's not relevant to the binding,
so drop that sentence.

Best regards,
Krzysztof

