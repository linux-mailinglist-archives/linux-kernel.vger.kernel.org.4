Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE1737E56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFUInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:42:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653019B0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:41:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9786fc23505so683244666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687336913; x=1689928913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmyMT+1AUqoR/yYld5R4nlU6HP4+c5LBSnMns61rspM=;
        b=AYUFnWHIQIvm1Xq9L65EGvF7S5pNfuo/ZEwN3QT/ttQzGt19W/sEm1OgAUEB2n3ekh
         tiWrHd/4eZhZcMnEmqU0oysX756sqkYiCjeSSgESBknr5sJxj3LihIhSnuJiEaLq/Dgp
         ttizVr3XhH5LxEyyvLFuM98v/vQfp/GdHZGUONN32s5h5TEhI6ggr+oEIl7uoLoPZWLh
         sGL6d3tEoCtllPmZrHjQ4a82SXjseVTEiii6qjBOc/ezhTz0JwLmYwJg8Y3/DzW8wg2q
         k7XUaYIHbDzg/IgksIJWn8m+ENRLfIMnXkH7AB+6aqUIPmUJN+zXwX8VsArkFBiovhOu
         0Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336913; x=1689928913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmyMT+1AUqoR/yYld5R4nlU6HP4+c5LBSnMns61rspM=;
        b=ezALQxXHM5+Q8Sg1GpbVNjUqa2FXfzglF6Sii+jPinrWTM5O7XfhgFxn8P/HNg/88a
         BqYkfMXPtcJa+lmkPcBF6yW0tkZzXR2dsm+jNKB21INUqO5wCx2Qg9yqP7p/G7Zh58dR
         MpWemRUhbMNlfCi184C51Zvc2pQxLtREtT3ROD3LlwCH7MVLRxYAKn5CUCufag03MIvP
         vcjKZItOnHHXeJ3MxmnoyYgPDKmh96Qr8AgsvTDuODwcK9XGYmnsaIfBdoIBSjj7oy26
         j4+WFSa8BlkCJScegrWQ9y4ZZ9st3/MhGxGwBGArVn4XB9AQ1ixW/wD/J+NXhQgsUgDJ
         Iovg==
X-Gm-Message-State: AC+VfDze26jub8GKS0fi3v3910/Da0UGs6Uehmx8U8CuZbPt/l2AT6dP
        bTj6sbJOs8utVatos+ucjuoEfw==
X-Google-Smtp-Source: ACHHUZ5rxR4eyS+PEFn295VDdxkdEq0Gm2K9yulyOuf77XPzqePt1rcFTBqjEgvEthZNb2qtwNhdZA==
X-Received: by 2002:a17:907:6d8e:b0:988:d01a:4d57 with SMTP id sb14-20020a1709076d8e00b00988d01a4d57mr7571083ejc.28.1687336912950;
        Wed, 21 Jun 2023 01:41:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906191500b0096a6be0b66dsm2691388eje.208.2023.06.21.01.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:41:52 -0700 (PDT)
Message-ID: <9c36cdbb-7204-f9ca-6191-88e0f0f71915@linaro.org>
Date:   Wed, 21 Jun 2023 10:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
 <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
 <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 18:31, Nícolas F. R. A. Prado wrote:
