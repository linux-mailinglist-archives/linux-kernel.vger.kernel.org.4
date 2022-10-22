Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0601F608326
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJVB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJVB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB92A5683;
        Fri, 21 Oct 2022 18:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A5D4B82DB9;
        Sat, 22 Oct 2022 01:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8203C43140;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402117;
        bh=bB4kphO/X5jJuTJ8ZrP9s9Z2hrxYanqjchvOPrdi9IY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gZVCmrjcnY07BlwEgAnye+GicS+kND8xo4NEdf6jov4fz9VG3f3EU9eaVhIRrCr+i
         /BiDn7D1Q+4pU+4LbAtn0nH4oH065Y7+jhc5lUIs6k4eHZVIwYc0zz3t3tCDS/uTOH
         RV/efVK+tZqkactbz0XBEoBm+Pe2yNLt8iUiW6KjjKR6nNu75PKU1aJC7TSezh+w9U
         jGODHJfbpj27afV/NrjLJRAFTMOFEQCFSegfmdoEW3SC5OkSLgM1aagKdUUCIWbKqP
         Nhu2UGQOBbaP200hTXsumBufDphfSZz+JTB148mmwDM/PGjMR21FjgCRODy89sa2Wx
         Uu1IUDaKZarkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD1EBE270E8;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hE31BLmRR9w6u5+vrEEc3QjkaOpUPaCo6QcdJCFez0Rg@mail.gmail.com>
References: <CAJZ5v0hE31BLmRR9w6u5+vrEEc3QjkaOpUPaCo6QcdJCFez0Rg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hE31BLmRR9w6u5+vrEEc3QjkaOpUPaCo6QcdJCFez0Rg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc2
X-PR-Tracked-Commit-Id: a6991d623de02c42c44ddfffde66ec18608069d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20df09614775475fecc37a786a382755ba3d7d2b
Message-Id: <166640211783.11783.1516014317037128656.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:37 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 20:50:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20df09614775475fecc37a786a382755ba3d7d2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
