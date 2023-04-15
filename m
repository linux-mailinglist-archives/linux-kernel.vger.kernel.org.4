Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808FD6E330F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDOSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDOSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 14:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA92107;
        Sat, 15 Apr 2023 11:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B3860B8B;
        Sat, 15 Apr 2023 18:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 453A2C433EF;
        Sat, 15 Apr 2023 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681582288;
        bh=Cu3Ss7aZ+xv3hvSYFJcdipZvm+kDtkCKbkQCc0HdIaM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LG0BGqU5bcioMQpA5SXTXvT+qKaEUahQG77xFuxk0afQnuWEj4USjE3LBh/Azkdtm
         u070p4SMkCfvm3XGCiFfk8z9AhheBeB7iafey3vmZpskIuOSwOeu62GSj1DsGSY29X
         0FtsJiHAO7b+lol8h9Bbc4ewX1/wO5Bh/cTeZKkQZzwZt2INE6hkXE7i0SLHs8GNHD
         yepSDQe6FqxokFDnKbszHyJSlnOiY6vyWRkFzlnCC3WaylC1UfXS8q5kJcV2yaVBwv
         S9oF/ReABPImD8WGEw3rHDZjxRPCjUbNEOD4cfSKPAKr+O6DaT0rffzDYmGcmqYcGJ
         4rwBqs9k9UshA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24204E5244F;
        Sat, 15 Apr 2023 18:11:28 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ff2bbe531bf390edf7715809f654374905ef2297.camel@HansenPartnership.com>
References: <ff2bbe531bf390edf7715809f654374905ef2297.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff2bbe531bf390edf7715809f654374905ef2297.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: c8e22b7a1694bb8d025ea636816472739d859145
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9772f14f557de9d4056212c84a0a4f64b7b09f31
Message-Id: <168158228814.18559.5754812983833626596.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Apr 2023 18:11:28 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Apr 2023 10:42:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9772f14f557de9d4056212c84a0a4f64b7b09f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
