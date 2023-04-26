Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675E6EF8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjDZRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjDZRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF477D9E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E50D6132A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97289C4339B;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528793;
        bh=th2u4FqXXQxcNjray53dhHWfMOx7cbf5YUqR+7Fov9A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V5bZuzt6KfhgBvf+X96pCYxnLyHgOK6NNvOu2pD57z2RKkalI4sbXj/ijNHZMqnMD
         xYYs9YtyeJ466a0Q76WNUvfyIM/u1ZC30J0HawxSqIzm59YIzeZ/2bAf/Bc2Virkhq
         Jv3oKOYKkceOfUcXU/Ay4dBKyBqMvMOcBKo2iKUdlYIIjjRLkBlEox8F01hL7x0JPy
         C8+GrEkrdqiJnKMAVkm+2Dx2mGyfxAZvAe++Q3FCNwHQNJo0MvBuX+amGu6YyfW3rl
         nSYkf+KxJLtQFFZnaz/3UtbAtRfaL4cdXd9uUCGxOYNUWHvg7w0f4HYT1q9odP5+CT
         TGmeVoTTJsHoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8538BE5FFC9;
        Wed, 26 Apr 2023 17:06:33 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425153951.GB28392@redhat.com>
References: <20230425153951.GB28392@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425153951.GB28392@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.4
X-PR-Tracked-Commit-Id: 7a40f1f18a88c6d43c8725d7f45146480a79fde1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbfaf03ebac999b4f44f36d851bd729c24c5a658
Message-Id: <168252879353.19907.18311126134872951543.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:33 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 10:39:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbfaf03ebac999b4f44f36d851bd729c24c5a658

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
