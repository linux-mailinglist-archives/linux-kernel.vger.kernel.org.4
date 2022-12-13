Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600E64C0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiLMXc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbiLMXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6753959B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EC06178F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 188ECC433D2;
        Tue, 13 Dec 2022 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974316;
        bh=XXkExz9DQCzCrKdXMEb9OpDUOZ9/DQ23rbN2cVSca2o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MtgnYlY/R8itN3u8CRHT+fguF8kOFbRWXTRtFuMNCo/JYWYEe8Ge1QQj6H388UmuZ
         51e5P2T5NGskg0m4XtnOPq0AzVzj5ibcUxdd6fgenGLE3RV9KQ8ANHbGg8/r8zWmmp
         kO2fA0Ids3fDEbUgvI5NS6eZjeX5d9DAbzjw2yGkXz/i+9egWw0xqY1px2HVrUgqn+
         Aj63pfTTN24GzlGYSm1tozpGL88v9puZxw80uZSkSDn5UfqQ4H8HU7KHMOt+FaTi3R
         QXGbX36OjnbwHLVripmd0r2BCzeviC5xOLmCJf2Cduz59bCq9jNV0U5YIZ5PlWvG+w
         lqerpnybDyjFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 076FAC00445;
        Tue, 13 Dec 2022 23:31:56 +0000 (UTC)
Subject: Re: [PULL] xtensa updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213155443.3704527-1-jcmvbkbc@gmail.com>
References: <20221213155443.3704527-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213155443.3704527-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221213
X-PR-Tracked-Commit-Id: 8939c58d68f97ce530f02d46c9f2b56c3ec88399
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ca06f1c1acecbe02124f14a37cce347b8c1a90c
Message-Id: <167097431602.3216.15330410080069651759.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:56 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 07:54:43 -0800:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221213

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ca06f1c1acecbe02124f14a37cce347b8c1a90c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
