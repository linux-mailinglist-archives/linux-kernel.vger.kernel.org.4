Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6526ED58F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjDXTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjDXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F496EBD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0AAF628CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FEC1C4339E;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365745;
        bh=MpVBpUyZtAdCwP8HMeSjWJK+6Bak4OhiLMUctqkJZ/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dQPmV8ci6rCS/vPwG+/PtqCGVtLCjJZ67yvL37l5lLXTFg26gP1XgdCuYQ4UKXVre
         lohtu7HGps0apin6s4v4LE/d2GzYF11qKs7i29bEfyDKyr4AMieoUY2lZCqun2RJyS
         AHTRX2/hrZPJ068XKWSvGlwbWRaCiW7+YuvxLiydfRpGb6hVflFdRX52MbKPMgsMl1
         k+dSqqZUvb+CircTONcIGqNC+r0WJa702oryJdGj05FleBH1fL5RekP3FbRH6lgz2c
         YVhFHgO3SI222Q5cMRMKNIe9Q2b+Uyv20Kr69qc+7wrOaxpcYycmvUv9hEMVglRBhA
         oPpWmXPs0qI+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D462E270D9;
        Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] locktorture changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ad60da0b-2535-49ad-8b92-5c8264278e4f@paulmck-laptop>
References: <ad60da0b-2535-49ad-8b92-5c8264278e4f@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad60da0b-2535-49ad-8b92-5c8264278e4f@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/locktorture.2023.04.04a
X-PR-Tracked-Commit-Id: 5d65cf6ae6aea1a8d533d4499201a13d0068a0dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a4075ada6a5f51087d6c046b024046bf3864beb
Message-Id: <168236574518.6990.1126700751010237717.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:05 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, dave@stgolabs.net, josh@joshtriplett.org,
        jstultz@google.com, qiang1.zhang@intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:16:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/locktorture.2023.04.04a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a4075ada6a5f51087d6c046b024046bf3864beb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
