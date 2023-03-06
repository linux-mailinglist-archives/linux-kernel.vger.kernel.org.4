Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0736D6ABD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjCFKgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCFKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:35:50 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CB59E6;
        Mon,  6 Mar 2023 02:35:46 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 449AB24E2E3;
        Mon,  6 Mar 2023 18:35:45 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 18:35:45 +0800
Received: from [192.168.125.108] (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 18:35:44 +0800
Message-ID: <7c314cc7-0377-ac42-8925-79abc9dcb86f@starfivetech.com>
Date:   Mon, 6 Mar 2023 18:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] Add JH7110 USB driver support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230306095212.25840-1-minda.chen@starfivetech.com>
 <ZAW/DqprkKaop4bg@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZAW/DqprkKaop4bg@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 18:23, Conor Dooley wrote:
> Hey Minda!
> 
> On Mon, Mar 06, 2023 at 05:52:12PM +0800, Minda Chen wrote:
>> This patchset adds USB driver for the StarFive JH7110 SoC.
>> USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
>> The patch has been tested on the VisionFive 2 board.
>> 
>> This patchset should be applied after the patchset [1] and patch [2]:
>> [1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
>> [2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfivetech.com/
>> 
>> patch 1 is usb phy dt-binding document.
>> patch 2 is the glue layer of Cadence USB3 and USB phy
>> setting. USB controller IP is Cadence USB3. 
>> patch 3 is USB device tree configuration.
>> 
>> Minda Chen (3):
>>   dt-bindings: phy: Add StarFive JH7110 USB dt-binding
>>   usb: cdns3: add StarFive JH7110 USB glue layer
>>   dts: usb: add StarFive JH7110 USB dts configuration.
> 
> Unfortunately, this patchset hasn't really landed correctly.
> Usually, in a series, patches are sent as replies to the cover letter.
> Git's send-email will do this for you if you pass it multiple patches
> and a cover letter (I do it by passing a directory, eg patches/foo/v1)
> 
> It appears that you have sent each patch separately, and to different
> recipients, which makes this harder to review.
> Please re-submit this with proper threading (and as v2 ideally, so that
> Greg's bot doesn't complain).
> 
> Thanks,
> Conor.
I am sorry about this. I will re-summit this patchset as v2 patch.
