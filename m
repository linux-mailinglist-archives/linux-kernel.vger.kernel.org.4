Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEE713952
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjE1Lqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029CBC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA1361520
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C571DC4339B;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=Fvf8goOIG5+PPHA/5LzvugEhKT7kMPu2rrX3tyQz4sg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UN11GPhycTTfwYOw9rZseYgTzQQrbTrlKeNbMQ0zu7i70OwMif58CFQWcH7m0g0U/
         Si/hCNzzHEgIkWnIy++m1M43a4YGtVzEf8BTn6c4E8X8hQJ1kl7Ew76qInzmmrLM03
         OsPtAUWbrIXP0Q4QemU3KjelCkAmxUYGvsCqAvvSCDYW6VWCq63vN7WEc7U4maqRsb
         GCnr2csvzuoBG/exHxGWHdqQ8XqMQIeHvkxUr6hDGWBwHctQG82Rb/Bpl6l2ROCCuq
         0eOe8mZaM4ADxkh7i8w2P6pfgAuktTxwmnJojf8TkdmMRZheo3httOowTOAt9Ul6kR
         OpJTjzlHS0iLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5ED0E22AE9;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168526035526.3457722.14103350194452732675.tglx@xen13>
References: <168526035526.3457722.14103350194452732675.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168526035526.3457722.14103350194452732675.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-05-28
X-PR-Tracked-Commit-Id: 4115af49d2c24e840461fb83027315e2d2de6db4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bd5386c653f64755dc33f77793273ef0763fe63
Message-Id: <168527440267.32373.12903641970206285911.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 09:52:56 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-05-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bd5386c653f64755dc33f77793273ef0763fe63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
