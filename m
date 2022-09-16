Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED86D5BABA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIPKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiIPKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:50:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70B6169
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:29:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso15606696wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lEm28T4aiukFj/jkOyJ/N1z4ZyJd8w2mvne3ZnFiHNg=;
        b=IEN8i+yAPd/f+hsdfXcFUDKh+gFqVy3qWI5xvBGkd73lTfZdOGaOjQzcLHtFGQQHVY
         jpbgZgOW/d7e4SUl2JBvJtkrKYgrdfdFbhIT32ecCqkpM1B5v14m5UKK3LOXMmqDYHGB
         TtKvW0kBBcIKKTQz/9ruHl4Jb5ooMEOY5agR/5jHPPEwU17PfCaJjN8qZyBzlLMQf3aQ
         7sx39Jss0gVpzP/pYJ5MnJ5W/YczeGkBPu+V0iljyYa9u91zQOYR2iCwI7IjRyORxnQz
         Z9oBOEJW1DDlyEnju0EZxtxCb0oxbZSXyRzM2Hw+K42JBQ1oNA72wpCERFFhPH3u3YuY
         yilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lEm28T4aiukFj/jkOyJ/N1z4ZyJd8w2mvne3ZnFiHNg=;
        b=azIcxZ1CPYGSRTWSWKXu6jZQirP37fa2tr8f/LgBeW0DIOUlfMsKQUAKQBCE6ZNLeh
         DYimHiWPe01kF9D3PP2imx48NXAbIoR+9R3DQanWRkHUdoPQCmEHX5Zh/sLrlWqTNIHn
         X8qxXO8pbf64qU5iajjB6XuBfMoqbYZOiUpWkitX5lmogtA2vc+7JOC8LqZHUCN86THZ
         LIqczBmxQtS5KXtvsgn0RT34eojH1dJT2fH3nl43vr06TH6jjyVcrADQDUPyn8LoGJ8K
         vDw3V19JAw44H6evqY9CYrFcyJciVJlonXro/RgPSkk3zq9Ea57oMqxZiMbCbspD3Jdb
         kD2g==
X-Gm-Message-State: ACgBeo2bepafbuOCHgJKFfIpY+IpD5UbZPYirXtUNmmmhwTYKA0NIhPi
        wl0sBVq0SNtS9t5nzV9Kde2dbw==
X-Google-Smtp-Source: AA6agR4GhmwLDzJhDGKWyU6qvAUsmcDKMpVKTynu1xNvIu9OwasG3Ddi3IpZk2qTkIBvVxJT59oYqw==
X-Received: by 2002:a05:600c:3493:b0:3b4:9a0e:b691 with SMTP id a19-20020a05600c349300b003b49a0eb691mr9691352wmq.123.1663324111900;
        Fri, 16 Sep 2022 03:28:31 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d4c8d000000b0021f131de6aesm4553655wrs.34.2022.09.16.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 03:28:31 -0700 (PDT)
Message-ID: <7a01b1cc-6d00-715c-1e21-b8836a64a9a0@linaro.org>
Date:   Fri, 16 Sep 2022 11:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dt-bindings: ov5645: Convert OV5645 binding to a
 schema
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220913160224.14951-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220914214132.GA2173@tom-ThinkPad-T14s-Gen-2i>
 <CA+V-a8ufbsiz3p2n3LmYxES2aJYN9y8byF9bSyckNFz=fB-5LQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8ufbsiz3p2n3LmYxES2aJYN9y8byF9bSyckNFz=fB-5LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 11:24, Lad, Prabhakar wrote:
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - clock-frequency
>>> +  - vdda-supply
>>> +  - vddd-supply
>>> +  - vdddo-supply
>>> +  - enable-gpios
>>> +  - reset-gpios
>>> +  - port
>>
>> I think we don't need all of these properties as required.
>> The only "really" required are:
>>
>>   - compatible
>>   - reg
>>   - clocks
>>   - port
>>
> Agreed, it's just the driver requirement hence the previous bindings
> had marked them as required.

Please mention the change from pure conversion (with reason) in the
commit msg.


Best regards,
Krzysztof
