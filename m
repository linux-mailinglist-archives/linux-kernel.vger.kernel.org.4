Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6D5E99A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiIZGgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiIZGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798F1EAE8;
        Sun, 25 Sep 2022 23:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9710661757;
        Mon, 26 Sep 2022 06:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06A2C433C1;
        Mon, 26 Sep 2022 06:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664174168;
        bh=RZWqL6mqGtYB3W7YZL1NmlDx5eOD8rP55uoSBbEQ7zk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=te8u1O9i9c9mofZaPXRCXAhTN2NGWJE0QLtKRMautYWAj4BKsMYlDcwDNSJiIQLwh
         JIg85KBLn3FjJYRHIPXql9VB7qDYM3AMCqf3Dr6KHXbAqONeIn3W2pj9b07hvWbpH7
         4RrOyk/iCFNL/SYLxOsFLwBKi8Gm5tF5+7jpWrJVlepS2ZD7mE3kzwFSmAml2rQ4Ln
         50G0Euw0BFTla11EagWXsrBNV6K1koFxRhLdKviLEaaHFkeLdnnBiwEOHnd4rY9v5o
         N99LbczJfUs0dNMnzC5gOLvbhx6zLp38gf0CqduV/ShpJlD5l0KfAE2KDxo2a+xbMn
         a9b+fhgOw7Kfg==
Message-ID: <eb8883bc-1328-acd8-2c41-af877cecbfa4@kernel.org>
Date:   Mon, 26 Sep 2022 08:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [V14,08/15] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec
 compatible
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, Rob Herring <robh@kernel.org>
References: <20220915064337.2686-1-irui.wang@mediatek.com>
 <20220915064337.2686-9-irui.wang@mediatek.com>
 <3bbdfb31-2ba2-7345-54c7-82a67d95e30f@kernel.org>
 <f0b80a0d60172e9c286c0cd3b599875a345ae4f0.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <f0b80a0d60172e9c286c0cd3b599875a345ae4f0.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 03:56, kyrie.wu wrote:
> On Fri, 2022-09-23 at 13:28 +0200, Krzysztof Kozlowski wrote:
>> On 15/09/2022 08:43, Irui Wang wrote:
>>> From: kyrie wu <kyrie.wu@mediatek.com>
>>>
>>> Add mediatek,mt8195-jpgdec compatible to binding document.
>>
>> Use scripts/get_maintainers.pl to CC all maintainers and relevant
>> mailing lists.
>>
>>>
>>> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
>>> Signed-off-by: irui wang <irui.wang@mediatek.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../media/mediatek,mt8195-jpegdec.yaml        | 169
>>> ++++++++++++++++++
>>>  1 file changed, 169 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mt8195-
>>> jpegdec.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/mediatek,mt8195-
>>> jpegdec.yaml
>>> b/Documentation/devicetree/bindings/media/mediatek,mt8195-
>>> jpegdec.yaml
>>> new file mode 100644
>>> index 000000000000..9135cf889d1e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-
>>> jpegdec.yaml
>>> @@ -0,0 +1,169 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml*__;Iw!!CTRNKA9wMg0ARbw!yu00-_vltBz3bkDyzkeH2PENGyfi_megjPx815JiqrNVa28ZU7kcFYidMEos_id7$
>>>  
>>> +$schema: 
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yu00-_vltBz3bkDyzkeH2PENGyfi_megjPx815JiqrNVa28ZU7kcFYidMAikt6uh$
>>>  
>>> +
>>> +title: MediaTek JPEG Encoder Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
>>> +
>>> +description:
>>> +  MediaTek JPEG Decoder is the JPEG decode hardware present in
>>> MediaTek SoCs
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>
>> You do not have more than one item. Skip items.
> 
> Hello Krzysztof,
> 
> The device node has the compatible of "mediatek,mt8195-jpgdec",
> if skip this item, it may case dt-binding checking error.

No, this won't happen if you use correct syntax.

> For another, we may extend this items in the future.

Not really, that would be change of ABI. If you have already list of
devices, include them now.


Best regards,
Krzysztof

