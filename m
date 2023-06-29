Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3CA742B67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjF2Rit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjF2Reo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706D35AA;
        Thu, 29 Jun 2023 10:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861A3615CC;
        Thu, 29 Jun 2023 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFA6C433CA;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060081;
        bh=9WLgxZhmGV7/VC7LqXrBS5Q1OO2y8fX7E+T8kONof3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U6pXuP/Tl3MtijtVhQfsiLKLl91vvEwEupDFAc984CYY0zkqAJEwpxIsP0TeZ7e3I
         x4hz/N//hGIUdlgh1cLOflgwTn8Qjaf8UrieC6usgzVWQ0ZkmpEXWVmqWEOKBxQ6kt
         BmGQldjOttDms8WKk+b760duDmAJtMxalOTupxYcq6S+kJQ/HUxYDXxbvdr4YsEoFi
         6MlLh8czMYI6YOAq1Cwnu3vAUDF8rcmOk/b5PpG2qaw2t72KQC8Ex0Fpd+BbQXOgt5
         9CFtSYgYKtCzf35I9ff35WLgW9D3jXrStRPUqeqUEAVBiE47pM3f/Mem4tN4lHD0Hz
         8KQ06HxczOxEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DADF3C43158;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.5-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJtnNxQjJ2yrpwIV@google.com>
References: <ZJtnNxQjJ2yrpwIV@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJtnNxQjJ2yrpwIV@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.5-rc0
X-PR-Tracked-Commit-Id: bf4ed21778f2920ca91a32fd3a1e1130e843e98f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86e203edf24bb327ce8fcd3c5c8c6bf530a846df
Message-Id: <168806008089.7356.3831766038000335082.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:40 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 15:48:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.5-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86e203edf24bb327ce8fcd3c5c8c6bf530a846df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
