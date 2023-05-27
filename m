Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C17135BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjE0Qni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjE0Qng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0469E
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 09:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D331560C4B
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 16:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EFC8C4339B;
        Sat, 27 May 2023 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685205814;
        bh=9yELd5zD/cn3C0achFlafAXisfS/GTLVjtu0dmLdxBY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iLtYCK5BzthrKbqNzXzmonwbyv3yybA+RBBge8Eyo2mEFhOJiIS7OE0XRyrdA5sgm
         e7c3DI0Z4Cd+6CNHQmF9Z9hjw3qkthKLHGhFxYj9NUGZhm41VxanXalqOAr2PgA4lN
         cyhD/cBZ6ZjeCa4FZNidCCcoTuiE8gdHwnkVeNX2HmEkoYuFlWTsvh78KU9oyua7k3
         nAAnDaq1MYPSA5twHVNc/c2/cP/ACO7faInWIP3L2gYkjUCK/Y9Sj7X6P4wyIcm2tq
         6Zdo/h65i/OS9apgt39AxYwG5JHr4Cqn6sWxxYH2q3A6qZKFrxapy6n7YTvoAgOYPF
         wQ4yHZpQVWuYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BC61E22AE9;
        Sat, 27 May 2023 16:43:34 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHG_8UO7R3mzhI4q@kroah.com>
References: <ZHG_8UO7R3mzhI4q@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHG_8UO7R3mzhI4q@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc4
X-PR-Tracked-Commit-Id: d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 957f3f8e5343041ddb9a1265ab661db259cc712e
Message-Id: <168520581416.11589.9951803864927975204.pr-tracker-bot@kernel.org>
Date:   Sat, 27 May 2023 16:43:34 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 May 2023 09:31:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/957f3f8e5343041ddb9a1265ab661db259cc712e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
