Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857666F10AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjD1DKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbjD1DKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7344AB;
        Thu, 27 Apr 2023 20:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E5E640D0;
        Fri, 28 Apr 2023 03:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E0BC4339B;
        Fri, 28 Apr 2023 03:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682651355;
        bh=Lk+9wrWBvS0+foFL6tGp0XWrKxcFrJfp2woFBnFysKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L2tlrzHdL4zr4w3LlLNC6d7y1fZptltx6J3ygGVE/K1z5g4y6VPjf88yzZHk4XjnI
         jn/Tu2+Zd4rYlLd8QEFZeOBGkU3uYDlKt3XEPH6edYDS+ape7263nFKfHTSJSNbFrd
         3NYFtiSsb9IQ8eldNwCCUyBqL99zqMa6bhetj9WYiZEByX6xC7NAJDddd4+B0Ol3q6
         Jy2m2FkFsS5SMBJJi4sfoVvtcAVrdQ6Bgt+9WJVZUfEeruyApH7Bac0rKi0lfi+tPu
         nc62Q5ANM4s7JNk47UusNUi8Z6ACGpFYWuYMK9DhLryYhfczC7VHdSWQ08Q0qY3Vjl
         3ocfz8XwnYI2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47D91E5FFC8;
        Fri, 28 Apr 2023 03:09:15 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427160755.c9b9049fa931902b453e94a8@linux-foundation.org>
References: <20230427160755.c9b9049fa931902b453e94a8@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427160755.c9b9049fa931902b453e94a8@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20230414131330.1053570-1-broonie@kernel.org Thanks.
X-PR-Tracked-Commit-Id: d88f2f72ca89ead8743ee15e547274ba248e7c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33afd4b76393627477e878b3b195d606e585d816
Message-Id: <168265135529.19690.7297265802795690747.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 03:09:15 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:07:55 -0700:

> https://lkml.kernel.org/r/20230414131330.1053570-1-broonie@kernel.org Thanks.

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33afd4b76393627477e878b3b195d606e585d816

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
