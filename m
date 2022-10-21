Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A136080EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJUVrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:47:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722A275B85;
        Fri, 21 Oct 2022 14:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17BB0B82D6E;
        Fri, 21 Oct 2022 21:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C15B3C433D6;
        Fri, 21 Oct 2022 21:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666388855;
        bh=8sORvRqXWAKFtluv9rdmmrgW2g89KzHzAc1lVtR1/Uk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JWRc/dKYQO2sv7N2z/uAEsfcXRK47yXZdhAdm0ItCNEJLvkEVzu+GaZSlXaAcJWWz
         iAUP92BjeqVkfCziWRRME8P20/8H/ssjx5jjcYiKnSrxogc+pztnd4OLUM1eoJoeMo
         s4qjPr56aHjNEz0puEJKxBtxgLBvYpvAngdpUwS6x13lqE+Xr2C7A9HK8OFVMEa3uA
         0AVr3Nq21MZzaSNlzn/l4gI6cf713zKJQd4VzKR0cjeqmJvhDXg1fwf120givb+ksB
         f6DkdvXa7x/mPRvXZ9rziK+7UUyd46Gzyr+lXXHUMS5ja9E8BF9sLrQ0Ix8oTw9TUv
         3uKzZn2y2bupQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC92FE270E0;
        Fri, 21 Oct 2022 21:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v6.1 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
References: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221020
X-PR-Tracked-Commit-Id: abe3c631447dcd1ba7af972fe6f054bee6f136fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0de0b76837c2e958ad0e8fa9abd9846843fbf3f8
Message-Id: <166638885569.26127.3497258280531687383.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 21:47:35 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Oct 2022 11:20:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20221020

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0de0b76837c2e958ad0e8fa9abd9846843fbf3f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
