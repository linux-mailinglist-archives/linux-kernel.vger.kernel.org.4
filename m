Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881569B616
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBQXAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBQXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:00:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECA107
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D60EB82C7B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 23:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCDBEC433EF;
        Fri, 17 Feb 2023 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674828;
        bh=/+E+Xt2KjcN0vWMalUVS6q3ENhyUTJNzgzHQ54Ud7mQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CFs2xG6bHCO68Clg6QWt4ERlET6veKb82qMYP00nK/PW6/arFOBpNLk78f3NgjNdO
         cn2Wz0XxLxg6qzpWzCo8JXyO/2wax0L2s1+nNcpB0Ilep+yAc3eXhbI7aahRSdcPBR
         db9mQT3jfDAXEo8WuUoWDWp2I/pZ3IRuBZiuLC8H0D4hywmpcW4KcWwxpxLDWxzDq7
         NXx7nn0l7kstGfSvviuwUKcYCTPN060SdoH5bnGVvnKhWUWTgKN1iU7uupMiSF+stx
         YpVWSAexECOQNyDDJqLXehwd042h6gjVglyo3HgRUZSUn0Wd5xQx9uziv0rk31l50V
         nIAsCzp8wZHFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA7E9E68D2F;
        Fri, 17 Feb 2023 23:00:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
References: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-6
X-PR-Tracked-Commit-Id: 4302abc628fc0dc08e5855f21bbfaed407a72bc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbeed98d89ea91ae68ff6dce6060671726292e85
Message-Id: <167667482875.20587.7032685656825133519.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 23:00:28 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        bgray@linux.ibm.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Feb 2023 09:40:18 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbeed98d89ea91ae68ff6dce6060671726292e85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
