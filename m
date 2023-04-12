Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827E6DF509
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjDLMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjDLMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCBB8;
        Wed, 12 Apr 2023 05:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3D462BE8;
        Wed, 12 Apr 2023 12:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53377C4339B;
        Wed, 12 Apr 2023 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681302211;
        bh=D85mqhWoBtVu7CAzMrgEbwz60PEDS/RonuJOphKnaSU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MsGq+SOydUlADJ4Rg8uCFtXnqlNTiIoBxrN35Fx2Mu3zLkSgmn2z31v/t+t+ViciY
         Y8ThdvURExiIc+bohB/Cg8pOQMyFcFQkA8HZuJheruXtVcYy5VDq6nymEklKqdnlEu
         NPRbr3YM0FL5BLgCIl7gG06tBJZGDAzkA3WdEN9ayCuDDIM/exN6WowpzytFog53cr
         kvhr3QEgj6RFGyqERy3eBZVGRkwfX9QvwN7J1wQuH6kOqic4UskYH4TDI0P74N/4Yk
         s1XiP+4C+5cb1e/RbVgAz9EoBmDmME7qAZMg1m2oiRDeez6hXVbPIVZLkJf45d7tg7
         386S9gUpb2+XQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org
Subject: Re: Introducing bugbot
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
        <1f0ebf13-ab0f-d512-6106-3ebf7cb372f1@leemhuis.info>
Date:   Wed, 12 Apr 2023 15:23:25 +0300
In-Reply-To: <1f0ebf13-ab0f-d512-6106-3ebf7cb372f1@leemhuis.info> (Thorsten
        Leemhuis's message of "Sat, 8 Apr 2023 14:10:40 +0200")
Message-ID: <87fs958f2a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> CCing Kalle (JFYI)
>
> On 03.04.23 23:45, Konstantin Ryabitsev wrote:
>> 
>> 2. Start mailing list threads from pre-triaged bugzilla bugs. This works the
>>    opposite way and creates mailing list threads based on bug reports filed in
>>    bugzilla. The useful things here are:
>> 
>>    - bugbot only gets triggered on open bugs in Linux/Kernel that have the
>>      "bugbot" flag set to "+", which allows pre-triaging a bug before bugbot
>>      sends it to the mailing list
>> [...]
>
> Are there any policies or best practices on how people should/are
> allowed to use this? From what I can see it seems one needs to change
> the Product/Component of the bug to start a thread. I wonder if a few
> maintainers that are active in bugzilla might be annoyed by this, as
> that might break their workflow.
>
> Which puts me in an awkward position when I see regressions reports in
> bugzilla and would like to create threads for them. Using bugbot would
> be better then the manual forwards I do now, like this one:
>
> https://lore.kernel.org/all/ed31b6fe-e73d-34af-445b-81c5c644d615@leemhuis.info/
>
> But here I decided to *not* use bugbot, as I know Kalle sometimes is
> active in bugzilla -- and thus might hate it, if I re-categorize the bug.

Yeah, for me moving ath11k bugs away from Drivers/network-wireless
component is not really helpful. And for ath11k I try to look at all
reported bugs in bugzilla anyway, though just slowly.

While at it, I have some things on my wishlist to make my use of
bugzilla.kernel.org easier:

* A new state named UNCONFIRMED and have it as the default state for
  reported bugs. This would help triaging bugs as some of the reports
  are not valid. In other words only valid bugs would have NEW state.
  IIRC the Mozilla project did this back in the day.

* Use P3 as the default priority for the new bugs. I try to keep ath11k
  bugs in priority order but new reported bugs having P1 always messes
  up the list always.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
