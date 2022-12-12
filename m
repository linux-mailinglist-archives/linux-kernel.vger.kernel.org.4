Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73D464AA93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiLLWrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiLLWqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CA2BCD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B02C6125F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91D35C433F0;
        Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885189;
        bh=KPegGEVegFFpefofyu70BbpkomNc1RZ+MI0finIAuq4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fy25Mnh6iOeE360y0t4eXYngnhPHga82+Winpq+f73pF0c9mT0J3QqWsTkLUWcK2c
         zsQVXloGOCXxhUKzp2/EC6s6sfSIlbyCictW34eMNkegMvmd99psrsKN8wGa8o+I37
         HFVjdb28p/wfVHlhy1Umkj52+WCj51QX1FO+1ZaK65ibCSkYoas+WyaVAjpcwwZ1sY
         HC3Nae7+NxtZyjaWBfgoS2dGsHV0nrU5IJ6mtkbIuEz23+Vc8pGEhA2ZpWbjFgYpEC
         rJRQpuS5RFBhj5QYaCKLuNNt+Bbv+DfXCjNOPqzr/V2Ya+NzUejEgBc7oWyBy0HqOU
         ANRhbGYE+njwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FC20C00445;
        Mon, 12 Dec 2022 22:46:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/splitlock for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212191524.553244-1-dave.hansen@linux.intel.com>
References: <20221212191524.553244-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212191524.553244-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_6.2
X-PR-Tracked-Commit-Id: 727209376f4998bc84db1d5d8af15afea846a92b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cab145a94ac9816dcea63e6f2a04c385ac8c3fc
Message-Id: <167088518951.6748.17195235350402287665.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 22:46:29 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:15:24 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cab145a94ac9816dcea63e6f2a04c385ac8c3fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
