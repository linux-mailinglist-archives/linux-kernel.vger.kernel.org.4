Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC51C72C388
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFLL4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFLL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:56:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74B93
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:56:07 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35CBtlkt049372;
        Mon, 12 Jun 2023 06:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686570947;
        bh=1bN6NxcCjY+QAN5JLc6yms+BPijFm/G6q8gUsULt3TU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QYRwK0Xk89cjat5dyLZCnV0chMNkWPMOErM3nS2iAEbOe3/k6WZQ96TvU7uNUe3kN
         VV16N3aMlXjq+m7dSW57fH4E8JyRo7kWmq89uZr3RPB1M58ejW/MWftyYbKN4GeJy7
         55SDZ+qbY1mtgY3e/+JYrzudlJyqgg2foSy6q3a4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35CBtl4H092981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Jun 2023 06:55:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Jun 2023 06:55:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Jun 2023 06:55:46 -0500
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35CBtiPZ099301;
        Mon, 12 Jun 2023 06:55:45 -0500
Message-ID: <3362316a-dc24-e2e2-4baa-69e51703e86e@ti.com>
Date:   Mon, 12 Jun 2023 17:25:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR by default
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230612094340.13865-1-r-gunasekaran@ti.com>
 <ab8dfd0f-fa49-6493-d79d-c35f632373f3@linaro.org>
 <e3e409c5-56b5-570d-e962-a7c0a1c05fa3@ti.com>
 <3ac37e54-0633-37d2-2ba7-f06abcb9a5a7@linaro.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <3ac37e54-0633-37d2-2ba7-f06abcb9a5a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 3:21 PM, Krzysztof Kozlowski wrote:
> On 12/06/2023 11:49, Ravi Gunasekaran wrote:
>>
>>
>> On 6/12/23 3:14 PM, Krzysztof Kozlowski wrote:
>>> On 12/06/2023 11:43, Ravi Gunasekaran wrote:
>>>> Enable HSR feature in kernel build.
>>>
>>> Why? Commit msg should answer to this question.
>>
>> I apologize for incomplete description. I will send out a v2.
>>
>> HSR protocol is implemented by the network stack at /net/hsr/*
>> In order to create HSR interface, HSR module needs to be loaded.
> 
> You described what HSR is, but I want to know why do we need it in our
> development arm64 kernel. You might want to enable anything and explain
> what is this "anything" but this does not solve any of the concerns.
> 

TI SoCs such as AM64x, AM65x support multiple ethernet ports which can be
used to setup HSR (a redundancy protocol) node in the network. So enabling
the HSR driver to be built as module. The HSR node can be created using a
pair of ethernet ports in the system.

> Best regards,
> Krzysztof
> 

-- 
Regards,
Ravi
