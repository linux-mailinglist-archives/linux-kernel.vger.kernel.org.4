Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7D6C1F63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCTSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCTSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:19:04 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807D392AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679335771; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=chIWHuy37NfAceRgh1oPpJxLogBXt29oQG4sJH/zTgCLt7dMKK0xWPvWInivxbqZAGY/K5HgVl47+UmsQH14PTTuL1BVLVB3y/40U7JnLbhFN9wyUKhticNFaG9uTV2r+nG3VP3Rnzn4mzDZlkKDV5dg+IOHDSxTc4sBZVQAYVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679335771; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=PYyaIm+P+mYKvMnaRpw6FVJYvgJmgrTISJViVNyUny8=; 
        b=iMnsJkWVyBPD/f6fsNxj3CW1PiwzdM+3evKSxnwB8L7veKvu+73pCxpSMUzqmnu9Pwgf5P/2KU6df7jr2dHbnEpzJF2lYvYviSxquSufDPPX/nySDpbMKpBQbHthaHSfN/Mw9jojiNI82eWhLLAJqHv6ysz+jfDYt5sUHtd+lzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679335771;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=PYyaIm+P+mYKvMnaRpw6FVJYvgJmgrTISJViVNyUny8=;
        b=S4/+gBIziSW84Unoza728oZBbCKdLYDIR88/iiZt6dFesRgZKWIYrnIPuKYMwWVb
        jcSZvPrV7uLcakvvAVzvmEMlC3RMygaHKYxcZl8RztDH4sLz5ySOt2pE9piprhaumjx
        xQqiNeXY80YckKJDHwWDGN4X524hyO0ck2qi8qdw=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 167933576955541.427630471938414; Mon, 20 Mar 2023 11:09:29 -0700 (PDT)
Message-ID: <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
Date:   Mon, 20 Mar 2023 21:09:25 +0300
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2023 21:02, Krzysztof Kozlowski wrote:
> On 20/03/2023 18:57, Arınç ÜNAL wrote:
>>>> All of these are at the end the
>>>> way we can properly match compatible-data to write a proper driver.
>>>> The current ralink dtsi files which are in tree now
>>>> are totally incomplete and not documented so we are planning to align
>>>
>>> Nothing like this was said in commit msg, so how can we know?
>>>
>>>> all of this with openWRT used files and others soon. That's the reason
>>>> we are not touching
>>>> 'arch/mips/boot/dts' at all now. I don't think anybody is using any of
>>>> this but mt7621 which is properly completed and documented.
>>>
>>> Anyway, none of this explains exception from naming convention - vendor,
>>> device or family name.
>>
>> Would mediatek,mtmips-clock.yaml make sense?
> 
> More, except:
> 1. This is not clock, but sysc.

Sergio, beware.

> 2. mips sounds redundant. Do you have rt2xxx and mt7xxx chips which are ARM?

All of the SoCs, RTXXXX, MT7620, MT7621, MT7628, MT7688 are MIPS. So I 
decided to call this platform MTMIPS as I've seen MediaTek use this on 
other projects like U-Boot. This is what I did on my pinctrl patch 
series as well.

Arınç
