Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99DB6D39A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDBSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjDBSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:02:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF1CDC4;
        Sun,  2 Apr 2023 11:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E6A0B80F10;
        Sun,  2 Apr 2023 18:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14295C433D2;
        Sun,  2 Apr 2023 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680458525;
        bh=s+3aut4dzx49Tpfk1jQ7bdm/uqHONBcDKv/95RZNTo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s0HNlhi/vg/bQo4JrwiUpofI5GRNm6Rr1WcmH8ZYkgQN/CU2g4iXiJrt7euDVeFVj
         fMdPY2popcsBSOfSuykKbzq2f3cAvuBpKOGL6KWN5aBa3LSlFLjGaJHfMad5M4P09r
         9wSg2tqjiAnJHKYVef6diLLxPSxw4MrA2Pvy5hPETF/Ox7TBUwJax8rSVk9ebhJcne
         vB1ouHYD45v9++TxeoY4VYTviEeEEhCas6vRTtAvyDfDdMBX/3ds8HAyYe6X3+noKI
         xl3aJfJgajmK2rpQBTPK9Y8M9UwPd/yGFoIBhZyKgnwwWldD9vNCMP0K5tVrqWLOK2
         5qHgINkphrd/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0273FC73FE0;
        Sun,  2 Apr 2023 18:02:05 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtvRF98xs3FCjc+WcfdR2wNVLNTqn=h+rYvtkj22T2f4w@mail.gmail.com>
References: <CAH2r5mtvRF98xs3FCjc+WcfdR2wNVLNTqn=h+rYvtkj22T2f4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtvRF98xs3FCjc+WcfdR2wNVLNTqn=h+rYvtkj22T2f4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc4-smb3-client-fixes
X-PR-Tracked-Commit-Id: e03677100707f849f01d8faf07ee58b4e56cdbf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7772da66255ab2b478a33df404a335fab55cc25
Message-Id: <168045852500.9845.4905937925386678170.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Apr 2023 18:02:05 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Apr 2023 16:32:58 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc4-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7772da66255ab2b478a33df404a335fab55cc25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
