Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8277741832
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF1SuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:50:10 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:47972 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjF1Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B508E61425;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 291E8C433C8;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687978186;
        bh=meKMCTdUlTNnW4yd1KQRfMy4bTaL2JTgaFTQhRpLNFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QtNdqlSsoxZJtPfQzBapBzCQkXUTGbwclbWQreHy3wiwGN1fyfzvAMdADEUCvmI+v
         90LfpLuKWcW7HGfm31o8aeA4CzjKcthLQazNnu6ir1Suq9Jp7u1flSMgzZfVaxENn6
         Lb87qYtJCMc4BVEyTZ4nnYe7TySpZQkCJ8EwSX8qlEQOfc2VqeO7zfoQUGoCdHNa5L
         2ERA+n3USeBdV5VlOskmAANecGpo7vNw7KLEL+i6lXwFAvfKqRxjbawaPzRMdcFm1B
         WFZNFMm/csMhkHpy7dVhDraw34zNXF/QPj8JdKTvXl1YhK5U8CQPWzaju8yqCe0Rlx
         9kaUHHrdiSFZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D10E5380A;
        Wed, 28 Jun 2023 18:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
References: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20230504132148.182960-1-broonie@finisterre.sirena.org.uk Thanks.
X-PR-Tracked-Commit-Id: acc72d59c7509540c27c49625cb4b5a8db1f1a84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e17c6de3ddf3073741d9c91a796ee696914d8a0
Message-Id: <168797818608.11874.3594300392706463490.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 18:49:46 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 08:50:35 -0700:

> https://lkml.kernel.org/r/20230504132148.182960-1-broonie@finisterre.sirena.org.uk Thanks.

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e17c6de3ddf3073741d9c91a796ee696914d8a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
