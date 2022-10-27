Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7260EDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiJ0CNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiJ0CNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:13:34 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0030E77A1;
        Wed, 26 Oct 2022 19:13:31 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 29R1mXqa097466;
        Thu, 27 Oct 2022 09:48:33 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Oct
 2022 10:11:23 +0800
Message-ID: <3c461dbe-7621-e4e6-c55e-6352119258f8@aspeedtech.com>
Date:   Thu, 27 Oct 2022 10:11:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 3/5] media: Documentation: aspeed-video: Add user
 documentation for the aspeed-video driver
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <hverkuil-cisco@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <xavier.roumegue@oss.nxp.com>,
        <ezequiel@vanguardiasur.com.ar>, <stanimir.varbanov@linaro.org>,
        <sakari.ailus@linux.intel.com>, <ming.qian@nxp.com>,
        <andrzej.p@collabora.com>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
 <20221025090203.5623-4-jammy_huang@aspeedtech.com>
 <8a8f7c818688bda7c75d2f4fb5f8f0d6f89cb965.camel@collabora.com>
 <22c85f42-a4d7-c6cc-5f1e-346c88c29dc5@aspeedtech.com>
 <4e3a4e1961afa77b5658357cc7fa0f289c7409fe.camel@collabora.com>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <4e3a4e1961afa77b5658357cc7fa0f289c7409fe.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 29R1mXqa097466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/27 上午 03:02, Nicolas Dufresne wrote:
> Le mercredi 26 octobre 2022 à 10:42 +0800, Jammy Huang a écrit :
>> Hi Nicolas,
>>
>> Thanks for your comments.
>>
>> On 2022/10/25 下午 09:18, Nicolas Dufresne wrote:
>>> Hi Jammy,
>>>
>>> thanks for the addition.
>>>
>>> Le mardi 25 octobre 2022 à 17:02 +0800, Jammy Huang a écrit :
>>>> Add user documentation for the aspeed-video driver.
>>>>
>>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>>> ---
>>>> v10:
>>>>     - new
>>>> ---
>>>>    .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
>>>>    .../userspace-api/media/drivers/index.rst     |  1 +
>>>>    2 files changed, 62 insertions(+)
>>>>    create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst
>>>>
>>>> diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
>>>> new file mode 100644
>>>> index 000000000000..798a2588b175
>>>> --- /dev/null
>>>> +++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
>>>> @@ -0,0 +1,61 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +.. include:: <isonum.txt>
>>>> +
>>>> +ASPEED video driver
>>>> +===================
>>>> +
>>>> +ASPEED Video Engine found on AST2400/2500/2600 SoC supports high performance
>>>> +video compressions with a wide range of video quality and compression ratio
>>>> +options. The adopted compressing algorithm is a modified JPEG algorithm.
>>>> +
>>>> +There are 2 types of compressions in this IP.
>>>> +
>>>> +* JPEG JFIF standard mode: for single frame and management compression
>>>> +* ASPEED proprietary mode: for multi-frame and differential compression.
>>>> +  Support 2-pass (high quality) video compression scheme (Patent pending by
>>>> +  ASPEED). Provide visually lossless video compression quality or to reduce
>>>> +  the network average loading under intranet KVM applications.
>>> I think some of the information disclosed in the following quote could be
>>> summarized. Notably the part about the extra buffers.
>>>
>>>      Aspeed JPEG Format requires an additional buffer, called bcd, to store
>>>      the information about which macro block in the new frame is different
>>>      from the previous one.
>>>      
>>>      To have bcd correctly working, we need to swap the buffers for src0/1 to
>>>      make src1 refer to previous frame and src0 to the coming new frame.
>>>      
>>> But before I push you this route, have you considered using a dedicated pixel
>>> format instead ? Here's my thinking, the output of the JPEG encoder is no longer
>>> "compatible" (or at least won't yield the expected images) if used with a normal
>>> JPEG decoder. By differentiating these two as dedicated formats, you will only need
>>> 1 vendor control, and you avoid the potential risk of software bugs mixing them up.
>>> Also note that there is other JPEG based vendor formats that exist in V4L2.
>>>
>>> Let me know what do you think ?
>> Yes, I also add a dedicated formats, V4L2_PIX_FMT_AJPG, in this series.
>> In [PATCH v10 1/5]
>>
>> media: v4l: Add definition for the Aspeed JPEG format, I add the
>> description in pixfmt-reserved.rst.
>>
>> After this series applied, the users can choose either of these two
>> formats by VIDIOC_S_FMT as
>>
>> per their preference.
> Sorry about that, I have skipped too much. The approach seems fair then, can you
> state in the doc that these control applies to V4L2_PIX_FMT_AJPG in some way ?
> (just a little cross-reference can help). The confusion with normal JPEG is
> easy.
>
> thanks for you patience,
> Nicolas

Sure, I will add the words below in next patch.

"VIDIOC_S_FMT can be used to choose which format you want. V4L2_PIX_FMT_JPEG

stands for JPEG JFIF standard mode; V4L2_PIX_FMT_AJPG stands for ASPEED

proprietary mode."


Thanks for your help.

>>> Nicolas
>>>
>>>> +
>>>> +More details on the ASPEED video hardware operations can be found in
>>>> +*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
>>>> +AspeedTech-BMC/openbmc/releases.
>>>> +
>>>> +The ASPEED video driver implements the following driver-specific control:
>>>> +
>>>> +``V4L2_CID_ASPEED_HQ_MODE``
>>>> +-------------------------------
>>>> +    Enable/Disable ASPEED's High quality mode. This is a private control
>>>> +    that can be used to enable high quality for aspeed proprietary mode.
>>>> +
>>>> +.. flat-table::
>>>> +    :header-rows:  0
>>>> +    :stub-columns: 0
>>>> +    :widths:       1 4
>>>> +
>>>> +    * - ``(0)``
>>>> +      - ASPEED HQ mode is disabled.
>>>> +    * - ``(1)``
>>>> +      - ASPEED HQ mode is enabled.
>>>> +
>>>> +``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
>>>> +-------------------------------
>>>> +    Define the quality of ASPEED's High quality mode. This is a private control
>>>> +    that can be used to decide compression quality if High quality mode enabled
>>>> +    . Higher the value, better the quality and bigger the size.
>>>> +
>>>> +.. flat-table::
>>>> +    :header-rows:  0
>>>> +    :stub-columns: 0
>>>> +    :widths:       1 4
>>>> +
>>>> +    * - ``(1)``
>>>> +      - minimum
>>>> +    * - ``(12)``
>>>> +      - maximum
>>>> +    * - ``(1)``
>>>> +      - step
>>>> +    * - ``(1)``
>>>> +      - default
>>>> +
>>>> +**Copyright** |copy| 2022 ASPEED Technology Inc.
>>>> diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
>>>> index 32f82aed47d9..46a494e00b72 100644
>>>> --- a/Documentation/userspace-api/media/drivers/index.rst
>>>> +++ b/Documentation/userspace-api/media/drivers/index.rst
>>>> @@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
>>>>    	:maxdepth: 5
>>>>    	:numbered:
>>>>    
>>>> +	aspeed-video
>>>>    	ccs
>>>>    	cx2341x-uapi
>>>>    	dw100

-- 
Best Regards
Jammy

