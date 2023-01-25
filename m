Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B567A8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjAYCXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAYCXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:23:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725D4523B;
        Tue, 24 Jan 2023 18:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E49BFB817C0;
        Wed, 25 Jan 2023 02:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 952FDC4339E;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674613383;
        bh=+ooWifrksTp84JgbHTsOjtCxB5xMbsZBir+94IC6RKQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gp9vFPpxuQJlA6dFjOdGSDKHpaye4bmvR2i4IaV2h3CCqOr/Av/nUKzM3XUsH/lb1
         qz2mvyU9lMiGJw8lZP6NQmplNlkGCu5FCvmDwBISleiOxe6Ia0e7QC3vc685+C4PPA
         u7pyK0P9ZRbC9RoSugbI14SsEV/K3rQ6mweyWGIvI1ZqqYhTT5naOm3fcPO5tHe26G
         e7ZoFcbpx3qPMvdwnkpk3yrgeSAGdd8AAMJb9guZTAZ3bz4BBFhe8D89lulKFlVCuU
         CdrIV1WbQgrx2mF01NHeA58Yj7y5iDsNMcL0hE4cIoGbocSvC5uyCXlNerniR8GASI
         XXTnc4zHn/J/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78D0DE52508;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
Subject: Re: [GIT PULL] modules changes for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
References: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc6
X-PR-Tracked-Commit-Id: 0254127ab977e70798707a7a2b757c9f3c971210
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 948ef7bb70c4acaf74d87420ea3a1190862d4548
Message-Id: <167461338348.26446.17203566815519029352.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Jan 2023 02:23:03 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, pmladek@suse.com,
        mwilck@suse.com, vegard.nossum@oracle.com, ebiederm@xmission.com,
        david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Jan 2023 13:06:27 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/948ef7bb70c4acaf74d87420ea3a1190862d4548

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
