Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6345F7BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJGRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJGRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0C3135A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3206C61A43
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 039FFC43140;
        Fri,  7 Oct 2022 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665162008;
        bh=gPZECmgJMz08JvLHN9ONpfqaWyb/kC3PV9CF/nISA98=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rUcQqg+nVAjo6ChozzbU8AYT7n6e5nr2eaXvz9BD6ap6swYiYnNFsrHKxGhHEo7Ak
         b95syK8oiTfGT/mYQlPqen8+TM2VGi50+ApjbxDxgs03TOjSzNHnswb+9BSCMMlDVg
         y8WujbolILlR9Aw80HfvVBsHx/EdCqWc/syn/j2hThN9b1AawkXc88MSAWk+kmNlhr
         5nDe/5SrdFHF6dzuBabaVfoVpN04lgdOqss3tF0DjioNULoAcEvfaO3oKL9M0M4N9v
         9BONSxE6Kr8lWdfZbwsWQ+KXYyvhT77YTeO6k+mmbi2EmrM8maOlO5vG14JiBVwgCt
         PLggRNrIc4Clw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5FDFE2A05D;
        Fri,  7 Oct 2022 17:00:07 +0000 (UTC)
Subject: Re: [git pull] drm regression fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzQnonp1KDSZ7ziUNdm8EfJX=VhmE9gA4L8wDO_AoYLuw@mail.gmail.com>
References: <CAPM=9tzQnonp1KDSZ7ziUNdm8EfJX=VhmE9gA4L8wDO_AoYLuw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzQnonp1KDSZ7ziUNdm8EfJX=VhmE9gA4L8wDO_AoYLuw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-07-1
X-PR-Tracked-Commit-Id: bafaf67c42f4b547bf4fb329ac6dcb28b05de15e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d84bb40bcb30a7fa16f33baa967aeb9953dda78
Message-Id: <166516200793.22254.6627873676763824408.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 17:00:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 13:03:25 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-07-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d84bb40bcb30a7fa16f33baa967aeb9953dda78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
