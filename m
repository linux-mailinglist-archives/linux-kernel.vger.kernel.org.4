Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A54609061
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJVXJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 19:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJVXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 19:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F7D77F9;
        Sat, 22 Oct 2022 16:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FC260B5C;
        Sat, 22 Oct 2022 23:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EB93C43142;
        Sat, 22 Oct 2022 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666480140;
        bh=4hUCG+3wwZpbbBxe5oInMxhZrkVOFV39XZDZAEj9Gbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jtzmsBR484NLt84b9Xw9xi+GNW/R2Q7EUYMQTxGIrXF9Irj0b/jbH+a0ZN52bF99s
         gsBiosBsOBCpB0wRqPaOwvZUPuXqWviw9m4boUcYwVP+cZbGPu/YKbkiZQusv0BgGd
         bQiJWgszUmg0T1ImimPXfPw5OHBZI87mevWWDdwEApOoXOpv/VdnVjMxqg82wHZ6rc
         7ErA4gjvC5bCeUlc+5icr4TYj4ilm1jFs/mtGjbOhBfw03TfRyu3zxzGx8YwMEeAAB
         jqhhPVHG5qXuJT3t1fjiN0rpXDUq++gwUZmU7LXSroXyKu7nSpjt6U2+D9npe20v0O
         9U/du/DN5dwBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 094F7C4166D;
        Sat, 22 Oct 2022 23:09:00 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221022140303.1523868-1-linux@roeck-us.net>
References: <20221022140303.1523868-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221022140303.1523868-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc2
X-PR-Tracked-Commit-Id: 5619c6609130bce910736a61724a5ee033a0822c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d47136c2801540e80f41ec7e063d8d592568ad76
Message-Id: <166648014003.24083.1665962232735300969.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 23:09:00 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Oct 2022 07:03:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d47136c2801540e80f41ec7e063d8d592568ad76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
