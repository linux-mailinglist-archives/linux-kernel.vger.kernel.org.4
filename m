Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7456C8FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCYR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjCYR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4BEC6B;
        Sat, 25 Mar 2023 10:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ADCFB807E4;
        Sat, 25 Mar 2023 17:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B45F6C433EF;
        Sat, 25 Mar 2023 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679767031;
        bh=mxRucQlHxVqqBwArR/9vTCRqZwnfNqObL0mrrbHPb8I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pqTLcIg/8kMmpd1EqTJUZzsu5ix42b1J/lMn/GgICtdeD8dkPeA0uE1WB2cW/tylK
         3ZsLDee4gOzKNn6yklcDw+35zqPnHQ8WNL7RYOCq2noGckLSknwsrMLAYYzz5dd3ih
         erkmzF/KDPpWhp50BMRNvhgI4LSk5JnxIB7ofVLZLEb2G0GPZRUM8JTtli+WEuWpWo
         JqhRizk0z1M3k2Xc1fltXu2NfobcApZVW5khupKq+h6UK4hzCfRGEBr2BxHXwArhis
         O7rypt6lIQm8MF/F3OAD5QjevJeHT8wScg00C8zBLENhoHMc8rTlzxJclLwWomPuqg
         AwM2VMyn3j7Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B67BE4D021;
        Sat, 25 Mar 2023 17:57:11 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230325140026.3591525-1-linux@roeck-us.net>
References: <20230325140026.3591525-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230325140026.3591525-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.3-rc4
X-PR-Tracked-Commit-Id: 968b66ffeb7956acc72836a7797aeb7b2444ec51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bdec23f971b1a5caf7a18ae117e44bdfaf26c93
Message-Id: <167976703150.11290.9071296417713948818.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Mar 2023 17:57:11 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Mar 2023 07:00:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bdec23f971b1a5caf7a18ae117e44bdfaf26c93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
