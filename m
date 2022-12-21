Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496F66535A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiLURx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiLURxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:53:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82522BDA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C3A0CE1876
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2969BC433F0;
        Wed, 21 Dec 2022 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671645198;
        bh=mwfOVeuQ2/KZmWwHmpVbZjfCeiGA0qA8rK6v/w1N7c0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GHWweNrt4P2xEHfF0CGgB6iXEphNfB4opIlQO27Xfl3jO/0zAu1KNBnx0RYEg2Y0I
         GMlufRn2MYXneP+UDbcz1uZvGXl3vjeRPHrPzfe2x5vLiSMT9oZGU5x174ZsKpOVT8
         t4clHdBRpNaYyUy62nJkkYH+ApJWfNba1t7BNxhzAy7IQ9qYTN8rvJ7DU34Q5S1EqO
         lKA8WUsoXyoQCA1Jzx/1Xsi3VtqGZqmvu1TGPmtCk5dixL1uK2qQtEacF1VeiwRTsf
         FHiWz+cKzopKWC189R3E4qgY6LhlxQEfAnujlNcBQI2ckQT2aR6GCVdCvz1c7YcafP
         s6AunCq69yFsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DA3DC43141;
        Wed, 21 Dec 2022 17:53:18 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c80b4fac-a515-b15e-7233-92145bb2a39c@redhat.com>
References: <c80b4fac-a515-b15e-7233-92145bb2a39c@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c80b4fac-a515-b15e-7233-92145bb2a39c@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022122101
X-PR-Tracked-Commit-Id: 54f27dc53f1764986d417cfafe1013806deba668
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d264dd3bbbd16b56239e889023fbe49413a58eaf
Message-Id: <167164519805.28688.5004655309179403860.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:53:18 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Dec 2022 16:18:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022122101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d264dd3bbbd16b56239e889023fbe49413a58eaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
