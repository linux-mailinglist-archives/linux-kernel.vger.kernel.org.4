Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24495626654
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKLCCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiKLCCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:02:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A736AEE7;
        Fri, 11 Nov 2022 18:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A604BB82887;
        Sat, 12 Nov 2022 02:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62E64C433C1;
        Sat, 12 Nov 2022 02:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668218560;
        bh=LbiPkuvW0U6ohcRWv28AT/S1UzjEDtnrxcxa1wDGo+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=psIjThu9VmNNcv1NHfppYDL3PW9Vscz/mD1xgFcTSBZzbU0u/npJF/oEz5EvYMIOs
         DLWEXATIe0d9is6HlDacpFM8v2N/Flwkse1Udtea52ps56LBZ2ejYFuCfUZYLpJVFQ
         S6QN5XseduCvBwUYockgaQHxcnhmJF8j3JDhuqzBWr5N9QyTPcwe+AoaRfXQ73/3/9
         c9z2eUw4xrEeCuNP8/QhSAoxAe+9Y6kLciVKxRLoh00Ja77p1i14H39UrOZoedN7wq
         RxpWAJMkXWHVNrdhC3e32HH/9dJGNwQKpR0mlW7btKg3SL5F5nkBO1qiMYqFX1tVrS
         rdAp1Ht8lnnRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F061C395FE;
        Sat, 12 Nov 2022 02:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
References: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-11-11
X-PR-Tracked-Commit-Id: 436fa4a699bcd1c368bea9199e22b0a1b9cf9e0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7c2b1f64e44c98206752a1599b0203ae5e92f27
Message-Id: <166821856031.28551.6780874855245963336.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Nov 2022 02:02:40 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 17:12:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-11-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7c2b1f64e44c98206752a1599b0203ae5e92f27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
