Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2B5E8E15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiIXPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiIXPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0163C8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 257BAB80DE0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA225C433D6;
        Sat, 24 Sep 2022 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034108;
        bh=M3+cOc7Iqi1w0+AS5uJ8P/hWru//sv+TXcl6puqGrA4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WdGHji8mj4qKrMKlz+2mj7idrpmbdB3E4kmZhWqy6x73XqKmXrDQ4uyIgEGs2dFkd
         dp1UeKvd0TydsIuGL9EQFYaI8akeeioZT8tb2gsHp9Kd2pPnvjaC2BStMPfAh2gymc
         f8pnB4mo0ty81qfXDK8NsJfEPU303vquFFxDrbq6Y5l//9HbZ0xeaY1UlX9XaiFrml
         hTvqvWMtXVINPnsGsd7WiiKvEp+14tObybgODN8rjKFlZRZgHD5gHczTDWgNzBVniW
         dFntjrX70sYc2YjyAVBOLo3155J8YzzC0QJzUTvwungGSKt9n4hRJI+mDURXLvPFRz
         0PkADsJM2Jqxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C04AEE21ECF;
        Sat, 24 Sep 2022 15:41:48 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yy5+KbO8g7t0szu5@slm.duckdns.org>
References: <Yy5+KbO8g7t0szu5@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yy5+KbO8g7t0szu5@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.0-rc6-fixes
X-PR-Tracked-Commit-Id: c0feea594e058223973db94c1c32a830c9807c86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aae8dda51964ff9d3f1dc96528b853826667efad
Message-Id: <166403410877.30824.2365999891805066767.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Sep 2022 15:41:48 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Sep 2022 17:48:57 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.0-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aae8dda51964ff9d3f1dc96528b853826667efad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
