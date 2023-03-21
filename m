Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653D36C2D79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCUJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCUJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:04:14 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5CE497CE;
        Tue, 21 Mar 2023 02:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679389375; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WqRN3QzU/H7CaDpyz81HgDFIkuUMULXko1qK+O+0z29BUNDrIhGPK3QqY3tfkvJs0fEMjoY8lR8RtPbczIE9J87IdJn87deu4cme5ydsQavkHZU2us1W4Jfufj5ixCmx6xloQSdhIBGELL6SKgkNP26z1YwEYDcPgSErnnimVTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679389375; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sB3XH7Ovi9XCs+7jQmmSOIgLMpgr0aqXAXi1VknrLAU=; 
        b=h7/UY7O9kNpcsBI3wTGm9bh6zGM9SYpYrfK7cX0m4HhEaRSPiCFdYpwIrWgrjOFCEQw/IyLpnokvkAMvz9p1memBfVzWuORRh4Y0upaQvND86V+5NlWVKNpIjruybNt28hMvsYgTA2/Gyn+8pT6m3q0OI1wFpanfyVFY2s0JpCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679389375;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=sB3XH7Ovi9XCs+7jQmmSOIgLMpgr0aqXAXi1VknrLAU=;
        b=cWA94N13PqvOSF08RkF11GPjZqAX0mPMweYC254siqNGr7+QHGaKmvnb7TA9o4QV
        Hh+2uuWV1+sx/jHM49gZzCj+dIXUU7sMdXl+L0NYe4t/tFnsEh12BoOvF84ctIgntd8
        66sIdn8RAOsjFJa3FTOd+0BEZVfhNSu7VPMqT2Iw=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679389372126149.2113472793228; Tue, 21 Mar 2023 02:02:52 -0700 (PDT)
Message-ID: <6ed317bc-ce3a-2da2-1d96-f0ea8ff0b48c@arinc9.com>
Date:   Tue, 21 Mar 2023 12:02:47 +0300
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
 <1c279b0a-c814-2fe3-0432-2aa6b3dff16e@arinc9.com>
 <9f8e7a74-35c6-6db5-4960-1efa79a23983@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <9f8e7a74-35c6-6db5-4960-1efa79a23983@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2023 12:01, Krzysztof Kozlowski wrote:
> On 21/03/2023 09:53, Arınç ÜNAL wrote:
>>>
>>> I do not see how choosing one variant for compatibles having two
>>> variants of prefixes, complicates things. Following this argument
>>> choosing "ralink" also complicates!
>>
>> The idea is to make every compatible string of MTMIPS to have the ralink
>> prefix so it's not mediatek on some schemas and ralink on others. Simpler.
> 
> Which is an ABI break, so you cannot do it.

No, both strings stay on the driver, it's the schemas that will only 
keep ralink.

Arınç
