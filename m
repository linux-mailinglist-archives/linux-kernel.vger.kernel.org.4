Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5326F1D55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbjD1RXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjD1RXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2D4497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55DD7644C5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F33C433A0;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702588;
        bh=u/S3i6DgLVP1l1gVrD8o9m4Va9PMqmXeiOWdhZveGfU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I3bmTFEtzrFmRAICAMOZpSSCXN+ZF7MnVFCja3KcKVVCrxsB51xDLzZVpOWph6oSa
         YX7/UH46UKDHfKy5hw237mPRtRY20MVcAjBdBtAqXrXWQdi2noQP+XZTSfS4a3Cern
         d1RbQIVWe3T1jACVCWP9z9glr1f1aFY6YbZiBtqCT8N6GLqSYeEyKEeq0nJVAsN5X6
         IVeezkAhn3FiUlYOvIBWcwIBGnMOBYY4y5e6upMbyUKQ7YM+zyoSorA3PuIOZ8pxK6
         v25OsrBFv1OpElkKwAPHF7vbm7XxWVMUjxQK8Y21QwAEB32Z7gwP8HTe/iuC1vFGmj
         jjCNfXx9hibxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0676E270D1;
        Fri, 28 Apr 2023 17:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427161010.1053561-1-dave.hansen@linux.intel.com>
References: <20230427161010.1053561-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427161010.1053561-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.4
X-PR-Tracked-Commit-Id: 5fbff260755750559aa12a30f6fa7f8a863666f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e54debe657109f1728312f9cb5ccae6f737b7dd1
Message-Id: <168270258865.30920.12355589708073227988.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 17:23:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 09:10:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e54debe657109f1728312f9cb5ccae6f737b7dd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
