Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD5D5FA484
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJJUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJJUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF39FD0;
        Mon, 10 Oct 2022 13:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5F160EFB;
        Mon, 10 Oct 2022 20:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B313C433D6;
        Mon, 10 Oct 2022 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432311;
        bh=yLv3ICh4+I7b0dgrE2R+b8Hd6EQbkWbmXK5ezOHOZQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qAstQwersBC5pqnHVBMI5hLbAxk8aDAd2apYg1DAr9p7lUW8hgxWPairt0uD7Y4b2
         5qgHVNNW4c2CPvVVlu+jxIrjJouoxLI2OTwig96BSPgsrjl3SDoL7KDV7Cjrl0v3DZ
         t2nmRqlJThShi29n4Fc4M/hRNictyiGj+0zRIZX4fs1hVsXd5kE0oC55lv1NwtG0nd
         g27pKJprf/tv7j6RBngAtKNsWT8LFqj6lq7aJMW0Uf87/Ul3wh/2cPZjdT6HomDB4Y
         udtghc7W7Mc3vb20oavln6fsly5tMR0rxf8YfkV04bU1WbLdImeb2Fkr+6Hpg9xhQs
         +ynRGFchetbbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AF7EE43EFE;
        Mon, 10 Oct 2022 20:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.1
X-PR-Tracked-Commit-Id: 0715fdb03e2c4f5748d245a231e422602ed29f33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8afc66e8d43be8edcf442165b70d50dd33091e68
Message-Id: <166543231104.6988.6365668300308952249.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:05:11 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 23:29:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8afc66e8d43be8edcf442165b70d50dd33091e68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
