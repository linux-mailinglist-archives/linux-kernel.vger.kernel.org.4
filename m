Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10C97135E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjE0RWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjE0RWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 13:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF78E1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA9D8603F7
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 17:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17CC1C433D2;
        Sat, 27 May 2023 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685208155;
        bh=iLmQvKnR0W+7FxEY1A+v5WguoW1iSCLbA5KWnRCGKPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AHu3Z+8trOd0ClOKxvqkTTzNpWRx1bSts5AHV7HDO6qVSEdYY96pXN3wfcDR3uQVn
         2lsYHdNlsTMZyhu8tN6IEO9sMjAHbOIIXCk4qYpdEXbXcRTeKgcH6p7BjntXpMRu2p
         Wik+rvjWLFAZvsJ8m8WmNgxG5EFQ7r+B2G6UIh/HoAOfvNVe8LPCKp2WPfyO7jYsDZ
         IT9W38B4eZp4U6K2ZkDPh73nvUNbwNzK/ZSu/GXl1E9RoU6admHgkwe4U8UMGq8nwI
         hyK6Uh48bs5P+jHGfKIjt1+arTJIh+8hWjuT6V96LRBF2Po3U+aVDIhZSJwHsstmbf
         vfO3lSPFLLstQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBE86C4166F;
        Sat, 27 May 2023 17:22:34 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230527053544.31822-1-jgross@suse.com>
References: <20230527053544.31822-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230527053544.31822-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc4-tag
X-PR-Tracked-Commit-Id: 335b4223466dd75f9f3ea4918187afbadd22e5c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e893b5aa4ac2c8a56a40d18fe87e9d2295e5dcf
Message-Id: <168520815495.27218.6793284360828021541.pr-tracker-bot@kernel.org>
Date:   Sat, 27 May 2023 17:22:34 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 May 2023 07:35:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e893b5aa4ac2c8a56a40d18fe87e9d2295e5dcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
