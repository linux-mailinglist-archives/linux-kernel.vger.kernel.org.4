Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B57310EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245027AbjFOHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbjFOHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:38:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534E26B0;
        Thu, 15 Jun 2023 00:37:42 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22C456606F57;
        Thu, 15 Jun 2023 08:36:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686814610;
        bh=LKh3/K++ffNF/AmhFmt1beqCBIT5fIwS1jSCTqbyqDI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gr0uhLjDP3FkXRGO3mjV/ksfm1Gc9ctX7XQsIC90QRgClzsyzFOlitxUYypzdlbMi
         76VM+QpyrDwoLufsZX11AlQZiska4ko9rQUvXF0hjLGNkqef+JQsQKLblJoQ7A8Y7A
         kk8AVCse0DLXFJN86tgONSQmw6bKWr434KeiwLCKQj5z8CZqrNRnECojIrtwHjPnNc
         24aWVEBFzVa657fisKnYqjvv4B0fLMQ3jVT+TbxbJPA/2gXbMZTgMI+irPexG9r033
         +Eq2+/apzCvXELNEat2utZ+V4PbOeRoQypEStqHHsxyW0+PtSHtB5Q/oVrk2ToALfZ
         PzrJ9i/AWyLWA==
Message-ID: <938c740e-8196-ca0f-b53f-a0e33722e25c@collabora.com>
Date:   Thu, 15 Jun 2023 09:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 01/15] dt-bindings: display: mediatek: ethdr: Add
 compatible for MT8188
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-2-shawn.sung@mediatek.com>
 <1f044902-0726-34ed-3eea-7224e5750e22@collabora.com>
 <6c24ad522f42ce35bf387bae1b8a029f58bb0e01.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6c24ad522f42ce35bf387bae1b8a029f58bb0e01.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/23 07:51, Shawn Sung (宋孝謙) ha scritto:
> Hi Angelo,
>   
> Yes, MT8188 ETHDR is fully compatible with MT8195, so we didn't add its
> compatible name to the driver but just listed it in dt-bindings.
>   
> May I double check with you that
> I see there is a short description regarding "items" object:
>> # items is a list of possible values for the property. The number of
>> # values is determined by the number of elements in the list.
>> # Order in lists is significant, order in dicts is not
> in https://docs.kernel.org/devicetree/bindings/writing-schema.html
>   
> So does the compatible has to be:
> "mediatek,mt8188-disp-ethdr", "mediatek,mt8195-disp-
> ethdr" rather than in reversed order?
>   
> However, I couldn't find any description mentions the order in
> Documentation/devicetree/bindings/writing-schema.rst
> Not sure if the order in "items" object does not matter after then.
>   

No the order doesn't matter in that sense. If you check the other bindings,
you'll see that the rule is to order by name, which your change as well does.

It's fine.

P.S.: In case you didn't know, `make dt_binding_check` and `make dtbs_check`
       will validate your bindings and your devicetrees against the bindings.

Regards,
Angelo

> Thanks,
> Hsiao Chien Sung
> 
> 
> On Wed, 2023-06-14 at 13:41 +0200, AngeloGioacchino Del Regno wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
>>> Add compatible name for MediaTek MT8188 ETHDR.
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>> ---
>>>    .../bindings/display/mediatek/mediatek,ethdr.yaml           | 6
>> +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y
>> aml
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y
>> aml
>>> index 801fa66ae615..677882348ede 100644
>>> ---
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y
>> aml
>>> +++
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.y
>> aml
>>> @@ -23,7 +23,11 @@ description:
>>>
>>>    properties:
>>>      compatible:
>>> -    const: mediatek,mt8195-disp-ethdr
>>> +    oneOf:
>>> +      - const: mediatek,mt8195-disp-ethdr
>>> +      - items:
>>> +          - const: mediatek,mt8188-disp-ethdr
>>> +          - const: mediatek,mt8195-disp-ethdr
>>>
>>
>> Is MT8188's ETHDR fully compatible with MT8195's ETHDR?
>>
>> If it is, you're not adding a mt8188 specific compatible string in
>> the driver and
>> this means that the devicetree will look like:
>>
>> compatible = "mediatek,mt8195-disp-ethdr", "mediatek,mt8188-disp-
>> ethdr"
>>
>> ...so the proposed doc change works.
>>
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
>>>      reg:
>>>        maxItems: 7
>>> --
>>> 2.18.0
>>>
>>
>>

