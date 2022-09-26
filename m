Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D05EB315
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIZV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIZV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6CAA1D56;
        Mon, 26 Sep 2022 14:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435FA612D3;
        Mon, 26 Sep 2022 21:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABA20C433C1;
        Mon, 26 Sep 2022 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664227685;
        bh=jDZqbsoZiq/I+Fhv8rIuDjBuHD5ZVMLz30M8Bshc/h4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i0Ct9ezR9ohq0p4Mc2NsiRk7aPPIdbuJltOhAA881zPFE4R/mjI+ib1woGiTYF0zI
         heKGCESVrTKkzUiMS1aA7u4faCSbwoPJjn8kCPDe+sODC28vwizZvyTiy3RyXMUVae
         DaQfgljTtFesGb9Jo0Azr6afhje0BELeJgWo8o5hU8fANFhEmd8sSoeStRGcuwOBrK
         B+8ej+ly+K8zKwvuIcADhalsiScIeThQMgegGbu7s8q9DaVqZF1hWpAujqCpPa/k1B
         5H2+iDVyEGeI5K+XbpXnTkFwpx9BTBDqQibXzFUtcwZI8DIAsHo+UQRyLYI1DytI16
         6UACnS8RyfbJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98E52C04E59;
        Mon, 26 Sep 2022 21:28:05 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.0[-rc8]
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
References: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-26
X-PR-Tracked-Commit-Id: 59298997df89e19aad426d4ae0a7e5037074da5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3800a713b6070d4f03fb43613a7b7d536a99b2b7
Message-Id: <166422768561.13634.7698660135812730257.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Sep 2022 21:28:05 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Sep 2022 12:37:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3800a713b6070d4f03fb43613a7b7d536a99b2b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
