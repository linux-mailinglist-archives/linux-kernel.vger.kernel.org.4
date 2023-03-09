Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045D6B2D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCITHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCITHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E9FCF82
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACB78B82073
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6264AC4339E;
        Thu,  9 Mar 2023 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678388829;
        bh=6kszQ0J66kwG++Us0O4Gnb6AIrWssa9P4xZYmvxCXr0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eWsKD+BIOTu4RbC5RYE/pKJOemlcsA1Frjkk6Re270YRrDPlyMVIE1ongJ6VAHT+T
         gbgdiX6QUtTGelnjHJF4t6fZAtFMkDCdFDHClo6Us/KqYaYsLTXNSV7nvWr1mFhlSV
         bKHSBmr0hEcvQplA+C54I3Ma5wsJ0yeoDNCzG2DcaEAYxGCgH9bJ7dlmG3aKGYbJ/0
         p5pt7aCGCyQv308ti6Vcj+psRK1ZzJbH2NGTQL0Qw+ypxaRmIWFH64TtRh8YNuthPK
         Ts8dtHT5lat3j5QLMlCdYXVliQoTgJGEBuxyBIGiGgXHtQhdfe3w36sAcJcULavNyl
         xZC8WnoegUK4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 487D3E4D008;
        Thu,  9 Mar 2023 19:07:09 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230309150636.sdg5ifko7waqr6rh@mail.corp.redhat.com>
References: <20230309150636.sdg5ifko7waqr6rh@mail.corp.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230309150636.sdg5ifko7waqr6rh@mail.corp.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023030901
X-PR-Tracked-Commit-Id: 8ae2f2b0a28416ed2f6d8478ac8b9f7862f36785
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2653e3fe33f411227296552b2e5f9c2640924900
Message-Id: <167838882929.4761.10177843954882034655.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Mar 2023 19:07:09 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Mar 2023 16:07:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023030901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2653e3fe33f411227296552b2e5f9c2640924900

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
