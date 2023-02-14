Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546316956B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBNCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:35:23 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CB12045;
        Mon, 13 Feb 2023 18:35:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 39F7D41F72;
        Tue, 14 Feb 2023 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1676342121; bh=rE6qpyTWbpm8E3scpREdIZtWBIv4E6C9Mb9n1PSac2A=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GvJn3KJxFK8whHrSfnoRkbvaRHCV6G94c5+N9L3/P+DaK4q3p7OA+XbN9ecxsuO58
         O9xkSKBiKX5TDD8DG5Ld7ric4HsIdT+CCFXHihE44X4TjXtjkVI2hgooIdRH3ByXx8
         uSWEon+y0EHzjYywOwzKOE7WHNoXdmqHGQcYW9ugeCWdA47EEbiqTrB1Kq22h6wNnK
         3Caecm4+T5MhZB77KJAn/5yuWOt4+eRygMg4US362vJy5H/EvkZda6XFzg2h1M3DDx
         2aL1V+fAszAxNr+QtYikx7t4mVqbN15c7TcWUAh6VAF6Jx8pa0OqNeFdd+h4Dw1ALd
         PgLXwzW3nRb6w==
Message-ID: <7b33b6de-81d2-0c9b-0e46-59f552eba5d4@marcan.st>
Date:   Tue, 14 Feb 2023 11:35:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Janne Grunau <j@jannau.net>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-2-cb5442d1c229@jannau.net>
 <5ebf96d9-689a-f915-29b8-31af891fc63f@linaro.org>
 <20230213115741.GA17933@jannau.net>
 <dfb765a1-a2bd-c5e3-344a-b368fad6d8de@linaro.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 02/17] dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr
 compatible
In-Reply-To: <dfb765a1-a2bd-c5e3-344a-b368fad6d8de@linaro.org>
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

On 13/02/2023 21.10, Krzysztof Kozlowski wrote:
> On 13/02/2023 12:57, Janne Grunau wrote:
>> On 2023-02-13 12:10:36 +0100, Krzysztof Kozlowski wrote:
>>> On 12/02/2023 16:41, Janne Grunau wrote:
>>>> The block on Apple M2 SoCs is compatible with the existing driver so
>>>> just add its per-SoC compatible.
>>>>
>>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>>>
>>>> ---
>>>> This trivial dt-bindings update should be merged through the asahi-soc
>>>> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
>>>> series.
>>>
>>> No, the bindings go via subsystem. Just because you want to validate
>>> something is not really a reason - you can validate on next. Don't
>>> create special rules for Asahi... or rather - why Asahi is special than
>>> everyone else?
>>
>> We did that 2 or 3 times in the past without commnts that it is not 
>> desired so I wasn't aware that this would be special handling.
>>
>> Merging binding and devicetree updates together looks to me like the 
>> most sensible option since dtbs validation is the only testable 
>> dependecy of dt binding updates.
> 
> But it is not the recommended practice. Bindings were always going with
> drivers and this was said by Rob multiple times.
> 
> For sure if there is no driver update at all or subsystem maintainer is
> not responsive, bindings were picked up by SoC folks, but it's rather
> fallback, not the main path.

Rob also said that we can do trivial compatible additions ourselves and
don't have to involve him or subsystem maintainers. It's too trivial to
count as a "binding" change.

Let's not make this harder than it is. We have a pile of compatibles to
add every SoC that will only keep growing, and we have the situation
where this is largely a formality because it turns out the hardware *is*
compatible anyway (we just change the top compatible just in case). The
list of subsystems we touch will only keep growing. None of those
subsystem maintainers have any useful input to add to this, as the only
people with the information about what compatibles go together or don't
is us (since we're reverse engineering the hardware). All the relevant
bindings are listed in our section of MAINTAINERS. This stuff isn't
worth gratuitous added complexity and involvement. It's hard enough
getting driver changes into the kernel, let's not make it hard to get
devices that *don't* need driver changes on top of that.

>> I'll consider devicetree validation as eventually valid from now on and 
>> not care too much about it.
> 
> Everything will validate once reaches next as well...

Only once both changes hit next. If the DT change hits next first, it
won't validate. If the DT change hits mainline first, it won't validate.
AIUI from what Rob decently told me, this is okay, so we can submit
proper bindings changes to drivers from now on. But I still maintain
that *trivial compatible additions* should go through SoC because
there's no point in involving 15 subsystems instead of 1 every time
Apple releases a new SoC that's compatible with previous ones on 14
subsystems.

- Hector
