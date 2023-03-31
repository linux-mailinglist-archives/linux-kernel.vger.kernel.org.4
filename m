Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80E6D2938
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjCaUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCaUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F82220C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD1662BAA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 20:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A8FC433EF;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680293696;
        bh=ZxtofbXaRHzWyE7ctF4k25q3TsjckVXj63uEHJmZ+34=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iITz1Eq6GsPBfdOGjlQ0r2chLjAJUeOwNDfTHHdmM3fnvOpaCIKMoTjUTEYCoOCR/
         q+idw2CnCMZoXTUcuyn23liOL3/StBUzb97ZuXhXE57tBtMypq53J/pUi7NJ2HohKH
         /+/ZvufUqfr+FVUOHP30sxojHJujS8Z5xvi4OUNNURICy8DpzPZKN7Rp9950B/3vKg
         VqLufjZkM3wi/vSFXAHITZScyww5lgf8ZvQ/RIgzaMAzgFkZi6fVHHpAECJKnRxxCj
         FD7Isdg8onscshxUtgMMaqDll9jHLDWv+0fLGCJTLfmXkl2vsrISqfWvf1nvYGzags
         TSDyqJcXPSq4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 720E0C395C3;
        Fri, 31 Mar 2023 20:14:56 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230331161139.398CBC4339E@smtp.kernel.org>
References: <20230331161139.398CBC4339E@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230331161139.398CBC4339E@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc4
X-PR-Tracked-Commit-Id: 02bcba0b9f9da706d5bd1e8cbeb83493863e17b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3df82e4201f5415f4773d4ca8f0ee5a71d5b88fa
Message-Id: <168029369645.23236.6522505578779156772.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Mar 2023 20:14:56 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Mar 2023 17:11:21 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3df82e4201f5415f4773d4ca8f0ee5a71d5b88fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
