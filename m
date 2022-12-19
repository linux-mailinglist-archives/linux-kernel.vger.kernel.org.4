Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE2650D48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiLSOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiLSOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:30:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C6EE2A;
        Mon, 19 Dec 2022 06:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A968F60FC1;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E376C4339B;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460209;
        bh=fKU+IjTEY+b9nn/FiTDwZM/P3ey5ddpHtNqqjF4Hckc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gjy4qkcL6Tj2V8bnDXC44gKD6MyxJPrl2e0eMrMYGKHvjmg8mCQfTS6chOqszM4u+
         OY3EPipIQCeGuAjGxTDajmxGjujEPe2Ha3VnfMzSu8D7/yLkeJ+l/jXf5i94iFHd0r
         zr726Mqr5pWb+0P4wF7QSIk0fYWTRdGzdgCt3koPajI2TgK+2QXZpeWPilYAdc1GGP
         J4B78dt7g9m0wlWAnIcbe6s2dKwEeNxVvKENdBrTVcTOUTQhhSoZk8q/yvTPCcIWdJ
         gNPopjFCLldWwlsX1c1OHD8MuCP5j2smOhM16clHUcvtjtYyY0RhilbCOyRqlSM1Mu
         hhkNTVpdqz9tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D571E21EEE;
        Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] final non-MM updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221217203730.f48e5345841a57dd6e713faf@linux-foundation.org>
References: <20221217203730.f48e5345841a57dd6e713faf@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221217203730.f48e5345841a57dd6e713faf@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-17-20-32
X-PR-Tracked-Commit-Id: f9eeef5918bbe1f2545d36280330dced25d6cf97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6e3e6f138058ff184d8ef5064a033b3f5fee8f8
Message-Id: <167146020924.28969.8020557519529165230.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:09 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Dec 2022 20:37:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-12-17-20-32

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6e3e6f138058ff184d8ef5064a033b3f5fee8f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
