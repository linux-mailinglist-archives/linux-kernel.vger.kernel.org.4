Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7806C2B83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCUHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCUHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:31 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767C3A85C;
        Tue, 21 Mar 2023 00:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679384406; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=g1mAIwAQGJnaDzbnyLbbzm1j87A7ju1iQLgaVLiGWTejB4ENaHbjVQ4q3CQvPS6nNhS6A+1JBzrlQNS7nW6lZI608Aoa9AGyAqruvMaaszlAbKVu6002H6mqfDPXE7EEou7Jbzs0dqcvuv2y2zZtixdPQOCEL7+WLShJ5VxHsiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679384406; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=p2SUM8/cC3gHbNv0XONomYTYaBPcNpwOnKNM8Drt0Vs=; 
        b=VyHjevJxvbEadEICJUk0vDsgjGrGpcixuWOJCkblHAhnfBFC/2tBmzRPyPbkcR8HxlXu7Vdnu05iXDqqXxeh7shdpG166aSUbtK9GjS9nkdeXjPe4zKAGa9NVyvQNdDU6M6rpEsFQSqU302kQrrVSQcH8HC9uPECCTIyupr2QQQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679384406;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=p2SUM8/cC3gHbNv0XONomYTYaBPcNpwOnKNM8Drt0Vs=;
        b=dLbxK1i5BZ5T4QGFnoMn37spsq+kiWfce65LRkHUitLVJp4z1IoNIYSTPUtSIpGw
        MGTgLdP2127lAwzyoBDm74mCrvMcvefpR1tZBwDZV8+9lMtl1VSjkCF9QyHxxX9Qrnu
        IOJirXJAQMQCaMpK27XdVN72po2W4CGYFIzMjGfw=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679384405241467.2005830717892; Tue, 21 Mar 2023 00:40:05 -0700 (PDT)
Message-ID: <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
Date:   Tue, 21 Mar 2023 10:39:59 +0300
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
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
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

On 21.03.2023 10:19, Krzysztof Kozlowski wrote:
> On 21/03/2023 07:56, Sergio Paracuellos wrote:
>> On Tue, Mar 21, 2023 at 7:43 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 21/03/2023 07:38, Arınç ÜNAL wrote:
>>>>>>>
>>>>>>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which are
>>>>>>> ARM, so mediatek,mtmips-sysc would work.
>>>>>>
>>>>>> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles will
>>>>>> start with ralink. There are already some existent compatibles for
>>>>>> mt762x already having ralink as prefix, so to be coherent ralink
>>>>>> should be maintained as prefix.
>>>>>
>>>>> The compatibles I mentioned start already with mediatek, so why do you
>>>>> want to introduce incorrect vendor name for these?
>>>>
>>>> Can you point out where these compatible strings for mt7620 and mt7628 are?
>>>
>>> git grep
>>
>> Not for *-sysc nodes. The only current one in use (from git grep):
> 
> We do not talk about sysc nodes at all. They do not matter.
> 
>>
>> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
>> plat_of_remap_node("ralink,mt7620a-sysc");
>>
>> That's the reason I also used prefix ralink for the rest.
>>
>> Does it make sense to you to maintain this one as ralink,mt7620a-sysc
>> and add the following with mediatek prefix?
>>
>> mediatek,mt7620-sysc
>> mediatek,mt7628-sysc
>> mediatek,mt7688-sysc
>>
>> That would be weird IMHO.
> 
> What exactly would be weird? Did you read the discussion about vendor
> prefix from Arinc? mt7620 is not a Ralink product, so what would be
> weird is to use "ralink" vendor prefix. This was never a Ralink. However
> since there are compatibles using "ralink" for non-ralink devices, we
> agreed not to change them.
> 
> These though use at least in one place mediatek, so the above argument
> does not apply. (and before you say "but they also use ralink and
> mediatek", it does not matter - it is already inconsistent thus we can
> choose whatever we want and ralink is not correct).

My argument was that your point being Ralink is now Mediatek, thus there 
is no conflict and no issues with different vendor used. It's the next 
best thing to be able to address the inconsistency, call everything of 
the MTMIPS platform ralink on the compatible strings.

If we take the calling new things mediatek route, we will never get to 
the bottom of fixing the naming inconsistency.

Arınç
