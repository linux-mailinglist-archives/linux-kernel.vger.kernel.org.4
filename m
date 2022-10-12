Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77405FCA21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJLR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0561D8ECE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D479615A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4222C433C1;
        Wed, 12 Oct 2022 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665597494;
        bh=HNAwbyU0QrEeUAf47+URYIJiu2DZL/66q2f0E40S06A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mjiDvI4pt32oqP8ZY2bxygz0c7ewJeB3ZrRVDQB0rPXaEAO2IiVk36cLreERfzIop
         H3E4yaSjQOVnbxxtF79d0oEW8fkB5bbKYstUiGSSrV+n4ZnKAjSHemgOGTYttq4xbR
         6GMvYAr4C407yc7iiMJFKqIesNQtUpUgIJRJCKXpHsNiFnCcncJXTVLJ+Hioz6V1dY
         Hdg/2uqn+mY7RCyzh8D+w7WJCUBqUp0ZZvHEC4/pAF9Jg21eJmo6Fg1XTsEkxL2I29
         yvST8ndRziY8sugdm/YGt3GTvbMEykEn78qXbNP4+KRzGhEtF4nplG/h1G9SrFz92G
         ne8nereWFJVFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B51BE29F35;
        Wed, 12 Oct 2022 17:58:14 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <166558251511.208146.10184958171655902083.tglx@xen13.fritz.box>
References: <166558251511.208146.10184958171655902083.tglx@xen13.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <166558251511.208146.10184958171655902083.tglx@xen13.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-10-12
X-PR-Tracked-Commit-Id: b8d49bcd8fd19824888c766a217891855d8692ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60ac35bf6b98fb87475c2f85f022d5ea737dd68c
Message-Id: <166559749463.25532.2147568745775222238.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 17:58:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 15:48:46 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60ac35bf6b98fb87475c2f85f022d5ea737dd68c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
