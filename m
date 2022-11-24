Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD9637735
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKXLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:09:13 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070C6F0C1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:09:11 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a7so1586546ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3sDEE3qa8mV6Z8JLdbIcpk1y3W4FOR+C6lE//MJGBA=;
        b=YwQsbws8Gdut4vqlvVwAGqR8yxlaet5b02SqRYH3b0ZOLIOkqiXHr0liDJUuIBNQyW
         cVkcsW6I8skCy4wXVnS+/xcCumMDaz5WbutbsK1JL/l4IE9Hsgul8ap1f92eYSEckq2P
         v5lmf34VWNXMvRyZkGdjoSNe0ReDIaw8qUsnpO+Pe//H72gJCw123DL4Jp9JSan1t6ba
         sFFMTZr+y+jq5hyy56MCzDOG1hQIcaCu4tX1KhmLiQrwNehIyQLgOgv0WcTIf8a6TaMa
         q0IBbHrj0u1x6rzKuOzKYlFWes7H/+dHxcVeCxPUM/8JPmq1zZmcndQxWBN0+kvYipjB
         kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3sDEE3qa8mV6Z8JLdbIcpk1y3W4FOR+C6lE//MJGBA=;
        b=sZwibrNCy7VebUG+lTPKWNzpxkbpVJ98vgioKTvGQQmqxP9OyrJqvyZ/PXHY+6yyp0
         zZikDJ8wV1CbOe8uKjwCV3WaxWQqxg2kShxR3tgR2JFlX1KwyCegFPIY0sMuRw8Ua2r8
         gwM5g10YnP1dSXVad/aGAZzsn5xfSng1z4ou5DBQLY9T7GMHSSHR9SgfGXTtsjaXVQB9
         v11PiLYu3UheANVhx5KGpg5dpQqbgcVlEhWlWsIyngOZeEnu6f81jPTN5e71u01TsmA4
         WiDT5X/vDu1+iXZwzI17YTQDfbX+4oMcN/VImmJvJXCF1acaUDIoEIZkV2wOBGD6gPSX
         VxYw==
X-Gm-Message-State: ANoB5plVo//r+fWKFMLvF1Ol87Lb6OBTOrQTQi6eo2DWB7pkgk3TypEk
        n6AtAoAgtWh4yiA/D99WK6cLuQ==
X-Google-Smtp-Source: AA0mqf6LyBiVykGyk7kCz9xb1VAXnYbL3E7n7XIc4SDO7ASJrU0aMhqJ7FUYBvNj2MY6wbI+eH7zYw==
X-Received: by 2002:a2e:7017:0:b0:277:18ee:c91e with SMTP id l23-20020a2e7017000000b0027718eec91emr10976398ljc.363.1669288149407;
        Thu, 24 Nov 2022 03:09:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u4-20020ac248a4000000b0049944ab6895sm85882lfg.260.2022.11.24.03.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:09:08 -0800 (PST)
Message-ID: <3012ca1a-c583-4148-8a96-f9ecf61a07dd@linaro.org>
Date:   Thu, 24 Nov 2022 12:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>, "robh@kernel.org" <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
 <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
 <20220930220011.GA1107972-robh@kernel.org>
 <ffc56eb60a3ef74c815c8d3c170a0df51958e20d.camel@mediatek.com>
 <24361bea-ecfe-b6e1-e755-5151220767f2@linaro.org>
 <722194a3d413ca15069554ebab1f34dec25057eb.camel@mediatek.com>
 <de2198dd-16a7-f412-932d-a75cccf801e0@xs4all.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <de2198dd-16a7-f412-932d-a75cccf801e0@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 12:05, Hans Verkuil wrote:
> Hi Krzysztof,
> 
> On 05/10/2022 13:58, Allen-KH Cheng (程冠勳) wrote:
>> Hi Krzysztof,
>>
>> On Wed, 2022-10-05 at 09:30 +0200, Krzysztof Kozlowski wrote:
>>> On 05/10/2022 09:21, Allen-KH Cheng (程冠勳) wrote:
>>>> Hi Rob,
>>>>
>>>> On Fri, 2022-09-30 at 17:00 -0500, Rob Herring wrote:
>>>>> On Fri, Sep 30, 2022 at 07:22:36PM +0800, Allen-KH Cheng wrote:
>>>>>> In order to make the names of the child nodes more generic, we
>>>>>> rename
>>>>>> "vcodec" to "video-codec" for decoder in patternProperties and
>>>>>> example.
>>>>>
>>>>> They are either generic or they aren't. Until something generic
>>>>> is 
>>>>> defined, I don't think it's worth the churn to change.
>>>>>
>>>>>
>>>>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>>>>> Reviewed-by: AngeloGioacchino Del Regno <
>>>>>> angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8
>>>>>> ++++----
>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>>> subdev-
>>>>>> decoder.yaml
>>>>>> b/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>>> subdev-
>>>>>> decoder.yaml
>>>>>> index c4f20acdc1f8..67fde48f991c 100644
>>>>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>>> subdev-decoder.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>>> subdev-decoder.yaml
>>>>>> @@ -91,7 +91,7 @@ properties:
>>>>>>  
>>>>>>  # Required child node:
>>>>>>  patternProperties:
>>>>>> -  '^vcodec-lat@[0-9a-f]+$':
>>>>>> +  '^video-codec-lat@[0-9a-f]+$':
>>>>>
>>>>> Just 'video-codec' doesn't work?
>>>>>
>>>>
>>>> Thanks for your reply.
>>>>
>>>> hmm, I think 'vidoe-codec' does wrok.
>>>>
>>>> There are two seperate hardwares for the MTK video codec.
>>>> codec-lat and codec-core.
>>>>
>>>> Is it ok to keep two child node names for various hardwares?
>>>>
>>>
>>> Aren't they still codecs?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Yes, They are both hardware deocders. Lat is responsible for the
>> bitstream and write the outcome to the lat buffer. Core will decode the
>> lat buffer and write the outcome to the output buffer. Each frame will
>> be decoded cyclically by these two hardware deocders.
> 
> So is this patch OK to be merged? Or do you still want changes?

The patch should be changed as Rob pointed out - use "video-codec" name.

Best regards,
Krzysztof

