Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B76C7318
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCWW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCWW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:29:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F1C29E21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20823B821CB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB621C433D2;
        Thu, 23 Mar 2023 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679610570;
        bh=jNQd2sgc0M644lxcUVN7lsBh0VpERn90kHKp7k6MS08=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CCawbdcA3wvVqeOq7yeyBY2yY7vqK5TXs00n8XiH8kwQamnxZz+TcLeTbd2hhJvqG
         6F23hvgHkKTYA4Ecytkismt/4TtjUDc5wBlyCb6RrTNKLqpBPAXPyb1sqzsw2o5jEa
         Xky6y0nWSjsgiZf892hZcoumi2B+4LlLut7HoACieQCeaIgudKR/cDc8NSemluJnWZ
         KrpYSe+YMXx1J9ZZ0lodgcCH04r0OXdeaEqOZ5C/DtfhQnG1yUrSoR7Wd+yOuBmvX6
         mJYHpnhLJgCjEElBEgVamMEiLSh2ZtT3HdJZM7YBXfc7ko2Y7pJ5thmwcmSOWXf5CV
         1fiJ9FMyudq4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A69FDE21ED4;
        Thu, 23 Mar 2023 22:29:30 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fix for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230323184537.749868-1-agruenba@redhat.com>
References: <20230323184537.749868-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230323184537.749868-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs2-v6.3-rc3-fix
X-PR-Tracked-Commit-Id: 260595b439776c473cc248f0de63fe78d964d849
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e760fa3596e8c7f08412712c168288b79670d78
Message-Id: <167961057067.18056.6663147195577984185.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Mar 2023 22:29:30 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Mar 2023 19:45:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs2-v6.3-rc3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e760fa3596e8c7f08412712c168288b79670d78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
