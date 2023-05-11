Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB36FFC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbjEKWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbjEKWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC8559F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88AB46521A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9F38C433D2;
        Thu, 11 May 2023 22:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683842653;
        bh=roCpE77mYTPg6wVYVSb34/80+JaQyDZdyzb20akFYl4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OzRCOv9TIAgJjUSoN92Bv8PdOQtN6DrO6Sb5wlzS4ifoVETco8VpLwbcPii8gGAtV
         123G96MOouPvkAH23AzJt2Magf6rtkFh7OkdG/teLZoup2taws5uknET1knqluOsNy
         uHpVHKUBeirMbL6//g2v9HCWtT/eGHQewfP/n+RoG2/J+WEPzdMkDm6koGkcEqNtmk
         YI+6mTZ4CpwDfJ0jeVIsOQ03SMe4IkwTY9yqyNjk5WUbQBvui3LpKPXbHKyxKHeSUM
         H7xZc/Stdxx8OF/nUJwAmRkbwBB1nM5+U4HwNweE9zJk/confUFuU+Wd3Wtz+8vTZy
         bgThKPEB4znaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D931EE26D4C;
        Thu, 11 May 2023 22:04:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzcHVOZNJf__haKP-=f+tZ2_=AokYjWUikF02yv46XuAg@mail.gmail.com>
References: <CAPM=9tzcHVOZNJf__haKP-=f+tZ2_=AokYjWUikF02yv46XuAg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzcHVOZNJf__haKP-=f+tZ2_=AokYjWUikF02yv46XuAg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-05-12
X-PR-Tracked-Commit-Id: d8843eebbbd15b78c6a7745717b3705eca923b0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc3c44c9fda264c6d401be04e95449a57c1231c6
Message-Id: <168384265288.22863.5222300484930093267.pr-tracker-bot@kernel.org>
Date:   Thu, 11 May 2023 22:04:12 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 May 2023 06:59:57 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-05-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc3c44c9fda264c6d401be04e95449a57c1231c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
