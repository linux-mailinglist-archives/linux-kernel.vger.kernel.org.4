Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA216657571
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiL1Kqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiL1Kqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:46:33 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675E2706;
        Wed, 28 Dec 2022 02:46:32 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B50BC24E133;
        Wed, 28 Dec 2022 18:46:26 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 28 Dec
 2022 18:46:27 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 28 Dec
 2022 18:46:25 +0800
Message-ID: <b828357c-81b3-870b-a658-02bf8cfad47c@starfivetech.com>
Date:   Wed, 28 Dec 2022 18:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/3] StarFive's SDIO/eMMC driver support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20221227115856.460790-1-william.qiu@starfivetech.com>
 <02e8c75f-658f-320c-7c90-64ccf2beccbe@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <02e8c75f-658f-320c-7c90-64ccf2beccbe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/27 21:07, Krzysztof Kozlowski wrote:
> On 27/12/2022 12:58, William Qiu wrote:
>> Hi,
>> 
>> This patchset adds initial rudimentary support for the StarFive
>> designware mobile storage host controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board. The main purpose of adding
>> this driver is to accommodate the ultra-high speed mode of eMMC.
>> 
>> The last patch should be applied after the patchset [1]:
>> [1] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/
> 
> It's a duplicate? Why do I have two of them in mailbox? Isn't this v3 then?
> 

Hi Krzysztof,

Sorry about that. I usually use a script to send emails. The first email was 
sent to the wrong person, so I corrected it and sent the second one.

Best regards,
William Qiu

> Best regards,
> Krzysztof
> 
