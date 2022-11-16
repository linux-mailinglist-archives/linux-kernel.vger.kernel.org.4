Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F162C842
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiKPSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiKPSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:53:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47BB60
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7F03B81E54
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C673C433D6;
        Wed, 16 Nov 2022 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668624683;
        bh=Ix65TQWZ4DpjbScvYzV559zitmw6e2Fr+crZYEqU9vU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CImTd82z0bEtf8pkWKBANxbBU3MPuIwCtromsO3gBx4MZ8AsWWIjxJMpcKNL9Itd9
         oIfv6jGQQ87JqZZvGtBgTV3O8g2+ukgLzoKud0IJYEMKolxZ2c8py01HinLofd+H0i
         AvSXZzqTuUnklVzguBOTtxgFlvyo1jTI+hJH8GPvkaus4/KsXMA+tfr67BvMc0ELF8
         i9P1hgCXzfOBc6abb5wJkkIj6IvoQOqfCzUAI4d/njFC1GQo2YXKupa46rrjpRWC0e
         UFfKtqwLChPckbxM5JuE/EYuSdT976v8JonLLAjudT7tfmtNN1y2NtT5v0KL+rLXh4
         9rM4o6E4n3VMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8011EE21EFD;
        Wed, 16 Nov 2022 18:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221116120055.4299-1-jgross@suse.com>
References: <20221116120055.4299-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20221116120055.4299-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc6-tag
X-PR-Tracked-Commit-Id: 4abb77fc5531381484477cac95913336c97176b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc675d22e422442f6d230654a55a5fc5682ea018
Message-Id: <166862468351.19828.7207830520981155384.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Nov 2022 18:51:23 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Nov 2022 13:00:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.1-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc675d22e422442f6d230654a55a5fc5682ea018

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
