Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A535B8A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiINOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:32:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E12A27D;
        Wed, 14 Sep 2022 07:32:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cc5so16178573wrb.6;
        Wed, 14 Sep 2022 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5fCS+f3KrgOmeVSjsMvV8OThDyXYF5+mHg0NkcRUCv4=;
        b=gNoJ1sPZVhjF7qrOCXMvTGD8VX43VHozbigNPNJ1vr3YXaQwH+pq2ZieWrEmoIbUOZ
         ekh6o5673RFANoU8UHmuKN4fLmfJPJB06M9a2T5a334B5dYk8jFb344QRwlrjZoXIdMZ
         KAJBHrUgduhhWhrDfsERhGW9w+lfYcz/PnZm73/FMsBM89S3rFQOyBJAZovYkq/Nvu68
         IMGGMJOpxv4Kqknv25T+1Kdk5Ma77ngYYytWVqLdzKe/pv9fn1ilkXlKPCGoONRrtEpU
         0UxzAid+5r03Xru7cbFnUhb1pnAzWRstyzHYtTvP5HGeJQPHjN59NVcg1OeGYox1mxgJ
         xmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5fCS+f3KrgOmeVSjsMvV8OThDyXYF5+mHg0NkcRUCv4=;
        b=DeCHlvCXu1ldukh7sNM9DYwFhJZRP/xRkaiIXUjcGMZ5yQb3kvwRP/TqcpGYPg6xvz
         UPIGXopVwtZw+69aAL3lFjgp34V7Mp936H1pBaIoKqtKiIQe9joKk5FnkrIO41twskjS
         PuYZqY4usrQlQ8usWk8uGp8/zjtoalBSFRxM96Rx81xXxTxm1+HTBErG9Z35oxZ7q4nr
         ZnVm9MhWHhOLebyh8PuMBmusVu8zZdP9fwZYeKdFb2G/4H4mz71GiLe3sTTpHvHfh8Ee
         PTHb+bf5solvJ3VsnHpVKhffDTmLTOggOYVBYhZ1KIJWkqsTZ0f5d9p4qLXFa+cxQnzN
         lU9g==
X-Gm-Message-State: ACgBeo0YgmPhlgf4M12DDxSUp9PAxkv3bEmc2K7vHXbsJQ7wY55mShWp
        NK98GvipxRDOxouzs/adabw=
X-Google-Smtp-Source: AA6agR7x9VBqWL/1tK3nx0tK1KRXlK/l6E8gqSjMHjpP7OBs5vcYmTE5hCQB4oFEVDPdWPJJaOGiyQ==
X-Received: by 2002:a05:6000:2ab:b0:228:e3b1:c3b2 with SMTP id l11-20020a05600002ab00b00228e3b1c3b2mr20778234wry.313.1663165926675;
        Wed, 14 Sep 2022 07:32:06 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b003b46a882171sm17143847wmb.33.2022.09.14.07.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:32:05 -0700 (PDT)
Message-ID: <463b0b0a-c1ec-0f89-45cf-50a7587db69b@gmail.com>
Date:   Wed, 14 Sep 2022 16:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220825091448.14008-1-rex-bc.chen@mediatek.com>
 <3ed3d73a-1671-708e-7c42-498cca6aaf1d@gmail.com>
 <8f3dba943170361211d9bb4c8bf1be12bbfdec20.camel@mediatek.com>
 <adcbb2b7-cddd-4546-bdf2-66d056a40c1d@linaro.org>
 <916bd99bcc4fa77eae5734b22365ce73acd90d58.camel@mediatek.com>
 <efedfd3d-9779-514b-0481-f0b669d2e326@gmail.com>
