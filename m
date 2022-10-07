Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF55F7E26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJGTiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJGTi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF06103D90;
        Fri,  7 Oct 2022 12:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB9561CED;
        Fri,  7 Oct 2022 19:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AED0C433D6;
        Fri,  7 Oct 2022 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665171502;
        bh=QW/PiwE0BOz8BFPT7ztpoOIgr+n+7TanxvPnfU1uilI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eKVO8c9Yz8HHMcOrXVhXtLWkOwS6rQyjufbUnX58xpQCUJF48bubxlLlJTC1Q1EFL
         LiRyg9YgjHPurVRBIEkyuh1Sc86Gc+VKZT1+NExGGAmB2kf1EsjQ0noJpn54YeFjHA
         m3TE5JTzIm87fTmyUJ6SJAbQE8czwjuFhkwHRMeFN0X/yWp3c3ZvAzhsAblPZR7DpV
         s3b2CCEDLj8b5FfuCuvuy+S/3ZHV6CMYYgCsaQ9ZLU8pKnwo4mof2ic+iQVskuEFmM
         UfSCJzFVRfZq6XOAOJ2VwIkhZsRHs00myDoAAW1Ffvp1jER9eazML6WLYnDebB3xh1
         p9UxgciOlgA4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A567E2A05C;
        Fri,  7 Oct 2022 19:38:22 +0000 (UTC)
Subject: Re: [GIT PULL v2] first round of SCSI updates for the 6.0+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <86a4f9d512e094c98a984553fb914580e774d4ef.camel@HansenPartnership.com>
References: <86a4f9d512e094c98a984553fb914580e774d4ef.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <86a4f9d512e094c98a984553fb914580e774d4ef.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 57569c37f0add1b6489e1a1563c71519daf732cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62e6e5940c0c09433efa52d0fa9a11623a4704b2
Message-Id: <166517150242.21522.7111319851190885685.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:38:22 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Oct 2022 15:24:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62e6e5940c0c09433efa52d0fa9a11623a4704b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
