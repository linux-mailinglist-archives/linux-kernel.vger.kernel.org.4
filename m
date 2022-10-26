Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F160E10E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiJZMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiJZMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:40:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD777E9E;
        Wed, 26 Oct 2022 05:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB505B82246;
        Wed, 26 Oct 2022 12:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8B7C433C1;
        Wed, 26 Oct 2022 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666788012;
        bh=FJ31cqAnQKzd03R5Ig4+m6Igv2FCyJA6gs796fBnpJw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AdcL4NB52XVTG7zzBcAt94N/c5iYpT3VAq0rLiUPRW8tfIlS2DQyf6RTNcHKboz/G
         rWWDtZaAiADHOPCEJGjdQZt7bapnt5f4Z4H68Fcs9Z2u0taHoUSYKU1cmll+H/ejLA
         p+LPiBlCReuCVo9Zk9des+ij8jmCKAx6jBzaz8npFntyOt5dYAau9qzeAU97k8oLZj
         0mcPMTIqBs5QwvOD3oscCxoF0UIL6Bqc/vpHqUvL0ov5Beh3YPW1Ra82phOUqsdk0U
         j9U0BJiBGdV88iKQoKhl65zHJDxUoBhIWH//IWx5MKxAcCNAP1UbDmnZv38V/flD+2
         VZK1jp1l60n2g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
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
        <20221019165258.1ea6daa6@kernel.org>
Date:   Wed, 26 Oct 2022 15:40:03 +0300
In-Reply-To: <20221019165258.1ea6daa6@kernel.org> (Jakub Kicinski's message of
        "Wed, 19 Oct 2022 16:52:58 -0700")
Message-ID: <87pmeeyd0c.fsf@kernel.org>
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

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 20 Oct 2022 04:14:40 +1100 Stephen Rothwell wrote:
>> > Dunno if this is a glitch or real problem. But it reminds me - I see
>> > there is direct wireless -> wireless-next merge without going via
>> > Linus's tree. I think you may have mentioned it to us, but not sure
>> > if I said this clearly - let's try to avoid such merges. Linus certainly
>> > doesn't like when we do net -> net-next merges without sending net to
>> > him first and forwarding. I'm not 100% sure why (maybe Steven knows)
>> > - whether it's an aesthetic thing or avoiding real issues thing, but
>> > either way it's _a_ thing :S  
>> 
>> Has Linus really complained about you merging the net tree into the
>> net-next tree?
>
> I can't find that exchange right now. Maybe it was about merging
> back his tree into ours without submitting a PR. Hm.

So yes, we merged wireless into wireless-next in commit dfd2d876b3fd
("Merge remote-tracking branch 'wireless/main' into wireless-next"). But
that's only in wireless-next right now, we will send a pull request to
net-next soon.

My understanding is that Linus does not like excessive or pointless
merge requests, and his recent email[1] says similar. But in our case I
think the merge is justified, otherwise we would have conflicts between
trees, which means more work for everyone involved with tree merges and
most likely even bugs if the merge resolutions are difficult.

And we were not planning to do this often, maybe something like once per
cycle and only then there's a strong reason for the merge. Naturally we
would document that in the merge, just like Linus prefers. Thoughts?

[1] https://lore.kernel.org/all/CAHk-=wgb42XG1c_rtwupJMD9QXbJsE6k_TBKYC4YvZ8bkATcVg@mail.gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
