Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5070AF82
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEUS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjEUSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5912D;
        Sun, 21 May 2023 11:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD16860EF0;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4988FC4339B;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684692578;
        bh=t0w1HkXLOWdl7/lvvqUQzl6Yu/OO9UX9naeNOOteEL4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MCIuATLtHpd7/ZVs0X7FeSyK8aJwaEKjgKQJbctE6sZirMK8P5IbU723hQ3TA+CYt
         FEh3k40403aC0cxdcoQyE7tKMg1YXX2736OPamR3s7JzAkprXKUMpYJ0+e2zRc2XhK
         ntMoMkOj3x0gMNnnMnVeYkS9KPilJvxQpCCmtfCDqlgRk04ezCVuEfpdNIxwsODqC+
         H6X1+aQchpCpM1ujoC4pvUv8LHSace72GuzeIarLeF8Yoqi8uKn6HBlUeRXA6GI04e
         UOyoss1643waqGvqjMMwkBJNR+9s4TYgeWEs3vERIBIDsO1toOF8hCQXaTHbPPuxEz
         ecMztU5vX9h9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34023C41672;
        Sun, 21 May 2023 18:09:38 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
References: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.4-rc2-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: e7b8b8ed9960bf699bf4029f482d9e869c094ed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2065b8c1b0120d47b327364a1a09090bdc11f31
Message-Id: <168469257820.2919.2123597062450231858.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 18:09:38 +0000
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

The pull request you sent on Sun, 21 May 2023 00:14:35 -0500:

> git://git.samba.org/ksmbd.git tags/6.4-rc2-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2065b8c1b0120d47b327364a1a09090bdc11f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
