Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD369BE1B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBSCIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:07:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EDEB56
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 18:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333BF60B72
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 02:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98952C433D2;
        Sun, 19 Feb 2023 02:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676772477;
        bh=DxlTIjIjI2Stqt/dwKaz6un7G99O55KZhP8JxTILwJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q/wARCQrGvMgq08VhcPxRVkmthQ1IHZlxk+/Qc/49bEXBHhK9VnGXid5QZSyJ8NR7
         ijj2U9NOrSZgHPDk/M7ozdV44hUcgcJ4KHSIAo/IZQ2rXJ5TOIIzcC/rXja/+ABJ3/
         WM39IKjHmvnFZm5LAiPh+fkcy6cxg62KqkDyirf11B6orACqyhoeBd+ut5DGj59vN/
         EU/bdwhERt/GuG/NTeKV/at5AF/a4PFKydGafZ8/gH8H59e8qc3lMKCMAOO1RpmJNF
         GrZwSkOUMzubResWy9/0Wxkiiuvnc8EkLXT2SFgNYUG/C+82LVyJqveuNRZSonQogL
         zyfxu+XLpFNmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AD01E68D2F;
        Sun, 19 Feb 2023 02:07:57 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167676366161.269954.1941292974323519398.tglx@xen13>
References: <167676366161.269954.1941292974323519398.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167676366161.269954.1941292974323519398.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-02-19
X-PR-Tracked-Commit-Id: 2b129f0b24ab578b02901b4a1744b7f97399faa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a33d946cbb8709339a856d7da406a7a670e86a60
Message-Id: <167677247744.889.17612258757798407785.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Feb 2023 02:07:57 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 00:42:23 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-02-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a33d946cbb8709339a856d7da406a7a670e86a60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
