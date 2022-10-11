Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7D5FBA43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJKSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJKSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA7792EC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8597BB81664
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C377C43470;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512530;
        bh=ZrrW/tbixKW7y8CadaVJuq2LFjH2sPz49Ipzk92Q5hg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hCiGMn5mUBCOo2UR17WPjhCMLQxkIbIGamefrqX3HqIwFtmrybvU5SqbbZmBuYqc8
         jEwoO8zkBfdukgBtkjZXTNNBZXEuA5bjCrjySiVC6N2vN6ztchxnI5aY5Ke455WY9U
         CPStcwOhqhlWhkKR3DUBOGhXK4Ysv4Hs0SaQ0nPE12QJgMDGcoWvyaqgG/AfwubHqB
         afUOmJjMdHOtYiBDfuuDeQohJn005Ifo2kNlDmWBr7QAE2/LdhHVOSxy3CgfPUpXoe
         l1CkSUEUFLt04e44+HpCoLPgD1qZ5LsT/poMiIs49Hrv/eMRjLLqSVu1EP7ANNDMP/
         2c9h/xlYv7XhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B061E29F34;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Subject: Re: [GIT PULL] dmi update for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221010175241.06ad4168@endymion.delvare>
References: <20221010175241.06ad4168@endymion.delvare>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221010175241.06ad4168@endymion.delvare>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus
X-PR-Tracked-Commit-Id: 13a0ac816d22aa47d6c393f14a99f39e49b960df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 500b717fe36f31eec487adae4824f9be7c48d998
Message-Id: <166551253017.20259.10872779452283811365.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:10 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 17:52:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/500b717fe36f31eec487adae4824f9be7c48d998

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
