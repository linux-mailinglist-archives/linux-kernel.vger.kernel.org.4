Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513575FB01A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJKKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJKKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:03:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433D80F6C;
        Tue, 11 Oct 2022 03:03:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ECBB16601A43;
        Tue, 11 Oct 2022 11:03:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665482619;
        bh=YFompAbEZpl5sUt2ZzyaB7q3wd5uHfsTnGM53GDNAE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fsEDbvlwrzvonnlugI5t2jEPPiJ3djT16/VaLCIBCgmVXCBkHRhKCVmnX6UOvnVSW
         uSySuM70tuWkkX6z06E2/vWsI+OLDfI9TngpoNo27Hl9tDFPoaXIIxJajIRHf5lelm
         CTQdQlHFZ3BL1jQbFPQB/YRTcpqgNaWYhZ+dPMq9GZf/vCzL4er0kKVP6uqVk5EtU1
         EUx9LTZLbpxtIoQ9v2IIaVv3M8bkNbO6yaLpTgL2VZXPPiDmnCKHlX0WEwl250w5vD
         rblGws+K8gSYXtuW3Z9kGlh0k2YsNqviYKaYT6QWtUtt4h5rCvGVJ9H55xkfvGberZ
         i5ImRbq1FR9bA==
Message-ID: <4ffd76b2-92bc-4c56-a520-960ea8635cd4@collabora.com>
Date:   Tue, 11 Oct 2022 12:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-6-y.oudjana@protonmail.com>
 <0769c6c8-567d-68c0-323a-9aaee1241e13@linaro.org>
 <6c889c7e-4c5a-a201-e37c-bf95b6826584@collabora.com>
 <20221010125758.GA468288-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221010125758.GA468288-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/10/22 14:57, Rob Herring ha scritto:
> On Mon, Oct 10, 2022 at 01:47:18PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 10/10/22 13:13, Krzysztof Kozlowski ha scritto:
>>> On 07/10/2022 08:58, Yassine Oudjana wrote:
>>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>
>>>> The document currently states a maximum of 1 interrupt, but the DT
>>>> has 2 specified causing a dtbs_check error. Replace the maximum limit
>>>> with a minimum and add per-interrupt descriptions to pass the check.
>>>>
>>>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>> ---
>>>>    .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>>> index 73ae6e11410b..a3a3f7fb9605 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>>> @@ -47,7 +47,10 @@ properties:
>>>>      interrupts:
>>>>        description: The interrupt outputs to sysirq.
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - description: EINT interrupt
>>>> +      - description: EINT event_b interrupt
>>>
>>> Is second interrupt really optional or you just wanted to silence the
>>> warning?
>>>
>>
>> The event_b interrupt exists (and fires on certain events, if configured to do so),
>> but it's currently unused.
>>
>> It's really optional.
> 
> Optional for DT means may or may not be wired up in the h/w, not what
> some OS 'currently' uses.
> 
> However, you can't really add new required properties or entries to an
> existing DT without breaking compatibility. Maybe that is not yet a
> concern.
> 

Right. I don't think that compatibility is a concern in this case anyway, but I
just noticed that this commit has no Fixes tag, even though it is indeed fixing
the binding, as mt6795 does have this interrupt and its devicetree does already
define the second interrupt in the pinctrl node.

Yassine, can you please resend this with a Fixes tag?

Fixes: 81557a71564a ("dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings")




