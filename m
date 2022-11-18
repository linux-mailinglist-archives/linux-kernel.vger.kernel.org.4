Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562362FEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKRUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiKRUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA74E42B;
        Fri, 18 Nov 2022 12:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FA762766;
        Fri, 18 Nov 2022 20:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C54C433C1;
        Fri, 18 Nov 2022 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802862;
        bh=tPITZP9r2HSAf9nzdYm/AciEbhtIHaSXV+4RrX0QkqU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rIpT0idQnN8kNpwoyZI+Rjm5Ng0h7muzUkzu3YrVeYIGjnfXM1c6Yve7vKsLuXF0S
         Md0Ox55kqu/3E2w9uJMwSz1nSPehsTDS7h7+q+tGYY8b36n1AaRFz3PFE4m2p9Da9u
         SNkLns7zI7z5/PzfbrLFJrGrbSUOPKsy493x9TVStQ1BMgQ2q+AYvacuJu3yh4gg+3
         dPgcmu+AgbvlfSbEq7B0SAJHch7pPq1kh27t/N58NoinoebLtrfFkRZRUlyZ+dG/Zn
         +H4ZQ4s816vG1Lq3XIVzNo8fMlvN2gGZHcgWQ/kFuuklc5t47pzhzvfLUUN05EfZr9
         Zg8pIvMDsgjYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D16C1C395F3;
        Fri, 18 Nov 2022 20:21:02 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3fKrfyixnq55Poc@kroah.com>
References: <Y3fKrfyixnq55Poc@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3fKrfyixnq55Poc@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc6
X-PR-Tracked-Commit-Id: 59a51183be1a6aaaf6f8483aec82e2fbf2c74ab9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 950a9f564aeade8f7b263bb8e9646c4c13ffd424
Message-Id: <166880286285.9331.16807198057290603656.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:21:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 19:10:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/950a9f564aeade8f7b263bb8e9646c4c13ffd424

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
