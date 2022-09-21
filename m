Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1408D5BFCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIUKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIUKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:55:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3990186;
        Wed, 21 Sep 2022 03:55:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 874626602028;
        Wed, 21 Sep 2022 11:55:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663757736;
        bh=9ajDDjf4XIDJ5mfE/Ipbc+msyJHbTMeaxbL2UlQiUpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EelxG/lbMgLGqVhHOXY9iMKIoKj0+8g2oA2/04MqRuA+GZqvKcionDPdLdI7ftcBn
         zFgGYu/xluP4hNHAnta2eIl4iglNpjIfi/lRg98OkwsjP1M29/49T4NxIiI9oMKJXw
         LJ2741FYnxzNeUbycBCP+5H2ipdQ2G73MJF72kNbSu+Xa3nMUYHIH5SkjSqfQxkMBf
         MW2G8d0BCpyASLjAYm6eR/weITAl72bAwmSuGRiQucpHSEctmrTluqfA/SdQ16XLlm
         ya31QFweHxLpOp3sfoHGjwxtCjR8tRBR069YxAYZFaffi8moW0RQFoSwy//SqP9XR0
         bkHCTuaYlyQNw==
Message-ID: <3cab86eb-2c5d-f6ec-a326-e34e63eabb24@collabora.com>
Date:   Wed, 21 Sep 2022 12:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
Content-Language: en-US
To:     yassine.oudjana@gmail.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
 <20220919170115.94873-2-y.oudjana@protonmail.com>
 <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
 <1860b0ff-5544-5e74-ccfc-beda18824927@linaro.org>
 <YQZJIR.QQOJU0071T1J1@gmail.com>
 <0c2ef56e-5dab-fb79-fead-adb4acef4cc6@collabora.com>
 <H82KIR.LT5P242T2PJ72@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <H82KIR.LT5P242T2PJ72@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/22 12:24, yassine.oudjana@gmail.com ha scritto:
> 
> 
> On Wed, Sep 21 2022 at 11:45:41 AM +0200, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 21/09/22 11:30, yassine.oudjana@gmail.com ha scritto:
>>>
>>>
>>> On Wed, Sep 21 2022 at 09:11:12 AM +0200, Krzysztof Kozlowski 
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> On 20/09/2022 10:06, AngeloGioacchino Del Regno wrote:
>>>>>  Il 19/09/22 19:01, Yassine Oudjana ha scritto:
>>>>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>>>
>>>>>>  Documents for MT6779, MT6795 and MT6797 that currently exist share
>>>>>>  most properties, and each one has slightly differently worded
>>>>>>  descriptions for those properties. Combine all three documents into
>>>>>>  one common document for all MT67xx SoC pin controllers, picking a few
>>>>>>  parts from each and accounting for differences such as items in reg
>>>>>>  and reg-names properties. Also document the MT6765 pin controller
>>>>>>  which currently has a driver but no DT binding documentation. It should
>>>>>>  be possible to also include bindings for MT8183 and MT8188, but these
>>>>>>  have some additional properties that might complicate things a bit,
>>>>>>  so they are left alone for now.
>>>>>>
>>>>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>>>  ---
>>>>>>    .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 ------------------
>>>>>>    .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ---------------
>>>>>>    ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 +++++++++++----
>>>>>
>>>>>  Hello Yassine,
>>>>>  nice cleanup over here!
>>>>>
>>>>>  There's a catch though: as far as I know, wildcards are not permitted... so you
>>>>>  should, at this point, merge all of these in mediatek,mt6779-pinctrl.yaml 
>>>>> instead.
>>>>>
>>>>>  Before jumping to that, though... Krzysztof, can you please confirm (or deny)?
>>>>
>>>> Wildcards are not allowed in compatibles. In filename wildcards or
>>>> family name could work if they are really going to match the devices. I
>>>> have doubts here. 67xx is quite a lot of different devices, so I am not
>>>> sure this will cover them all.
>>>>
>>>> I would prefer one name (oldest SoC or lowest number).
>>>
>>> Lowest number (and probably oldest too but not sure since mediatek naming 
>>> conventions are a bit weird) currently documented is mt6779, but mt6765 gets 
>>> documented in this patch and mt6735 (this one I know for sure is older than the 
>>> rest) in a following patch, so do I just stick with mt6779 or do I change it in 
>>> the following patches documenting mt6765 and mt6735?
>>>
>>
>> I see the sequence as:
>>
>> 1. You merge mediatek,mt6797-pinctrl.yaml into mediatek,mt6779-pinctrl.yaml; then
> 
> And mediatek,pinctrl-mt6795 gets merged here too I assume?
> 

Yeah sorry about forgetting that one. Anyway, obviously, do one merge operation
per commit!


>> 2. Adding MT6765 documentation to mediatek,mt6779-pinctrl.yaml; then
>> 3. Adding support for MT6735, documentation goes again to 6779-pinctrl.
>>
>> This means that you're working with mediatek,mt6779-pinctrl.yaml :-)
>>
>> P.S.: That was also a suggestion about how to split things per-commit!
>>
>> Cheers,
>> Angelo
>>
>>> Thanks,
>>> Yassine
>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>>
>>
> 
> 


