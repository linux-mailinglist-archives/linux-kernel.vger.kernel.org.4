Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A453A60E45F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJZPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiJZPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:23:42 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 08:23:41 PDT
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6859A9F8;
        Wed, 26 Oct 2022 08:23:41 -0700 (PDT)
Received: from localhost ([::1] helo=tynnyri.adurom.net)
        by tynnyri.adurom.net with esmtp (Exim 4.92)
        (envelope-from <kvalo@adurom.com>)
        id 1onhk2-0000bQ-4O; Wed, 26 Oct 2022 17:50:55 +0300
From:   Kalle Valo <kvalo@adurom.com>
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
        <20221020041440.3f6c1e46@canb.auug.org.au> <87ilk6y7nv.fsf@kernel.org>
Date:   Wed, 26 Oct 2022 17:50:50 +0300
In-Reply-To: <87ilk6y7nv.fsf@kernel.org> (Kalle Valo's message of "Wed, 26 Oct
        2022 17:35:32 +0300")
Message-ID: <874jvqy6yd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Hi Stephen,
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>
>> On Wed, 19 Oct 2022 16:23:24 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> On Thu, 20 Oct 2022 03:23:40 +1100 Stephen Rothwell wrote:
>>> > Today's linux-next merge of the wireless-next tree got a conflict in:
>>> > 
>>> >   net/mac80211/util.c
>>> > 
>>> > between commit:
>>> > 
>>> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")
>>> > 
>>> > from the origin tree and commit:
>>> > 
>>> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")  
>>
>> This should have been commit
>>
>>   45ebac4f059b ("wifi: mac80211: Parse station profile from association response")
>
> BTW I have been trying to reproduce this conflict to no avail, do you
> still see it?

Never mind, I see it now. Sorry for the noise.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
