Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129E61E6BD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKFV4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKFV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:56:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26276DF77;
        Sun,  6 Nov 2022 13:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A239D60DCC;
        Sun,  6 Nov 2022 21:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 751CEC433D6;
        Sun,  6 Nov 2022 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667771793;
        bh=RDp3Fh3LdL7f8EPSyE35maQPSfI7HU8AJRy1PbW+2dw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DRzgbedKWOl+W/92naT00wmCWsbazrNya8KA82Jx9REiKmj2VO9gKY78ipFVNfROn
         QPArMqpm39YiKwTd7mVyRGysZOSjYHp7xOm2HY8bV2fZwGFrnTc5XMyltfOvAW/D8c
         vdFR3hmfwzHWNaE8xRy7i64iqWlnMDviTAr9oi622Z/eRS1w+gZRC8HnshehAGzofL
         cRZTs40oFrUbRINITRH7ASyyXSyPVkHVjTjFz9plI7r588gchSKvRhi+9tDNjYvuB5
         QxpGUMFvqrTmMyVLeM91aWp5odlyye85OVnj5+891oA3kqRo2nR9ACWhnvFLEhH+61
         e60cTwoz9g0WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62DBDE270DD;
        Sun,  6 Nov 2022 21:56:33 +0000 (UTC)
Subject: Re: [GIT PULL] CXL fixes for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6367f8419c601_35f43294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6367f8419c601_35f43294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <6367f8419c601_35f43294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.1-rc4
X-PR-Tracked-Commit-Id: 8f401ec1c8975eabfe4c089de91cbe058deabf71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16c7a368c8ba9aba3b0e0ae5ec0a64be9fb45665
Message-Id: <166777179339.27970.9157117891390962367.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 21:56:33 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Nov 2022 10:09:05 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16c7a368c8ba9aba3b0e0ae5ec0a64be9fb45665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
