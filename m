Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBC6C2020
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCTSkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCTSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:40:08 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057102D16C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679336618; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OYpZ8/MOy9/Sv5w/gjuY/jMFNCToIzLNTzT7zIWp77kYm+evVOI3i5rrD82y8xKaQHI+DFYsDmQq+HuUob7hJ4obnCQ9AeSCodFtRq5UyivirXi+hvxsg0wHY2KYXWUiqMaJmeWGOI1kueZkVmo2EtIMCwJfuT0EJf1fo8Coayo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679336618; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=so7tX6OW8//LFmzMA4l6Ntrngg/J9YJH/igJ97ZyXrs=; 
        b=nG+N3IzKipK81vh2DnBEWZ8Y1CgdD+jEQ1D9BoF9T2V/bW5f//TrVk2G4VbXCsegA61dg7RYLPTmlvBy4e1sf3Vx6AUvN4H5x9z4NXdHG2yn3i+X9i+A9Cf3r5+uAStQzLwpb7Gv4dl8gCYmJENCGMuLyKVslIsmeXq2+5qH9hU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679336618;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=so7tX6OW8//LFmzMA4l6Ntrngg/J9YJH/igJ97ZyXrs=;
        b=NZ4+d6yGK+tBdGjKHfUksQWt0tCnk+puc1vo3QZUhzsoHC79RJwvm5HxqS5q3hrg
        3JhkFabTOWBa1ztiHnK4Z7iFHTOI287C6BZCiSVkQNsnKI1RvLGnPp5ULpSbPZapvEw
        GXPya8bJ9vqJBCKpJZXp3el2kpfLIhU0uzeG2x7k=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679336616427517.2861213917661; Mon, 20 Mar 2023 11:23:36 -0700 (PDT)
Message-ID: <6a8989c5-f12d-a4cb-9b20-29049dee016e@arinc9.com>
Date:   Mon, 20 Mar 2023 21:23:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <5109c01b-48bd-2854-3f42-bf8ef8b4a821@linaro.org>
 <9cfd5bc1-64e9-5250-5a8d-18ac4c205584@arinc9.com>
 <f323f1bc-1d91-f8bb-2c1f-2f1b93fe1b3e@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <f323f1bc-1d91-f8bb-2c1f-2f1b93fe1b3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2023 21:11, Krzysztof Kozlowski wrote:
> On 20/03/2023 19:07, Arınç ÜNAL wrote:
>> On 20.03.2023 21:01, Krzysztof Kozlowski wrote:
>>> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - ralink,rt2880-sysc
>>>> +          - ralink,rt3050-sysc
>>>> +          - ralink,rt3052-sysc
>>>> +          - ralink,rt3352-sysc
>>>> +          - ralink,rt3883-sysc
>>>> +          - ralink,rt5350-sysc
>>>> +          - ralink,mt7620-sysc
>>>> +          - ralink,mt7620a-sysc
>>>> +          - ralink,mt7628-sysc
>>>> +          - ralink,mt7688-sysc
>>>
>>> One more comment - this and maybe other compatibles - have wrong vendor
>>> prefix. This is mediatek, not ralink.
>>
>> This platform was acquired from Ralink by MediaTek. I couldn't change
>> some existing ralink compatible strings to mediatek as Rob explained on
>> my pinctrl patch series that we don't do that. The compatible strings on
>> this patch series here are new but I'd rather keep the compatible
>> strings ralink to keep things consistent.
> 
> The comment that you cannot change existing compatibles does not apply
> to these, because these are new. However indeed some SoCs have already
> compatibles with ralink, so it's fine for these. mt7620 and mt7628 are
> already used with mediatek, so these should be rather corrected to new
> prefix.

If you're talking about the pinctrl schemas for MT7620 and MT7628, it's 
just the name of the yaml files that have mediatek. The compatible 
string is still ralink so it should be kept ralink here as well.

Arınç
