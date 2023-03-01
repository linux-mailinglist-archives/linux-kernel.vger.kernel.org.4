Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C86A7284
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCASCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCASCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA14A1FA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A773B810CF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5B56C433A4;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693731;
        bh=/fmcF6Mc5jiHRUCnAB/sK+1p63glA3GaznS7cJc+ULY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aLXIPA47WnLX6nFPZG9O0al8J2aXGI9TRZKv7I7OjLNCJboC+bbbAI4tBXbu+okLz
         Dop5g5P3uiaieTZNK/pimyfy/Wdl/tmTJF/ophwX1PxjyMCMU9U+d147qXK6J2KHUw
         Ks10VASa9fvQmYL4hWs+BinopluddKn9K3a31sBAqlp4yyspTYsfkCHSZ6aeJ2yrT9
         nGEdsYTxNSkt/dtBNC+Bn9wrFra5/H5F5CL/1YRWX0ArRoMrq4cTEKjuZtphFPYUYp
         Wui9hghbLHXbxQsBtxfAYDqKJW8JKKDGvqoD2LZN/vFt4Tezp3SEnYaMTgHBPkAlZm
         kR77M9Rt8lucg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4F63C41676;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a9466e48-77be-bb9e-bdfe-df8c763d7a76@oracle.com>
References: <a9466e48-77be-bb9e-bdfe-df8c763d7a76@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a9466e48-77be-bb9e-bdfe-df8c763d7a76@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.3
X-PR-Tracked-Commit-Id: fad376fce0af58deebc5075b8539dc05bf639af3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e110580bc1ab84d02509750ce09277914174c6a
Message-Id: <167769373167.10213.16519989391244411295.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:11 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 09:54:16 -0600:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e110580bc1ab84d02509750ce09277914174c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
