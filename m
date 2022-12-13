Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47FB64BEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiLMV4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiLMVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F01262D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C833EB815A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ADDDC43396;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968442;
        bh=VS1YO3C1FmDhjjo64cEf4sVP6XeDarbxvkrHOztmAdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hJZ1BQLscbo6ykufQmHhY/XkMJrBcA7ju1iEb93TXMONnnJ3RakWW/eaoOV6SlpV7
         YVSzsR5vAr5FS0ETLbA5D0ynj4vmsT4GUPRU+PRdUb6vyE9JzwTuyYbzrO6W011qNM
         anq/51jQoBuOi+9XzCdWRkY6rESBO2MBCKb6DhFxnpgIombzNcV0K5HJx6GJtRodRE
         qsrccTqeA6LfV0ktqJgenUEDUb+YFU5bRL9Ygv1/bzT1EsCfzYdVPT7Z32OnkHR7Kt
         tMEa3UBN5BzfQTmHNCEOB4UwcOnV5wT0kvCANjF0MddkfOcPTLZLTDu79vQ6nkAMqr
         kKUWH6lCDUHDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B529C41612;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes and additions for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5iKRKVS+o7I3OL3@minyard.net>
References: <Y5iKRKVS+o7I3OL3@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5iKRKVS+o7I3OL3@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.2-1
X-PR-Tracked-Commit-Id: c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90b12f423d3c8a89424c7bdde18e1923dfd0941e
Message-Id: <167096844243.13204.13573850329214162960.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:54:02 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 08:20:52 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90b12f423d3c8a89424c7bdde18e1923dfd0941e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
