Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650E6C8926
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCXXQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCXXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:16:01 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0F1632E;
        Fri, 24 Mar 2023 16:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679699724; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=d3y3LPZCu4SPmmoSoE4F1CKylg9Vm+wwqfkQOsexnma8glSM3yZaxhSJMRACbP/yFteQ4gO62P7wItEi51gh9h7B+fNM/01aZLlDA+huCBSf0xO1Wz9b2ekw96x3MtA3IyEKZ+65DvkJHGIdQUyRCa/lnqpMlStvdciNsjd/rpE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679699724; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UOBDa6MyNkcFKIV/F23N+9xhrYR0u9RTEEtDZX8a+jo=; 
        b=PGgjg6WzgXvVJ7+M1kVx4MceFBzhhK5bs9GIPE8B4XJ0hdqNqCrdZ8REIF/1ayTgYldAVmcoOJlH98TbDG4mlk0Xsk08CFsyc4sXmYW5yqqvyi+3oYnwsJu7ZXIjEcawLkfo+hNmaeFeaku9ZiUH6y/+j6Y1Qmu30kOoz+3oZ2E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679699724;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=UOBDa6MyNkcFKIV/F23N+9xhrYR0u9RTEEtDZX8a+jo=;
        b=cTkJFg04WU+lmEEpriyfAYjs6ld6bnmkkqmxjxzSg8xX/AvIpNqRhb3BPjAqOx9o
        GshsQrsLfAX9T6l9o911AjvyyTZNuyvkJgZk0DBEMeJrl3j2Lm5P1hTGkFG2gagvlFY
        4eoqBvUxJVXXKFo2Xw/oRDTXLuWNKa5R4J+OvP/A=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 167969972213758.27737140967122; Fri, 24 Mar 2023 16:15:22 -0700 (PDT)
Message-ID: <3fdc7db4-0df3-f922-3dbf-9f9250c271aa@arinc9.com>
Date:   Sat, 25 Mar 2023 02:15:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
 <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
 <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
 <2150938b-5433-6f51-c404-2c0f6976f864@linaro.org>
 <1c279b0a-c814-2fe3-0432-2aa6b3dff16e@arinc9.com>
 <9f8e7a74-35c6-6db5-4960-1efa79a23983@linaro.org>
 <6ed317bc-ce3a-2da2-1d96-f0ea8ff0b48c@arinc9.com>
 <20230324221029.GA64664-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230324221029.GA64664-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2023 01:10, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 12:02:47PM +0300, Arınç ÜNAL wrote:
>> On 21.03.2023 12:01, Krzysztof Kozlowski wrote:
>>> On 21/03/2023 09:53, Arınç ÜNAL wrote:
>>>>>
>>>>> I do not see how choosing one variant for compatibles having two
>>>>> variants of prefixes, complicates things. Following this argument
>>>>> choosing "ralink" also complicates!
>>>>
>>>> The idea is to make every compatible string of MTMIPS to have the ralink
>>>> prefix so it's not mediatek on some schemas and ralink on others. Simpler.
>>>
>>> Which is an ABI break, so you cannot do it.
>>
>> No, both strings stay on the driver, it's the schemas that will only keep
>> ralink.
> 
> But you are adding one of the strings to the driver, right? Still an ABI
> break, but only if you have an old kernel and new DT. That can be
> somewhat mitigated with a stable backport of the new id, but still an
> ABI break.

Ah, that makes sense. Yes, I'd be adding new strings to the driver.

> Whatever is in the driver should be in the schema too. 'make 
> dt_compatible_check' will check this. And some day, I'd like that list 
> to get to 0.

I'll keep this in mind for the schemas I maintain. I will add 
ralink,rt2880-pinmux as deprecated on the pinctrl schemas so it would 
disappear from 'make dt_compatible check'. I believe I'm supposed to do 
it like this?

properties:
   compatible:
     enum:
       - ralink,rt2880-pinctrl
       - ralink,rt2880-pinmux
     deprecated:
       items:
         - const: ralink,rt2880-pinmux
           deprecated: true

Arınç
