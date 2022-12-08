Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1C647765
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLHUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:41:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FF84B49
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E820C61F52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 20:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C4EC433EF;
        Thu,  8 Dec 2022 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670532092;
        bh=Uh9aVjphYymvrr8de0ee4jR1evK/WHgZK1WWp9Wx/FM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qP47zRY8IGTU2fb9xyPVtnMAIXhCweHh0NJGCkO6cpsLwJbBOX+tec8x/xe6WYFCT
         piZzpBgagtH6iCMlTecKi4blYWT2wGAEWn+9+HeQd39yUKLwxFTQkhDld80Xb0MhPq
         1ZltzzQx86SDRtKFEFzxoF/4BK7to9qrVL1gjhVBAxXs/GUWASG0wheDUcbuwkdUSO
         RzI7VyzmYuzU1yiKxcMfZr1/sTffISjlApdGKJQ0ZS7KAqmUIhb8jRCWMPu/VmUsL3
         n3Y7ayhzgdLJmnLFDtdaqKLqtkNQ1DqHgEifWNka35RMAal9WPLjwBDhWZAovCMhgM
         tNO1SfTCIWHkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CFEDC433D7;
        Thu,  8 Dec 2022 20:41:32 +0000 (UTC)
Subject: Re: [GIT PULL] HID regression fix for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2212082109060.9000@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2212082109060.9000@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2212082109060.9000@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022120801
X-PR-Tracked-Commit-Id: a9d9e46c755a189ccb44d91b8cf737742a975de8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce19275f0103934828cb19712b6d8552c39476c8
Message-Id: <167053209223.22607.17807584955181257433.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Dec 2022 20:41:32 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Dec 2022 21:16:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022120801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce19275f0103934828cb19712b6d8552c39476c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
