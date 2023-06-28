Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C34741831
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjF1SuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:50:18 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48744 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjF1Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF1D61435;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E1CC433C9;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687978186;
        bh=RoJzv8k3rOknsSiLlmImmhYwiNzqXGrGTP1/kTXbSmQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eAy/OQ3J4fs1iV1GH0bkTbLTmOJUfQrv1ltj2TlCAPidC7nRbgGRMW+9QML1naz6P
         C3RN5a0bPxCiPCHGJVbuG+BsjNJFBtf9l9qZHZUn7fOn7ni1v7UBwbNjJK8Fe03oJO
         GwHiYlV10d5jEy5suqlpLqp4Q+g6AMG4ebpawdV9JSQUgML5K5wWhothnnHmMHqe9u
         lilSal6A7QDs4azC51eIGCy7HMTmBZOKPYRS6XhPCwS28DFch/xs1J1GJkUl/WKfMM
         C6f1SHdmDEXlyI6ze1JKyKAnv5k7Yi+FtGrYNwV/ssSj9pNfBzJJQdGIx/N5AsJKsz
         0UavBgEXjo9qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 445A8E5380A;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626085045.24fa63256602e6e1bd51434b@linux-foundation.org>
References: <20230626085045.24fa63256602e6e1bd51434b@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626085045.24fa63256602e6e1bd51434b@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-06-24-19-23
X-PR-Tracked-Commit-Id: 4afc9a402aa3890885747b396c1adcd45f127665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77b1a7f7a05c673c187894b4ae898a8c0cdc776c
Message-Id: <168797818627.11874.602726043835228610.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 18:49:46 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 08:50:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-06-24-19-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77b1a7f7a05c673c187894b4ae898a8c0cdc776c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
