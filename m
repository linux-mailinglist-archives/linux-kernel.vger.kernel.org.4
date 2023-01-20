Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4479D67603C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjATWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjATWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:38:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6722A25;
        Fri, 20 Jan 2023 14:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A09ECB82A68;
        Fri, 20 Jan 2023 22:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AA0C4339B;
        Fri, 20 Jan 2023 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674254307;
        bh=QLbPU9eAYmoROBLx3KkIcxhf9AIMhTr5gxbMIOoCkVk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uWSY6Fva9TlKBhqyRQwP0L95svJ1kLUo/yQ6PchHLJup/YQhd9d6hqlGuggMujzRJ
         tAq3LRBUK9+11QeV3JDGKsyHYvsX790pNQN1hh/ci3EqnXwlySKCJQVeSa42ZO4vVs
         mJpUEGfTmKSQgXusDUSs2R0PW2SppFr2LcVnz4oQ3rga3qEM820xE7oT9HV2ceD0WP
         CQ1SPb7ldjo1y7hRZt3aVlQZ/PW2c5BHQKJKBZQplpJulQJUs5UKYy5rnIoXhKHnQZ
         pP7DCJ4LA16dbQ4gttSVGUY+EHdWS3OA3G/8yDYvf4sxTalhdv2Pl19umAfZn9LD9J
         1SoJhB6FZmZqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47B09E54D2B;
        Fri, 20 Jan 2023 22:38:27 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtJDpG9COgrDSrytNvcsCruxe1svD5CtjeYnakQDjrVCQ@mail.gmail.com>
References: <CAH2r5mtJDpG9COgrDSrytNvcsCruxe1svD5CtjeYnakQDjrVCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtJDpG9COgrDSrytNvcsCruxe1svD5CtjeYnakQDjrVCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc4-smb3-client-fixes
X-PR-Tracked-Commit-Id: a1b7c8457ecc062f612a1aca174c2e1c21f9ac10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e31badaa188d0e2923f5082c041083c05bda3ff
Message-Id: <167425430728.2096.9732513153474237440.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 22:38:27 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 15:23:33 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc4-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e31badaa188d0e2923f5082c041083c05bda3ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
