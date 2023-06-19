Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB60734C58
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFSH1d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFSH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:27:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E6121;
        Mon, 19 Jun 2023 00:27:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 378B88138;
        Mon, 19 Jun 2023 15:27:14 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 15:27:14 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 15:27:13 +0800
Message-ID: <73ded260-3967-7547-9317-f4cbe5bcbb1c@starfivetech.com>
Date:   Mon, 19 Jun 2023 15:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 3/6] media: starfive: Add basic driver
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230525083202.67933-1-jack.zhu@starfivetech.com>
 <20230525083202.67933-4-jack.zhu@starfivetech.com>
 <fa665e61-f36a-5f65-4837-8d7c8c6a052e@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <fa665e61-f36a-5f65-4837-8d7c8c6a052e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for your comments.

On 2023/6/16 21:13, Bryan O'Donoghue wrote:
> On 25/05/2023 09:31, Jack Zhu wrote:
>> Add basic platform driver for StarFive Camera Subsystem.
>>
>> Reviewed-by: Bryan O'Donoghue <c.odonoghue@linaro.org>
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> 
> One thing here is the patch title and hence commit message.
> 
> "media: starfive:" doesn't really tell you this is a camera versus say a encoder/decoder.
> 
> I see you've used the name "camss" for your driver, which I think is a perfectly good and logical choice - however if you started to make commits along the lines of "media: camss" that would conflict with the qcom camss.
> 
> How about for starfive and qcom by the way, we do what Laurent did in
> 
> commit 3e8537b4c15172bfe1b285c3155ed5c37d523cd3
> Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Date:   Wed Dec 21 10:33:39 2022 +0100
> 
>     media: ti: omap3isp: Use media_pipeline_for_each_entity()
> 
> i.e. future StarFive commits for camera would be "media: starfive: camss" and similarly for Qualcomm "media: qualcomm: camss"
> 
> The point being the commit title namespace should be instructive and specific re: 3e8537b4c15172bfe1b285c3155ed5c37d523cd3
> 

Okay， I will add a camss directory under the starfive directory and modify the patch title.

> ---
> bod

-- 
Regards,

Jack Zhu
