Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0296EA21B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjDUDCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjDUDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62ED76BE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA6964D75
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E348DC433EF;
        Fri, 21 Apr 2023 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682046055;
        bh=ORWOXLRCZAZ68uA7hqXTxqouI1G2eD9DgBRCQjtGS30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uPZ/GUH8pKAOlQOfZYF3Z2JMKAb8x7aEp+bENJTtDmC9dV0LhNOiIvz2+6ua4wV6Y
         VLRgO/0HJsSGT5DuL9pUKMdQNriDb8SRyt5zVmQnVYVtPcWSrz/K+yU/Z+zEKM2PHT
         l16thnK6lGe9cInAD0KjA7zja63j6SBPn9iNqibOGz2ZNAG4c1Bxa41Y1hBc68dF8Y
         PqZ0TjPqPO7GrI33Ynt3JqIR6Twlc+xS5HZMDZMgAlQNbEft500umGhWcKz6gZCFaB
         i3qILmEbALs6bae3UpbGy80uIGcjRmn06BAlu2TKoI8uBgwv5PInYzYVGN13X7O0iq
         h0O4iKzxFJRXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0467E270E1;
        Fri, 21 Apr 2023 03:00:55 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.3 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txf3=L+t2-RRDqPaRDBw_VxKqpJqcqS49f8gz3QWcHmEw@mail.gmail.com>
References: <CAPM=9txf3=L+t2-RRDqPaRDBw_VxKqpJqcqS49f8gz3QWcHmEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txf3=L+t2-RRDqPaRDBw_VxKqpJqcqS49f8gz3QWcHmEw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-21
X-PR-Tracked-Commit-Id: 00a4bd000e78a3a898e60bdc13e2852c8044a38c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2af3e53a4dc08657f1b46f97f04ff4a0ab3cad8d
Message-Id: <168204605584.25737.15590254702789022512.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 03:00:55 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 11:27:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2af3e53a4dc08657f1b46f97f04ff4a0ab3cad8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
