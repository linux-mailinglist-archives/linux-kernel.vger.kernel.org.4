Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8873EF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0ABV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjF0ABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484E1999
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB8160FBD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D332C433C9;
        Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687824069;
        bh=44wUiNPlIR3gJtwd4fiAO4NfcjwrI/cBWYUT30nME3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Khrcb2L1nyLQv4znD04GDExXmY5DE5G0V+VbFSVznvLUvsyGGe8pke/U7BtmY4Xcs
         twVnCYVCyD6NRgKLAPatUiTXjichVZEphg7raRwW5xhBIvAa8z+RlyJJRmFs/mfcmS
         N7gSIpBY+VXTnY1wrp0LZ5nMGVzxRc9S6dMSm2zTaFHaueYIye3YqxSyryMELh7qVX
         W9soTPntQ2Rce/YghkS/HZA9+HbDxRGWdQ+ZjFHuwLKRGVMGeygELQ6dnPnh92bpyD
         xdDX/6VKVDNUgIonQGNKZWn5r8yjFo2Ab2A9EA371eSYvd6t1NyMl1cAuilaQXjRp3
         036W2RXg7Tzjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04DEFE537FE;
        Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626193050.1532183-1-dave.hansen@linux.intel.com>
References: <20230626193050.1532183-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626193050.1532183-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.5
X-PR-Tracked-Commit-Id: 94142c9d1bdf1c18027a42758ceb6bdd59a92012
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfe7a7e52ccdf60dfd11ccbe509e4365ea721ca
Message-Id: <168782406901.12263.2996177191014331764.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 00:01:09 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 12:30:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfe7a7e52ccdf60dfd11ccbe509e4365ea721ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
