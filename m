Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B76C2D22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCUI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCUIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:55:39 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D884A1DF;
        Tue, 21 Mar 2023 01:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679388805; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Swv/m0J4JYRMHxlqM6ECwP2kon4rJ/HJj6ZqQTKYLCJjehL8CFkZkel6SFhlGnrkdtA5SjtM/bYVLjqBk+kFu0mCbvUhpIfJqPybu0qIB6oj+ZVgC8pw0BYEpsSSoMjLsLI8OXRl1pBTS419m2go0YpzspJ7hopFd0mQToyvm5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679388805; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=SYr/ERVf7CLgKo8BYU40SJ/s8dnmY3Et/To78+kiaok=; 
        b=eHBdWAI5BgOe/8uphh4rutUaT+O44LX4h4qV4H0LYJR7RwEh4Q9KJKBqJSh1tM3uBVvmXfK3YGJ4sQLCjlNKKLHX9LhsLS2U8nynBfsTR9X4b69omsCVb/CC461wqESh2llULs59pUmj5sTvzN2GBLyCYbIHcuSh8YbHde7SmKg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679388805;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=SYr/ERVf7CLgKo8BYU40SJ/s8dnmY3Et/To78+kiaok=;
        b=AZG9H+sEfYbUlUJydeJ22rxDPL7HTLtPG5JIm+EbEmhf4mmhlumVDD2OweH3MFIN
        YefnygVFBezJwLdGvKtTKoeXh+7qvq5CEYzK9mASpII99TqQZUMLJ4bo+8Bvaik6C7/
        VwLSay/6mUZlLLMs7Lv7xGX8WWQAqRYiXPrRkdqw=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679388803856160.0109146913502; Tue, 21 Mar 2023 01:53:23 -0700 (PDT)
Message-ID: <1c279b0a-c814-2fe3-0432-2aa6b3dff16e@arinc9.com>
Date:   Tue, 21 Mar 2023 11:53:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
 <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org>
 <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
 <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
 <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
 <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
 <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
 <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
 <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
 <2150938b-5433-6f51-c404-2c0f6976f864@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <2150938b-5433-6f51-c404-2c0f6976f864@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2023 11:39, Krzysztof Kozlowski wrote:
> On 21/03/2023 09:33, Arınç ÜNAL wrote:
>> On 21.03.2023 11:27, Krzysztof Kozlowski wrote:
>>> On 21/03/2023 09:24, Arınç ÜNAL wrote:
>>>>>>
>>>>>> If we take the calling new things mediatek route, we will never get to
>>>>>> the bottom of fixing the naming inconsistency.
>>>>>
>>>>> All new things, so new SoCs, should be called mediatek, because there is
>>>>> no ralink and mediatek is already used for them. So why some new
>>>>> Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?
>>>>>
>>>>> You can do nothing (and no actual need) about existing inconsistency...
>>>>
>>>> I couldn't change ralink -> mediatek because company acquisitions don't
>>>> grant the change. I don't see any reason to prevent changing mediatek ->
>>>> ralink without breaking the ABI on the existing schemas.
>>>
>>> You cannot change mediatek->ralink without breaking the ABI for the same
>>> reasons.
>>
>> Then this is where I ask for an exception.
>>
>> The current solution only complicates things more.
>>
>> https://github.com/paraka/linux/pull/1/files#diff-0ae6c456898d08536ce987c32f23f2eb6f4a0f7c38bff9a61bdf3d0daa3f6549R21
> 
> Sorry, I don't understand what's under this link and how some Github
> repo pull helps in this discussion. I don't see there any text, which
> could help.

That's Sergio's current branch, before he sends out a new version of the 
patch series. So that's the current solution, having 
mediatek,mt7620-sysc and ralink,mt7620a-sysc on the schema.

> 
> I also do not understand why this pull proves that you can change
> existing mediatek compatibles (we talk also about ARM, which is shipped
> to million of devices) to ralink without breaking the ABI.

No no, I only want to do this on schemas that concern the MTMIPS 
platform. It doesn't concern the MediaTek ARM schemas.

> 
> I do not see how choosing one variant for compatibles having two
> variants of prefixes, complicates things. Following this argument
> choosing "ralink" also complicates!

The idea is to make every compatible string of MTMIPS to have the ralink 
prefix so it's not mediatek on some schemas and ralink on others. Simpler.

Arınç
