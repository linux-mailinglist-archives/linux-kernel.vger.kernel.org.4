Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7F6126D4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3Bgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 21:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJ3Bgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 21:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D525593
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 18:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5546860CFB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B529EC433D6;
        Sun, 30 Oct 2022 01:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667093791;
        bh=WMforJQO1cx02BcE93t2NP+U626nUvGNP/BUU80HPZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s7RvuNbmFGsHSze7blu5D0nH1WBxbzt1CymOxJL7zXn65UajkbsmvvW0Hp4pCKx9N
         zD+xKaSSOahIGAHndj/jC4ijb6XhmJ15AzsYe1kc2jkupxNR0SIOrh6Di0GvVbJhjS
         moQ+HFRXwF81g6oVcz1Eu/3yVirR3XhEn4uVyQEQ/RRnfF8UfFtuttaz/Tpax6OSKM
         OTf0G6MP38QVdkUfibaLGPGO7S9Z6a6I9sZi6GSAixwBrtYVTHan8iXnSLv2i2laaZ
         lBgIK8ZSlSjlEuNulaEOxeGTbksuFkAJPmvHryyyngWylNVVhYyeKbiU2UbHxRowD5
         NwYl8dm/gOGyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A37A3C41672;
        Sun, 30 Oct 2022 01:36:31 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221029234929.834356-1-Jason@zx2c4.com>
References: <20221029234929.834356-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221029234929.834356-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc3-for-linus
X-PR-Tracked-Commit-Id: f5e4ec155d145002fd9840868453d785fab86d42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 882ad2a2a8ffa1defecdf907052f04da2737dc46
Message-Id: <166709379165.27206.5704157186970995669.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 01:36:31 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 01:49:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc3-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/882ad2a2a8ffa1defecdf907052f04da2737dc46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
