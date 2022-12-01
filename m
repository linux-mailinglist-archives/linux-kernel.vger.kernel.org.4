Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AA63F499
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiLAP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLAP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:58:05 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243443848
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:58:02 -0800 (PST)
Received: from atl1wswcm04.websitewelcome.com (unknown [50.6.129.165])
        by atl3wswob02.websitewelcome.com (Postfix) with ESMTP id BE6D6339F9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:58:01 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0lwkpoabXgEOM0lwmppTOO; Thu, 01 Dec 2022 15:58:01 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fZOYRKy3GgWYe5iiinL32p52xoI3jWCROvrohykcCbQ=; b=Gels9cR66w/BH/KcuPVtNF4MLZ
        og38RhuxCcza2SNI5x1rjielpejc0cy40eIcz6XYY55k9EaMLfNctmPJ685RR7bqZ2AXvB/Sd8Mix
        b/OT+m0kBkRCt7ynpDlVf1QB3Xkszk+QmCCxCeyL70gv7fvZLov4CTGlwC9yLxWbzDgE2IoySVup5
        p6WrT6q+ZchQ7SD3duusYsfJsAWqi+z+gCitLmdkCL3MU+u9gy5zn4JhZ3iFclGu3HUXnd2n4TQNA
        6/iE8PD3ALbDHz0x+tSmUd8A70CFPqxmzzgFSTpmBOBnu/skv2PacsL4drB21WHvCoRmAztDmYX8v
        pCKKbbcw==;
Received: from [106.197.183.239] (port=28074 helo=[192.168.221.42])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0lwj-003Nap-OW;
        Thu, 01 Dec 2022 15:57:57 +0000
Message-ID: <e84b629a-f7a7-e2a1-810c-87e1ce4538de@linumiz.com>
Date:   Thu, 1 Dec 2022 16:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marten.lindahl@axis.com,
        jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
 <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
 <e7b20055-4f44-aa91-e18d-9fb0f835fbf1@linumiz.com>
 <29de4d2b-3e32-809e-6ccd-5e7a4fe548fc@linaro.org>
 <e0d97b79-2133-8869-eaea-eb286fdb3a11@roeck-us.net>
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <e0d97b79-2133-8869-eaea-eb286fdb3a11@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.197.183.239
X-Source-L: No
X-Exim-ID: 1p0lwj-003Nap-OW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.221.42]) [106.197.183.239]:28074
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 5
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB0BIN4lzPt9cQ40z91lxSNuzdxP6vHkQD9m5QS/dQkn+u/NxPjS4rfOZJYGh31hmqqng5h2L86SICECIBQb5DsCGurPvDPnLuIOJGjhlKBlhKdD2a2p
 eUqcsfxfFhFqvZ+4i5db7jQI8t6UTst89tf+ckQUndd4wFvx2/fJAPTllmHgCedDE3gQPYBxN8JflZqKwjYT+8tDiCGlTZv8v6s=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/22 16:37, Guenter Roeck wrote:
> On 12/1/22 03:38, Krzysztof Kozlowski wrote:
>> On 01/12/2022 12:29, Saravanan Sekar wrote:
>>> On 01/12/22 11:26, Krzysztof Kozlowski wrote:
>>>> On 01/12/2022 05:46, Saravanan Sekar wrote:
>>>>> Document mpq7932 power-management IC
>>>>>
>>>>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>>>>> ---
>>>>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It seems my previous comments were not fully addressed. Maybe my
>>>> feedback got lost between the quotes, maybe you just forgot to apply 
>>>> it.
>>>> Please go back to the previous discussion and either implement all
>>>> requested changes or keep discussing them.
>>>>
>>> Hi Krzysztof,
>>>
>>> Thanks for your time to review and feedback.
>>>
>>> Here are the summary of comments on V1, I have fixed all according to my
>>> understanding.
>>>
>>>
>>> 1. Use subject prefixes matching the subsystem (git log --oneline -- 
>>> ...).
>>>
>>> git log --oneline -- Documentation/devicetree/bindings/hwmon/pmbus/
>>> 1ccca53618c4 dt-bindings: hwmon/pmbus: Add mps,mpq7932 
>>> power-management IC
>>> 373c0a77934c dt-bindings: hwmon/pmbus: Add ti,lm25066 
>>> power-management IC
>>> 7f464532b05d dt-bindings: Add missing 'additionalProperties: false'
>>> 8a36e38d8b0f dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
>>>
>>> I have used the same format of 373c0a77934c.
>>>
>>> 2. Does not look like you tested the bindings. Please run `make
>>> dt_binding_check` (see
>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>>
>>> I did run dt_binding_check on V1 but failed to notice warnings. Fixed
>>> warning on V2 and didn't observed any warnings.
>>>
>>> 3. Why requiring nodename? Device schemas usually don't do that.
>>> dropped "pattern: "pmic@[0-9a-f]{1,2}""
>>>
>>> 4. regulators node is a regulator with one more regulator? Drop.
>>> dropped "$ref: regulator.yaml# "
>>
>> The comment was - drop entire regulators node.
>>


PMBUS_REGULATOR_STEP helper macro has
                 .regulators_node = of_match_ptr("regulators"),  \

regulator subsystem parse (regulator_of_get_init_node) based on 
regulators_node. I think it is common all the regulator/pmic dts has 
regulators node.

>> Plus additional comment for the driver (and related to bindings) was
>> that this is not hwmon but a regulator driver. Why putting regulator
>> driver in hwmon?
>>
>
> Turns out this is primarily a hardware monitoring driver, like the drivers
> for all other PMBus chips. Regulator support is actually optional; the 
> driver
> works perfectly well with CONFIG_REGULATOR=n (except that it needs some
> #ifdefs to address that situation).
> 

Here is my view, communication to MPQ7932 PMIC chip is based on pmbus 
specification.

Now the conflict is that we have pmbus directory under hwmon subsystem, 
if pmbus spec implementation would have been separate like i2c-smbus 
then we can implement chip driver in regulator subsystem which access pmbus.

pmbus_core does supports regulator framework PMBUS_REGUALTOR and I 
believe it is valid MPQ7932 driver implantation under pmbus directory.

Kindly suggest to remove pmbus dependency on hwmon and proceed further.

Thanks,
Saravanan

