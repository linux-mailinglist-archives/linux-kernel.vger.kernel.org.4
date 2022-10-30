Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCFE612C44
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJ3Se6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJ3Set (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69055FDA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C9660F2E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47962C43145;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154887;
        bh=8iSamVttWeFXIi8fBzl6WpgO0jL/+KhNGJI1hVjNQxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SOfBponEMTr6BvBlc3/rvTKOTjqSqUaZeSaIMMU5FnVeSidsQphwVwOb72st3yymn
         gysnyX9SYZ6jYizPY21oLRKzs8av+1NXKdeD3YeD4h2MO3nj0NxuPRZ5S3S3agJLHV
         PUDbRu9MqDF0QXwnXTKusyGreCkvAkwY9OllM/uyEiw77GoRQ7RhOu514jhMjGJqMK
         2r8+Xt0Yw/2bBWTtU8jWsMfi9NWnETfGq8SrYTRgKfhhbxNWgGcHUs9267bzxfeovz
         tlPWAO78YfyIzgopE/OsFMlqGvrcHaYPiSGE+euiHr7BSFt7ghaZKPbbD7S03wNU1E
         SXPMbzrB1B0JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 372B8C41676;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y16GIJg2y/3M9Xbt@kroah.com>
References: <Y16GIJg2y/3M9Xbt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y16GIJg2y/3M9Xbt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc3
X-PR-Tracked-Commit-Id: 677047383296ea25fdfc001be3cdcdf5cc874be2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f127546bb4341df88a51df8e6cc7d8a70cbacd7
Message-Id: <166715488722.31922.6429695924524000382.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:47 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 15:11:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f127546bb4341df88a51df8e6cc7d8a70cbacd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
