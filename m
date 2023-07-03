Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB48746416
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGCUaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGCUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEA10E5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB1661068
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 410DFC433C8;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688416221;
        bh=8Msw49oAWjiU5naC/682akYcI72IxmHY1BvjSjSKqW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h12sCkW5H+KD+QhhgGmYQ11+nkPrkputcUxi78hl5R4Y5Fw/Umi2ML6jyXe5aTbQz
         +rXMjEmEbPPVc4+HbhcDypzHMOw4vRfrLxJvmz8ufqUg438jYMHvjx7A90cXVFodpW
         jnWOsI5fHc9P5/mGAQNfrb84geughitdSrXq9XD9EEgs0GMP3nop5n9wiDimwqkQsS
         U4jM1vv5LKwFPiRko+6hzGrYLz8ziZxLJnTx2l4O/em+8tigofwMAzTdXMFT5Qnh0s
         4ubkvHs2OCh1odIVrG9DSyY8T76GK0Y9iaI16jI9cxvnjZF1nhnxVoYAmD+6jp5jLe
         mgRhhtAkveIFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C874C561EE;
        Mon,  3 Jul 2023 20:30:21 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core update for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKKeQTv0ful5Ji_f@kroah.com>
References: <ZKKeQTv0ful5Ji_f@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKKeQTv0ful5Ji_f@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.5-rc1
X-PR-Tracked-Commit-Id: a91845b9a872039618d74104c0721376ce092638
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc75f2164593554e3ec36261cec0588c8ed32641
Message-Id: <168841622117.1331.7627865954691098613.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 20:30:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 12:09:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc75f2164593554e3ec36261cec0588c8ed32641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
