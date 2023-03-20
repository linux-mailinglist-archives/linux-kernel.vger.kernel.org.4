Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEDD6C116A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCTMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCTMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:03:17 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7646A6;
        Mon, 20 Mar 2023 05:03:12 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 65C9F24E1EC;
        Mon, 20 Mar 2023 20:03:04 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 20:03:04 +0800
Received: from [192.168.60.83] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 20:03:04 +0800
Message-ID: <40406847-e08c-4b3a-869e-205e06c286b6@starfivetech.com>
Date:   Mon, 20 Mar 2023 20:03:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/6] MAINTAINERS: Add Starfive Camera Subsystem driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Eugen Hristev" <eugen.hristev@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-6-jack.zhu@starfivetech.com>
 <20230312111418.GB2545@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230312111418.GB2545@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/12 19:14, Laurent Pinchart wrote:
> Hi Jack,
> 
> Thank you for the patch.
> 
> On Fri, Mar 10, 2023 at 08:05:52PM +0800, Jack Zhu wrote:
>> Add an entry for Starfive Camera Subsystem driver.
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b2e7ca5603c3..c67faea9f967 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19907,6 +19907,15 @@ M:	Ion Badulescu <ionut@badula.org>
>>  S:	Odd Fixes
>>  F:	drivers/net/ethernet/adaptec/starfire*
>>  
>> +STARFIVE CAMERA SUBSYSTEM DRIVER
>> +M:	Jack Zhu <jack.zhu@starfivetech.com>
>> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/admin-guide/media/starfive_camss.rst
>> +F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
>> +F:	drivers/media/platform/starfive/
> 
> You could also add the MAINTAINERS entry in patch 1/6, with just the
> .yaml file to start with, and extend it in the patches that add more
> files. Up to you, I don't mind much.

Thank you for your suggestion, I will do that.

> 
>> +
>>  STARFIVE DEVICETREES
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  S:	Maintained
> 
