Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61B26E74CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjDSIQy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDSIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:16:52 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCED100;
        Wed, 19 Apr 2023 01:16:50 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 12E2824DBBD;
        Wed, 19 Apr 2023 16:16:42 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 16:16:41 +0800
Received: from [192.168.125.108] (113.72.144.253) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 16:16:40 +0800
Message-ID: <f7e07efc-c274-4fc2-20c1-4c5e2e1c989e@starfivetech.com>
Date:   Wed, 19 Apr 2023 16:16:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 0/7] Add JH7110 USB and USB PHY driver support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230406015216.27034-1-minda.chen@starfivetech.com>
 <517670ca-ba2e-811e-3eb2-7f38011c9690@linaro.org>
 <985d0a57-1fc8-5725-4d3a-33dcc5d49d67@starfivetech.com>
 <5953bc83-9609-6d12-7e9b-ca5202151fb3@linaro.org>
 <a75ed45c-55c4-ff94-86f9-313ec79720ac@starfivetech.com>
 <c79e7d05-0b62-40e6-0864-35b2821c69e7@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <c79e7d05-0b62-40e6-0864-35b2821c69e7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/18 20:22, Krzysztof Kozlowski wrote:
> On 18/04/2023 13:12, Minda Chen wrote:
>>>>>>
>>>>>>
>>>>>> base-commit: 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
>>>>>> prerequisite-patch-id: 24a6e3442ed1f5454ffb4a514cfd768436a87090
>>>>>> prerequisite-patch-id: 55390537360f25c8b9cbfdc30b73ade004f436f7
>>>>>
>>>>> fatal: bad object 55390537360f25c8b9cbfdc30b73ade004f436f7
>>>>>
>>>>> What commits do you reference? How are they helpful?
>>>>>
>>>> I use "git format-patch --base=(commit) to generate patchset.
>>>> Maybe I set the wrong base commit.
>>>
>>> How are they helpful if these are private commits?
>>>> Best regards,
>>> Krzysztof
>>>
>> base-commit is not private commits. 
>> I should set base commit 197b6b60ae7bc51dd0814953c562833143b292aa. This is 6.3-rc4 commit.
>> But I set 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35. This is 6.3-rc4's previous commit.
> 
> You missed the point. I am not talking about base commit. I am talking
> about your prerequisites, which are useless. What can we do with such SHA?
> 
> Best regards,
> Krzysztof
> 
OK， I will delete them
