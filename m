Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810906081D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJUWvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJUWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:50:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE118950B;
        Fri, 21 Oct 2022 15:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00F67B82D85;
        Fri, 21 Oct 2022 22:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0486C433D6;
        Fri, 21 Oct 2022 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666392652;
        bh=iYFAAGxpYxCh3Njk9I4j2QNNULMGHNo8YvV2czyNCl4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tiF7+c+hloX09SNtZl+u6o/ICCDu0G8dyOx4XvgB4Y9w/UGE3ZhMIFmXtn0m3GbZT
         T0P/LwKHUa36VkWTwVd/hQxyuqbKdN73tYJSSqCwP6yXyQUe3T8VtenLKiFj6U9aRI
         V/WbxpM4lAnm0K60dqWH7Dsd2zN6sqU4tfHussrs1z0ahlvtlQCEfALCV6sqZfSep1
         P0ANQW5iAjDP4sSxapAkwi2z6Ic16ZgABhkHFJKTdLC6R6yHgJWEA4R5G+lmBZ7SJn
         DmTMzSIKs249FGa+ZclnwnwHMOBXPetoAVjwKFkBdCLsK7sgjS9uPlzlR3fit1wxYt
         rEb5kkgB6KDUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD6ABE270DF;
        Fri, 21 Oct 2022 22:50:52 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5054a79b9c9672750ad68704c2d4f77ec2986d6f.camel@HansenPartnership.com>
References: <5054a79b9c9672750ad68704c2d4f77ec2986d6f.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5054a79b9c9672750ad68704c2d4f77ec2986d6f.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: dc8e483f684a24cc06e1d5fa958b54db58855093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed5377958cfd43a2291f25f5e88845b90b9aee3f
Message-Id: <166639265270.28861.6589353956452632217.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 22:50:52 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 09:28:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed5377958cfd43a2291f25f5e88845b90b9aee3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
