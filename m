Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1B5C047E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIUQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIUQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93B760D1;
        Wed, 21 Sep 2022 09:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 964C563208;
        Wed, 21 Sep 2022 16:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E05C433C1;
        Wed, 21 Sep 2022 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663778066;
        bh=TJwtM6boaPTX/2Eq5vN8/nMLleMLx+nBZGZAmMU9HuM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F4iVwjkOe4p3obzwYIeTwixXn81XJGlJj1zU58bOdBG0Np6BQ4lkyreV0L372QFk/
         6eHkYIFAqJOjvrdLk1QEhB00/WSK4B7X/Jkyt5qYKLW2EkYzr7ok/VjKw8lPk3HCGA
         VQ2R6FHQ3Y8slwpWFC97bY5VtLyjFWFXZsY7KSbJ9VHXkfjztVvqct1Tc6Ggg/hma4
         Kifffqq8A93ybE3nlN314tAQd+eTXLS8Y6dmWnzWkU6WxyY4p4+P0omIdgsMnJvu0p
         7ewsVXE4EiQsvCVGJXcxVvZbOSya/H1KPPPx/yGO6TMOaH+emxlfywtExck8cUC3DR
         M+HGWtqnoC0kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBB52E4D03C;
        Wed, 21 Sep 2022 16:34:25 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220921133553.GA13191@alpha.franken.de>
References: <20220921133553.GA13191@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220921133553.GA13191@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_2
X-PR-Tracked-Commit-Id: e9f3f8f488005f6da3cfb66070706770ecaef747
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26c95642d419028db590ae0c511d9ddcdbc51746
Message-Id: <166377806589.17149.18113641835587487083.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Sep 2022 16:34:25 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Sep 2022 15:35:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26c95642d419028db590ae0c511d9ddcdbc51746

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
