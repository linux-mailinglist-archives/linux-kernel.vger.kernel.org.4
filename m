Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550E66A4977
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjB0SSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjB0SSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:18:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF614993;
        Mon, 27 Feb 2023 10:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A48BD60EEB;
        Mon, 27 Feb 2023 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C65C433D2;
        Mon, 27 Feb 2023 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521899;
        bh=I0bCf74Lcqw1AcD3SHYA/yvmv57h0u37nXL8rWrpVGA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nlNY3JaFSeGl/WQEV2chTvmRvXdvCykBHmuyfSOB7MQQeiYwz5Y2GY80c7jisndEq
         6NDodWE4w+35sEQoJaVEEkwAcw/xAXZvYhB3+rI3fS2ArXVUaeQqnIdJS6GkayYSKH
         1OqCoXQaJRyWgqJVaMZ0OJiSiB2ELdWX0JVWuuLmpQBoJZQRB1H2b9xDzx+nQW5HEe
         LMYE2nGvqX/05wp+tk1wsnj2kekZIeqfVh2AEbjM/FsgVV/SFgvarCFPxA5mTWrQdJ
         9vvG91FsEKJBial1tUcX9JXj+nueWqmO/Z6XukV6rnqMN1PT4NkIxfO7YDNdy5eaZ9
         /0E3roAZOV6VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07639E68D2D;
        Mon, 27 Feb 2023 18:18:19 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9cbb5e07-9390-9758-b3ba-bfbf0d594c66@linux-m68k.org>
References: <9cbb5e07-9390-9758-b3ba-bfbf0d594c66@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <9cbb5e07-9390-9758-b3ba-bfbf0d594c66@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.3
X-PR-Tracked-Commit-Id: 5aa52ccf692bfef7ddc23c2be1d48524a4427527
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02a737f4bb22fd72bffb5b4008bbcb773218b5dd
Message-Id: <167752189902.27343.10214107172463167808.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:19 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 17:05:30 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02a737f4bb22fd72bffb5b4008bbcb773218b5dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
