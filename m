Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD236675CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjATSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjATSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:46:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6F80B9D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 261C9B829D9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA8D1C4339C;
        Fri, 20 Jan 2023 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674240415;
        bh=kNbcAezO8Z4DN/HcD77SaNz5ilkQJtnSKKl1dD3ukYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b+3z6eGL9J0tqjZ4jcLR56cs6OcP90JAJKb5H8siehDfNjWWHszHxUjAuWum/vTUH
         zRKAS28dv5w2lntlnZHJGUDiOZPhZeYDPw3QIKu67h+bkr2r/Gc8GtRlYv0GRxuszl
         GpfWoN/oOzxb/xhU514uiuG4WEslBfh6sj7Py/sL8fqGqvZnwCZhOMP//9qc+unP1T
         Zu671TzO/zzyJsL8tfiPsjKIm9Mmv8mwfByMCtqSGhH5cH8wN6CJPGlP3LxaecNGWh
         K8mO8/7uJx3S3t2HkWyorxnI3MazClhgNsu2su0P3zlzOn0+n7Pj4cjHALr7deVoMl
         pyHnVJ6NgoRzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B80A5C04E33;
        Fri, 20 Jan 2023 18:46:55 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic Phy fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8qr3cy7eA5RJqbO@matsya>
References: <Y8qr3cy7eA5RJqbO@matsya>
X-PR-Tracked-List-Id: Linux Phy Mailing list <linux-phy.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y8qr3cy7eA5RJqbO@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.2
X-PR-Tracked-Commit-Id: bc30c15f275484f9b9fe27c2fa0895f3022d9943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaaf919c2ef595ab9a8a6810f53a6db685dbba40
Message-Id: <167424041574.21297.11151887306594739677.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 18:46:55 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 20:27:33 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaaf919c2ef595ab9a8a6810f53a6db685dbba40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
