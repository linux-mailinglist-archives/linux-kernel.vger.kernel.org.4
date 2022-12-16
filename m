Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993664EC00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiLPNSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLPNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:17:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5CA646D;
        Fri, 16 Dec 2022 05:17:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h10so2478590wrx.3;
        Fri, 16 Dec 2022 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2r40LSZ/+/ZAU+L6Fli/YpabKQRcmpXucebZ+SCfPdk=;
        b=m4oNL4yKToYAtLq7BehnRnVmnCHOJAdX8n/A6r+w9r8UdYC32p/5sg/ZtCUyLrH6Rz
         f8ZEeQIMoSWbJV6Ivu79OUF9oD5rMQKCXflo/na25jXo34TTtnWWQrIsU4kiMcP2xkC9
         dI69R1EZf+ma2kwCGLyi74913VBgeb/20I9IW3nIZiCLKNL/9EC0pgBSuhdhuN5GTTII
         W1dcmtj60I5n95TrzYGNw1Et6Z44OvfxoK7uST5BFd6MCJIS408DYA/O5RtvPPGqpxTk
         cZWv2bPsfMROKhrPz0gqMJ2a+uq8eWPHY/FfbQ94um6eUVyS4XocRSQuKC5GCcZSNYWs
         xTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r40LSZ/+/ZAU+L6Fli/YpabKQRcmpXucebZ+SCfPdk=;
        b=IaSl/QsxTNYtyK5WUiEbE952jG1FPa9bsAs0/xTQPSKQ+yc+MQvbsG37Y+g6yuzo4v
         UJHYqIN577f6miWYMICFyBT7fUbaiccyZkhXf5G4ohgzMzuJm4Clh9r6JrxAMP+5UqDv
         aid7K9wMyfZIzBIJD/rB8piIu96FjuImlcQCsvxbqw727fzh5wpmTvTWxNQxzVN+5tw0
         KgAslv/U+qev6amYr64dtFRxQTEYYHX02vS1/RL2ddW77KFb9nFQPIA2meKTdNZ8P/+8
         o9HdNm7Q3flELp/mHY0BFdZbqu6S4kJ9zF9VWyO6oH7jpR57hDITEeUC6+7P+HM0ER+e
         6mrg==
X-Gm-Message-State: ANoB5plbyv8Rwh+mkyE33il8uoz5TLA04L3LSRuTK++bJWA2SF3SFt/F
        rb+9wmH7EVjUyvaSCdP/86M=
X-Google-Smtp-Source: AA0mqf7g8RulHms7mAUgqAkszLKw5bIQ5cri/X2jVfUUUr/6n4r1sBEvqj9oEdJRfP+kSloFbuFYTg==
X-Received: by 2002:a5d:67c6:0:b0:242:6c24:af20 with SMTP id n6-20020a5d67c6000000b002426c24af20mr19469107wrw.56.1671196676742;
        Fri, 16 Dec 2022 05:17:56 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ba12-20020a0560001c0c00b002549b649b62sm2315488wrb.50.2022.12.16.05.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:17:55 -0800 (PST)
Message-ID: <05d6f9e6-a291-35c3-9b02-2235ad92669d@gmail.com>
Date:   Fri, 16 Dec 2022 14:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH resend] arm64: dts: mediatek: mt8192: Mark scp_adsp clock
 as broken
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
References: <20221130031741.3176853-1-wenst@chromium.org>
 <2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com>
 <CAGXv+5E=X_hwg76=B_jqWrpieo8bR-=r8NLbNz2=JzE=kBwMWQ@mail.gmail.com>
 <8806f4cf-2141-acb8-1f9d-cd6ade64756e@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <8806f4cf-2141-acb8-1f9d-cd6ade64756e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2022 10:02, AngeloGioacchino Del Regno wrote:
> Il 01/12/22 09:56, Chen-Yu Tsai ha scritto:
>> On Wed, Nov 30, 2022 at 7:10 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 30/11/22 04:17, Chen-Yu Tsai ha scritto:
>>>> The scp_adsp clock controller is under the SCP_ADSP power domain. This
>>>> power domain is currently not supported nor defined.
>>>>
>>>> Mark the clock controller as broken for now, to avoid the system from
>>>> trying to access it, and causing the CPU or bus to stall.
>>>>
>>>> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>
>>> ....or we can add the ADSP power domain to actually fix this properly, which 
>>> looks
>>> like being a generally good idea :-)
>>
>> Sure, but that and any driver changes have to be backported, or anything
>> touching the clocks will still break the system.
>>
> 
> I agree.
> 
>> There's no reason we can't have both. I think having this one merged and
>> backported to stable first, then adding the SCP_ADSP power domain, and tying
>> it to the clock controller as a follow up addition works best.
>>
>> What do you think?
>>
> 
> I think that one reason to not have both is that we'd have to revert this commit
> after the SCP_ADSP power domain is added (with the appropriate Fixes tags and/or
> Cc stable)...
> 
> I'd expect that entire addition to be no more than 3 commits, including the dtsi
> one... and if it comes out as I expect, we'd be solving that issue on all of the
> affected older versions of the kernel - the right way.
> 
> Can we wait for... let's say, a day or two to check how that works, before taking
> a final decision on this commit?
> 

Do I understand correctly that the correct way for now is to merge this patch 
until we have a fixed the power domain controller?

Regards,
Matthias
