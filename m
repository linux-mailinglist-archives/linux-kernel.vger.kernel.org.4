Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5A6002CF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJPSTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJPSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:18:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE845F6A;
        Sun, 16 Oct 2022 11:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0236CB80D31;
        Sun, 16 Oct 2022 18:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE390C433B5;
        Sun, 16 Oct 2022 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665944330;
        bh=PqFdSOW1+zko7cKrWFMxMkmUmcdeX6oJBVOM+nShxdI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XXONTM/JnPhx3BaVeD0i4+Fb9/m/1dQPBK3GmBbC0lSFtmXokt7GI7ugItqNmTE+E
         OVaqPwXpa6yJZ3GSc36dsGMqS7UeBYzMae7akR+RFjWR5GC19ukgjO0gnOB9P25ZuJ
         YOZPzcfhxGKZCtSVkQnIAXkbmgnyR+oqTtuvgFSIWT1uU0j5tgZN594MTOEm0fp2CP
         Bd7DBspgEHDlNZWIKCjJU+R5S5l65qHDDvv4vYu0yJrFhEfydjA4yFaybXFQiUhLaV
         63IT+ZZDdeMJxQUJ1FA7PNFCEZwRxj+e6I0lSyJX1kCDA6jGcsoL6jg4Kqh7i/8gMx
         1mK170O0yzrag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FBFAE4D00A;
        Sun, 16 Oct 2022 18:18:50 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQThQhJRDsFrHo=3sYd5MTFq_R_7CNjpoPmsNeO7WWmGA@mail.gmail.com>
References: <CAK7LNAQThQhJRDsFrHo=3sYd5MTFq_R_7CNjpoPmsNeO7WWmGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQThQhJRDsFrHo=3sYd5MTFq_R_7CNjpoPmsNeO7WWmGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1
X-PR-Tracked-Commit-Id: 0a6de78cff600cb991f2a1b7ed376935871796a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2df76606db9de579bc96725981db4e8daa281993
Message-Id: <166594433057.2997.16341880685966727293.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 18:18:50 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Oct 2022 03:09:07 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2df76606db9de579bc96725981db4e8daa281993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
