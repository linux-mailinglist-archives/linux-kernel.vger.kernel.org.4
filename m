Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A385E8E29
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiIXPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiIXPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:48:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8C9F8CB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE672B80E79
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80F61C433D6;
        Sat, 24 Sep 2022 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034532;
        bh=DKq5bKZrMG7pkNqi7RqqaYSr2vpcg7/qETBKCMyB96c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UE3CPckjG06MHVYMX0Qm1yS/LTpZyzqccZxfpx1UOzdRWU9cu7rQgdgHguwngnXob
         WYIwWqB5zt+X1b9xtYsc1XoFdsDB2ULsE04LR/eVxSYsi6pqAZv+AgrE5zJWTYGr2F
         SFWyZrcW28KeXAwabKfKf0/cludGxwGkkev9iMPS7cwZqCyC1m5jRi0HZ5enBRXjTA
         fpF39gqcK4sht31/02xqxpotGGJTRn5/ieo9YasHuw3zcOwWLr94i4sr82xdR5WosZ
         UFfvQ1DaKHpmtJBQH4k+vwzR2nH9zoMsMD3S1bUCPMuqN416Swan7ieL+qrAn4CZxX
         ZoefCO40/p39A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70703E21ECF;
        Sat, 24 Sep 2022 15:48:52 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy6/TuLIZ60zb3ia@kroah.com>
References: <Yy6/TuLIZ60zb3ia@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy6/TuLIZ60zb3ia@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc7
X-PR-Tracked-Commit-Id: 2bc54aaa65d2126ae629919175708a28ce7ef06e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a61b828566fba088d3baa0dc3e440b51fdf9ce2
Message-Id: <166403453245.2421.7940561349630656495.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Sep 2022 15:48:52 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 10:26:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a61b828566fba088d3baa0dc3e440b51fdf9ce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
