Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A25BFB07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIUJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiIUJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:30:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B690C41;
        Wed, 21 Sep 2022 02:30:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hy2so8542429ejc.8;
        Wed, 21 Sep 2022 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date;
        bh=Jr8oE61NhRIq5ZsnsT8b0rg0+Oxtl2j72+/LPlx4O9U=;
        b=TMKQLD+XciKaaTQSYkvB3tJ8eNcp4xWvlqLGsi5r3tIQqHj2qxYrC0WoiDJfaWogCw
         x33dXgcrIMpKRIp7/Zqrx8QlRwgFz+GZcQVN0ArhSdwUlXHpPGoshEaTjPOTcEvvVX6p
         YbO1pHD7FxOCpqLTU8pg9+Xrcxqvp5/OG7MvB0QoFrKLoRnIyeIk8ogaUBdXF9lgpk1P
         7k2Ihf04SW2jzsrcocHj5VWOKHFktP+0r4C1yM9PGmLUopDDE7bB4BF/iE1BrD479DNz
         jq3JVoJC8QMPsPEcknhqMdWKUt8iIWUP4pK+Yk3o1ZH/KFKRHah129vMoQii8nA5I6AL
         Y3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Jr8oE61NhRIq5ZsnsT8b0rg0+Oxtl2j72+/LPlx4O9U=;
        b=zMLFMdESeMcaQ7dl5PoeqmoddMp6wC6Id0CXeJC8fQJfeE/ExK3aiPMPjSpBZCigEE
         KssAMWHKQt9Wrg/wOGKuQ/3jBewy6VnLPYBnFb3PWE13uvROSkgTfF0jgNkyCNxBnEvi
         KCf3eVIqeT7ocb4CqHWEN8o+KPfy9CiOJFB1MNvoPfLR1ohgOGWVeFIA1pn9XlTOL/iz
         iQLmXTuJmUjEXqh4O07RHN4JrV89Da9Y0eZXmDAz+TdRZqJA2As0Esfxr5zulhiwuCZ9
         ei5PTtwxa7gFNpZ4+PVBKN7NjixmMfNzzXv/1eASr60JsfVL1wro2T6SCsUIsseAEKmP
         XnCw==
X-Gm-Message-State: ACrzQf1uoJ9xyvVFP0RpLnyvxrKnZNtkL/JsETur+tFunPrY2HNHk4MS
        FnbYc46NOs1ZpCDJ3rVaH7o=
X-Google-Smtp-Source: AMsMyM4NZ0hTTtsK2z2By1E+T/Uxaefrn9FUpIRfGRW+qR5bcdHeJBDFr5WP1T1tpANx/WVSreO0Jw==
X-Received: by 2002:a17:907:7209:b0:778:e86e:568 with SMTP id dr9-20020a170907720900b00778e86e0568mr20854264ejc.659.1663752649092;
        Wed, 21 Sep 2022 02:30:49 -0700 (PDT)
Received: from [10.31.3.208] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b0078175601630sm1057335ejh.79.2022.09.21.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:30:48 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:30:34 +0300
From:   yassine.oudjana@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Message-Id: <YQZJIR.QQOJU0071T1J1@gmail.com>
In-Reply-To: <1860b0ff-5544-5e74-ccfc-beda18824927@linaro.org>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
        <20220919170115.94873-2-y.oudjana@protonmail.com>
        <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
        <1860b0ff-5544-5e74-ccfc-beda18824927@linaro.org>
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



On Wed, Sep 21 2022 at 09:11:12 AM +0200, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 20/09/2022 10:06, AngeloGioacchino Del Regno wrote:
>>  Il 19/09/22 19:01, Yassine Oudjana ha scritto:
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>> 
>>>  Documents for MT6779, MT6795 and MT6797 that currently exist share
>>>  most properties, and each one has slightly differently worded
>>>  descriptions for those properties. Combine all three documents into
>>>  one common document for all MT67xx SoC pin controllers, picking a 
>>> few
>>>  parts from each and accounting for differences such as items in reg
>>>  and reg-names properties. Also document the MT6765 pin controller
>>>  which currently has a driver but no DT binding documentation. It 
>>> should
>>>  be possible to also include bindings for MT8183 and MT8188, but 
>>> these
>>>  have some additional properties that might complicate things a bit,
>>>  so they are left alone for now.
>>> 
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>  ---
>>>    .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 
>>> ------------------
>>>    .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 
>>> ---------------
>>>    ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 
>>> +++++++++++----
>> 
>>  Hello Yassine,
>>  nice cleanup over here!
>> 
>>  There's a catch though: as far as I know, wildcards are not 
>> permitted... so you
>>  should, at this point, merge all of these in 
>> mediatek,mt6779-pinctrl.yaml instead.
>> 
>>  Before jumping to that, though... Krzysztof, can you please confirm 
>> (or deny)?
> 
> Wildcards are not allowed in compatibles. In filename wildcards or
> family name could work if they are really going to match the devices. 
> I
> have doubts here. 67xx is quite a lot of different devices, so I am 
> not
> sure this will cover them all.
> 
> I would prefer one name (oldest SoC or lowest number).

Lowest number (and probably oldest too but not sure since mediatek 
naming conventions are a bit weird) currently documented is mt6779, but 
mt6765 gets documented in this patch and mt6735 (this one I know for 
sure is older than the rest) in a following patch, so do I just stick 
with mt6779 or do I change it in the following patches documenting 
mt6765 and mt6735?

Thanks,
Yassine

> 
> Best regards,
> Krzysztof


