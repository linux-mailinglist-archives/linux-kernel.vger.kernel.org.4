Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE76AD787
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCGGlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCGGlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:41:11 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD223CE3D;
        Mon,  6 Mar 2023 22:41:09 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6D15724E240;
        Tue,  7 Mar 2023 14:41:07 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:41:07 +0800
Received: from [192.168.60.139] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:41:06 +0800
Message-ID: <30000009-cf05-988a-9817-97a7af36db37@starfivetech.com>
Date:   Tue, 7 Mar 2023 14:41:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 02/11] media: dt-bindings: starfive,jh7110-mipi-csi2:
 add binding docmuent
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
 <20230302091921.43309-3-jack.zhu@starfivetech.com>
 <11e7c986-e6cc-ee57-b36e-816af8cc11a7@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <11e7c986-e6cc-ee57-b36e-816af8cc11a7@linaro.org>
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



On 2023/3/3 16:47, Krzysztof Kozlowski wrote:
> On 02/03/2023 10:19, jack.zhu wrote:
>> Add DT binding document for Starfive MIPI CSI2 receiver
> 
> Ehh... you have entire commit msg to explain what you do here. Yet there
> is nothing mentioning that you actually have Cadence MIPI CSI here.
> 
> Since you decided to add new bindings, you receive review matching new
> bindings. I don't think this is correct approach (duplicated bindings),
> but could work for me. However how are you going to solve all the points
> of my review?

Maybe I don't need to add the CSI yaml file, since it already exists on the Linux mainline.

> 
> Best regards,
> Krzysztof
> 
