Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33006E034D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjDMAou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDMAoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9316E8D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D9563A44
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68068C4339C;
        Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681346679;
        bh=mY4V4GpNX4N0NVguYOaXXW8tNoh31OuCQheysCJ5k00=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AHI6GSQpubc/GNmJP5x3YyKvCO9ZVgQurzEtRvBXhOzbKu3rB4NVhiTK4RNWF822z
         cVPkagH0cC3aLJmjWhBwWGesdPOKbibjFjmIe0utgglz8EDuci6G73U/FK5BuvHSWA
         pATobWxNiraoyNl+aI0nPW6Tr7TnR/wrbKxbqoatBjnGSkODaSV7Xnc6FADhrMI/G7
         Yy893bqSLolypqilIbw2E+f72elm6BnTCr6/v6uQibVHstHLL8nhhsdGxk8mOCCX1d
         VJ3TI2jKNZmHJXyAF4ZM8Sd7vqH93b2fHad9w+Hx4LU60z+4z7/vTQdj8THc83PTf6
         sPt26K697WOCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50AB9C395C5;
        Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2304130001520.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304130001520.29760@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2304130001520.29760@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023041201
X-PR-Tracked-Commit-Id: 38518593ec55e897abda4b4be77b2ec8ec4447d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de4664485abbc0529b1eec44d0061bbfe58a28fb
Message-Id: <168134667932.12533.5226669770793724705.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 00:44:39 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Apr 2023 00:03:55 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023041201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de4664485abbc0529b1eec44d0061bbfe58a28fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
