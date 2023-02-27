Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B3D6A3E10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjB0JPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0JPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:15:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335DD265B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:08:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso3350853wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+3pF92mSwYUhZy9VRH+vsVoYv/M6+lCoICkuRbVNPs=;
        b=tUj0g530f3WAX6zMkiIob+nD3+znuJH4ZEokLzpC9j0yMozZ+6j4xtIysbReCzryyc
         hmmVw4LwVO+K2a0x1sTkTF1fmfE7o06O02wHgNXEbAptfuXSch+ew/MNWqFtFEqGjZME
         90gBrUhTclwaxlicifCU9E18i2aLswra3wMOB/JnZynfRBKWyhuWhcF0L9VxuOVNIjCX
         7dzuvotjWXMRGOXquSEyEZ4ZRCo9Nvr3imV6Ng+aEVPMc8H7BwkiFuARGkHaLyCkP0tc
         M3xt61M+nC6QnKYIqM1x01Kt5ENmULXB0+NHnhZv0XgFfCES6v8uQkeKHYCpfE5GMcxA
         oyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+3pF92mSwYUhZy9VRH+vsVoYv/M6+lCoICkuRbVNPs=;
        b=xGatfXQVS5tywIYJJPG2cK1qCMBaM6JMsmMhG/qxhA050k5XRXnVjEhf25ptNxCALj
         36ixFJOiuJV+O470tl5Grclqiof0e1LxlTnIBIs/4SJdjLH0R9sSO0/tmrRNXybQeyLu
         dMuXIqIJhOinDoB12U7OogYeEbJxlKHfUCt5zdCElKWASr0lMKnmnoXPzMVvcEdWIOSs
         Ex7SLeihJ0cRYCXDwssKUEjfF7QX+XBa3l86DRGoJZM3QByHzJ7YijLkikQ4PyzT2lzu
         WsxPromlR15lM7X42n1cA6et/jc5mKeLlo67I+rR6OFKc9BnrcHhwZtm2PNOqzd6xy/5
         z4Gw==
X-Gm-Message-State: AO0yUKV+laL1ludmmr5g39kKHQYYbjLtI+buFbhHQ8xEabhom0rRbPsZ
        lYmh2nsEisxcxf8znTjXWXBjHA==
X-Google-Smtp-Source: AK7set+CgWk1B+qEbO2S6zEfsqUjUh/9Lug+Zx2H+A7mNnO3xd751GxZ8Zsy42rsWWaEMswByX9LgQ==
X-Received: by 2002:a05:600c:4e12:b0:3eb:3998:8bca with SMTP id b18-20020a05600c4e1200b003eb39988bcamr3861828wmq.17.1677488903422;
        Mon, 27 Feb 2023 01:08:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm13368751wms.18.2023.02.27.01.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:08:23 -0800 (PST)
Message-ID: <d2e43fe8-2072-6723-dbb4-500a6ff8f719@linaro.org>
Date:   Mon, 27 Feb 2023 10:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: Add MediaTek MT6735 clock
 bindings
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
 <20230225094246.261697-2-y.oudjana@protonmail.com>
 <52d479ff-14c6-b65d-952b-e7753fee2dea@linaro.org>
 <2XCQQR.YSBPBN01H6D31@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2XCQQR.YSBPBN01H6D31@gmail.com>
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

On 27/02/2023 09:29, Yassine Oudjana wrote:
> 
> On Mon, Feb 27 2023 at 09:18:45 AM +01:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 25/02/2023 10:42, Yassine Oudjana wrote:
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  Add clock definitions for the main clock controllers of MT6735 
>>> (apmixedsys,
>>>  topckgen, infracfg and pericfg).
>>>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  Acked-by: Rob Herring <robh@kernel.org>
>>>  ---
>>>   MAINTAINERS                                   | 10 +++
>>>   .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
>>>   .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
>>>   .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
>>>   .../clock/mediatek,mt6735-topckgen.h          | 79 
>>> +++++++++++++++++++
>>>   5 files changed, 167 insertions(+)
>>
>> You should squash it with other part of binding. What is the reason
>> behind splitting one binding into three patches?
> 
> It seemed logical to me that each of clock and reset bindings as well 
> as documentation would be separate parts especially since they go in 

I don't understand. All of these are bindings. What do you mean by
"documentation"?

> different paths, but if combining them is how it's done then sure, I'll 
> squash them and resend.

They cannot go different paths and your submissions creates false
impression they can. If you want to see - apply these on separate
branches and test if: driver compiles and paths to files in doc are not
broken. Answer: driver won't compile and paths will point to
non-existing files.


Best regards,
Krzysztof

