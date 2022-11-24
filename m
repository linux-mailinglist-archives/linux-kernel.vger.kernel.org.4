Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F265063771F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKXLF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKXLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:05:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A45C0CC;
        Thu, 24 Nov 2022 03:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B3E620C5;
        Thu, 24 Nov 2022 11:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F74BC433D6;
        Thu, 24 Nov 2022 11:05:52 +0000 (UTC)
Message-ID: <de2198dd-16a7-f412-932d-a75cccf801e0@xs4all.nl>
Date:   Thu, 24 Nov 2022 12:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Content-Language: en-US
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <722194a3d413ca15069554ebab1f34dec25057eb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 05/10/2022 13:58, Allen-KH Cheng (程冠勳) wrote:
> Hi Krzysztof,
> 
> On Wed, 2022-10-05 at 09:30 +0200, Krzysztof Kozlowski wrote:
>> On 05/10/2022 09:21, Allen-KH Cheng (程冠勳) wrote:
>>> Hi Rob,
>>>
>>> On Fri, 2022-09-30 at 17:00 -0500, Rob Herring wrote:
>>>> On Fri, Sep 30, 2022 at 07:22:36PM +0800, Allen-KH Cheng wrote:
>>>>> In order to make the names of the child nodes more generic, we
>>>>> rename
>>>>> "vcodec" to "video-codec" for decoder in patternProperties and
>>>>> example.
>>>>
>>>> They are either generic or they aren't. Until something generic
>>>> is 
>>>> defined, I don't think it's worth the churn to change.
>>>>
>>>>
>>>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <
>>>>> angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8
>>>>> ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>> subdev-
>>>>> decoder.yaml
>>>>> b/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>> subdev-
>>>>> decoder.yaml
>>>>> index c4f20acdc1f8..67fde48f991c 100644
>>>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>> subdev-decoder.yaml
>>>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
>>>>> subdev-decoder.yaml
>>>>> @@ -91,7 +91,7 @@ properties:
>>>>>  
>>>>>  # Required child node:
>>>>>  patternProperties:
>>>>> -  '^vcodec-lat@[0-9a-f]+$':
>>>>> +  '^video-codec-lat@[0-9a-f]+$':
>>>>
>>>> Just 'video-codec' doesn't work?
>>>>
>>>
>>> Thanks for your reply.
>>>
>>> hmm, I think 'vidoe-codec' does wrok.
>>>
>>> There are two seperate hardwares for the MTK video codec.
>>> codec-lat and codec-core.
>>>
>>> Is it ok to keep two child node names for various hardwares?
>>>
>>
>> Aren't they still codecs?
>>
>> Best regards,
>> Krzysztof
> 
> Yes, They are both hardware deocders. Lat is responsible for the
> bitstream and write the outcome to the lat buffer. Core will decode the
> lat buffer and write the outcome to the output buffer. Each frame will
> be decoded cyclically by these two hardware deocders.

So is this patch OK to be merged? Or do you still want changes?

Regards,

	Hans
