Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C874C6DD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjGIRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGIRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E611C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D8D660C1B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02053C433CD;
        Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924795;
        bh=wTyh+NEUtwRKuTheUdEE/Cq6bdRtQ6EdQChLcgWhhxg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g3jovuSuYT2vvRiJhFpO+al6bCy5kS/l5SYi9em7y2PZ64P3kZ0VowJojFB7++oOr
         DmcEGXwXcjFTm+VRsomo+z7pBd/5XhtzDj/ja2qQc1+oqXc3IQTSZiV4ZOKf98delQ
         1HzX2cUsZ4DHxtw8sfbLfAcrpZIVym9hlGOwoeygWv5HXkAAexG7NCTkwTYM8lAZ9A
         1idJTeRPyM+uLKXcCXIgj8bkeM4cGARtCELJ5qmxVL3lA2WrJzlhKQnayAUqttsdOW
         vCWauzyh73XkuMvMF2ZPMFpxj4PhFVSH/pKGidYccT+IgB46iBRhMkrh+V0Wou55gy
         GhcIClpmd/jsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3F7FE53801;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Subject: Re: [GIT pull] x86/core for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168890380261.187070.2103277819790991312.tglx@xen13>
References: <168890380261.187070.2103277819790991312.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168890380261.187070.2103277819790991312.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-07-09
X-PR-Tracked-Commit-Id: b1472a60a584694875a05cf8bcba8bdf0dc1cd3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3da8db05531829cf64f922491be6f052acc5fba
Message-Id: <168892479493.9789.7072157841142757782.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:34 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  9 Jul 2023 13:57:03 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-07-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3da8db05531829cf64f922491be6f052acc5fba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
