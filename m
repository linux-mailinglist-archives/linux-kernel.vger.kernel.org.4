Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA486F75C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjEDUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjEDUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB901887E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 12:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD41963844
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 19:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 424A7C43445;
        Thu,  4 May 2023 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229784;
        bh=rR8pRehz/FaPkakrj7Vsl047aV1UVlLmSnglN+Qub0U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XjNTQwKkD3Ts6Z6n3nNfE09gEB1x3Bo6peV91HA4txvNWpvPvemkqpdbuowN/mzMM
         41RebyJ/jl4msgTWRiXVselY01lF36kMXVm8xR+ZXt5kzdkqhiDhBQSOiaGmbL5O5x
         ltopCmXQJMLKLokJx4JjI/Vn6Z6X71dLSgQBc/Ule6cea8HcQAmSbjEw4IVEJTvzIu
         N4wBS+23cfNHo6xU7pOQOM/HRbjPLMvpsvpSGYfTTwgLkwuyFbxa5zhqTqMc3ciIlR
         fynLt7YXcIAs2Zdnc6UFBYI6WnnTj/tUuEoehBXFLKL09/ayNdbzueOa4D6XFOH/Xk
         nKmGJtCrHTuEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E678E5FFC4;
        Thu,  4 May 2023 19:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230504142247.GA18895@willie-the-truck>
References: <20230504142247.GA18895@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230504142247.GA18895@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 0fddb79bf283a561eb81f09d01f5ac8f61bf8966
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 671e148d079f4d4eca0a98f7dadf1fe69d856374
Message-Id: <168322978418.14542.15437473952868532528.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 19:49:44 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 May 2023 15:22:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/671e148d079f4d4eca0a98f7dadf1fe69d856374

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
