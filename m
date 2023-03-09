Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBC6B199A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCICwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCICwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:52:19 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210753D88;
        Wed,  8 Mar 2023 18:52:16 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8309B24DCBE;
        Thu,  9 Mar 2023 10:52:15 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 10:52:15 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 10:52:15 +0800
Message-ID: <868f03bd-7318-a5e8-f338-c234030a9882@starfivetech.com>
Date:   Thu, 9 Mar 2023 10:52:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 04/11] MAINTAINERS: add Starfive Camera subsystem
 driver
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
 <20230302091921.43309-5-jack.zhu@starfivetech.com>
 <c39f8ecf-26e7-3187-2488-d9fb0f64d2fa@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <c39f8ecf-26e7-3187-2488-d9fb0f64d2fa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
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



On 2023/3/3 16:42, Krzysztof Kozlowski wrote:
> On 02/03/2023 10:19, jack.zhu wrote:
>> Add an entry for Starfive Camera subsystem driver.
>> 
>> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8ddef8669efb..a202deb4cb1a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19906,6 +19906,15 @@ M:	Ion Badulescu <ionut@badula.org>
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
> 
> Why only one binding, not all of them?

As we communicated in the previous emails, The file starfive,jh7110-mipi-csi2.yaml
will no longer be used. I will convert cdns,csi2rx.txt to cdns,csi2rx.yaml and add some
new properties. The "cdns,csi2rx.yaml" will be added in "CADENCE MIPI-CSI2 BRIDGES".

> 
> Best regards,
> Krzysztof
> 
