Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27B7339FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjFPTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbjFPTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387F33AB0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F7561B8F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A1A6C433C8;
        Fri, 16 Jun 2023 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686944127;
        bh=ESUTyCi5EwCLGJ30KrlsfLr7gaBrJN1b8v1ohbJuktE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ufgVe0RaYqzR0q/3naVj33s4baVcalbQRgvnQ84FLYKAWbpmEhEdPanNLoQKtocR9
         cqbnIxH/8gah1d+HuHzmNwK0F4i0CYe71rsGtVw8msxXqydJ+8PhUXi3m8Nb4PfRAf
         AKETuCu+L1JxrzR7hXXe9YVidncMB4a3nPgEr0hwyLfChpk5XsYLW23kn267Ptn4te
         Pig7QkcCtSLE0jGqD8bugibB/Mj3tsUOjeZwMo3OFWVgFWKnNOxqN8WPSp4LY1lt2G
         yjinJ6HuT0KbjatiFaveWWXiGz8S0vtNEU9MHD14BeYciAYlLHr2HgficbbGqURWj+
         gyPkhYtJ5AQRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9B48C395E0;
        Fri, 16 Jun 2023 19:35:26 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ttv77ry2.wl-tiwai@suse.de>
References: <87ttv77ry2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttv77ry2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc7
X-PR-Tracked-Commit-Id: 227d2c3154a93f424503d3e4b7e157288848cf1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4af682124c5b892f554d7fa4d21216530d8da4b
Message-Id: <168694412694.25417.7393469725558210268.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 19:35:26 +0000
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

The pull request you sent on Fri, 16 Jun 2023 10:05:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4af682124c5b892f554d7fa4d21216530d8da4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
