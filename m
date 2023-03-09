Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE66B1B45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCIGRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCIGQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:16:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE992DBB5F;
        Wed,  8 Mar 2023 22:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690A8619A9;
        Thu,  9 Mar 2023 06:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E589C433D2;
        Thu,  9 Mar 2023 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678342612;
        bh=BtthgR0zbwmyvaFDelFkF+Pa981UtRRUf5qDW/VObEI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=N9DWIXFLEWQU7zpt7PMFfgOh9+s008I4WsuaTbdcLwGtw1dAcwh1KI6FRxxqRPihR
         w2lgJS3F2FZtXLChCFLoduHaMIglZG7pqEyaKSR8KyGiHeNCKI1AnAPrCf95aaVbKX
         K8y9DVVCFp7OEfwyLaeEYCnl0IYDcwcGJqFRMVVJSncGDu9cKYpwchUa/ZsOmgUQaw
         KjeTCdYRDv2rd/tRqg5O1Rj86jrgb8leRoWzS5VhOV+sPUdaDU4htL7No7UnDpEiko
         t/ATUSKPQcVZqUwT1nWjVG47mqk2WaPRWJmJd6VVgAtwsYdLBYm86O3CZlB3jPhukf
         neZ8wK1iuQHsg==
Message-ID: <ab9f7730-d399-0786-67e5-aad57716809e@kernel.org>
Date:   Thu, 9 Mar 2023 07:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
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
 <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
 <18f9a6ca-a61b-4cbb-b729-1fdb6d48651a@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <18f9a6ca-a61b-4cbb-b729-1fdb6d48651a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:09, Dipen Patel wrote:
> On 3/8/23 11:05 AM, Krzysztof Kozlowski wrote:
>> On 08/03/2023 19:45, Dipen Patel wrote:
>>> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>>>> On 14/02/2023 12:55, Dipen Patel wrote:
>>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>>> bindings.
>>>>
>>>> 1. Your commit does much more. You need to explain it why you drop some
>>>> property.
>>> ACK, will address it next patch
>>>>
>>>> 2. Bindings go before its usage (in the patchset).
>>> Ack...
>>>>
>>>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>>>> people and lists to CC.  It might happen, that command when run on an
>>>> older kernel, gives you outdated entries.  Therefore please be sure you
>>>> base your patches on recent Linux kernel.
>>> It is based on recent linux at the time patch series was sent...
>>
>> That's good but then why you do not use scripts/get_maintainers.pl? The
>> hint about recent kernel was just a hint... Just do not invent addresses
>> by yourself and use the tool to get them right.
>>
> I will take a note for the next patch series to add any missing people. The current
> list of people/group is what historically helped review this new timestamp/hte subsystem.
> 
>> (...)
>>
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        enum:
>>>>> +          - nvidia,tegra194-gte-aon
>>>>
>>>> This is an ABI break. Does your driver handle it?
>>> yes, handling patch is part of this patch series.
>>
>> Can you point me to the code which does it? I see "return -ENODEV;", so
>> I think you do not handle ABI break. I could miss something but since
>> you disagree with me, please at least bring some arguments...
> Refer to patch https://patchwork.kernel.org/project/timestamp/patch/20230214115553.10416-3-dipenp@nvidia.com/
> which has compatible properties added and also code changes to reflect addition/deletion of some
> properties.

I referred to the code which breaks the ABI.

> 
> I am not sure I have understood about ABI break comment. How else one should handle if
> there is no related gpio controller property found?

In a way it does not break existing users? There are many ways to handle
it, but I don't know your code to point you.

> I am assuming you are referring to the
> below code from the patch 2 (link above) when you said "return -ENODEV".


Your bindings patch points to ABI break without any
explanation/justification. Then your code #2 patch actually breaks it,
also without any justification.

Best regards,
Krzysztof

