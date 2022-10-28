Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41877611C39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJ1VK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJ1VKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C6B155D84
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EB162A7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DF1CC433D6;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991449;
        bh=ImvQq1RwfCfKyA9eW89Ju+KhWE2wPoIMcvQO91587u0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rMBSiUt84jSOTGJOKjZ19tYN+/Iu88WsSRJ0aAx3kNFH/07hofqoEE4wN8oauGlzy
         PHf90tYLDecpmaetSXk4U18dZp7FRVhP9C7ibdloPffsK2me9AP5A73tDd6yI3v3/V
         tT7rqiXKb+itFWkyKnpqITxMbW1d8xJ5g4Xn/WkOE7V1utvfdEB4hmScZwHuBTgxuu
         Q2SnsGKoTw6VRCCODCa4f/yjp1tMWCbYIfVZ6OfrVQHAIsHAW0FogPtul4VAeELM8W
         rNbUFXrffj4epYe9vHI5iRVAJBr5J1voNRDNI6wGnu2wrxLDk7W/PTKVdZpiEnUYjR
         x+ejmO7WEhBgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A1C7C41671;
        Fri, 28 Oct 2022 21:10:49 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edusmh37.wl-tiwai@suse.de>
References: <87edusmh37.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edusmh37.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc3
X-PR-Tracked-Commit-Id: f1fae475f10a26b7e34da4ff2e2f19b7feb3548e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f186fd2f5a83fbfe85b1f0048d741c0726f5119a
Message-Id: <166699144916.13387.8503032319549429673.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 21:10:49 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 11:29:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f186fd2f5a83fbfe85b1f0048d741c0726f5119a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
