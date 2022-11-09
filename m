Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B962363E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKIV7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIV7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:59:48 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A5F61;
        Wed,  9 Nov 2022 13:59:47 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A9Lx727033026;
        Wed, 9 Nov 2022 15:59:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668031147;
        bh=b7PO55ox9Ku0+BUb/jH+AxWWw1UBs2sKYVo9NFf7PL4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Bdde3cIGRfuIlPIRh6X6Mq1Ya3UWGQ2qFo03xmImNW1ty+jN+mw/e3cKGGILP9H/T
         3XKmaia5VWUhGuztW2z2LtF0z42twWLZkO61/9sLfK/BD2TXzmylhwwjp9y+mL2FJI
         +xZiHpspuXnXm7IxCRdWEEA4WWu87iMIjfyJyDBE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A9Lx7VM057000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 15:59:07 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 15:59:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 15:59:07 -0600
Received: from [128.247.81.39] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A9Lx6jt009420;
        Wed, 9 Nov 2022 15:59:06 -0600
Message-ID: <5418ac3b-04d7-5e77-7612-c8f168e24621@ti.com>
Date:   Wed, 9 Nov 2022 15:59:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>,
        jerome Neanne <jneanne@baylibre.com>
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
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <7heduewjp0.fsf@baylibre.com>
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

On 11/7/22 3:14 PM, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> On 13:58-20221104, jerome Neanne wrote:
>>>
>> [...]
>>
>>>
>>>>
>>>> Can you try an compile with W=1 please.
>>> This raise one warning on mfd:
>>> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ defined but
>>> not used [-Wunused-function]
>>>     28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>>>        |            ^~~~~~~~~~~~~~~~~~~~~~
>>> soft_shutdown has been validated and is used in TI baseline even if not
>>> hooked in upstream version further to this review:
>>> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
>>>
>>> It was a TI requirement to implement it...
>>> Let me know if you want me to remove this function or if we can keep it like
>>> this.
>>
>> There are platforms without psci, correct? I think the comment was to
>> drop the force override with system-power-controller property,
>>
>> if (!pm_power_off) {
>> 	tps65219_i2c_client = client;
>> 	pm_power_off = &tps65219_pm_power_off;
>> }
>>
>> Could still be valid for such platforms, no? I do see that the
>> capability that the PMIC has - which is software shutdown is a valid
>> feature that we support in many different PMIC drivers. Is'nt the job of
>> the driver to introduce the functionality in a manner that is
>> appropriate to the OS framework?
> 
> Yeah, I think Nishanth is right here.
> 
> We should probably keep the `if (!pm_power_off)` part so the PMIC will
> be used if PSCI is not, but it also allows an easy way to test/use the PMIC
> shutdown functionality downstream if needed.
> 

Then should be using the sys-off handler API[0] so it doesn't block PSCI
which is also switching over[1].

Andrew

[0] https://lwn.net/Articles/894511/
[1] https://www.spinics.net/lists/arm-kernel/msg1024127.html
