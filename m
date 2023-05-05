Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDC6F7E86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjEEIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjEEIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:14:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAF18866;
        Fri,  5 May 2023 01:14:18 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3570E7FFE;
        Fri,  5 May 2023 16:14:16 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 5 May
 2023 16:14:16 +0800
Received: from [192.168.60.114] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 5 May
 2023 16:14:15 +0800
Message-ID: <817b8919-e9dd-cf2a-41e0-9b50747ab4cf@starfivetech.com>
Date:   Fri, 5 May 2023 16:14:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
 <14c06503-621f-2477-7b15-b17f1890ecfe@starfivetech.com>
 <7bd29805-11e7-68ee-aa47-68bae2a2fb38@starfivetech.com>
 <925bf170-bb54-b427-976a-87e0dca230da@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <925bf170-bb54-b427-976a-87e0dca230da@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 14:40, Krzysztof Kozlowski wrote:
> On 05/05/2023 07:57, Jack Zhu wrote:
>> 
>> 
>> On 2023/4/24 19:19, Jack Zhu wrote:
>>>
>>>
>>> On 2023/4/13 11:55, Jack Zhu wrote:
>>>> Hi,
>>>>
>>>> This patch series adds support for the StarFive Camera Subsystem
>>>> found on StarFive JH7110 SoC.
>>>>
>>>> The driver implements V4L2, Media controller and V4L2 subdev interfaces.
>>>> Camera sensor using V4L2 subdev interface in the kernel is supported.
>>>>
>>>> The driver is tested on VisionFive V2 board with IMX219 camera sensor.
>>>> GStreamer 1.18.5 with v4l2src plugin is supported.
>>>>
>>>> Changes since v3:
>>>> Patch 1:
>>>> - Modified port@0 and port@1 properties.
>>>> - Extended the port@0 example with appropriate properties.
>>>> - Added 'port@0' for 'required'
>>>> Patch 2:
>>>> - Modified spelling errors.
>>>> Patch 3:
>>>> - Merged patch 5 into the patch with an explanation for compatible in
>>>>   commit msg.
>>>> Patch 6:
>>>> - Asserted pixel_rst[i] reset in the loop after the err_disable_pixclk
>>>>   label.
>>>> - Modified Code Style for getting sys_rst and p_rst.
>>>> - Renamed clk_name to name and modified the relevant code.
>>>> Patch 9:
>>>> - Added static for stfcamss_get_mem_res function.
>>>> - Added static for isp_close function.
>>>> - Fixed implicit conversion warning for stf_vin_map_isp_pad function.
>>>> - Dropped unused variables.
>>>>
>>>>   v3: https://lore.kernel.org/all/20230331121826.96973-1-jack.zhu@starfivetech.com/
>>>>
>>>
>>> Hello everyone,
>>>
>>> From the current review status, the patches related to the CSI module
>>> have 'reviewed-by' tags. I would like to know if it is okay to add
>>> patches 1-5 from this series to a PR first.
>>>
>>> Thank you!
>>>
>>> Jack
>>>
>> 
>> Hello Mauro, Laurent, Maxime, Rob, Krzysztof, Robert, Todor and Philipp,
>> 
>> Can you give me some suggestions and comments on the previous request
>> to commit CSI related patches first? Thank you for your time.
> 
> You received very specific feedback, so know you decided to ignore it?
> 
> No, implement what you were asked for.
> 

Hi Krzysztof,

Thank you for your comments.

I am talking about CSI-related patches 1-5, not including the patches
6-8. The CSI module is a relatively functionally independent hardware
module. The CSI-related patches 1-5 already have 'reviewed-by' tags,
and there are no unprocessed comments left. So, made the previous
request. Please let me know if I understand something wrong.

I don't want to ignore any comments, I will continue to modify the isp
patches 6-8 in subsequent versions according to your comments. The
ISP-related patches are being prepared.

Jack

> Best regards,
> Krzysztof
> 
