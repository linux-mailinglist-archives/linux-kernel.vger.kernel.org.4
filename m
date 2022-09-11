Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EED5B50E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIKThJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIKThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC82558E;
        Sun, 11 Sep 2022 12:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E62461083;
        Sun, 11 Sep 2022 19:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04BB4C4347C;
        Sun, 11 Sep 2022 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662925019;
        bh=2FcVKFfoqpFAmEwtevtXWoAEUeA20iOdUGEBgr9Zb2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RNCa4anhwxY2tXwTiTEEQaJXmXi9bEqWRoh8JG6sUUELzNDOGhhRcwBOQrGsm93fo
         QY2bb687EM0SRjf/uIioKQ53+jnm3f4oqFl3jhG9/3Rg6rpJbT/WE8ZqcSdPyyVOiq
         GX5XetKfqCGs15ZNqu6OpwtGR1nYnodtiu9PLZuEr0n7U3jDBjZgN8ocLHAYsSCkUi
         3+4NbIaNvy8VN13RTRdlhNhG8+BN9WY80a8tVuDbIfM56WvVC8ccBkvWAnlME+C95H
         WYBoqN9a8ghLsjq2QsUwyLI9LW3MTYpVM3wkA3CNdO0SLb9HpGIv/tWiNkCDXZ7K3Y
         wYSF9t8uShSGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4F6BC04E59;
        Sun, 11 Sep 2022 19:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASxoB67Tdzj78FA9iuRr2WxcH+-knSkziv36TFOW4KhHQ@mail.gmail.com>
References: <CAK7LNASxoB67Tdzj78FA9iuRr2WxcH+-knSkziv36TFOW4KhHQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASxoB67Tdzj78FA9iuRr2WxcH+-knSkziv36TFOW4KhHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0-2
X-PR-Tracked-Commit-Id: c17a2538704f926ee4d167ba625e09b1040d8439
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ed9c1e971b1f6474793da20496fa53c35d4a37b
Message-Id: <166292501893.24843.7917908249853034042.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Sep 2022 19:36:58 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Sep 2022 21:23:58 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ed9c1e971b1f6474793da20496fa53c35d4a37b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
