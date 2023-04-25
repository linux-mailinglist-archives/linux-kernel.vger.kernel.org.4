Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E886EEB09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 01:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjDYXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjDYXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 19:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8118E87
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EF96321E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85623C4339C;
        Tue, 25 Apr 2023 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682466004;
        bh=qPJx8ZN4x8kU/qF0Od1/2a/2gkZq1+OIYG7LIP6jFy4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cf/OCsgqtu8fPpzmxWGxgLDeXiviRat1X6dIWklxkuw+EdgHmn/lqJyz/R+rvRqAY
         Znm3HcxinkYSPP+4LKu3rNKxHv0sVv1ep+64MTSlOPmgtSr4A8vnxJ5M4yCuf2h9UE
         xUWvstHNiV0kO5BjeZEG5QCasyBB9F93IlP9+dLY6OHQkVvPZ3czcld+TEi/seFnml
         TNiB8O0h8wx8n0N6t7ZjzxUn4XEoS8hJqVukkexlQEVorBTHt5a3iC8qzPiZI3alk0
         JzmXgUpEPh0doblVEgWWOREeJ5LkVnzigDWQNroHlMbvSqoagFdgKYB1x/LTEZSfPa
         BndL/WF4rYW8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C5DEE5FFC9;
        Tue, 25 Apr 2023 23:40:04 +0000 (UTC)
Subject: Re: [git pull] drm for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txgxnFundgAa9LrveUVUU9_8A1RK8-hy+3pg7tDMJmSPQ@mail.gmail.com>
References: <CAPM=9txgxnFundgAa9LrveUVUU9_8A1RK8-hy+3pg7tDMJmSPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txgxnFundgAa9LrveUVUU9_8A1RK8-hy+3pg7tDMJmSPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-04-24
X-PR-Tracked-Commit-Id: 289af45508ca890585f329376d16e08f41f75bd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8cc58e289ed3b5bc50258f52776cf3dfa3bad66
Message-Id: <168246600441.4872.8908465628713097973.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 23:40:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 15:41:41 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8cc58e289ed3b5bc50258f52776cf3dfa3bad66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
