Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55BF5FBA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJKSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiJKSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D47B797;
        Tue, 11 Oct 2022 11:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55D66125B;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 159F7C4347C;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512530;
        bh=ttzmfGB3hvhX3OsFhFXeIm0KYgoc3KDurzCSSK9wPl4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QrjslGPg5/9LnZd6fEhtJAyb3AWgwNo6SukKQtXWdTh5NAHJh2tPo6o2QZYTM/l1l
         FfCiX2Mi67jNZ+fwBI00fTwGOYhCzaqJL6ENvVLOkuYzEp5yflNgfhN2rkE4slwCLC
         lmSNYeWqP1MOaf/L2UQvoy7NN6TDNbnH/Nb8RCXuOqN/yHE0RQoGY2KJwG/Sed+VAO
         j++NEqsQcHjEZAP1brSMvl4gZ4xQaTAGAg14OQW09m29mST6YEBXXH6jwiKiuyoZJC
         o5QVxHtKzXJZeWZ6gXHveoopPwrl2dzsZbP4KpGVBwCAJDgYZ2epVPUJcROWHp93IV
         aYskSwUbgCWPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2324E29F36;
        Tue, 11 Oct 2022 18:22:09 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.1-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0O/KXxdj2gc4Sw+@google.com>
References: <Y0O/KXxdj2gc4Sw+@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0O/KXxdj2gc4Sw+@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc0
X-PR-Tracked-Commit-Id: 5f8f8574c7f5585b09a9623f0f13462e4eb67b4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 694b37a5dd3c87235e02fabbe7b394f6ab1f444b
Message-Id: <166551252998.20259.2643720805793098948.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:09 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Oct 2022 23:43:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/694b37a5dd3c87235e02fabbe7b394f6ab1f444b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
