Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201E73C440
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjFWWo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFWWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84EB273F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BFD66118F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBF84C433C9;
        Fri, 23 Jun 2023 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687560266;
        bh=nhbg9ZFKjKecA0OTjNLj1c/LfuvE4mH8UyK2Ogh0b20=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rTvgM3fflverPK55Oy2BAHnnd3bL22Kworbnqw8zpgKJNWiwLbgfIkR3gabEkhYft
         Ijs6lzMZNtcEVH6Vb7OUmyXc96NOu1YL1a323wzxkN6XUS6nYfzjGkwdPbG9vnj0k+
         alnIISTEzPlPr4DFYRLAnIfwV9SBIQ/viqPnbxuGtbbE+SPQzRFbzO1HXPKZyhGSqs
         XmC321y6PHdgUCuO7dkGs9lnlTkqJaXMy+fNHOd6y+R11OzaeCDFBEUjtdeKFS7hNh
         7FmA0odiGil+K0frta9YBoCfXwazD/GcQ4BpzlfTBw1Af4hSauwX30nvsoMj6gHNVc
         5Y/RVtqJmvltQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B73C7C43143;
        Fri, 23 Jun 2023 22:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87352ixqlh.wl-tiwai@suse.de>
References: <87352ixqlh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87352ixqlh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4
X-PR-Tracked-Commit-Id: 6f9441f4e3ebf86b8a0427f14ee1753f2183a3cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61dabacdad4e7d464c11f715ae6b065151a73078
Message-Id: <168756026674.32686.18300845879981755878.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 22:44:26 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 15:20:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61dabacdad4e7d464c11f715ae6b065151a73078

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
