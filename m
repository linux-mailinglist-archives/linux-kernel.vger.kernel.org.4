Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D85F94B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJJABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJJAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670A4C619
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E00660CF6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0B39C433B5;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665358401;
        bh=L1PN73V1hlzclilv47KNmUK0YKXNudjX1LbPlg8VaPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BLfNJdF7z25BNOgOiM7JxyQe387Ty3mLkqHaPFItO2tDUpgGVE79GnL4NpXF2jeoi
         T9O+h4ppFrb4Acpt4k/WqczPDokCV+wwrdGndfjrQ/3omaTshX5heuKmIWPkRLFx/U
         iTcZraIVQX4yfjHIa2AcMklWWNIV6FsH+RA05WIBC9VIcuSqgVTAQoSMnpRnWOV44R
         amqvbEL2wWh9EECtTDPpRttvoyduXnFPCKG5nrayaCnZN5LHsmf5DkqLeM0c4eVT0J
         op3Kn4okzQ+lEKPTp85B6PZBG1r9ZBEIZex4QkHW3tA1NP2yVM390SL49VedsyywE1
         w9U/bu6uXUIIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D053DE21EC5;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
Subject: Re: [GIT PULL] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r0zowp3x.fsf@email.froward.int.ebiederm.org>
References: <87r0zowp3x.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r0zowp3x.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/signal-for-v5.20
X-PR-Tracked-Commit-Id: 9a95f78eab70deeb5a4c879c19b841a6af5b66e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e572410e47a4e9647d5d7a49ca699a1497378707
Message-Id: <166535840184.20820.15794571459376500278.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 23:33:21 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 16:53:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/signal-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e572410e47a4e9647d5d7a49ca699a1497378707

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
