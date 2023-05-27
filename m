Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B2713107
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjE0Ayf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0Ayd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC092135;
        Fri, 26 May 2023 17:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489C2614FA;
        Sat, 27 May 2023 00:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B05D8C433D2;
        Sat, 27 May 2023 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685148871;
        bh=bcNPjOLewgnUDtaifUPUR9yhT4ypXWGVX7YZ4dqRf1Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EM9E4JXng9NsVOO1Gw+72ZTWruC3EWhzeK/PxiGWpurd3so1RaHnpj0rO1dHRtWkL
         5nuoQ1vmCNkbpJCBlQG+cskv6wr41Bn/j7IeMKbgu7Ej8uHTWvTGpmdhGxnqN0E1ar
         dZTwRVMvD8wmEb99KWYKH6uBKPDr6JAJTEOc+qRdj3bduduF85S6iVMouSINNdim9P
         WXuwmZ8ttRDERvrU2+JBOIn2R6DQrM+8f0k5/v8/N5oPfm53wVK6k1nTI7N2uYMGOC
         dxTMMH0NlXpkiYCks/6dC4jy86Sim52+9wRZhWI0mlKB/2NdZv7NnK0Dk3yc4VvaRh
         v056/fvbL/QxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DB4EC4166F;
        Sat, 27 May 2023 00:54:31 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <64714d92a5ba8_1ec11294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <64714d92a5ba8_1ec11294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <64714d92a5ba8_1ec11294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc4
X-PR-Tracked-Commit-Id: 793a539ac78843ef9378bb42a44edfbc552a67d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49572d5361298711207ab387a6c318407deb963a
Message-Id: <168514887163.8173.2989748393510570791.pr-tracker-bot@kernel.org>
Date:   Sat, 27 May 2023 00:54:31 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 May 2023 17:23:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49572d5361298711207ab387a6c318407deb963a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
