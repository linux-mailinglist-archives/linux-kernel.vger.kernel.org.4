Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4B5F9DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiJJLsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJJLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:48:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3577199C;
        Mon, 10 Oct 2022 04:47:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23B6966022A5;
        Mon, 10 Oct 2022 12:47:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665402441;
        bh=7tuh7nNoMmOTC8qASx41d6YAap5Q04ANum0eL2sT7cg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K/FhvlBlG72ChQicSlXdO8lwTUkOREPEwjtokn6anOxhxLmFaeEz5VtF9F44pbpwU
         kaQHKZaYgD43S0I0lmkC084+gORg1sNtW7mcHyQD4Cv/pJl/y5dpmskHblM7egL4XK
         WZoUEpORhFb2flqRsO421UkWnJ8EPtuourLcqSwITMhP1FIMEvv54IpzLkK98NfiqC
         hiaZXxtsKV4aX53M/aLzt+COaE7KK0lARzWbkw1Epo/b2/mN5pwtLE+UO3bBxOtG0U
         lCaGiTAzPlF/FVSlx6AMuohJ3YkHGXjV8NsGTz8BCzThnLvn/POE+Ofebr3ooN91sN
         +/nps6Ggx09NA==
Message-ID: <6c889c7e-4c5a-a201-e37c-bf95b6826584@collabora.com>
Date:   Mon, 10 Oct 2022 13:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-6-y.oudjana@protonmail.com>
 <0769c6c8-567d-68c0-323a-9aaee1241e13@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0769c6c8-567d-68c0-323a-9aaee1241e13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/10/22 13:13, Krzysztof Kozlowski ha scritto:
> On 07/10/2022 08:58, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> The document currently states a maximum of 1 interrupt, but the DT
>> has 2 specified causing a dtbs_check error. Replace the maximum limit
>> with a minimum and add per-interrupt descriptions to pass the check.
>>
>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> index 73ae6e11410b..a3a3f7fb9605 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> @@ -47,7 +47,10 @@ properties:
>>   
>>     interrupts:
>>       description: The interrupt outputs to sysirq.
>> -    maxItems: 1
>> +    minItems: 1
>> +    items:
>> +      - description: EINT interrupt
>> +      - description: EINT event_b interrupt
> 
> Is second interrupt really optional or you just wanted to silence the
> warning?
> 

The event_b interrupt exists (and fires on certain events, if configured to do so),
but it's currently unused.

It's really optional.

> Best regards,
> Krzysztof
> 


