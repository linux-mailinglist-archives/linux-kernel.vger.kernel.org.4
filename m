Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F06C2A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCUGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:39:05 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDB2D75;
        Mon, 20 Mar 2023 23:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679380705; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HgjfFrQ21rle45rF7u9dVNU//yzNvqpj36S5yrhVXcJnJH9rU400kLaMT49PzCzIF/md0A1pteBT+Tjl63s+oOTXd2CHUye0cQx0n52UJomcdRU7wlAeRVx2zJP3Euy1rJmxin3/Tx2gqmcMZFdLs3JeHwK1/Z9AXGMorGA/huU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679380705; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MtqhAiVzYsXN8NBYdM8JpEnwguRTzgJMuNA/bO2XA4o=; 
        b=PWxhhk8K9R/wC+JfBTs1f0l6FXFE6/Dcis2lqxEP4gXWzWZCc5kiVYpNpR6ogwd1oDD0lZpFZ78050JzRUVO3aQp7EuDxX0Ya9YD22/SnUWPeO0W0zvx5RXOlwqtGeZHKkxfVu5Ir/BoXPM5aJDYmZ+kSnrwFsyyJs3nAPER5/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679380705;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=MtqhAiVzYsXN8NBYdM8JpEnwguRTzgJMuNA/bO2XA4o=;
        b=BgyIkyqCvSJo2UtncNvZZPJtrn4L7nivhg9S279FfTyyFzlUrGXVwlRfG7/QtB9T
        EzWlGS49MZJqUz7P74aOH5Q1pYbDo/QWrj2jEmcN0JKJ7bNUitujPXgu2Obc+lw+AKc
        9dMVGNg6t7SsYnIhc6eCMxqZbGYeF3vud9A5noIU=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679380702839868.114840000752; Mon, 20 Mar 2023 23:38:22 -0700 (PDT)
Message-ID: <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
Date:   Tue, 21 Mar 2023 09:38:17 +0300
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
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
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

On 21.03.2023 09:32, Krzysztof Kozlowski wrote:
> On 21/03/2023 05:34, Sergio Paracuellos wrote:
>> On Mon, Mar 20, 2023 at 7:15 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 20/03/2023 19:09, Arınç ÜNAL wrote:
>>>>>> Would mediatek,mtmips-clock.yaml make sense?
>>>>>
>>>>> More, except:
>>>>> 1. This is not clock, but sysc.
>>>>
>>>> Sergio, beware.
>>>
>>> I meant, that's what I understood from what Sergio said. :)
>>
>> Yes, you understood properly. I will use 'sysc' instead.
>>
>>>
>>>>
>>>>> 2. mips sounds redundant. Do you have rt2xxx and mt7xxx chips which are ARM?
>>>>
>>>> All of the SoCs, RTXXXX, MT7620, MT7621, MT7628, MT7688 are MIPS. So I
>>>> decided to call this platform MTMIPS as I've seen MediaTek use this on
>>>> other projects like U-Boot. This is what I did on my pinctrl patch
>>>> series as well.
>>>
>>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which are
>>> ARM, so mediatek,mtmips-sysc would work.
>>
>> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles will
>> start with ralink. There are already some existent compatibles for
>> mt762x already having ralink as prefix, so to be coherent ralink
>> should be maintained as prefix.
> 
> The compatibles I mentioned start already with mediatek, so why do you
> want to introduce incorrect vendor name for these?

Can you point out where these compatible strings for mt7620 and mt7628 are?

Arınç
