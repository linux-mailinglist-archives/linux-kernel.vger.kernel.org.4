Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6D64E0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLOSaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLOS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654524876F;
        Thu, 15 Dec 2022 10:28:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A8EB81B0B;
        Thu, 15 Dec 2022 18:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6AA8C433D2;
        Thu, 15 Dec 2022 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128923;
        bh=HO6pevyUao/aOCVkxHh+lrrFVCIdD2FxNhXwF4ECUmI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dJvlzrPkN45yJyGGEzXanv277j5S64bdeAYcm+QaPeHocRYOkqNJ4e2jtskIqC7+k
         FpuOIU3ZShIotkO4qGOvFsGrqDeG5o2mpizM0LIJyN/t3gBtPCWZCShkNPDDZ/6x24
         X7ZGWXzNJcJ/oS5iPvSJB5KYBDv9jhkhVds5n0XHHKtX/A6E9n05kReu4cF50x4PuY
         /FxKkTa7UziQnZv5U33HiuG33vgq6lI0uTtXsDA8n++3Ekywrff1B/UGcjUOebINzY
         N3Y1RYRidk7DVUrzsJWUdoGn3U9VTri0IdohjYP86cOWeH4myCNBFXvrWER8m0ynZK
         NgI6FFTLPhngA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9714BC197B4;
        Thu, 15 Dec 2022 18:28:43 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
References: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.2-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 72ee45fd46d0d3578c4e6046f66fae3218543ce3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 504a73d46bad8964be2cdaa63a2bedaef198ea3b
Message-Id: <167112892361.20649.11546129183422634830.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 18:28:43 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
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

The pull request you sent on Wed, 14 Dec 2022 21:18:14 -0600:

> git://git.samba.org/ksmbd.git tags/6.2-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/504a73d46bad8964be2cdaa63a2bedaef198ea3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
