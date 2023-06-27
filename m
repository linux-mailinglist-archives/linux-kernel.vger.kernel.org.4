Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76A573EF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjF0ABY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjF0ABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDF199A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFBB60FBF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C10C433CD;
        Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687824069;
        bh=LSaDb1uGCVMutQf9ZCeyh+JG1tdPPoXMVZr0Wqiop0Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bj+lLQU6VtjqJ8js7a1sE+y5hd0Km7Dyrd8w4E++A/9fmDEKWyWW4FpHvmSpTUG36
         FCF3z2D5FK8rcIflK+9QCd6nlOt1zJFLIlinC54ZXUihSa4Hdagqfc9xwSG32oIxmX
         WfKNBS18ytVRhG4DPDPlrkJz/kbu4xMmZPJqAcQEf8+QbsAEvm+5B8aewL6ojqdQu7
         e+//Czh1mDCTtJ9Kia7z6fGE5J/7777gOTQB3G2TkMnRsGIPfS+Zk34u6gxdHYx7nC
         bm0I1d3gV2EvAICnJqhY/IAnkr/KYEDloU5kyQXhWOgphEEDZEb+gnRRg4JBSLjfxA
         Lu7SfBMEsuvAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D094E5380A;
        Tue, 27 Jun 2023 00:01:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626194712.1536077-1-dave.hansen@linux.intel.com>
References: <20230626194712.1536077-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626194712.1536077-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_6.5
X-PR-Tracked-Commit-Id: b360cbd254fde61cb500a4a3ca2e65dff3dfa039
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19300488c9d9c9ed539ab3f4f1bfc0050c9a4482
Message-Id: <168782406911.12263.2501002485808614789.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 26 Jun 2023 12:47:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19300488c9d9c9ed539ab3f4f1bfc0050c9a4482

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
