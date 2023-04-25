Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292816EE7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjDYSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjDYSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B9317A13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE7F63125
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF61CC433EF;
        Tue, 25 Apr 2023 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682448707;
        bh=M78hdPn+q8Hi+svH36mrNic13BVHtN5ujQkWtah+pmI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uoEpWcBJiKCXt+YorcfTZQ6e6R9kpLXYx47GdQM3DGfrjyWr0BXG9P5BDxoPW+zNu
         lbd9h1EKFbqHehhniMyfiivDbBAhRLi54P+JItCZE1eVo6x9DDtsLf7mChED+cWO6n
         ReVhPg2nZxLU/vGjcCw+982g4SWSxxWDGBosspnilBvg4gXahgfI8KKBjKfDAAT3+9
         g/qOgVKmAHVsvhhweIuV4gd8YVMchMrKWiLtVVECv9/+ykomVbAFfpXAtcLaBNmBB0
         g1IoWjp+rlxHMABNQWlU/3bRMNvKwJ9G5uO0C3qbG/AQNJguLdI0gvqIOI525+xqJP
         mhUpgpxNhPxfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94EB8E5FFC6;
        Tue, 25 Apr 2023 18:51:47 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168235968801.840202.17752066425816055574.tglx@xen13>
References: <168235968801.840202.17752066425816055574.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168235968801.840202.17752066425816055574.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-04-24
X-PR-Tracked-Commit-Id: 63a759694eed61025713b3e14dd827c8548daadc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29e95a4b2686b2cfb5564b3fb31371d5f71c6b66
Message-Id: <168244870760.5918.3872890961942614202.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:51:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 20:13:23 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29e95a4b2686b2cfb5564b3fb31371d5f71c6b66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