> On Tue, Jun 20, 2023 at 03:00:00PM +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2023 14:46, Nícolas F. R. A. Prado wrote:
>>> On Tue, Jun 20, 2023 at 10:12:14AM +0200, Krzysztof Kozlowski wrote:
>>>> On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
>>>>> The binding expects the first register space to be VDEC_SYS. But on
>>>>> mt8183, which uses the stateless decoders, this space is used only for
>>>>> controlling clocks and resets, which are better described as separate
>>>>> clock-controller and reset-controller nodes.
>>>>>
>>>>> In fact, in mt8173's devicetree there are already such separate
>>>>> clock-controller nodes, which cause duplicate addresses between the
>>>>> vdecsys node and the vcodec node. But for this SoC, since the stateful
>>>>> decoder code makes other uses of the VDEC_SYS register space, it's not
>>>>> straightforward to remove it.
>>>>>
>>>>> In order to avoid the same address conflict to happen on mt8183,
>>>>> since the only current use of the VDEC_SYS register space in
>>>>> the driver is to read the status of a hardware controlled clock, remove
>>>>> the VDEC_SYS register space from the binding and describe an extra
>>>>> syscon that will be used to directly check the hardware status.
>>>>>
>>>>> Also add reg-names to be able to tell that this new register schema is
>>>>> used, so the driver can keep backward compatibility.
>>>>>
>>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>>
>>>>> ---
>>>>> I dropped the tags from this commit since a syscon is now used instead
>>>>> of an extra clock.
>>>>>
>>>>> Changes in v3:
>>>>> - Removed the active clock
>>>>> - Added a mediatek,vdecsys syscon property
>>>>>
>>>>> Changes in v2:
>>>>> - Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
>>>>>   clock for mt8183) to avoid changing number of clocks twice
>>>>> - Added maxItems to reg-names
>>>>> - Constrained clocks for each compatible
>>>>> - Reordered properties for each compatible
>>>>>
>>>>>  .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
>>>>>  1 file changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>>>> index 1e56ece44aee..2f625c50bbfe 100644
>>>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>>>> @@ -21,8 +21,13 @@ properties:
>>>>>        - mediatek,mt8183-vcodec-dec
>>>>>  
>>>>>    reg:
>>>>> +    minItems: 11
>>>>>      maxItems: 12
>>>>>  
>>>>> +  reg-names:
>>>>> +    minItems: 11
>>>>> +    maxItems: 11
>>>>
>>>> maxItems: 12
>>>>
>>>>> +
>>>>>    interrupts:
>>>>>      maxItems: 1
>>>>>  
>>>>> @@ -60,6 +65,10 @@ properties:
>>>>>      description:
>>>>>        Describes point to scp.
>>>>>  
>>>>> +  mediatek,vdecsys:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description: Phandle to the vdecsys syscon node.
>>>>> +
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> @@ -79,8 +88,26 @@ allOf:
>>>>>      then:
>>>>>        required:
>>>>>          - mediatek,scp
>>>>> +        - mediatek,vdecsys
>>>>>  
>>>>>        properties:
>>>>> +        reg:
>>>>> +          maxItems: 11
>>>>> +
>>>>> +        reg-names:
>>>>> +          items:
>>>>> +            - const: misc
>>>>> +            - const: ld
>>>>> +            - const: top
>>>>> +            - const: cm
>>>>> +            - const: ad
>>>>> +            - const: av
>>>>> +            - const: pp
>>>>> +            - const: hwd
>>>>> +            - const: hwq
>>>>> +            - const: hwb
>>>>> +            - const: hwg
>>>>> +
>>>>>          clocks:
>>>>>            minItems: 1
>>>>>            maxItems: 1
>>>>> @@ -101,6 +128,9 @@ allOf:
>>>>>          - mediatek,vpu
>>>>>  
>>>>>        properties:
>>>>> +        reg:
>>>>> +          minItems: 12
>>>>
>>>>
>>>> What about reg-names here? They should be also defined and in sync with
>>>> regs.
>>>
>>> That's intentional. As described in the commit message, mt8173 will keep having
>>> the VDEC_SYS iospace, while mt8183 won't. And we use the presence of reg-names
>>> to tell them apart.
>>>
>>> So, mt8173 has 12 regs, no reg-names and no syscon, while mt8183 has 11 regs,
>>> with reg-names and the syscon.
>>
>> reg-names is not the way to tell apart variants. Compatible is. If you
>> add reg-names for one variant, it's expected to have it defined for
>> other as well, because the order of items in reg is always fixed.
> 
> But differentiating with compatible in this case would be wrong, since it's not
> not something inherent to the SoC. We really just want to be able to tell
> whether the vdecsys iospace is supplied as a reg or as a syscon.

Wait, you should not have one device or even family of devices taking
their IO space with two different methods. It's exactly the same device,
the same bus.

> 
> This series focuses on getting the mt8183 decoder working, and as part of that
> introduces the binding and DT node for mt8183 with vdecsys as a syscon instead
> of a reg, to avoid introducing new 'duplicate unit-address' DT warnings.

I got patches 1, 2, 3 and 6, nothing more so I cannot comment on what
else you are trying to do here. Since you did not cc me, it's not relevant.

Your DTS change does nothing like switching from MMIO to syscon.

But anyway this variant comes with some set of regs and reg-names. Other
variant comes with different set. In all cases they should be defined,
even by "defined" means not allowed.

> 
> But in a separate series we could drop vdecsys from mt8173's reg as well,
> passing it as a syscon instead, which would solve the warning on that platform,
> though some more driver changes would be needed to be able to handle it for that
> SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
> from their regs to have a correct memory description.
> 

Sure, but I don't understand how does it affect defining and making
specific regs/reg-names or keeping them loose.

Best regards,
Krzysztof

