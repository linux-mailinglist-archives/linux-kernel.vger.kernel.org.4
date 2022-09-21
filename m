Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625E5BFAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiIUJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiIUJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:25:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D574E1A;
        Wed, 21 Sep 2022 02:25:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l14so12195255eja.7;
        Wed, 21 Sep 2022 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date;
        bh=IE/lUB9GeFJ3cgcWCczdBLBsp8zcC8CA4nMsFXJExts=;
        b=o1HmafZL8GjyvYOix7SJfx4WJKUR1Bc7OAqttjJ9T0N/Yj/KoCu+7CIoTFiNKbmSRl
         GO0O9hT6LMnktP8nnM6SrQl4A4F5EzaFjoovPZeVJiVfKsmcFeu4oLmMC0ZR01q5wQqX
         9lVBRxxeTKxqXZUHu9XOp+D4p+wdTaqhH2F4wU3KbjMjMlqIEAfpaH+iynNW9GCZ7xDX
         jE31ceI38vQe8l90z6zWIFTXMkTCGGzfSfcprfmByYV+SOclJHxiRa88je+R/VF2OE/r
         jm5a75DhyMjEevwPb8xnQSSOogPe+GjqvLNVzzr1+NYuWUoBpTOE8cuesEXbByZ1ddT1
         9cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IE/lUB9GeFJ3cgcWCczdBLBsp8zcC8CA4nMsFXJExts=;
        b=IPWfPr07qHEqQMppmtaQwJeBrm22Xh6VB1BVHH3iCydWIflrtjNI7V4a5uuSsTWFLf
         M3FMHmxpG3IlK/TXFwXpeGuwNPQ4HgxpdNgxuN9pg8TsFGPLqnJkNb5cxpgh8zWR+ySv
         qslGGG/GTxjCq9ZvQbyZiR85xAkU2p+OKJPvkYpQmOdKwHXWwojIlgoEUrUuWLymwC36
         XsFcXR7GDveQwo08JBqV7SdBNgP04Yeu6LM9kUxsh5oz9UGchhCSzK4gPb5MCorpS9PC
         U4yKwqR3Wso1c1MYgmjcAiE2r0dLjrPWQVW8O7LIVDQn7ohRhcm7U9MunBJoEuhTBnql
         35fA==
X-Gm-Message-State: ACrzQf35WiOH2KmxAAI7gTkwrd387ko/p3jn1EnKaCmKuhiHLVqFNMQG
        yCyADXFQmODzhVmuWltsj6A=
X-Google-Smtp-Source: AMsMyM5aVGhWkOnNJmsBsfyVgjUfb2jYAdOqzt7epbBXN3MqtxhZqf/7Xfo/k1tguHf3FwqbXbSahQ==
X-Received: by 2002:a17:907:a044:b0:770:da0d:171d with SMTP id gz4-20020a170907a04400b00770da0d171dmr19485416ejc.742.1663752335121;
        Wed, 21 Sep 2022 02:25:35 -0700 (PDT)
Received: from [10.31.3.208] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072b3406e9c2sm1053996eja.95.2022.09.21.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:25:34 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:25:20 +0300
From:   yassine.oudjana@gmail.com
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <8IZJIR.7AG9DG7U1XLJ@gmail.com>
In-Reply-To: <b567fb19-460c-ea1f-4c84-0724e73052fd@linaro.org>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
        <20220919170115.94873-2-y.oudjana@protonmail.com>
        <b567fb19-460c-ea1f-4c84-0724e73052fd@linaro.org>
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


On Wed, Sep 21 2022 at 09:20:43 AM +0200, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 19/09/2022 19:01, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Documents for MT6779, MT6795 and MT6797 that currently exist share
>>  most properties, and each one has slightly differently worded
>>  descriptions for those properties. Combine all three documents into
>>  one common document for all MT67xx SoC pin controllers, picking a 
>> few
>>  parts from each and accounting for differences such as items in reg
>>  and reg-names properties. Also document the MT6765 pin controller
>>  which currently has a driver but no DT binding documentation. It 
>> should
>>  be possible to also include bindings for MT8183 and MT8188, but 
>> these
>>  have some additional properties that might complicate things a bit,
>>  so they are left alone for now.
>> 
> 
>>   properties:
>>     compatible:
>>  -    const: mediatek,mt6795-pinctrl
>>  +    oneOf:
>>  +      - enum:
>>  +          - mediatek,mt6765-pinctrl
>>  +          - mediatek,mt6795-pinctrl
>>  +          - mediatek,mt6797-pinctrl
>>  +      - items:
>>  +          - const: mediatek,mt6779-pinctrl
>>  +          - const: syscon
> 
> No, this is not like old bindings at all. It's not merging, it's a
> change sneaked inside huge diff. Also - probably totally untested on 
> DTS
> (or old bindings were broken).


Actually this change was made specifically so that it remains (probably 
becomes?) compatible with existing DTS and passes checks. mt6779.dtsi 
currently has the syscon compatible string but it wasn't listed along 
with mediatek,mt6779-pinctrl in the old document, but instead there was 
something in the description about putting the pinctrl node under a 
syscon node, which isn't the case in the existing DTS. This patch 
passed both dt_binding_check and dtbs_check. Anyway, I see how I failed 
to describe this change, so I'll go through the patch again and try to 
find any other small changes I might've made and forgotten about, and 
either put them in separate patches or describe them in the commit 
message, whichever one you think is better. Also, do I make those 
changes in the original documents then combine or combine first then 
make them in the new one?

Thanks,
Yassine

(Sorry for the spam, my client was misconfigured so it previously sent 
HTML instead of plain text.)

> 
> That's a no-go.
> 
> Best regards,
> Krzysztof


