Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264970AF7B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjEUS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjEUSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037312B;
        Sun, 21 May 2023 11:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9FDB60EE2;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3615BC433EF;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684692578;
        bh=j0rvlUHfUVrFxS8a6kSVC8ETDNMwBXvUQlXQOjGM0Kg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IhQ4IS7ifxfmGYRQNoyjLUT1B72iQ7i/K4bLTPEm2ZwUilB19Ath8MFmzmXe8IRyk
         AJ7rGE6d8Iaq0/YLB1esqqr3t+ARacyFX6vELOCGzA4bvVpLUUV37+7IZFSfT3/9ce
         +8AX7BJr6Zt1IFDW6xhoBoG+d6Z8bbiVKV00T0g2FA57nVGdVHVv8NkLLloYsqP8sw
         5d+GtPydsP6yEdRZs0ZgC2V6otryL5LxRQRoM0lvoA3ECzB/IXjfFziVP6c5BqN3rf
         VabZxW0Ri8XEp0brDH7uNireTF3MqC8P10qpXHfIoMu+45XmcjMkbDfAwPhtKDUdwM
         Ra1kNSqDBsXYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21475C3959E;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msKAPYH17pZOiZ8Mv2FV96HpAQ5P0+KVXv+uG=uvb0tZw@mail.gmail.com>
References: <CAH2r5msKAPYH17pZOiZ8Mv2FV96HpAQ5P0+KVXv+uG=uvb0tZw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msKAPYH17pZOiZ8Mv2FV96HpAQ5P0+KVXv+uG=uvb0tZw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc2-smb3-client-fixes
X-PR-Tracked-Commit-Id: 59a556aebc43dded08535fe97d94ca3f657915e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c9dcf128ef99c257dcde5dbb8683605009906bf
Message-Id: <168469257812.2919.7517356976985544350.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 18:09:38 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 May 2023 23:52:37 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c9dcf128ef99c257dcde5dbb8683605009906bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
