Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBB6C4526
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCVIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCVIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:36:44 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4D3B3F9;
        Wed, 22 Mar 2023 01:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679474119; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VxpK86Dv374oplQqRnwCEhqmj4Zo+qKAVSW9meqZGBm5jDpDlGtRXX86xjSSgfjdJumsIpQTBWUyg6yTIZCwpUnFqQzyMI7tk2ZBtp24wv4Kage98qJVUsYFOw7YG4YxwoMsBMqsnMgCV8n0YGx2QYoxzkhfDKNU+qPdC2wJN4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679474119; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5oAP0W3ZqSOBqmB59Et1t8fJn6L4/71xzO8TcHCvQOg=; 
        b=jaCBC8idU27IvTP+eSE7rJlUKTyHgClDy69BjfGkSYawNgPN0tYWizqaIjxtGuEIGiCVD3h+2ck4gH9bn065SKAkn2oNobRVIWvcWoIIza3XRADXr+VwCAkJYUUBbCoubW0slHtyyo7BSUBMbgAwJiBP/x0/CMYkleD8sxJ23Yk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679474119;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=5oAP0W3ZqSOBqmB59Et1t8fJn6L4/71xzO8TcHCvQOg=;
        b=IH42g6zqhE/s+NpINEJS1AI7eiS6pR83nvg7TKQlgxEfi+vHFb3tk0tzKWp07JPA
        Z2H3Dyzi2jTRyf8iQL9J+K1oHMG16bEmzLShGz3P/fAjDwx1EdUJbtjstHXB1R8gYTf
        q3zgIhaKcDMFy7Mg9PKn6QTQ7gDNjX/aWc67TPGQ=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679474116878525.6173073863655; Wed, 22 Mar 2023 01:35:16 -0700 (PDT)
Message-ID: <5f9e9d79-a744-99cf-6a53-bd7342252b46@arinc9.com>
Date:   Wed, 22 Mar 2023 11:35:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system
 controller
To:     Rob Herring <robh@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
 <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
 <CAMhs-H_dSgcPNQVusHWVvztYHptOxSJ_o7G0eU9=M1C7RXdsVw@mail.gmail.com>
 <ce13ca6c-e61a-d31e-2626-d818a5d0e15e@arinc9.com>
 <20230321221837.GA1751474-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230321221837.GA1751474-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2023 01:18, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 10:09:59AM +0300, Arınç ÜNAL wrote:
>> On 21.03.2023 10:00, Sergio Paracuellos wrote:
>>> On Tue, Mar 21, 2023 at 7:45 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 21/03/2023 06:00, Sergio Paracuellos wrote:
>>>>> Adds device tree binding documentation for system controller node present
>>>>> in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
>>>>> for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
>>>>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>>>>>
>>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>> ---
>>>>>    .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
>>>>>    1 file changed, 65 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..f07e1652723b
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
>>>>> @@ -0,0 +1,65 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: MTMIPS SoCs System Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>> +
>>>>> +description: |
>>>>> +  MediaTek MIPS and Ralink SoCs provides a system controller to allow
>>>>> +  to access to system control registers. These registers include clock
>>>>> +  and reset related ones so this node is both clock and reset provider
>>>>> +  for the rest of the world.
>>>>> +
>>>>> +  These SoCs have an XTAL from where the cpu clock is
>>>>> +  provided as well as derived clocks for the bus and the peripherals.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - ralink,mt7620-sysc
>>>>
>>>> Since you decided to send it before we finish discussion:
>>>> NAK - this is already used as mediatek
>>>
>>> Sorry, there was too much stuff commented so I preferred to clean up
>>> all of them while maintaining the compatibles with the ralink prefix
>>> instead since that was where the current discussion was at that point.
>>>
>>>>
>>>>> +          - ralink,mt7620a-sysc
>>>
>>> As I have said, this one exists:
>>>
>>> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
>>> plat_of_remap_node("ralink,mt7620a-sysc");
>>>
>>>
>>>>> +          - ralink,mt7628-sysc
>>>>
>>>> Same here.
>>>>
>>>>> +          - ralink,mt7688-sysc
>>>>
>>>> I expect you to check the others.
>>>
>>> I can change others to mediatek but that would be a bit weird, don't you think?
>>
>> I've seen some parts of the MTMIPS platform use mediatek compatible strings
>> thanks to Krzysztof pointing them out. I don't like having some parts of the
>> MTMIPS platform (pci, mmc, usbphy, etc.) with mediatek compatible string
>> while others are ralink.
> 
> That's unfortunate, but again, compatibles are just unique identifiers.
> They are only wrong if they aren't unique...

Understood. Sergio, please keep the new strings here ralink.

> 
>> Like Krzysztof said [0], Ralink is now Mediatek, thus there is no conflict
>> and no issues with different vendor used. So I'd rather keep new things
>> Ralink and gradually change these mediatek strings to ralink.
> 
> So break the ABI multiple times slowly. Again, either you live with
> *all* the existing compatible strings or you declare it is fine to break
> the ABI on these platforms and switch everything at once. Carrying both
> strings (in bindings or drivers) and breaking the ABI is lose-lose.

If removing the mediatek strings from the drivers and bindings is better 
than keeping both strings on the drivers except the bindings, which 
would keep the ABI intact, I'll do the prior and do it all at once.

Arınç
