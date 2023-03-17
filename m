Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637896BF03A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCQRzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCQRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C189655055
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5554E6103F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B57F9C433EF;
        Fri, 17 Mar 2023 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075739;
        bh=pOiJt/GdXT+g7wc43tRROZKnfISDSVnPoMPzLBoXC5E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SpMiI8O9VWo8E0fg4RFzJFY+Ahj/F3mOtw+HslrKnIB7N+QUFJFPr7ZkjoorHdZDy
         +zfQC6NUZEf/P/q1DhIbxZG0eEy5n3+1hzmZDMqF1c1XWtrHuKXDKupLkBIQrFmaEJ
         XfiDl7Nn7No9rSZNSqlGekZsqm/TL5/CRk5jEnOqurBOG3fbCQmZg/hy6LRRl3mFuf
         kUjBNZty9QaEx5l0JXf3NG6KiLyW5nVyMK0+2yd+ulDd7wLLFWb/Siqw+wrvl8tJkv
         jRHdHbP1+q3Tv2EonLpg43NRzovZuNs/QlYKq+IcgkIswSa1YCga+D61iEq4nxPYaA
         1y44zJxQSY4EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A17BEC43161;
        Fri, 17 Mar 2023 17:55:39 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230317064023.1229-1-jgross@suse.com>
References: <20230317064023.1229-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230317064023.1229-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc3-tag
X-PR-Tracked-Commit-Id: 7ad2c39860dc0ca01d2152232224d2124e160fe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eb392ec095ee29b932985deefb43e6d86d8a463
Message-Id: <167907573965.19035.6263826550490708525.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:55:39 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 07:40:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eb392ec095ee29b932985deefb43e6d86d8a463

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
