Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAEF72B34E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjFKRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFKRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 13:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C0187;
        Sun, 11 Jun 2023 10:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DAEB61151;
        Sun, 11 Jun 2023 17:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8CB3C433EF;
        Sun, 11 Jun 2023 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686505412;
        bh=yj37bOV7I6EvZfBgval39j5Pv4HVDeEBlGs+fXJsXdo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pq2ZMGrysqk5iUBSFxsKfS8Abu+/OolPq5C0LQyNpjEk3mE22iW5VYeNfmH/EbFsy
         akRcQu814CDrLIHBo2rLLQHYXDh5HtnOXnpsw2SJTTDWVo+rVXe2osB7kF4sIPtcug
         NC+6BwHfRe8eIn9LQ9i8xfar6kxtLwYxuddq9sYdETwRxw/6iJNL8YZSPgR52AuMeO
         SwSUyIhCvsfe958uuBI++UhlrTPnS8qv0i+ihaIAN5As4pyl+5HwTrjK/JI2VVFyGC
         c7LpbcTzuG1FG25n60YScpT9Cyvo4czSJlAcSlA5QheBauQPQa+MnKdSyVWOfADYjI
         UhLGWWyCE4VBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D38A0C43157;
        Sun, 11 Jun 2023 17:43:31 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msURVv3pndri8KF4iL74L8PJjMO6Rd7sWDuLanpmmRffg@mail.gmail.com>
References: <CAH2r5msURVv3pndri8KF4iL74L8PJjMO6Rd7sWDuLanpmmRffg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msURVv3pndri8KF4iL74L8PJjMO6Rd7sWDuLanpmmRffg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.4-rc5-smb3-server-fixes
X-PR-Tracked-Commit-Id: 1c1bcf2d3ea061613119b534f57507c377df20f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65d7ca5987f29f4c3d5c0889d2f046bb246d18d4
Message-Id: <168650541185.29074.9398636507053251003.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jun 2023 17:43:31 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Jun 2023 20:59:05 -0500:

> git://git.samba.org/ksmbd.git tags/6.4-rc5-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65d7ca5987f29f4c3d5c0889d2f046bb246d18d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
