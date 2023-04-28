Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA526F1D56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346450AbjD1RXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbjD1RXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A342A4203
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FB1644C9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA1BC433D2;
        Fri, 28 Apr 2023 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682702589;
        bh=vrc07lVBtGLwa2n4PJNYoWx6DdxCif61+S56iTXw3pE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cK6OYknvTwZI5p/Vz9yQhnw1zjcqfO3KqOgXLG0Np/kS3QzovGEMcFc6AWsiJwXF5
         FrG27lPRHGOD9Jv9oMEMYt7S6yJitf54+1gyLFB+vxx5bhn3/A8Q1H4B2UOCLEFruN
         LbpDHkzBpN1m9HO+ppCGbvp3JMwbIMtzNmSHk1TseOU9QJenDN5N7Hu5bA5XZqk0oP
         7y5SMyPJVU9hmnxdCxgF4WBCdVqtZMD7OYskQPYFmOGNU5kbIUbjERBy2ma1h+VhYN
         kEAbFLlrVgIhP3vqnSpxhW+TnctvuQM8EO60w9eV3Sungyh8r+jUXmVMRocaRVZUZf
         oVfcgmXWX0BSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 880F0E270D1;
        Fri, 28 Apr 2023 17:23:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.4
X-PR-Tracked-Commit-Id: 97740266de26e5dfe6e4fbecacb6995b66c2e378
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22b8cc3e78f5448b4c5df00303817a9137cd663f
Message-Id: <168270258955.30920.5745850670612737866.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 17:23:09 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 15:56:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22b8cc3e78f5448b4c5df00303817a9137cd663f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
