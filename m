Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D666B5845
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 05:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCKEwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 23:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCKEwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 23:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8612CBAE;
        Fri, 10 Mar 2023 20:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 316F4B824B6;
        Sat, 11 Mar 2023 04:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D047AC4339B;
        Sat, 11 Mar 2023 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678510327;
        bh=071mMextrEUT74H8Z9xw0kJIWRG6LDVPVsMuC9fZtLE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CAepQPSdKbGX95cC2dxKeixArcox0NH7HYJH1wn4X7lL6fwWPAL/MQ1xGN933ledB
         BsWj2lKLhRVGeiPYBdgfNE3XsuuqNqXY0wjNuiylX7kFGW/V4YaIVZlT3ctdea6FJN
         D2i3h5iFNESZEyAx0ZCdYHp4McAY58LNWGhCrUGX+KeegYIBlKxYPDrnSp80snk3pZ
         rCjPT6ARWAe8L1eHrE7eHLW4rqDg+oGdXP8oBL6KCVKV+ktvKbx24+Y+r5HjaxmM61
         iZBAoCUQkTW1I1qipqz54tdNp9Z7M3aFnoWz+pdHDYSZ08oNNKQygRpMIe/G3OvHOv
         CKokSJh7ZOOQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0D4BE61B75;
        Sat, 11 Mar 2023 04:52:07 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f34e06d6f44d17ad720e3a62497c612aebf5aab1.camel@HansenPartnership.com>
References: <f34e06d6f44d17ad720e3a62497c612aebf5aab1.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <f34e06d6f44d17ad720e3a62497c612aebf5aab1.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 288b3271d920c9ba949c3bab0f749f4cecc70e09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef5f68cc1f829b492b19cd4df5af4454aa816b93
Message-Id: <167851032778.30895.12444734641506682720.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Mar 2023 04:52:07 +0000
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

The pull request you sent on Fri, 10 Mar 2023 17:12:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef5f68cc1f829b492b19cd4df5af4454aa816b93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
