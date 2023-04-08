Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE466DBC81
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDHTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDHTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7AB74A;
        Sat,  8 Apr 2023 12:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3FF560A3D;
        Sat,  8 Apr 2023 19:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3455FC4339C;
        Sat,  8 Apr 2023 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980471;
        bh=1dV4o6ZickC5jXYQ5rt72Nxo4lmlqxemxOrgDqKDo5w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=siv8pjVwHmz69mblY1hzZMSA9vm0AAg9v7BCeJQmKIaUb0O4s6H8mMXvtfllmpkkK
         VCSDqafmzLafnNsWhMJmXt4insMY8mCT6FpCZHM9FzHSjIvQrZojaWxR6acA67Lc2a
         IHZY25kdXmPJizY3WnMQSrzTRmLPPV1qTl4UW9asjApIkyFl+SfTIYjgb6vCWdmgM8
         M1qByNbd+FDNTQo1Y1URwbel3gX5hsvy4hSAdz8kOG+QFX1VsMBwAXr0LFjTK3TOf7
         oMeUJxIb0oMWOcBiNDBcl1kynvuaNohgKqgzVLY6V0tk0nverefrHA87g75I433/o7
         tD+wK/e94lI3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20424C395D8;
        Sat,  8 Apr 2023 19:01:11 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <255a80b21248110095a4e3a6c993183f1046a4b2.camel@HansenPartnership.com>
References: <255a80b21248110095a4e3a6c993183f1046a4b2.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <255a80b21248110095a4e3a6c993183f1046a4b2.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 48b19b79cfa37b1e50da3b5a8af529f994c08901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a79d5c76f705de81cb6b55ad279dde9759da06d2
Message-Id: <168098047112.1995.17476880214223964394.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:01:11 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Apr 2023 17:42:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a79d5c76f705de81cb6b55ad279dde9759da06d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
