Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BB5FCAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJLS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJLS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F257B6D55E;
        Wed, 12 Oct 2022 11:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89EAFB81BAA;
        Wed, 12 Oct 2022 18:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D1E6C433D6;
        Wed, 12 Oct 2022 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665599364;
        bh=FvRswQz2M5ajPERC0b1OqcrxyIKILbG95iY84nr+mW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KV/dJWNOFiDHCesF0C6+4uFmGDtzEg2V2ypq21KSbun4175sWPFMc3BqYpm0McolZ
         PknpOnfmnO4t47l+TJvj4FmN0x/seHTtuby2wBmmGVgkS8/qlw6pUgwywUksN2WHpt
         hYena79MpXrO+9+8AvBc85TJo3rVFilgUIuNlBLl+Yl+psUDywnvjIEIhAQvrT/kWb
         6+ZenavlPALdc2NF6Om+/ijFWRDURoc8dSuYpBoC9c0WThM6LHSq/B/ZUvtI5B/0Ox
         5J+3DBilhd1wsrKHo+736TUhRUhKNNHNdNBZ+bD4zYklLMOwK5i+srHYCljZtxuEZt
         8INvpWMtyElZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B956E29F35;
        Wed, 12 Oct 2022 18:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221011190341.511a73168c42a296fd6589a6@linux-foundation.org>
References: <20221011190341.511a73168c42a296fd6589a6@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221011190341.511a73168c42a296fd6589a6@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-10-11
X-PR-Tracked-Commit-Id: 6a961bffd1c3505c13b4d33bbb8385fe08239cb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 676cb4957396411fdb7aba906d5f950fc3de7cc9
Message-Id: <166559936423.10775.1394747723690841704.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Oct 2022 18:29:24 +0000
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

The pull request you sent on Tue, 11 Oct 2022 19:03:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/676cb4957396411fdb7aba906d5f950fc3de7cc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
