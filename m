Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C021F5FA2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJJRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJJRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE24D839
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D8AB8105F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60F5EC43147;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422527;
        bh=it7AxIz6lwLOs58yxpQup8K2H4kLAF3mRabbW2yzta8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WVoLz7gZcSK7jUnKYEkTRSI2MuIit9DMrr6l6YIz6M6a3fsEBdPVFLsxg6D31v6BH
         1jRh+bmpK6/se7/dp2ZOz947cNmIWXPDkSbEud/mX4rLZuGMv7SG77iBvlcHCR8QHd
         OzjoyPMsrAbrSzMtwYwVU8AsesOr2FWI8kEpH8AUoCQgB/fYcU5qo+J3j1/31ZM05B
         DJJ+1K8ASHpa2fv89Bk5eZA9pzLwoUGa957PlyLdiIWtnp5TFXGRjmvd6lKHxA1EKW
         Uaw17ZGQ1za0z6+HCDzXqVt4xAwclJ+XA503d1mAk8p09xl8ZR0O636IaF+QbXj+90
         kyRxcqFfXTm+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D783E4D022;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz/fXafXBApgFQrF@gmail.com>
References: <Yz/fXafXBApgFQrF@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz/fXafXBApgFQrF@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-10-07
X-PR-Tracked-Commit-Id: 76e64c73db9542ff4bae8a60f4f32e38f3799b95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e71f0167b3db4e4b3d0d8353c375f6587323052
Message-Id: <166542252731.13651.16837482531367303884.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 10:12:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e71f0167b3db4e4b3d0d8353c375f6587323052

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
