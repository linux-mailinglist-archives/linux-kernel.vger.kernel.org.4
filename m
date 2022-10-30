Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB8612C49
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ3SfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJ3Seu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AB25FE2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EBA5B80F00
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2268CC43470;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154887;
        bh=PWPlaHoffg9W4MT1oKchtSV1P10J3xMD0DR3GLMrfAk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N+eBIPKvRQZ53Om2TsM8EHuDBokB7NNMb2BZWlCRWDn2tZjfhWO/vIApDPFx6PxB7
         swrOfEN/ncI+KUg6z4OGm6R0jiSMfpRKY3akXY+qwu9qOfZBYeG2nwt8riqxbbPtI3
         AEQVGbPJmGoyyFLEii8xMmceVpkn2f//f9qR84+2YCTMRXOfcSeCRDjvFxCBFEPoZ2
         ownd7gwk4zsMx1DSD32u0kmy2+M6Kp32+ZmCtXD7PRq0LRG6JWyo4toZTQM1oa2lxt
         5CmHxGhAMiRnfwIvImhRz6pWDLcXEZAo/1XGMBovyx3upTY4xFAMRmhIaXGzRKO/6g
         JObOpKX6Kc57A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08BC7C73FF7;
        Sun, 30 Oct 2022 18:34:47 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y15He+PfiChMoTJv@zn.tnic>
References: <Y15He+PfiChMoTJv@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y15He+PfiChMoTJv@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc3
X-PR-Tracked-Commit-Id: cb6c18b5a41622c7a439508f7421f8766a91cb87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 434766058e16868e3c04223fb1b3eeca3d9b7ba1
Message-Id: <166715488703.31922.10164143666479869220.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:47 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 10:44:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/434766058e16868e3c04223fb1b3eeca3d9b7ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
