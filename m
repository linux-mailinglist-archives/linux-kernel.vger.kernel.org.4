Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132EA5FFCB3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJPAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPAPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 20:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63740BC6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B188CB803F1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 00:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78E35C433D7;
        Sun, 16 Oct 2022 00:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665879338;
        bh=t5U11+x4czcTlpCrS/3J3OedwSEGUOn1KQy3HtgOllk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkoJMzC/LSC973QoDYOvqn5nKJpKo2VoqUbIXCW9H4QX2EiZh03A1hfDDgaZ/XHGb
         aET+oHn5YJVQCjBRnj8j2iuJFdBTYEdMfEch4rNh/QDd9P+FxkHvLBTQOtd7dXLiAf
         RySq6QQoNI2OvnL7qGMeH1MEXHVeUQ9SN6U2jDfLHXCsWZJHfadj3NY5JvwKSO4XEM
         B65ldKbLmOnS6ANT6ezUYBihRCWD5c1R/0XoQZ2wYPmhJKwI7mEq2JXMtdnvvzTC7Q
         GGiGcE16hj8/n/kN1ItyWqaMa2xMF+PNKr0zxuNG77C0DUnAXuopkj6+8UIRcTWJXD
         io/RNd9KUH01g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6620FE270EF;
        Sun, 16 Oct 2022 00:15:38 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0rkcqBr6Wan4ueU@stafford-asahi>
References: <Y0rkcqBr6Wan4ueU@stafford-asahi>
X-PR-Tracked-List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
X-PR-Tracked-Message-Id: <Y0rkcqBr6Wan4ueU@stafford-asahi>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 34a0bac084e49324c29e6d0984d24096e02c6314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36d8a3edf8bd504320fca970f8b0633b8226cb58
Message-Id: <166587933841.18523.260321128044065343.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 00:15:38 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Oct 2022 17:48:50 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36d8a3edf8bd504320fca970f8b0633b8226cb58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
