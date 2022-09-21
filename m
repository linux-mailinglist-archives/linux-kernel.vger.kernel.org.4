Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C25BFC44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIUKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIUKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:24:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AD6252;
        Wed, 21 Sep 2022 03:24:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd10so4169909ejc.2;
        Wed, 21 Sep 2022 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date;
        bh=eIhhSNSnUwxjgTPYFm7S/0hwWM40o8GyyO97/j15IFg=;
        b=G9WT/UQGubvNFxWnL/o0yleoSM08Bw5rZ4oh9Cq8Ws4o55wR8QFPHLGZ4OBwtduVI0
         XuHnrt1+SQYDZldS/SUXodcrWAV8VoFl0Ls3Fyyw9e1IYCRgEcgJnXRKQgddXfzHo+uD
         XHP46DejS8sOitBMxgt0bOF/fuYRJvPtdkT8C+lFeka4OzXVamcrsXCwHlhVdrpXcZdo
         xlP6cWNEfYGat8SUOKeJmZri5hDkfNZr3Z1yICMNHkBwQeC5lE3M1ST84thcZg9sdPVl
         CYRoerTu4l7icXsMiZ5wKUznCNpk6TeFnmzMSDUAP+eFeNmNhrP2Y4eMnBsKy97cWQ3U
         q1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=eIhhSNSnUwxjgTPYFm7S/0hwWM40o8GyyO97/j15IFg=;
        b=QEIaJnS3CJ9exfBuUih3pRF28mJyudIFOjrPKaMoPFvy7feczar7XZyGlXjzOahX54
         2/oFzaHOJTBSYJqM833KswEf9bVPHod+HTuSWQxhfN/7OjQWOefuITt88KBhHknc/MQ9
         UsCOfkYdYHq12Nd53joL08zROya8UPs4NunFDNlxOaqcsBZtRaMDpzqyzbXKWbeWMPww
         WRqkXQLpYNlPKt4Ys981CQMyyQdLYzVm5Yk13HaH65ogEsTKKYo+6+8zPGVCw3yhU15h
         EGkMKZoRn/4HAuJrGRCvOxWt5iPB16WB9rPYzPOJ5R/OLKG7UQZy+bD1CuTia2oa0tmd
         Xyww==
X-Gm-Message-State: ACrzQf0wY0hXNa9STX6UAjgnVyM5fPShcy1rLodBWzrUXXlUgCehK+DD
        ewzMeTpdORn4gx7/X4SCgL0=
X-Google-Smtp-Source: AMsMyM4/tQ/3iyKx28lNFLOxL9B4PbS2w3ASNsuN7lnWPKZ9DR/VYhQRB6uyEMozzstJbV/bbVLkzA==
X-Received: by 2002:a17:906:6a0b:b0:77d:2f20:69db with SMTP id qw11-20020a1709066a0b00b0077d2f2069dbmr19074694ejc.572.1663755872843;
        Wed, 21 Sep 2022 03:24:32 -0700 (PDT)
Received: from [10.34.6.160] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id fc24-20020a1709073a5800b0077b523d309asm1070024ejc.185.2022.09.21.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:24:32 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:24:17 +0300
From:   yassine.oudjana@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
Message-Id: <H82KIR.LT5P242T2PJ72@gmail.com>
In-Reply-To: <0c2ef56e-5dab-fb79-fead-adb4acef4cc6@collabora.com>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
        <20220919170115.94873-2-y.oudjana@protonmail.com>
        <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
        <1860b0ff-5544-5e74-ccfc-beda18824927@linaro.org>
        <YQZJIR.QQOJU0071T1J1@gmail.com>
        <0c2ef56e-5dab-fb79-fead-adb4acef4cc6@collabora.com>
X-Mailer: geary/40.0
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



On Wed, Sep 21 2022 at 11:45:41 AM +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 21/09/22 11:30, yassine.oudjana@gmail.com ha scritto:
>> 
>> 
>> On Wed, Sep 21 2022 at 09:11:12 AM +0200, Krzysztof Kozlowski 
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 20/09/2022 10:06, AngeloGioacchino Del Regno wrote:
>>>>  Il 19/09/22 19:01, Yassine Oudjana ha scritto:
>>>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>> 
>>>>>  Documents for MT6779, MT6795 and MT6797 that currently exist 
>>>>> share
>>>>>  most properties, and each one has slightly differently worded
>>>>>  descriptions for those properties. Combine all three documents 
>>>>> into
>>>>>  one common document for all MT67xx SoC pin controllers, picking 
>>>>> a few
>>>>>  parts from each and accounting for differences such as items in 
>>>>> reg
>>>>>  and reg-names properties. Also document the MT6765 pin controller
>>>>>  which currently has a driver but no DT binding documentation. It 
>>>>> should
>>>>>  be possible to also include bindings for MT8183 and MT8188, but 
>>>>> these
>>>>>  have some additional properties that might complicate things a 
>>>>> bit,
>>>>>  so they are left alone for now.
>>>>> 
>>>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>>  ---
>>>>>    .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 
>>>>> ------------------
>>>>>    .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 
>>>>> ---------------
>>>>>    ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 
>>>>> +++++++++++----
>>>> 
>>>>  Hello Yassine,
>>>>  nice cleanup over here!
>>>> 
>>>>  There's a catch though: as far as I know, wildcards are not 
>>>> permitted... so you
>>>>  should, at this point, merge all of these in 
>>>> mediatek,mt6779-pinctrl.yaml instead.
>>>> 
>>>>  Before jumping to that, though... Krzysztof, can you please 
>>>> confirm (or deny)?
>>> 
>>> Wildcards are not allowed in compatibles. In filename wildcards or
>>> family name could work if they are really going to match the 
>>> devices. I
>>> have doubts here. 67xx is quite a lot of different devices, so I am 
>>> not
>>> sure this will cover them all.
>>> 
>>> I would prefer one name (oldest SoC or lowest number).
>> 
>> Lowest number (and probably oldest too but not sure since mediatek 
>> naming conventions are a bit weird) currently documented is mt6779, 
>> but mt6765 gets documented in this patch and mt6735 (this one I 
>> know for sure is older than the rest) in a following patch, so do I 
>> just stick with mt6779 or do I change it in the following patches 
>> documenting mt6765 and mt6735?
>> 
> 
> I see the sequence as:
> 
> 1. You merge mediatek,mt6797-pinctrl.yaml into 
> mediatek,mt6779-pinctrl.yaml; then

And mediatek,pinctrl-mt6795 gets merged here too I assume?

> 2. Adding MT6765 documentation to mediatek,mt6779-pinctrl.yaml; then
> 3. Adding support for MT6735, documentation goes again to 
> 6779-pinctrl.
> 
> This means that you're working with mediatek,mt6779-pinctrl.yaml :-)
> 
> P.S.: That was also a suggestion about how to split things per-commit!
> 
> Cheers,
> Angelo
> 
>> Thanks,
>> Yassine
>> 
>>> 
>>> Best regards,
>>> Krzysztof
>> 
>> 
> 


