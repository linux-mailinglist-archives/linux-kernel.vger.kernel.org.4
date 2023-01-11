Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF8665C99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbjAKNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbjAKNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD831AD91;
        Wed, 11 Jan 2023 05:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7929B61C4E;
        Wed, 11 Jan 2023 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B9C433EF;
        Wed, 11 Jan 2023 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443738;
        bh=8NhfFvzMGm4OezYdWZuY5JD3WOcgMUOWBN1uo5+sJHs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iyhCv3TOX/EbzLfahcPwnIIy5LQgzCgBwlH3O31wkYbIrzFpTERm/rndJ2klwjaVB
         JEt4/iXipgeUEQaIntoKkmsuGtFtVZnwGOp7d99GgwabDPKAecXtOg8ZCQDCnUKjnm
         FqgTcsfzoA7Sgs0By9aBDDEMYIhmjqK5wJ1PU7Kj5DyAO8rcseCdBwV0Q/zzTbCSZE
         4Mt3I9m9tLuicJoG1AK+JePTdxRI5Xm3ujpPHJMjcf2B2m2zOJUoFlgevWMD1Mp07a
         DcZswrBG+TSBMQjSXuB/5RciqcWsvqQWuL5PdTkKhhj94Jczikh5i1tJdXP5K6+l1x
         FEl3PcxFMFSDA==
Message-ID: <14ffd7a0-caf3-d5ee-18bb-df4e53f276c7@kernel.org>
Date:   Wed, 11 Jan 2023 14:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
 <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 14:21, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Krzysztof,
> 
> Sorry, I missed your comments following the topic of recipients list.
> 
> Below are the rest of the responses
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Wednesday, January 11, 2023 4:31 AM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Hans Verkuil <hverkuil@xs4all.nl>; Laurent
>> Pinchart <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add Toshiba
>> Visconti Video Input Interface bindings
>>
>> On 10/01/2023 02:41, Yuji Ishikawa wrote:
>>> Adds the Device Tree binding documentation that allows to describe the
>>> Video Input Interface found in Toshiba Visconti SoCs.
>>>
>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC.  It might happen, that command when run on an older kernel, gives you
>> outdated entries.  Therefore please be sure you base your patches on recent
>> Linux kernel.
>>
>> You missed few of them, so clearly this was not sent correctly.
>>
>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.

Follow all comments.

>>
>>> ---
>>> Changelog v2:
>>> - no change
>>>
>>> Changelog v3:
>>> - no change
>>>
>>> Changelog v4:
>>> - fix style problems at the v3 patch
>>> - remove "index" member
>>> - update example
>>> ---
>>>  .../bindings/media/toshiba,visconti-viif.yaml | 98
>>> +++++++++++++++++++
>>>  1 file changed, 98 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>>> b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>>> new file mode 100644
>>> index 00000000000..71442724d1a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.ya
>>> +++ ml
>>> @@ -0,0 +1,98 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Toshiba Visconti5 SoC Video Input Interface Device Tree
>>> +Bindings
>>
>> Drop "Device Tree Bindings"
> 
> I'll drop it.
> 
>>
>>> +
>>> +maintainers:
>>> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> +
>>> +description:
>>> +  Toshiba Visconti5 SoC Video Input Interface (VIIF)
>>> +  receives MIPI CSI2 video stream,
>>> +  processes the stream with embedded image signal processor (L1ISP,
>>> +L2ISP),
>>> +  then stores pictures to main memory.
>>
>> Fix wrapping.
> 
> I'll fix this.
> I didn't realize a new line has been added through formatting a patch.
>  
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: toshiba,visconti-viif
>>
>> Compatible must be specific. You called your SoC visconti5, didn't you?
>>
> 
> The Video Input Interface hardware is likely to be used at future SoCs of
> Visconti Architecture.
> Does compatible have to be specific to SoC's model name 
> rather than architecture name?

Compatibles should always be specific to SoC model name. Adding more
generic family fallback is also good idea when it is applicable.

Best regards,
Krzysztof

