Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6578654E64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLWJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiLWJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:29:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B637233;
        Fri, 23 Dec 2022 01:28:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0F4C6602CE0;
        Fri, 23 Dec 2022 09:28:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671787737;
        bh=HMLMMep+mcr89+itvPl0BOj1Xg+OhOyXlyh2zXtaR5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=brejs5DLGzFiWPzayUdJwPiSDH5WJUJB3VeuSuz2fvhsfXTAKhUF1zSYlsTfE4jww
         w6k1k54mM7TNZiTWWA4L0BN2OTVP5ontwkm/KSMq7sqyfX6HvCkj3EfzarEnOIyKMU
         8G9UumpxeoWpXVbzMUBnPExW9Cke8DdxuVK4Iy3eZ0OvEzh4qEnCF0lyc7z+GVLqNe
         XN0YjSK3uN70e7jQrH4kQXeWUGviFiAZ2GOP4gijKj2dtVzm50r+k7GYwjUji5Hyti
         EFJxUN3LeJwEd/Bkj6FGBw6eIxtGT0NtYfNgAHpSsmJuy554PNbkvp8rvIldtlRixa
         eobv4Zotx0ZvQ==
Message-ID: <a9f9a86d-459e-314d-446e-e24b5ee469fe@collabora.com>
Date:   Fri, 23 Dec 2022 10:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 08/25] dt-bindings: clock: mt8173: Add dummy clock ID
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
 <20221222114857.120060-9-angelogioacchino.delregno@collabora.com>
 <869ae494-d74e-03a0-3622-b3a2b0b10470@linaro.org>
 <960b0707-f0e5-993b-3706-a7a275e0698f@collabora.com>
 <46edd627-c128-b979-823f-0a94fe9d425b@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <46edd627-c128-b979-823f-0a94fe9d425b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/12/22 10:26, Krzysztof Kozlowski ha scritto:
> On 23/12/2022 10:21, AngeloGioacchino Del Regno wrote:
>> Il 23/12/22 09:52, Krzysztof Kozlowski ha scritto:
>>> On 22/12/2022 12:48, AngeloGioacchino Del Regno wrote:
>>>> Some old MediaTek clock drivers are starting the clock count (so, the
>>>> clock ID) from one instead of zero and this is logically incorrect,
>>>> as we should start from 0.
>>>> During a cleanup an issue emerged due to that and the cleanest and
>>>> shortest way to keep devicetree backwards compatibility while still
>>>> performing the well deserved cleanup is to add a dummy clock where
>>>> needed, with ID 0.
>>>
>>> Unfortunately I do not understand at all why adding dummy (fake) ID
>>> cleans anything here. Unifying IDs to start from 0 is not an argument on
>>> DT bindings header IDs.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>
>> All clocks are in one or multiple arrays, and if we don't register ID 0,
>> devicetrees will reference the wrong clock, as the IDs will shift back by
>> one during registration.
> 
> So what stops you to register some 0-dummy clock? Why do you need a
> binding for it?
> 
>> This was done for a commonization of probe() and remove() callbacks for
>> MediaTek clock drivers... since we have 3 affected SoCs (MT8173, MT2701
>> and MT6779) out of *19* (soon 20), to me, it didn't make sense to write
>> commonized code to address this just because of 3 out of 20 SoCs (note
>> that each SoC has around 4 clock drivers).
>>
>> Any suggestion to keep this one short, while not touching dt-bindings?
> 
> Just add a clock or better empty entry in your table, without touching
> bindings.
> 


Okay, now that's embarassing - that's a simpler and obvious solution I
should've thought of before sending this series. Heh.

Thanks, by the way!

Regards,
Angelo
