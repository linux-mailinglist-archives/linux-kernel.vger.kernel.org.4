Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035466BA47C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCOBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:14:35 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A42298C0;
        Tue, 14 Mar 2023 18:14:33 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BA4A324E1D1;
        Wed, 15 Mar 2023 09:14:26 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 09:14:26 +0800
Received: from [192.168.60.77] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 09:14:26 +0800
Message-ID: <46943d0c-81a6-2eda-680a-43c56e9aece6@starfivetech.com>
Date:   Wed, 15 Mar 2023 09:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] media: admin-guide: Update rkisp1.rst
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230310024056.59220-1-jack.zhu@starfivetech.com>
 <ZBBB/pM0WliJUu2i@valkosipuli.retiisi.eu>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <ZBBB/pM0WliJUu2i@valkosipuli.retiisi.eu>
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



On 2023/3/14 17:44, Sakari Ailus wrote:
> Hi Jack,
> 
> On Fri, Mar 10, 2023 at 10:40:56AM +0800, Jack Zhu wrote:
>> Update Rockchip ISP1 driver file path
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  Documentation/admin-guide/media/rkisp1.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/admin-guide/media/rkisp1.rst b/Documentation/admin-guide/media/rkisp1.rst
>> index ccf418713623..3eec078c9eff 100644
>> --- a/Documentation/admin-guide/media/rkisp1.rst
>> +++ b/Documentation/admin-guide/media/rkisp1.rst
>> @@ -10,7 +10,7 @@ Introduction
>>  ============
>>  
>>  This file documents the driver for the Rockchip ISP1 that is part of RK3288
>> -and RK3399 SoCs. The driver is located under drivers/staging/media/rkisp1
>> +and RK3399 SoCs. The driver is located under drivers/media/platform/rockchip/rkisp1
> 
> Applied now but going forward, please keep the lines at 80 chars or less.

OK, will modify it. Thank you for your comments.

> 
> Thanks.
> 
>>  and uses the Media-Controller API.
>>  
>>  Revisions
> 
