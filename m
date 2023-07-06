Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DE7494C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjGFExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGFExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7141FC3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5916187D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EDE5C433C7;
        Thu,  6 Jul 2023 04:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688619168;
        bh=z2xkLJuulRAingrQIdailDptV/VxupTcFWrDUbgI+p0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a9uROIq8S6naLMYbKOFPvusiZKmOzg4uZvrH0sm3cvyenNcQ4WJS0q2C0P/vFra5M
         UUwk1HZTjk4sPTNHyrIE4KdJqNUAYUnN71In86MUlfvqgZ6xc9Vrvzw2M0VEslYFK2
         xVq6PSWshfiRuMeglP7EicPLPV7DauDZELgV8m2tXUIuQdLvzmrpWc/nz8gZSgkcWp
         kAP60m1k3RHyMiJM4QSj1UMWrbvOyMKQnKTvLxfnwKb0LLTzGWEULngtzF4/ehePpZ
         5OBDFjLtRMf1YsU18l6YOaDV3cqJZ9j4c4qW6Apz0JbcuH49bX+i1DGF6fjNn7NNXy
         NkbY44jc6VEng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D871C4167B;
        Thu,  6 Jul 2023 04:52:48 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKUkQTLeDMNIyyK7@matsya>
References: <ZKUkQTLeDMNIyyK7@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKUkQTLeDMNIyyK7@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.5
X-PR-Tracked-Commit-Id: a454850a815e62fa5d7c1eded0e8d56742613b94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7afb9d76bc513cb8a2409092dbd3610524a198fe
Message-Id: <168861916824.502.1776850620425802328.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 04:52:48 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 13:35:21 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7afb9d76bc513cb8a2409092dbd3610524a198fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
