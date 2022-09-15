Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E15B9F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIOQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIOQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:20:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5F9DB4F;
        Thu, 15 Sep 2022 09:20:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 29so27709750edv.2;
        Thu, 15 Sep 2022 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kd+JAIxoatS6fqpZjKg+PafGJDvgpv06EAtknvwbZaQ=;
        b=F72x7QYZIhbmFjR0ChiYcfO63EjAeyERPyBY55RLEnhiiokBPHqF50G9KkbcsNROkA
         lYQEegvB+fu3ppSt53cWMXH+tkODzC8u62kgMKqmu0OhOAxg+BrNr6XVxIE2nNV8P4bI
         P71fNfJnKryq4wYh4Geo7Ow9ztj5pRH/lDi5sTHfQPwPziIuSOTSD3LJojcshvV7couK
         0odQpei6AzHdQZLYwpxEZ0GVfoRsgLFDyI2/l/trh/4lUZu9GYR+H06Xi4BhjZFdWNrE
         0T1xy5zADQ3cvJbuBqlZ+znEVnuXjTQVQ8GF7rwRIg3WCgCwMoQSAGM/NfpkgmOdxb4d
         EE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kd+JAIxoatS6fqpZjKg+PafGJDvgpv06EAtknvwbZaQ=;
        b=3tP8Nbd6u+IwxEVE4LRT64qXzcG9AwhaS2JdHhtzjLXGfSTxW2r5HEefHpjPWHsyEv
         zAZFTJhgotCJyZYtxlFCUar04KyRarylLTFc1WR6pSOttYBFuZ7g+p0LqRNtXaPs5ywZ
         ZJqk0hjiIn2duTa9o3Cn0VeicaTWrLGVj2feiG1NpGvt7dPV5fcjEmybosThsMDaz2XX
         XJJrruj9sp1+xjm7afWsSu+qqhZREeUPz8VaZH4q78JH2NZ19MCELwJJL82/tevSDg/f
         SHOjqCAWF3i7MfkMinuIjerVzpN6Wx6aktlbIEiI6BL3UYUg7Enuxq3HeZCA9gk+7GyD
         ZA4A==
X-Gm-Message-State: ACrzQf0eSutJkIYLYbenRpPQFDDOOxk8u/Gjlz6Q6B5uhIK06iVKY8qc
        p84qLpt5nKnpB7u3BQF0v+M=
X-Google-Smtp-Source: AMsMyM63oHtUjcmEQaYXKXqjqIFTLT8HB0HjfWwV868jYlpt/GWlhdq2iBhj+mSI9knUF4WLNHgqkw==
X-Received: by 2002:aa7:cd8e:0:b0:452:2682:a955 with SMTP id x14-20020aa7cd8e000000b004522682a955mr516912edv.379.1663258834101;
        Thu, 15 Sep 2022 09:20:34 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b00772061034dbsm1534324eje.182.2022.09.15.09.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:20:32 -0700 (PDT)
Message-ID: <a8e18b62-f49f-7c99-e046-3ee609e11627@gmail.com>
Date:   Thu, 15 Sep 2022 18:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220914182331.20515-1-jason-jh.lin@mediatek.com>
 <20220914182331.20515-2-jason-jh.lin@mediatek.com>
 <1b739216-8bb1-162b-1af5-24acba7324bf@gmail.com>
 <296155e2a12a474439ba092e73b4bcffbf3d3edc.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <296155e2a12a474439ba092e73b4bcffbf3d3edc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 15/09/2022 03:24, Jason-JH Lin wrote:
> Hi Matthias,
> 
> Thanks for the reviews.
> 
> On Wed, 2022-09-14 at 23:24 +0200, Matthias Brugger wrote:
>>
>> On 14/09/2022 20:23, Jason-JH.Lin wrote:
>>> For previous MediaTek SoCs, such as MT8173, there are 2 display HW
>>> pipelines binding to 1 mmsys with the same power domain, the same
>>> clock driver and the same mediatek-drm driver.
>>>
>>> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding
>>> to
>>> 2 different power domains, different clock drivers and different
>>> mediatek-drm drivers.
>>>
>>> Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
>>> CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
>>> Quality)
>>> and they makes VDOSYS0 supports PQ function while they are not
>>> including in VDOSYS1.
>>>
>>> Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
>>> component). It makes VDOSYS1 supports the HDR function while it's
>>> not
>>> including in VDOSYS0.
>>>
>>> To summarize0:
>>> Only VDOSYS0 can support PQ adjustment.
>>> Only VDOSYS1 can support HDR adjustment.
>>>
>>> Therefore, we need to separate these two different mmsys hardwares
>>> to
>>> 2 different compatibles for MT8195.
>>>
>>> Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195
>>> SoC binding")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> I'm not sure Krzysztof gave his Acked-by tag.
> 
> I'll remove this tag.
>>
>>> ---
>>>    .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        |
>>> 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> index 6ad023eec193..a53b32c0a608 100644
>>> ---
>>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> +++
>>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
>>> l
>>> @@ -32,6 +32,8 @@ properties:
>>>                  - mediatek,mt8186-mmsys
>>>                  - mediatek,mt8192-mmsys
>>>                  - mediatek,mt8195-mmsys
>>> +              - mediatek,mt8195-vdosys0
>>
>> As I said in the last submission, we should make mediatek,mt8195-
>> mmsys as a
>> fallback of vdosys0. Actually mediatek,mt8195-mmsys is only used for
>> the
>> fallback of vdosys0.
> 
> I think adding both vdosys0 and vdosys1 can make the description of
> this patch clearer.
> 
> It's find to me to only add "mediatek,mt8195-vdosys0" in this patch.
> So I'll remove the "mediatek,mt8195-vdosys1" at the next version.
> 

That's not what I wanted to suggest. Up to now in upstream kernel compatible 
mediatek,mt8195-mmsys enables support fro vdosys0. The vdosys1 is not yet 
upstream, so no support.
If we change the compatible, we should keep mediatek,mt8195-mmsys as fallback of 
"mediatek,mt8195-vdosys0" so that older device tree blobs won't break with a 
newer kernel.
For "mediatek,mt8195-vdosys1" we do not need a fallback compatible as the code 
never reached upstream, so no breakage expected.

Hope I explain myself now.

Regards,
Matthias


> Regards,
> Jason-JH.Lin
>>
>> Regards,
>> Matthias
>>
>>> +              - mediatek,mt8195-vdosys1
>>>                  - mediatek,mt8365-mmsys
>>>              - const: syscon
>>>          - items:
>>
>>
