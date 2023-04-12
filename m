Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE66DFBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjDLQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDLQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EEA40FC;
        Wed, 12 Apr 2023 09:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B757C63765;
        Wed, 12 Apr 2023 16:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95008C4339B;
        Wed, 12 Apr 2023 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681318060;
        bh=BqTptBLVI1dCnRJ0/GjMix6ij4TtxuV6kJqDROI1j1Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=f6oplni109CwS2TqFnZbWPjPKmBqu2qk0XUDILlq7jlI0H5AhPqADCEuPHgJNMi9Q
         TMt3vYRC7poMtBsl58dq6guqo6q8wPicuV+ZQfqflOVunfwdWG6h29HPw5uYWfA7NP
         v9Xlh3wNUk/bduO2svXz0Mk5pYZDGjC2O9i0rxIQdmMg9q+0tzlzN7zXPn9o+yYqKg
         7TLQCUfOZewjc22DBCNxW+bGdUFHraml7r06bMEIzvteHu9LV56kJQOVd6dVrT9ey8
         K6SsNKrtKZYqopQlGknxNte1hZtviRqn5adnBbB/7mEiWJ2k59eQpU4VsNbtj5W/fq
         7Qeml2g3+RE1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        aros@gmx.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, tools@linux.kernel.org
Subject: Re: Introducing bugbot
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
        <1f0ebf13-ab0f-d512-6106-3ebf7cb372f1@leemhuis.info>
        <87fs958f2a.fsf@kernel.org> <20230412-appear-tiring-f5a896@meerkat>
Date:   Wed, 12 Apr 2023 19:47:35 +0300
In-Reply-To: <20230412-appear-tiring-f5a896@meerkat> (Konstantin Ryabitsev's
        message of "Wed, 12 Apr 2023 10:07:21 -0400")
Message-ID: <87y1mx6o9k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Wed, Apr 12, 2023 at 03:23:25PM +0300, Kalle Valo wrote:
>
>> While at it, I have some things on my wishlist to make my use of
>> bugzilla.kernel.org easier:
>> 
>> * A new state named UNCONFIRMED and have it as the default state for
>>   reported bugs. This would help triaging bugs as some of the reports
>>   are not valid. In other words only valid bugs would have NEW state.
>>   IIRC the Mozilla project did this back in the day.
>
> This is more hairy than it looks, but I'll try to figure out what happened to
> the UNCONFIRMED state in our bugzilla.

I can only imagine how difficult bugzilla can to administer. So if it's
too hairy to get UNCONFIRMED working again don't use too much on it.
This is more like a nice to have feature, not a critical thing.

>> * Use P3 as the default priority for the new bugs. I try to keep ath11k
>>   bugs in priority order but new reported bugs having P1 always messes
>>   up the list always.
>
> Okay, I set the default to P3, which is nicely in the middle.

Nice, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
