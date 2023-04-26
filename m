Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63E6EEC16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbjDZBwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbjDZBwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E6107;
        Tue, 25 Apr 2023 18:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE13A63246;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52D90C433A8;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682473880;
        bh=JyxxvmROh0OsyDJ9v9r+Y6OjJ81JNiOLU/Ss3wrhskg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lWqy7XDaUIGLka8ByT7yoQBVNoersWX++Gdh/QmjrvlavLvBc/psMM8vMVZ8i4NBF
         sMtYLGTjC3umC+EDeFUkjDIjtvAw/7vGJ31znOSeM5Jjgyv88WXFBTR8p3BPnqZVsd
         4TZxbtihuEV5cYHsLVnTwFEDEj6FYKM3oV/6GHrFJVt0y8bjcN8vIMkUUZBNWMnYjz
         elN3E1JwOrXQwEzkJP3S7kmOZXElnQz+ZTcZ6F5ugKUophYpHQgxbHPCg0vpz/ip1/
         VdtCzfuKhy8p7oeOxkQyDDC/j7uH7wy99uSHZELGLfTPM1rW3Hutz+9s1M/Qnsycs9
         XZIKXf3eILNMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42D66E5FFC6;
        Wed, 26 Apr 2023 01:51:20 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7z2iy5M+eWoA6M23rYfZ+OS54FVDjWmGNze4fR45EmA@mail.gmail.com>
References: <CAJZ5v0h7z2iy5M+eWoA6M23rYfZ+OS54FVDjWmGNze4fR45EmA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7z2iy5M+eWoA6M23rYfZ+OS54FVDjWmGNze4fR45EmA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1
X-PR-Tracked-Commit-Id: 5bc6b1df65c87f8dd7d0afe494a2c0b9d5c73140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e0ca0bfc33b7196ae3a5cbe26289a4025618f5a
Message-Id: <168247388026.11449.11110692337488491582.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 01:51:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 19:50:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e0ca0bfc33b7196ae3a5cbe26289a4025618f5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
