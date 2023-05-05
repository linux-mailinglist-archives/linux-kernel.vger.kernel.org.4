Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B36F8952
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjEETMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjEETMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F5449D;
        Fri,  5 May 2023 12:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84A2860BB1;
        Fri,  5 May 2023 19:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B85C433D2;
        Fri,  5 May 2023 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683313925;
        bh=AEsBlHq3AKmd3082is5bzZ6ip5K0uswV5FqQOfuEMYQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pE4VAUtXMryhgFlWthWEJ31Ykj8ccaMJgWNcmqgmed8+lral+3LPMPmnZxIVmb2d+
         9VXuhuFWnV7M9m5eoayF48hiI6giJq0XIK85cYi61BOC35c90Ab+p4JBpb96Q+PkXp
         SC4kwQQy88PKQWX5Hhz+eUe4yUUUsm6cVgiddwnsjQMN1UOMtXRkEzz/2LKILXM8wG
         i9ZcYP4CydTxF7Nj/AttJoJVs4ZjV9XJiHXru2O2tz+duQ0d2OaQzYBeTCVcboYQfD
         DidVrkPv6PeDaGNtSBjTn2FUyZpFu+cddhaMGiy8uxkN7ZEj+UNTwT34HrNpPK+jh8
         e7psPOqYsdi2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0790C395C8;
        Fri,  5 May 2023 19:12:04 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hQO1q7B=Mp+hQaHeWnkN+cm+QARpFXEAJ=FQKGtOE8Mg@mail.gmail.com>
References: <CAJZ5v0hQO1q7B=Mp+hQaHeWnkN+cm+QARpFXEAJ=FQKGtOE8Mg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hQO1q7B=Mp+hQaHeWnkN+cm+QARpFXEAJ=FQKGtOE8Mg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1-3
X-PR-Tracked-Commit-Id: 2492ba4cd06dd24076f44327174816b04cddde90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 817e1af1b37230ef6bb40bec6ccaf9a800ee6610
Message-Id: <168331392484.10509.10619188898766746070.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 19:12:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 19:49:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/817e1af1b37230ef6bb40bec6ccaf9a800ee6610

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