In-Reply-To: <efedfd3d-9779-514b-0481-f0b669d2e326@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2022 17:39, Matthias Brugger wrote:
> 
> 
> On 26/08/2022 09:13, Bo-Chen Chen wrote:
>> On Fri, 2022-08-26 at 15:00 +0800, Krzysztof Kozlowski wrote:
>>> On 26/08/2022 05:07, Bo-Chen Chen wrote:
>>>> On Thu, 2022-08-25 at 22:57 +0800, Matthias Brugger wrote:
>>>>>
>>>>> On 25/08/2022 11:14, Bo-Chen Chen wrote:
>>>>>> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>>>>>>
>>>>>> For previous MediaTek SoCs, such as MT8173, there are 2 display
>>>>>> HW
>>>>>> pipelines binding to 1 mmsys with the same power domain, the
>>>>>> same
>>>>>> clock driver and the same mediatek-drm driver.
>>>>>>
>>>>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
>>>>>> binding
>>>>>> to
>>>>>> 2 different power domains, different clock drivers and
>>>>>> different
>>>>>> mediatek-drm drivers.
>>>>>>
>>>>>> Moreover, Hardware pipeline of VDOSYS0 has these components:
>>>>>> COLOR,
>>>>>> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
>>>>>> Quality)
>>>>>> and they makes VDOSYS0 supports PQ function while they are not
>>>>>> including in VDOSYS1.
>>>>>>
>>>>>> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR
>>>>>> related
>>>>>> component). It makes VDOSYS1 supports the HDR function while
>>>>>> it's
>>>>>> not
>>>>>> including in VDOSYS0.
>>>>>>
>>>>>> To summarize0:
>>>>>> Only VDOSYS0 can support PQ adjustment.
>>>>>> Only VDOSYS1 can support HDR adjustment.
>>>>>>
>>>>>> Therefore, we need to separate these two different mmsys
>>>>>> hardwares
>>>>>> to
>>>>>> 2 different compatibles for MT8195.
>>>>>>
>>>>>> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add
>>>>>> mt8195
>>>>>> SoC binding")
>>>>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>>>>> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>>>>>> ---
>>>>>> Changes for v2:
>>>>>> 1. Add hardware difference for VDOSYS0 and VDOSYS1 in commit
>>>>>> message.
>>>>>> ---
>>>>>> .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>>>>>> |
>>>>>> 3 ++-
>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>>> .yam
>>>>>> l
>>>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>>> .yam
>>>>>> l
>>>>>> index 6ad023eec193..bfbdd30d2092 100644
>>>>>> ---
>>>>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>>> .yam
>>>>>> l
>>>>>> +++
>>>>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
>>>>>> .yam
>>>>>> l
>>>>>> @@ -31,7 +31,8 @@ properties:
>>>>>>                  - mediatek,mt8183-mmsys
>>>>>>                  - mediatek,mt8186-mmsys
>>>>>>                  - mediatek,mt8192-mmsys
>>>>>> -              - mediatek,mt8195-mmsys
>>>>>> +              - mediatek,mt8195-vdosys0
>>>>>
>>>>> Thanks for you patch. As I mentioned on v1, I propose to set
>>>>> mediatek,mt8195-mmsys as fallback for mediatek,mt8195-vdosys0 to
>>>>> not
>>>>> break
>>>>> backwards compatibility.
>>>>>
>>>>> Apart from that, the binding change will need some changes to
>>>>> support
>>>>> the new
>>>>> binding. Please provide these together with this patch.
>>>>>
>>>>> Regards,
>>>>> Matthias
>>>>>
>>>>
>>>> Hello Matthias,
>>>>
>>>> Thanks for your comments.
>>>> The purpose of this patch is to confirm we can separate mt8195
>>>> mmsys
>>>> into two compatibles. I think this modification is accepted.
>>>
>>> No, it is not accepted following Matthias comments. You received my
>>> ack
>>> based on assumption that ABI break is perfectly ok for platform
>>> maintainer, as he has decisive voice. If anyone is not happy with a
>>> ABI
>>> break, then his concerns must be addressed.
>>>
>>> So let it be specific:
>>> NAK.
>>>
>>>>
>>>> After this, I think Jason-JH will push another series with this
>>>> binding
>>>> patch.
>>>
>>> I don't know what do you mean here - another series on top of wrong
>>> patch?
>>>
>>
>> Hello Krzysztof,
>>
>> For this mt8195 mmsys binding separation, we still need to modify
>> driver for this. The reason I send this patch is to confirm we can do
>> this binding modification and I also think we can not pick this patch
>> here.
>>
>> We will push another series and it contains modification of binding and
>> drivers. (The series will push by Jason-JH Lin)
>>
> 
> Sounds good. So lets wait for Jason-JH Lin to send this series and we can go on 
> with the review.
> 

Just to be sure, this has not happened yet, correct?

Regards,
Matthias

> Thanks!
> Matthias
> 
>> Maybe I should use "RFC" for this series, and I think it's more
>> correct.
>>
>> BRs,
>> Bo-Chen
>>
>>>> In Jason-JH's series, we will modify mmsys driver based on this.
>>>> And I think we don't need to keep "mediatek,mt8195-mmsys" if we
>>>> also
>>>> modify mmsys drivers in the same series.
>>>
>>> This does not fux ABI break and broken bisectability.
>>>
>>>>
>>>> Is it ok that postpones to pick this patch until we finish review
>>>> follow-up series?
>>>>
>>>
>>> No. You got a clear review to fix.
>>>
>>> Best regards,
>>> Krzysztof
>>
