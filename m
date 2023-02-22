Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2869EC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjBVBnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBVBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:43:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B631B556
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABBD61232
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 416B0C4339C;
        Wed, 22 Feb 2023 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677030196;
        bh=Ot4IlMt86aLhIt4eznKFWGHa4CeI1g3LzAsedP1CeGU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oeZVUqDzX5xEOo/Nai3x2ChVWabCoMF1MLh4pTLSJ9CCk2tGseSE7Phs2ibL3+PSr
         SRZBBv9fbUXgHIBazveRH41MmAxFnMG3OGh2LecINwbpgVrKCScnRSFjf59U1KUo8A
         CHp5aPSIoLfVbChQyTcuI3x4lpF+hTqZ3kuebqNhvbkzXYXB7PgKGTcZRyGIKme7Ha
         rNjlbXKfFX0DCyrUnVZhM8dzCYqvhD/M9QrmNqYe8A3FUZoc7f8s9yvQwxSjdM1iFH
         zGXYaRt50N+eWxBisfoAuA4NIR3e1YLJayAxH1gh9GkO05T3r41FsuRXJPVtJpN65d
         UAAVbmIdYmoZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22161C43151;
        Wed, 22 Feb 2023 01:43:16 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230219053326.4980-1-jgross@suse.com>
References: <20230219053326.4980-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230219053326.4980-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc1-tag
X-PR-Tracked-Commit-Id: 4ecc96cba8d93d86abf46d17067e9b4c96241a29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 239451e90355be68130410ef8fadef8cd130a35d
Message-Id: <167703019613.10177.1154874445058167246.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 01:43:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 06:33:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/239451e90355be68130410ef8fadef8cd130a35d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
