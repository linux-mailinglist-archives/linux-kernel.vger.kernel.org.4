Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DE62488A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKJRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiKJRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:45:32 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE62DAA4;
        Thu, 10 Nov 2022 09:45:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AAHikMB018321;
        Thu, 10 Nov 2022 11:44:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668102286;
        bh=yW1uO952OcBO2fElaCf2Q7WipVJKTPj/Dc1SJmpKnwQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jmWpEZtBQjS+jkYmlQnMGGEGS3FoSgizdYC4mDmAC9EuKZcIWv9APoor5v+zti9VA
         2Ok1cqJCcekDc4R5Zv49W+RIYyJMHulx4Oz/6EPnRwe6eiBEsO37Rnv5oDFD4GmSCV
         kG3QiELaUFr3RkwjhRlSUU99+fHUNDOfYdi/24G8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AAHik26061482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Nov 2022 11:44:46 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 10
 Nov 2022 11:44:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 10 Nov 2022 11:44:45 -0600
Received: from [128.247.81.39] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AAHijVL130696;
        Thu, 10 Nov 2022 11:44:45 -0600
Message-ID: <1231f3e6-61a7-ca3c-2fbb-679b583e0df1@ti.com>
Date:   Thu, 10 Nov 2022 11:44:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
To:     Kevin Hilman <khilman@baylibre.com>,
        jerome Neanne <jneanne@baylibre.com>,
        Nishanth Menon <nm@ti.com>
CC:     Lee Jones <lee@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <kristo@kernel.org>,
        <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <tony@atomide.com>,
        <vigneshr@ti.com>, <bjorn.andersson@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>, <arnd@arndb.de>,
        <jeff@labundy.com>, <narmstrong@baylibre.com>, <msp@baylibre.com>,
        <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com> <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
 <20221105000104.rtj3r6ufqwqmepon@keenly> <7heduewjp0.fsf@baylibre.com>
 <5418ac3b-04d7-5e77-7612-c8f168e24621@ti.com>
 <1267bf43-618c-7347-be3a-2792c656d9b6@baylibre.com>
 <7hk042agn4.fsf@baylibre.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <7hk042agn4.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 11:00 AM, Kevin Hilman wrote:
> jerome Neanne <jneanne@baylibre.com> writes:
> 
>> On 09/11/2022 22:59, Andrew Davis wrote:
>>> On 11/7/22 3:14 PM, Kevin Hilman wrote:
>>>> Nishanth Menon <nm@ti.com> writes:
>>>>
>>>>> On 13:58-20221104, jerome Neanne wrote:
>>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Can you try an compile with W=1 please.
>>>>>> This raise one warning on mfd:
>>>>>> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’
>>>>>> defined but
>>>>>> not used [-Wunused-function]
>>>>>>      28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>>>>>>         |            ^~~~~~~~~~~~~~~~~~~~~~
>>>>>> soft_shutdown has been validated and is used in TI baseline even if not
>>>>>> hooked in upstream version further to this review:
>>>>>> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
>>>>>>
>>>>>> It was a TI requirement to implement it...
>>>>>> Let me know if you want me to remove this function or if we can keep
>>>>>> it like
>>>>>> this.
>>>>>
>>>>> There are platforms without psci, correct? I think the comment was to
>>>>> drop the force override with system-power-controller property,
>>>>>
>>>>> if (!pm_power_off) {
>>>>>      tps65219_i2c_client = client;
>>>>>      pm_power_off = &tps65219_pm_power_off;
>>>>> }
>>>>>
>>>>> Could still be valid for such platforms, no? I do see that the
>>>>> capability that the PMIC has - which is software shutdown is a valid
>>>>> feature that we support in many different PMIC drivers. Is'nt the job of
>>>>> the driver to introduce the functionality in a manner that is
>>>>> appropriate to the OS framework?
>>>>
>>>> Yeah, I think Nishanth is right here.
>>>>
>>>> We should probably keep the `if (!pm_power_off)` part so the PMIC will
>>>> be used if PSCI is not, but it also allows an easy way to test/use the
>>>> PMIC
>>>> shutdown functionality downstream if needed.
>>>>
>>>
>>> Then should be using the sys-off handler API[0] so it doesn't block PSCI
>>> which is also switching over[1].
>>>
>>> Andrew
>>>
>>> [0] https://lwn.net/Articles/894511/
>>> [1] https://www.spinics.net/lists/arm-kernel/msg1024127.html
>> Can we go for upstream with v7 without tps65219_soft_shutdown. Then if
>> everyone agrees with Andrew proposal, I'll submit a separate patch which
>> adds implementation of tps65219_soft_shutdown support through sys-off
>> handler.
>>
>> So that we are not blocking upstream in case further
>> discussions/alignment are required.
> 
> Seems OK to me.  Nishanth?  Andrew?
> 
> But I think you'll need to at least submit a v8 without the unused
> code/dead code that Lee pointed out.
> 

If you need the v8 anyway, then add support through sys-off in
that spin, should only be a couple lines of change.

Andrew
