Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EED6C27E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCUCKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUCKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:10:04 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07D2B9E8;
        Mon, 20 Mar 2023 19:10:02 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8748F24E1FB;
        Tue, 21 Mar 2023 10:10:00 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Mar
 2023 10:10:00 +0800
Received: from [192.168.125.82] (183.27.97.64) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Mar
 2023 10:09:59 +0800
Message-ID: <7f38d366-f3da-7441-3400-7719b0f33326@starfivetech.com>
Date:   Tue, 21 Mar 2023 10:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/3] Add JH7110 MIPI DPHY RX support
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <7e525c7d-d534-adba-4aea-a485ba37bcc7@starfivetech.com>
 <ZBhT8tpBhdFugurm@matsya>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <ZBhT8tpBhdFugurm@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/20 20:39, Vinod Koul wrote:
> On 03-03-23, 14:05, Changhuang Liang wrote:
>>
>>
>> On 2023/2/23 9:59, Changhuang Liang wrote:
>>> This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
>>> It is used to transfer CSI camera data. The series has been tested on
>>> the VisionFive 2 board.
>>>
>>> This patchset should be applied after the patchset [1] and patch [2]:
>>> [1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
>>> [2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfivetech.com/
>>>
>> Hi, Vinod and Kishon
>>
>> Could you please help to review and give me some suggestions
>> for this patch series? Thank you for your time.
> 
> There are already comments on dt-binding, please address them!
> 

I have address them on v3, and I am really looking forward to your comments. 
Thank you so much for wasting your time.

>>
>> Best regards,
>> Changhuang
> 
