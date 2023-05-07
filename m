Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE58B6F9ACC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjEGSMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjEGSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C3840C1;
        Sun,  7 May 2023 11:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBAD616C9;
        Sun,  7 May 2023 18:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 505F6C433D2;
        Sun,  7 May 2023 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683483126;
        bh=UkkbW5V/b2Ee7c/0XpGX1hdrLyYkcdi3OZcw8KIAbLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jjsJzQu71yiSa+tg0XhHR/vCof7CmsFhohDnWhTHFqSO4dnwfXrVMO6rKSjucaQb2
         iRpLdCWGCmLToqF+Fk/DUn2G25tf6oxVOxelzLZ3xukFsp8RWFxHHLHouKNapRkeGX
         cANC3EmFp1h90FGYKZaf+ft6F7z/O5mDMs+PlAtp9bCmP2/xxc3Oz/Le7gTE3abdbL
         67AtvlqJ/NXtKshD9uaS5IYtc8LFd6Pd5kEH7VWAvn2sLTVhyMmEy3frqLHpReJjrY
         p2QCnQyP6E+7UwYiQoNewJzffcptovJfXGUU9HLzr+OV7hQyOTHSzNYxfn1+t2iIGa
         SUe5rN+IpcxLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EA8BE5FFCC;
        Sun,  7 May 2023 18:12:06 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muHUgLTaYUcWWEucCmdBR=JHgEAC+oPePBgLVKpJxHYVA@mail.gmail.com>
References: <CAH2r5muHUgLTaYUcWWEucCmdBR=JHgEAC+oPePBgLVKpJxHYVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muHUgLTaYUcWWEucCmdBR=JHgEAC+oPePBgLVKpJxHYVA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: 9ee04875ae73412f5071f6ec1af01788ec271e7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63342b1dd5f884d97b41b0cd04fae01a69e0a762
Message-Id: <168348312625.16669.2594566272822393155.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 18:12:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 May 2023 15:45:24 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63342b1dd5f884d97b41b0cd04fae01a69e0a762

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
