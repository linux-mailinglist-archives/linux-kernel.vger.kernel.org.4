Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D964AC84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiLMAg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiLMAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:36:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9A316484
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CC9CB81042
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2EA4C433F0;
        Tue, 13 Dec 2022 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670891782;
        bh=1JHpiuYfoFTivjaarnC/iUvURHa8yAyVbg/u5zQ3BpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lw08qo4uqiXfQfTDgY2bSsJPr1AClmuP8bNz0VHsm6GNjNy0Pp60VukI/gbxFjCZ0
         W8W8OlZpfHXQvMGdaAsxZsshJQgJV3bTxGrzxSn/cQ7GPGG53QBZt9D03x2Bkku4jb
         ABjzlOluLe6sVKK55u6YiJUewmpid+qxyapZSKJR9Lyz4IvHb0Wn2l/Si63NF2AdQR
         2gjox3q6MK5r41JXZiTuGQ5U6iDDjr7f4H77AqKQ4FI49JkkjTmG65MAyYANNhcEFc
         0bQO7QW+hoqd3JdTzrqD+6R8m5imtXkSUR9dAP3NBnzc7l/61LOox6lrh1TP3VAlP2
         yLtQ/oDIre/OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9D74C00445;
        Tue, 13 Dec 2022 00:36:22 +0000 (UTC)
Subject: Re: [GIT PULL] percpu changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5dhRrNFzNX1Z64/@fedora>
References: <Y5dhRrNFzNX1Z64/@fedora>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Y5dhRrNFzNX1Z64/@fedora>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-6.2
X-PR-Tracked-Commit-Id: d667c94962c1c81ef587ac91dc5c01a1cfe339c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1443c7e75a28c6fde5c67cb1904b624cf43c36
Message-Id: <167089178268.4798.15939054678237929741.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:36:22 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 09:13:42 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1443c7e75a28c6fde5c67cb1904b624cf43c36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
