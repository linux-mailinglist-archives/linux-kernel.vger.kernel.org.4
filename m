Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276A6B055C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCHLFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCHLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:04:43 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6EA9B2D7;
        Wed,  8 Mar 2023 03:03:58 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2615C24E32C;
        Wed,  8 Mar 2023 19:03:56 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 19:03:56 +0800
Received: from [192.168.60.130] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Mar
 2023 19:03:55 +0800
Message-ID: <05465184-5976-6cee-9925-e3712a1ea650@starfivetech.com>
Date:   Wed, 8 Mar 2023 19:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 11/11] media: starfive: enable building
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-12-jack.zhu@starfivetech.com>
 <bd6c9135-e12c-a6ac-db46-416403850751@linaro.org>
 <15b29a5b-29a1-8440-2b46-0c201c20defd@starfivetech.com>
 <edf4febc-1629-45c6-ea48-ece8df12a4a5@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <edf4febc-1629-45c6-ea48-ece8df12a4a5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/8 18:33, Krzysztof Kozlowski wrote:
> On 07/03/2023 10:46, Jack Zhu wrote:
>> 
>> 
>> On 2023/3/3 16:43, Krzysztof Kozlowski wrote:
>>> On 02/03/2023 10:19, jack.zhu wrote:
>>>> Add Kconfig and Makefie, update platform/Kconfig and platform/Makefile
>>>> to enable building of the Starfive Camera subsystem driver.
>>>>
>>>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>>>> ---
>>>>  drivers/media/platform/Kconfig           |  1 +
>>>>  drivers/media/platform/Makefile          |  1 +
>>>>  drivers/media/platform/starfive/Kconfig  | 18 ++++++++++++++++++
>>>>  drivers/media/platform/starfive/Makefile | 14 ++++++++++++++
>>>
>>> This is not a separate commit. If it were, it would mean you just added
>>> dead code in previous commits, so why adding dead code in first place?
>>>
>> 
>> The previous patches are made according to the module function.I think
>> it is helpful to explain the composition of the code file. 
>> 
>> stf_camss[patch 9] as a platform device manages all resources including
>> ISP and VIN. ISP/VIN [patch 7/8]as a sub-device needs to access other
>> resources managed by stf_camss.There is mutual reference between them.
>> Therefore, this patch is used for the overall compilation of the starfive
>> directory.
> 
> So previous code is dead? Again, what is the reason for adding dead
> code? Mutual reference is not the answer.
> 

Maybe I need to merge the previous patches[6-11] into one patch to submit?

> Best regards,
> Krzysztof
> 
