Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2864E41A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLOW7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLOW7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:59:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041575D695;
        Thu, 15 Dec 2022 14:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958C961E4E;
        Thu, 15 Dec 2022 22:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A861C433D2;
        Thu, 15 Dec 2022 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671145150;
        bh=bryYAKiUz+q78gc+5DZIT7J6SqFM4Y3HWT7kn+IKE3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fs2Zx5nQ7HLkSC6ZW8CwPk575xRTXfi+ws61OwC+UoLV8h7rKadiXbvbHU4pQxGBX
         0qskh5q57uGlEsQhEpvvQXoyFNQ5OaBZgiIPEQ2kZ4fxQf4KDXxdkbhf7XkmP+aA6B
         xAERXSDU8j0TjlUVrGXmgHpN+TbwuUE5incNN9iiJEeoy61eHq6WmTDvhyWmT38fOF
         w26oICLiwg9a5LzVmglsMXGOFN/vd7AZhbNfum06phISIU9QqPFV++YmkCTxxUBnh6
         vrGyrMff/i9MhQUMXVZIVGl3Qywfho49kTdinMD0WDcPDR7uGKqkz7AgYHv42zpacw
         XsslJwIyxue4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED2BDE4D00F;
        Thu, 15 Dec 2022 22:59:09 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mve4N+szjwBM2qebKwVdC_fybKEaG8JeeMLk-S_D0dckw@mail.gmail.com>
References: <CAH2r5mve4N+szjwBM2qebKwVdC_fybKEaG8JeeMLk-S_D0dckw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mve4N+szjwBM2qebKwVdC_fybKEaG8JeeMLk-S_D0dckw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part1
X-PR-Tracked-Commit-Id: d74f4a3f6d88a2416564bc6bf937e423a4ae8f8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 851f657a86421dded42b6175c6ea0f4f5e86af97
Message-Id: <167114514996.1903.1282503941170678808.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 22:59:09 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Dec 2022 16:40:44 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/851f657a86421dded42b6175c6ea0f4f5e86af97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
