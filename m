Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0186328EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKUQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiKUQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:01:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C91D289F;
        Mon, 21 Nov 2022 08:01:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id cl5so20548322wrb.9;
        Mon, 21 Nov 2022 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=se+MAs3HPFJjq3A9atUw8nuqmBuPrTQxwBOsSaeeZ/M=;
        b=M01iq+hGiBLlhv4xo7OLt1pSkljmKcyHE42TEXpwR3fT2o7x7AqEchub097biFmD9+
         b78HOhBtRMwWoXgzFWQQwxz2rS0R/bvFz9uMUGv2kv8iOyBBpw7/y93ui20Gm950PjZX
         A5qZoypqyLlUwAGuh4qrHFv3Ds0IDnnRlN2BqB3WNYTSs3+ZoO2Ehojm/uVtcXzaGMuX
         9TPIe9Ja6pFKhH/LA2r7iNMV8sPH7IwBzsh8f0RU8Sgx3tfVFa4mx6y3vDjBJ2GTg74X
         mvGDrO9DF1EZVUEbkeuWjYtCEDBW5Wisvc+P7Sg5SRr48f3c2Rg9gHswAUK5Qg8qjID+
         Ccxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=se+MAs3HPFJjq3A9atUw8nuqmBuPrTQxwBOsSaeeZ/M=;
        b=Zbzj9wWRhxxKroJf5z0igYCLiwY2kmZxBkusPPOl8PQxCuG4TjBB23C8aLYI5XnGfh
         QH9uNU1SnfD/S+JCJiwd6lHJHN/JyClyO4QgpDNuNaPGS7b5M9xm6dhq+/SjymvQBjeq
         +gGlVwcuM5YrB2/ZmzUuu0T0z422DB+xOQQpGoYe2/a9Z7aQme16/vHzINVpzTTECNoq
         Ksh/bpiBROSLqs8rUc/ocWSm2WkV9rUdf6kPpUlWmosXBWW6L+Vi8uXhIEX8fQ/zlrAV
         JpVs7+SVcFM8HDLuxNW/Smr9F49Ttzl/vIZGz0NeIT6bkGHS9jDuPUDwTcc2aRWllrx0
         Svxg==
X-Gm-Message-State: ANoB5pnq/eZ0POnI6mZH06XwzdMI+lmtuoY93yc29ls9IelGhihwO6kp
        fVHLE4ZW39NLVKwyLg+JCxY=
X-Google-Smtp-Source: AA0mqf5gLA5fhDHy2H4OoFEcT5qd8QgZCyHvhnj6qkFS6raf4HRUdXRYP+KL/PjWDptXygZ6jBH97g==
X-Received: by 2002:adf:fb01:0:b0:22e:6556:da75 with SMTP id c1-20020adffb01000000b0022e6556da75mr5941260wrr.653.1669046496228;
        Mon, 21 Nov 2022 08:01:36 -0800 (PST)
Received: from [10.32.3.204] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm20519888wmq.1.2022.11.21.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 08:01:35 -0800 (PST)
Date:   Mon, 21 Nov 2022 19:01:25 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v5 6/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6735 pin controller
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Message-Id: <DIGPLR.WRMNJFUPZ02P3@gmail.com>
In-Reply-To: <1d27a496-b49c-94d5-e9e6-68c81195a69a@collabora.com>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
        <20221118113028.145348-7-y.oudjana@protonmail.com>
        <1d27a496-b49c-94d5-e9e6-68c81195a69a@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 21 2022 at 14:48:58 +01:00:00, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/11/22 12:30, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Add bindings for the pin controller found on MediaTek MT6735 and
>> MT6735M SoCs, including describing a method to manually specify
>> a pin and function in the pinmux property making defining bindings
>> for each pin/function combination unnecessary. The pin controllers
>> on those SoCs are generally identical, with the only difference
>> being the lack of MSDC2 pins (198-203) on MT6735M.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 55 
>> ++++++++++++++++++-
>>   MAINTAINERS                                   |  6 ++
>>   2 files changed, 60 insertions(+), 1 deletion(-)
>> 
> 
> ..snip..
> 
>> @@ -352,18 +391,32 @@ examples:
>>               };
>>                 /* GPIO0 set as multifunction GPIO0 */
>> -            gpio-pins {
>> +            gpio0-pins {
>>                   pins {
>>                       pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
>>                   };
>>               };
>>   +            /* GPIO1 set to function 0 (GPIO) */
>> +            gpio1-pins {
>> +                pins {
>> +                    pinmux = <(MTK_PIN_NO(1) | 0)>;
> 
> Please follow the same format that you can find in all of the
> mtXXXX-pinfunc.h.
> 
> What you wrote here (MTK_PIN_NO(x) | func) is defined in there for 
> the purpose
> of providing a definition name that actually means something (for 
> both readability
> and documentation purposes).
> 
> This means that your GPIO1 set to function 0 (gpio) should be
> 
> 			pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;
> 
>> +                };
>> +            };
>> +
>>               /* GPIO52 set as multifunction SDA0 */
>>               i2c0-pins {
>>                   pins {
>>                     pinmux = <PINMUX_GPIO52__FUNC_SDA0>;
>>                   };
>>               };
>> +
>> +            /* GPIO62 set to function 1 (primary function) */
>> +            i2c1-pins {
>> +                pins {
>> +                    pinmux = <(MTK_PIN_NO(62) | 1)>;
> 
> pinmux = <PINMUX_GPIO62__FUNC_SDA1>; (is it sda1??)
> 
> This means that you should as well add a mediatek,mt6735-pinfunc.h 
> binding...

This is pretty much what I was trying to avoid by doing this. 
Originally I tried to have something similar to qualcomm pin 
controllers which use "pins" and "function" properties (but probably 
with integer values rather than strings) without making any major 
changes to pinctrl-paris or related DT bindings, but it quickly became 
obvious that it wouldn't be possible when looking at how it does things 
currently. pinctrl-moore was better in this aspect, actually making use 
of pin groups to describe how sets of pins have shared functions 
instead of making a group for each pin, and taking "groups" and 
"function" properties. However, it wasn't fully suitable for the 
hardware so I had to stick with pinctrl-paris. At that point I thought 
of this to be the simplest way of doing it. I think it is unnecessary 
to define every single pin-function combination. Yes, doing it this way 
doesn't make it clear what function is being set right away, but a 
quick look at pinctrl-mtk-mt6735.h is all it takes to find out. 
Furthermore, in most cases functions 0 (GPIO) and 1 (primary, pin named 
after it) are the only ones used so knowing the pin names is all it 
takes to figure out the functions.

With all of that being said however, I guess I don't mind following the 
current convention for the time being. The pinctrl subsystem (not just 
mediatek pin controllers) has some of the most inconsistent DT bindings 
from what I've seen, specifically when it comes to specifying pin 
functions, and I think it will end up having some major cleanup down 
the line anyway.



