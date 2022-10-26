Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E260E372
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiJZOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiJZOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:35:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E3491C4;
        Wed, 26 Oct 2022 07:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC792B822B5;
        Wed, 26 Oct 2022 14:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971E6C433D6;
        Wed, 26 Oct 2022 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666794940;
        bh=x+48O7cslOovb4alCfajPAHTVBLIpgxGIG/BjNakEuU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BIE8ohkyArcywM2fFtNX6bxnFoOap0OB1HrpR+gZ8DrvimZfqgQdzCvciO0oY9vVB
         Nx9RhsEGgzooFcKyAqSrmpVq/RFpY1nR+hFxWOO7N7RTCi2cN18yCJ1v2o51uBVlo9
         CV5AixzaizXMQeMKmuXBm7MBlzalmajrliWCYk9zVZK8MzjAS4T6ctxbnFmUIWDAWF
         9GOrYE8+6EX7GpBpldkBFhQIbZwARlNZrCc1OdbtGtHzP93463DLg6eS3U1wLy51nt
         HHBw/CeuXgkzrRj99RuGIWpsRCfKxUUa9Mi6Eo2L8NimV9oKr17Jn04NifBSwrE17c
         BuV+GXrKDVYyw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Ilan Peer <ilan.peer@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus' tree
References: <20221020032340.5cf101c0@canb.auug.org.au>
        <20221019162324.2baaa7e8@kernel.org>
        <20221020041440.3f6c1e46@canb.auug.org.au>
Date:   Wed, 26 Oct 2022 17:35:32 +0300
In-Reply-To: <20221020041440.3f6c1e46@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 20 Oct 2022 04:14:40 +1100")
Message-ID: <87ilk6y7nv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> On Wed, 19 Oct 2022 16:23:24 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 20 Oct 2022 03:23:40 +1100 Stephen Rothwell wrote:
>> > Today's linux-next merge of the wireless-next tree got a conflict in:
>> > 
>> >   net/mac80211/util.c
>> > 
>> > between commit:
>> > 
>> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")
>> > 
>> > from the origin tree and commit:
>> > 
>> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")  
>
> This should have been commit
>
>   45ebac4f059b ("wifi: mac80211: Parse station profile from association response")

BTW I have been trying to reproduce this conflict to no avail, do you
still see it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
