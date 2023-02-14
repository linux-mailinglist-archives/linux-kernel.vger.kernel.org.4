Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5356956A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBNCYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNCYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:24:17 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6010413;
        Mon, 13 Feb 2023 18:24:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A050841DF4;
        Tue, 14 Feb 2023 02:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1676341453; bh=QrvBfs8ixULKSq9GklOrtp9kQ96xkSGonZTX6j4xO+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Cdtf2ZaKvHQBXUIc/Rzfe4J0xUn+wAGKMfauDfgz+5NtVUJUyrI9HcgPOAC8wUNH8
         3uVGq6k1K5g/FBhqVDdUw7UNc+Q4EQcKlY3+5uj3GvA1pB1gswqmAHhqBNVGJa0tUr
         81jlXVGF9XhZOikv82qxB38645hNQdsnR8sfxAoTY8vw2kIW/e8zf/qPlQRycQ/0Xp
         KAkzKN4uv4gD50pGDi24yuluAyQnfwwTkv6RtNvI3P6KV2Skcavl5/aCMm3QqKUmJJ
         CSCz8i0rvJq5qeTRMdTJtf7I7kSwmdrn4z8NcLSz4enPflO6f7Jp4Bp9ete/kyr09i
         zZely56M5hsig==
Message-ID: <0a33fa04-039f-9a7e-f2a3-2a1a6abc98d4@marcan.st>
Date:   Tue, 14 Feb 2023 11:24:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/17] dt-bindings: power: apple,pmgr-pwrstate: Add t8112
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
 <3287867a-456c-ddc3-adbf-90001950c926@linaro.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <3287867a-456c-ddc3-adbf-90001950c926@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 20.09, Krzysztof Kozlowski wrote:
> On 12/02/2023 16:41, Janne Grunau wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.
>>
>> This goes after t8103. The sort order logic here is having SoC numeric
>> code families in release order, and SoCs within each family in release
>> order:
>>
>> - t8xxx (Apple HxxP/G series, "phone"/"tablet" chips)
>>   - t8103 (Apple H13G/M1)
>>   - t8112 (Apple H14G/M2)
>> - t6xxx (Apple HxxJ series, "desktop" chips)
>>   - t6000 (Apple H13J(S)/M1 Pro)
>>   - t6001 (Apple H13J(C)/M1 Max)
>>   - t6002 (Apple H13J(D)/M1 Ultra)
>>
>> Note that t600[0-2] share the t6000 compatible where the hardware is
>> 100% compatible, which is usually the case in this highly related set
>> of SoCs.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>
> 
> Missing SoB.
> 

I'd rather get an r-b, since this is going back into my tree ;)

- Hector
