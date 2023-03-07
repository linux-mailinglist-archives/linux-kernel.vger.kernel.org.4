Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1887B6ADB69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCGKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:08:22 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07103CE34;
        Tue,  7 Mar 2023 02:08:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6CF4D24E350;
        Tue,  7 Mar 2023 18:08:18 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 18:08:01 +0800
Received: from [192.168.60.139] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 18:08:01 +0800
Message-ID: <d2b7207c-9dab-958b-58f0-5a3c28202470@starfivetech.com>
Date:   Tue, 7 Mar 2023 18:08:00 +0800
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
 <30000009-cf05-988a-9817-97a7af36db37@starfivetech.com>
 <6aeaa895-7f99-3598-2490-88eb48735a15@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <6aeaa895-7f99-3598-2490-88eb48735a15@linaro.org>
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



On 2023/3/7 15:53, Krzysztof Kozlowski wrote:
> On 07/03/2023 07:41, Jack Zhu wrote:
>> 
>> 
>> On 2023/3/3 16:47, Krzysztof Kozlowski wrote:
>>> On 02/03/2023 10:19, jack.zhu wrote:
>>>> Add DT binding document for Starfive MIPI CSI2 receiver
>>>
>>> Ehh... you have entire commit msg to explain what you do here. Yet there
>>> is nothing mentioning that you actually have Cadence MIPI CSI here.
>>>
>>> Since you decided to add new bindings, you receive review matching new
>>> bindings. I don't think this is correct approach (duplicated bindings),
>>> but could work for me. However how are you going to solve all the points
>>> of my review?
>> 
>> Maybe I don't need to add the CSI yaml file, since it already exists on the Linux mainline.
> 
> If you add *only* new compatible, you do not need new binding. If you
> add any new properties, then depends, but old binding anyway would need
> conversion from TXT.

have some new properties, this means that
need to convert cdns,csi2rx.txt to cdns,csi2rx.yaml and add my new attributes?

> 
> Best regards,
> Krzysztof
> 
