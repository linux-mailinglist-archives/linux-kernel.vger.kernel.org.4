Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28408690FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBISK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBISKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369676811A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D038CB82274
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87600C433EF;
        Thu,  9 Feb 2023 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675966220;
        bh=OyJ92mjWOYGF5yKWoggo0vwINRg8q8KakxL1ZClIO2I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F9RQHastXoEnrtxMzPnbQ55IkWFCx9/ELonTBdABvdwKr2OBfGzoM1/PKxorl3Czo
         VfghehyKNXSjNwUrZub1PrmtuajnTz761XlDE//cjCLqFbpaN4RR3U4ivKKLWE6pgY
         JIeexDwQdfW/CZHLbdgYG38ruB94U9K76vdocLJxsggCNp26LE8wvSnA9QF+gWgjy+
         Nd5XC9n3EJxK2f3R/v6DbFmXLYvSI860gEf34YwP0XpE9x+XyQsmxNUXibZCxqgdy0
         8KAgOuU4A7ROW8iwd9DHKJNjl2V35BED1/GCdHwFxepgMUtRuC5qqwaP7W6ugZ4gxw
         H58XGN/Azz1kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D8A7E21ECB;
        Thu,  9 Feb 2023 18:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230209143135.a75h6fcbpjzfca4s@mail.corp.redhat.com>
References: <20230209143135.a75h6fcbpjzfca4s@mail.corp.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230209143135.a75h6fcbpjzfca4s@mail.corp.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023020901
X-PR-Tracked-Commit-Id: ebebf05a4b06a1be49788ca0edf990de01c4b0d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b028189d1019ca352da108643b8f1503ee25a0e
Message-Id: <167596622031.10454.3154902306443547859.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Feb 2023 18:10:20 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Feb 2023 15:31:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023020901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b028189d1019ca352da108643b8f1503ee25a0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
