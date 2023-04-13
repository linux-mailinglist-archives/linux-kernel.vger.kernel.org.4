Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B816E1742
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDMWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDMWVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4626BE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E53F641F9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CCAEC433D2;
        Thu, 13 Apr 2023 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681424479;
        bh=88/OIL7pcebf90UeHpSbS/WTFZsHseIT9TjhS4eELnA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XOPp/RUHw1GQZXjn9wkp8RBCvOooew/kGx4ktSPW212FAVLLKMsENQ4pLLNPe/HAF
         07omFZGcvaVCPsLtxQMZDuvm7MNKtlRLYtn9dhwfQ8q74MdRsR+59G3knXYdtFK/IS
         hii892tXMzxe1FhjGYtorfK7S+vowDcXVHmzm40wcYpuR3UzzHbxEL64DZiRlHuVZD
         CvwqmzTSSu90PX7ShT3v97jGL+n1I/KwqSW4CxoOIDHd/GplagAjynhXs+QK1eD9ve
         xDqcDXjsjgEO1r/4mqgJDVghv9XSSOt2AiwD5qRjObbVBjyig+D2fn5cqPW/1n3ulv
         mfOC1b3VqPOlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BC2CC395C5;
        Thu, 13 Apr 2023 22:21:19 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKMK7uHy7FMdpEZLu2TTzgnGOrntBcQi_B0c=X+oT_fyUhcTDw@mail.gmail.com>
References: <CAKMK7uHy7FMdpEZLu2TTzgnGOrntBcQi_B0c=X+oT_fyUhcTDw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKMK7uHy7FMdpEZLu2TTzgnGOrntBcQi_B0c=X+oT_fyUhcTDw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-13
X-PR-Tracked-Commit-Id: cab2932213c5cd72a9e04e5e82002e81b946592b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1be7b6c165f0d451c3ea2062f506bf5f130bd5e
Message-Id: <168142447956.24378.13098315995798149937.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 22:21:19 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Apr 2023 21:51:38 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-04-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1be7b6c165f0d451c3ea2062f506bf5f130bd5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
