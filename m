Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CC677249
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjAVUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjAVUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE015CA2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA0BDB80B59
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79FF8C4339B;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674418838;
        bh=O1DV/NuaxtVcFmj5GlUmyxTBPlAz5p/6QxFRogMeCl4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lk2bIANbFtfcA7b0AYcT8SF8siRKLoraos/DnJOhReJhVBAw39F3HH3G1keRLvTT6
         9790gx4MHyfqZ4N3Gd9uHNd0VpCklsSrIV8sZwNVdAyjAl/F65NpJXFbP8L8YrpGwQ
         ZBTddhn/fQpC6c6XKfLQGg3Ott/QGaSGpx36sOqBMRrNrwwj4hlyGCvWWGPMlZu7KB
         a9PFi62QQxOXrgVoxYRfOC+RI0T7NnhqanpL1jTF8HhCWT3M88xVJmUEimm4zT6EFG
         9wluNzLv7CO97tLfV807dmT585nh6lgbPxOZ28r97wL2qxuVB6yn7KmOUp02ph2zc6
         l4B6nO63mPaJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67C34C04E34;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 writepage fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230122090115.1563753-1-agruenba@redhat.com>
References: <20230122090115.1563753-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230122090115.1563753-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc4-fix
X-PR-Tracked-Commit-Id: 95ecbd0f162fc06ef4c4045a66f653f47b62a2d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c006ad74d68be45ee36ca68fd9c053974fb6b0f
Message-Id: <167441883842.2461.17616475217090729818.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Jan 2023 20:20:38 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Jan 2023 10:01:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.2-rc4-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c006ad74d68be45ee36ca68fd9c053974fb6b0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
