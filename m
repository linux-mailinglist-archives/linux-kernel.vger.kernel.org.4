Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3738E608323
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJVB2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJVB2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E12A568C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 18:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753ED61FB1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF041C433D6;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402117;
        bh=2NH6m2nyWWNkCu6dKhRmmjC+7R05DApm9d7S2WAVw2Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FlPPlqAsrdsucR/fd2goMAvag8TJ4q8LwVldb/4cY94UUnfzRhdfHhWX5ADT0dy6m
         l34kz4onFBUVpziORV/CYK+gI3PXxWj/P0VByCvvy0arw4eoXu0xs9G4brZMxcvbrP
         X2WZYMRWahgJMl1NYJRNeuevXGrHFlJyV8fdrJZMTO+2FeRNzj5An+3+HbPLcYmARi
         ic40E9hFVZikDbNBqpJ+mJxT4fFhdhtHNHWUc1pjHMp4IIGSPAImwGK6o2JE/OH6jF
         EFV6TUcNorFHougYPtJ4ReNZX3vh2FeOaObAj9DEmiPn+PfLQBuKa3ug9QnXLWs++6
         Q2WmzSVXBSn1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B7EE270E2;
        Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1K56ThNRTpLRA2X@8bytes.org>
References: <Y1K56ThNRTpLRA2X@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1K56ThNRTpLRA2X@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc1
X-PR-Tracked-Commit-Id: 620bf9f981365c18cc2766c53d92bf8131c63f32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e97eace635a42da4644290179aea496178e64988
Message-Id: <166640211774.11783.8745653046282981940.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:37 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 17:25:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e97eace635a42da4644290179aea496178e64988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
