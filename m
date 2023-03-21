Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F66C2C95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCUIfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCUIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:35:16 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF4222F0;
        Tue, 21 Mar 2023 01:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679387632; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RZ33c6MMbBaIUiN6tW6Y444tiInEw5dnZH4aJV04Ggrj2u77jkKN7Pptmq3Cj7mjRsimoPNbY52IDoe68FM3Saz0QyZ+8bMeZQjd/NWHjP6v72mGi17IXVPqEduQ6cDh4tic5wutYf7FTBaDR1SG6zo+jx3Vr8NNQE0ZpDHfmSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679387632; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8hpQK9ToNpRcIR0nUQvwZUjbZt8M7a1xsGtg97t/jT8=; 
        b=feFPt9K259BOOQvAzSGLpAj7UrqyPI6kaaLGi0SQbdOllKThreMgImG7kATvATJGwsflLdL/pu018hivdCiApDvJPZm+iwEaAS8a5w4MteDnt999Gvq8g1mI++qUM7hepkNbViR5BpU9e2JXq7QjjfgplDw7ZxfhlvKh8hErGvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679387632;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=8hpQK9ToNpRcIR0nUQvwZUjbZt8M7a1xsGtg97t/jT8=;
        b=N+x6iwsLl0kkIZvL5WzjHEHkXFoBBvW3/lNB4gleJO2NHWXD4gOH1PyVt7RWQQih
        dSVEFvydqUMmFHUQPi6N9PgT/HVXTDqJtX8643HofqSdID9gsCxXSswfQc0VUINguHx
        VfiT1ErqjShopml8rg+dbxTTNoI3vAZrdP1MZ5QM=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679387630600838.4456904705892; Tue, 21 Mar 2023 01:33:50 -0700 (PDT)
Message-ID: <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
Date:   Tue, 21 Mar 2023 11:33:46 +0300
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
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
 <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
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

On 21.03.2023 11:27, Krzysztof Kozlowski wrote:
> On 21/03/2023 09:24, Arınç ÜNAL wrote:
>>>>
>>>> If we take the calling new things mediatek route, we will never get to
>>>> the bottom of fixing the naming inconsistency.
>>>
>>> All new things, so new SoCs, should be called mediatek, because there is
>>> no ralink and mediatek is already used for them. So why some new
>>> Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?
>>>
>>> You can do nothing (and no actual need) about existing inconsistency...
>>
>> I couldn't change ralink -> mediatek because company acquisitions don't
>> grant the change. I don't see any reason to prevent changing mediatek ->
>> ralink without breaking the ABI on the existing schemas.
> 
> You cannot change mediatek->ralink without breaking the ABI for the same
> reasons.

Then this is where I ask for an exception.

The current solution only complicates things more.

https://github.com/paraka/linux/pull/1/files#diff-0ae6c456898d08536ce987c32f23f2eb6f4a0f7c38bff9a61bdf3d0daa3f6549R21

Arınç
