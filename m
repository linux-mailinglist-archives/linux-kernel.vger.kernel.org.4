Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C79607F36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJUTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJUTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECD9285106;
        Fri, 21 Oct 2022 12:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CA561F5E;
        Fri, 21 Oct 2022 19:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 759DFC433D7;
        Fri, 21 Oct 2022 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666381420;
        bh=adEFkg9f6GiF4D5gz8yBkFGSQVw7aW57nsbqLh4YALg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vhl/EPqxKTmGsSqZcG2F2j6Jxk5S17Q02dy4upeDgIGfUQvbk2uyOo54pnYVEvUbw
         LwS1l/ZDc3vs8f1Wt3SjBsnzy/BACq4LomtOnnlrAjsT7K7mILMQVib4CjhfuoOKwb
         m/0KViBpPLJcMvkWNDJGSOu6LH5uoGByDtaaZPfq5LuF6O7sM0SavHCcjQDeMJ2AnU
         LpBlcOsxs+2w8dpFdymqLeW2xQiGoaFFdIDCasZgAsrsj1mrqDgk721XoRqsjZw4YF
         T3IX95J05rIdNJ/ksizu6pmDCEffIPhtgrKnqAPJPtHKozNKSY8g33oiV7W6wG2OI2
         BeNnoVKrsgY/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61E91E270DF;
        Fri, 21 Oct 2022 19:43:40 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.1 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221019180449.GA12018@www.linux-watchdog.org>
References: <20221019180449.GA12018@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221019180449.GA12018@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc2
X-PR-Tracked-Commit-Id: e25b091bed4946078c0998e4be77bc56824a9adf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f1e0c18bc8324ae05646c34759fd8dbe87f6582
Message-Id: <166638142039.20847.15361548694074274704.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 19:43:40 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Oct 2022 20:04:49 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f1e0c18bc8324ae05646c34759fd8dbe87f6582

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
