Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36669615316
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKAUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKAUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:20:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF71C102
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5237EB81EAC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5823C433D6;
        Tue,  1 Nov 2022 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667334003;
        bh=NZ69dsZSzwIHwq0jzde81Mbze0dkSqoahbQU1CBOMuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jg33hFVsppWlNtGXPuuKM2sN2pcvpQAyIozSRLbcPvF82tXt6pYXyQfkmwxQrx99T
         9Fs2GryOQw5onSw8eGwbhpPzRA1NHy57zVppZ88QK+2DGqODEfkBEe7fECZ23RrMd2
         nbtz1GUfj80BEhClLl2T8oiND+v95/NicY423Zo5CAo4Y4VOGTZG3jFOHcb6yiY727
         gcbWXM8LAiAldjjQ8pBO1xlsgjsJ5MGQt9MFGla5xskwUiJ7UtJ2xx7BtVywYaDlp4
         k0nMB/8Gu6GMPq5sIGDr51cuKIZ/Ymiwo5giGRJqYNvtYeQlDREBs6Ma0+7d1Nczvy
         Wseuvn78dQ0bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C176DE270D5;
        Tue,  1 Nov 2022 20:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc bug fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221101171234.GA763719@paulmck-ThinkPad-P17-Gen-1>
References: <20221101171234.GA763719@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221101171234.GA763719@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc-urgent.2022.10.28a
X-PR-Tracked-Commit-Id: b3f4f51ea68a495f8a5956064c33dce711a2df91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54917c90c2cfc6cf3be6deb143cf3967b6dd8d3b
Message-Id: <166733400277.32297.16716909280123999905.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Nov 2022 20:20:02 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@1wt.eu
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Nov 2022 10:12:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc-urgent.2022.10.28a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54917c90c2cfc6cf3be6deb143cf3967b6dd8d3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
