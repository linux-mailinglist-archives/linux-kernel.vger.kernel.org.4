Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D185069A4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBQEij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBQEii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B92CC42
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:38:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 115FD6100A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A529C433D2;
        Fri, 17 Feb 2023 04:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676608716;
        bh=lBD+ZV+x7RW/eX53Icvx7ILkWEuCoGjpdQs2LC4GIJE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DEvc2+ldxoY1eRm4xROZ/tl8JAOTaeExbBxAhinMVOIoBiSh5mtJGwb/K0LSQMoBr
         OiyjoKf0Y1oViAJ77gASHQqdb6uoGsgE0T00du8EgHIH0Dx3x8ff4OgHR5as11f3K9
         Ebp0eiUZORVwpluSX9DW6lRxq5QTPdtY1xL18F8irU95Bq6r6ixi9J4cb+9IOS95ce
         E2URsqVMbUb4JKnzKErUaTahzl+hhyz/wz/q+xR0oL6avSHMcoBtOOGY9Syr/pH3Ko
         eQXDvkCxi29YAe/8XXUs+l7jCxOK8WiItWgz3lhjhAz8H4Niy1Rne6sSv01cn8riIL
         0x/EzPKnxBlCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 651A4C1614B;
        Fri, 17 Feb 2023 04:38:36 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyvvUJiuADGfPznEKCNBmwGzPEKE7Oob_9BduxE6Od4TQ@mail.gmail.com>
References: <CAPM=9tyvvUJiuADGfPznEKCNBmwGzPEKE7Oob_9BduxE6Od4TQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyvvUJiuADGfPznEKCNBmwGzPEKE7Oob_9BduxE6Od4TQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-17
X-PR-Tracked-Commit-Id: f7597e3c58eeb9ce534993f53c982f2e91e6dd4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec35307e18ba8174e2a3f701956059f6a36f22fb
Message-Id: <167660871639.4329.3467322456999511365.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 04:38:36 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 12:16:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec35307e18ba8174e2a3f701956059f6a36f22fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
