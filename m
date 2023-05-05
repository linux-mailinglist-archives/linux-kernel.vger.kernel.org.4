Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2E6F8954
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjEETMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjEETMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46F22699;
        Fri,  5 May 2023 12:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBDE64006;
        Fri,  5 May 2023 19:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D26BAC433A8;
        Fri,  5 May 2023 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683313929;
        bh=6NNam1CrPO+G011LzbpcgdG4JHLZ4nulUzWMe26Ey/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TXlVSZ7/G8ar1tvaQacd3d+5WHk1vwcq1SVqWKGefooDDChd6auA/WsAwVNNASyqN
         rOWwiqZ0ZS4y7/vr4hROd5SOvVqFnG/j1Wc+bGPhNqTYM3ULu5J5ZvpU249RZZuk6O
         LTGgoOZuIUz4EHZdU4EVCFzTi2PGitx95LC4k/dhSl5XOcD6zsLl1ME55Ts28R8fuO
         Rh5EL01iQcQbWGIRjdx/5ZPlFfoypAAPHQCTmmf53Im6VmnXzrklf2Cer1KD0oTwQC
         O1cGyvF+u5h6WPIAAeR9mkX65dUz0buWS1Y22uppV2fwd8JQv2ag9EK30Er7tjC0sh
         XJHtuJGHudvYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6352C395FD;
        Fri,  5 May 2023 19:12:09 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gKvM670zp0WtTV1nYgQuUiJVzOC6bRo9Lv8DRY4cdG+Q@mail.gmail.com>
References: <CAJZ5v0gKvM670zp0WtTV1nYgQuUiJVzOC6bRo9Lv8DRY4cdG+Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gKvM670zp0WtTV1nYgQuUiJVzOC6bRo9Lv8DRY4cdG+Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1-3
X-PR-Tracked-Commit-Id: 3db66620ea90b0fd4134b31eabfec16d7b07d7e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7163a2111f6c030ee39635ac3334bfa1a52a3dd3
Message-Id: <168331392974.10509.2391000996467712896.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 19:12:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 19:50:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7163a2111f6c030ee39635ac3334bfa1a52a3dd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
