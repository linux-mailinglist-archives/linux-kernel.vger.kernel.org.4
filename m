Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C96B11BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCHTGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCHTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:06:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA443470;
        Wed,  8 Mar 2023 11:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0991261908;
        Wed,  8 Mar 2023 19:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6582C4339B;
        Wed,  8 Mar 2023 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678302316;
        bh=4579myHlZN9028AWu5vKlgKiQpdTskFF5YbznY9DXHs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=fMaPrr+CXmlgTlLTxYN07FtYLmw0su0eIQl4b3c01QC2HWnHNTMK2FM7grL+JWhKK
         3iTjUiIGJ/9BLo2f/6k557BuIeYkCpScSSiAklScWLhTQRiY1LIx++j6WRfJT7zxFx
         IRyfLBAZFRnIcFSumGoRhS6dulelz81qRLLWoqSFfPsyqwn7iMnyA545gSAaIHKlAS
         r1wT4ng7BoLkruuTtYaCic4X/a6jRJu35Ejb66uSoEPHgJK7pbTzKZD3iwjLI/LLit
         HZQ2Bfil4QeATZXS50OlUfhaVNO8/cRtzWVU7iQnFOCa9KK5VGaSRqheGtWYnAmKP3
         8/AKOw16m1IAQ==
Message-ID: <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
Date:   Wed, 8 Mar 2023 20:05:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
 <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
 <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 19:45, Dipen Patel wrote:
> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>> On 14/02/2023 12:55, Dipen Patel wrote:
>>> Added timestamp provider support for the Tegra234 in devicetree
>>> bindings.
>>
>> 1. Your commit does much more. You need to explain it why you drop some
>> property.
> ACK, will address it next patch
>>
>> 2. Bindings go before its usage (in the patchset).
> Ack...
>>
>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>> people and lists to CC.  It might happen, that command when run on an
>> older kernel, gives you outdated entries.  Therefore please be sure you
>> base your patches on recent Linux kernel.
> It is based on recent linux at the time patch series was sent...

That's good but then why you do not use scripts/get_maintainers.pl? The
hint about recent kernel was just a hint... Just do not invent addresses
by yourself and use the tool to get them right.

(...)

>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - nvidia,tegra194-gte-aon
>>
>> This is an ABI break. Does your driver handle it?
> yes, handling patch is part of this patch series.

Can you point me to the code which does it? I see "return -ENODEV;", so
I think you do not handle ABI break. I could miss something but since
you disagree with me, please at least bring some arguments...


Best regards,
Krzysztof

