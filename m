Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9268B3D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBFB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752317CCA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E9D7B80CB9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B69C6C433EF;
        Mon,  6 Feb 2023 01:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675646914;
        bh=FfaZGqzCiXpA5W48eheRx5UFruhg5Dta87m99mlv66Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RHryAnij3/Xy+XppcVcJaRlZx3xkRXWvLC119fD31LdE/XBAXmSQuDMbhXKmfavw9
         bblcoiwCMIzQJ+bFeoe47cP9XsfJiYbXCwaTWvvNJJIN23xbbxZRvs1J4nOTQIA+OA
         9yYO7GxFd4hf0AGKz+eGZXiq2/5aJFsCBGwZAwJDClWMeHb0eVsFMRp5b/OgWxkTKo
         4Fo+ElASdSEdQ/csRjb3WLngPTK1mbxhaBp/EXshTJimb+kyiIDZtala4Z8ZPZIwf6
         tOh+h2FzLo+3QfnfdmRjskAXCLOHaETfOjdpNbLTh5JLlyUvtl/fv+vV4glgtgFILw
         Y1F3pnzWtUX0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F1A0E55EFA;
        Mon,  6 Feb 2023 01:28:34 +0000 (UTC)
Subject: Re: [git pull] fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+AnKB6wuL7NUFmi@ZenIV>
References: <Y+AnKB6wuL7NUFmi@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+AnKB6wuL7NUFmi@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 9c7417b5ec440242bb5b64521acd53d4e19130c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2d11f342b179f1894a901f143ec7c008caba43e
Message-Id: <167564691464.14322.11312958359609420106.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Feb 2023 01:28:34 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Feb 2023 22:01:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2d11f342b179f1894a901f143ec7c008caba43e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
