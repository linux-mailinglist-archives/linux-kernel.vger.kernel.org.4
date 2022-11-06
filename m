Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404CB61E562
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKFSuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 13:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKFStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:49:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364AFCDB;
        Sun,  6 Nov 2022 10:49:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5E0FCE0E7C;
        Sun,  6 Nov 2022 18:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F9EC433D6;
        Sun,  6 Nov 2022 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667760583;
        bh=1/a9XaPaAPdoM/HUiqVlNW3k6jzFVcmUm7lDa7rTz6o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cZVKbMY7YbMwogEaR6XJfk3Z4nuZ1OeT8dTP3zrN8WjBeTDrtBrWlD6DCH56CF5sO
         Ylyk6TBS1JVE+IV9yt4IZc0/7jr4lWoYk3anFkVErEhhmXMII8UKd+U0VNe/l21bpb
         aMhoj8lA7/5tZBM6hb96oKpfzF7zXI7Dj02nM9GNIAYtrRYvm5rDqqnwodoI6fh25Q
         bQ25CEjxI7VpKXKG5JqO0F4bpgP5dsjGNaA2NX2iYHcFfduy8a64PljQdWPsYnPKtG
         X7wFuou+qajmr/wTIpGP5isH5bso5En/BvJa5o5Joyad2FUk8Pvl+G+Cv9ufMMK5lA
         xN5yj+6hPm9ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25701C41621;
        Sun,  6 Nov 2022 18:49:43 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msckOPtJzUmpzRZAQCQG96nRWDFd=b3An_oiZpU=kwLBQ@mail.gmail.com>
References: <CAH2r5msckOPtJzUmpzRZAQCQG96nRWDFd=b3An_oiZpU=kwLBQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msckOPtJzUmpzRZAQCQG96nRWDFd=b3An_oiZpU=kwLBQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc4-smb3-fixes
X-PR-Tracked-Commit-Id: 542228db2f28fdf775b301f2843e1fe486e7c797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90153f928bee544c794a2410afba6d936a09edce
Message-Id: <166776058314.6751.4099420058110381779.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 18:49:43 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        ChenXiaoSong <chenxiaosong2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Nov 2022 00:07:38 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc4-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90153f928bee544c794a2410afba6d936a09edce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
