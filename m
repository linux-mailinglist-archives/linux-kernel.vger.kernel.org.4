Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F96C2C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCUIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:25:00 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2AD53E;
        Tue, 21 Mar 2023 01:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679387085; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=i05bnC+eqsZ/guCkE1iDRgrw/24mMV66GoLFVESxqjw3330+WDiXIPf5bJdpAJX6vUCQT+xiICC32CVERizh4mfpG+cRfxxnfR4pidCsrBqE9E5DjnseudCIh85QaNRRhirmn6vJ9Ouq752FVeqevCobspMyyYLAGBYGxJG48BQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679387085; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=od2igUX/Gb6z7tl9jzyrfJnWIXU+B/ka6PHP7kBPVDQ=; 
        b=Vde4uie4FCtAiYzgRpH6dPsFp8dxCqhagPU4pCNu12bnjsdbsrKhYDAU9G+6Rb03nrijskINTzuwkWJysnzAEOzkDq6khxnXkx51VN3w59Drk9PgTcz5iAAISv5gV17Ua0vj33LCpW6LfQSdiNljJ4qvx/Lj/59Q+9s/P0rrT4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679387085;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=od2igUX/Gb6z7tl9jzyrfJnWIXU+B/ka6PHP7kBPVDQ=;
        b=C7pD7bJJX6X9uVIcDUYWRRDn352MDvLOKIE8pWASUbWXtgMKJgDpg9UBvrPX8iBe
        ZS2ItuAaF1UW/LK1P3d5UO/2IoFSuX2M8rNhI2FcuQMQ7dHM6ld/h/+PO0Nb+2YsepF
        g6GwWz0xmMvuQ00s4IhIrd7syVBOncSAB+z+lsWg=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679387084074537.1592183726682; Tue, 21 Mar 2023 01:24:44 -0700 (PDT)
Message-ID: <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
Date:   Tue, 21 Mar 2023 11:24:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
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
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
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

On 21.03.2023 11:04, Krzysztof Kozlowski wrote:
> On 21/03/2023 08:39, Arınç ÜNAL wrote:
>>>>
>>>> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
>>>> plat_of_remap_node("ralink,mt7620a-sysc");
>>>>
>>>> That's the reason I also used prefix ralink for the rest.
>>>>
>>>> Does it make sense to you to maintain this one as ralink,mt7620a-sysc
>>>> and add the following with mediatek prefix?
>>>>
>>>> mediatek,mt7620-sysc
>>>> mediatek,mt7628-sysc
>>>> mediatek,mt7688-sysc
>>>>
>>>> That would be weird IMHO.
>>>
>>> What exactly would be weird? Did you read the discussion about vendor
>>> prefix from Arinc? mt7620 is not a Ralink product, so what would be
>>> weird is to use "ralink" vendor prefix. This was never a Ralink. However
>>> since there are compatibles using "ralink" for non-ralink devices, we
>>> agreed not to change them.
>>>
>>> These though use at least in one place mediatek, so the above argument
>>> does not apply. (and before you say "but they also use ralink and
>>> mediatek", it does not matter - it is already inconsistent thus we can
>>> choose whatever we want and ralink is not correct).
>>
>> My argument was that your point being Ralink is now Mediatek, thus there
>> is no conflict and no issues with different vendor used. It's the next
>> best thing to be able to address the inconsistency, call everything of
>> the MTMIPS platform ralink on the compatible strings.
> 
> And how does it help consistency? The mt7620 is used also with mediatek
> prefix and adding more variants of realtek does not make the
> inconsistency smaller. It's still inconsistent.
> 
>>
>> If we take the calling new things mediatek route, we will never get to
>> the bottom of fixing the naming inconsistency.
> 
> All new things, so new SoCs, should be called mediatek, because there is
> no ralink and mediatek is already used for them. So why some new
> Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?
> 
> You can do nothing (and no actual need) about existing inconsistency...

I couldn't change ralink -> mediatek because company acquisitions don't 
grant the change. I don't see any reason to prevent changing mediatek -> 
ralink without breaking the ABI on the existing schemas.

Arınç
