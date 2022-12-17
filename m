Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3E64FCFC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLQXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 18:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQXG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 18:06:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2495FE5;
        Sat, 17 Dec 2022 15:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3177B8098E;
        Sat, 17 Dec 2022 23:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073E9C433D2;
        Sat, 17 Dec 2022 23:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671318383;
        bh=bqFARoqphpHbyhbrxZUsG+sj09U5aINP1y9RjnZgMzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CkinHnDSV71qouT/0CdbN0kx6wvIptd79x3UNAA+Tr3+azRa+jFeOtLI5d4QHqMsQ
         0DQodXMzY1SR7VAygEYCVjEEmZumgbYUTzqmuvuZSh/IYUAmYGRvAXFTix5Khbgb1D
         L5wObwO1wPACZCIIbSARcvRtlcPc8/u2TslWiAneZN7/i25fnMzZrnCG3BbzcOBwUf
         c2Ka8zn4X5bxLxc6DRsu08l/0SNO5olIK9t8YZo7E9FukTAWJMvwMNvR70PTWhOl5s
         1NkQp7v1abKsgedWhve643x74TK3QgNb9b0EHMxM6GpY8MLmxPDHai6a1M5WOLxQ3a
         M6581qpoqbTYQ==
Message-ID: <4f42ebf8-a5bd-6d98-0515-f4872c7c33a8@kernel.org>
Date:   Sat, 17 Dec 2022 23:06:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220126200350.3633576-1-clabbe@baylibre.com>
 <Y54BbjoRm5z2Tlp8@spud> <Y54uAuwrwU5Nl8kp@Red>
Content-Language: en-US
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <Y54uAuwrwU5Nl8kp@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2022 21:00, Corentin LABBE wrote:
> Le Sat, Dec 17, 2022 at 05:50:38PM +0000, Conor Dooley a écrit :
>> On Wed, Jan 26, 2022 at 08:03:50PM +0000, Corentin Labbe wrote:
>>> Converts hwmon/gpio-fan.txt to YAML
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>
>>> I didnt found any clear maintainer and since DT yaml mandates a
>>> maintainer section, I set devicetree@vger.kernel.org.
>>
>> Hey Corentin,
>> Looks like there were only some minor comments from Rob on this patch,
>> but I do not see a v2 on lore. Just never get around to sending a v2, or
>> did it fall through the cracks?
>> Thanks,
>> Conor.
>>
> 
> I just forgot it.
> 
> I will send v2 soon.

I didn't expect soon to mean 4 minutes later!
Thanks!
