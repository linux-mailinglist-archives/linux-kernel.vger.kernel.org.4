Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358364A94E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiLLVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiLLVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA81A20A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F39561234
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D91C4339C;
        Mon, 12 Dec 2022 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879501;
        bh=GQDDJJbrRJdSRC5AUTAuyajr+7sua89sdH6DVOXw+94=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YTW7lVUw9Z922dxrh4TeUbeMovMS+a/mE9f49GK8CDHPKt6FmPNSrxu1JmV3n8a/x
         tj94/SUXGKeglfnbiukvcfd4C5aW1sdqtKHfFKOXKyt8p94Czw65jzLHWZOrgp3YHx
         ygc90rAEOM9cGU+SteLSxutlz46j6bI+/K5uisPGfWRGzn78ol/dJuXsbt7sXjcvu5
         YzwgXccrM3gzZNj8VrAUr8juSBIY0qOUEROwADj1XNeSC2Au2H0NTW53kgJfvqq3yD
         iI62ZX+afFEMjWGjExnMLFx0eaHGf2LzfWUHXoQ7DOTF1pep8yCiKypEySoGMxWAVs
         HiI3dyZy9aRAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A534EC00445;
        Mon, 12 Dec 2022 21:11:41 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212062430.10263-1-jgross@suse.com>
References: <20221212062430.10263-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20221212062430.10263-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc1-tag
X-PR-Tracked-Commit-Id: 8b997b2bb2c53b76a6db6c195930e9ab8e4b0c79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6b160bc4daa1227695ef807e11097a3e9934d66
Message-Id: <167087950165.1809.16468715012916138281.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:41 +0000
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

The pull request you sent on Mon, 12 Dec 2022 07:24:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6b160bc4daa1227695ef807e11097a3e9934d66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
