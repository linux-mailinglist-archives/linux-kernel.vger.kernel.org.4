Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F96EEBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbjDZAuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjDZAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92122193E1;
        Tue, 25 Apr 2023 17:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3AB62E0D;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A81FC433EF;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470171;
        bh=S2GMdo53A6ZmyF9BBrhmPbTXFtIVagtRorCymkZ1c+c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AHzY/7RgwmThFwIrExnl5NKxLD7uI1jX3q89GAukpfJxW4pB2ZQf7igXzspVPe2QK
         4f1Zpb0q4l0jK2MgswrwMzNSyYnYTUlfzRBtZV+DDtcEqz7cfqH2LkysDCvmAYaQGc
         L8UQir+ekhkFRAkKM9Ifl6fZEZIpKUearLxA1WobjWorENQDoOzC3GYli4TPhioFf5
         ktQlVxWtj9I9oSNcuuR2MpLYNMBS9tGmlj1NGlnuQae7qYQjVEpQwEeJLK5aoJ5SbQ
         OFmpPk14K91xPxcSPuR1/qL30nsRqQ+sQdX5b3xZFQzrXhRLWEKjhyAAZt/pM+ZKxS
         PbfvAXTzLS1TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 234F6E5FFC6;
        Wed, 26 Apr 2023 00:49:31 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424145902.277800-1-andersson@kernel.org>
References: <20230424145902.277800-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424145902.277800-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.4
X-PR-Tracked-Commit-Id: ba7a4754da1092decbeea3b29bf7d5946f1be400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe89e9b1af14794a4df9d45b958ff1adf0b98dc1
Message-Id: <168247017113.10866.13504213550079613895.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:31 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 07:59:02 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe89e9b1af14794a4df9d45b958ff1adf0b98dc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
