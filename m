Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00B70E445
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjEWSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbjEWSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477D119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4FC86358A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F932C433D2;
        Tue, 23 May 2023 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684864984;
        bh=/P/Osjoc4z4Yu1N3CgNlw0iuscbguTL7v6pbGCgQbH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b99bd4Xjdm1odCryN2qdU5WbBTcWoU0sFMQvQwhAHVzlDLAoyYhXLH3LI1CmpxtAo
         XVc4H2Jn8h4YdYHfozN82i8iyvZroRwmkVIyb5cNkbNyP87mas94y0n/Z30OuPLGSQ
         xJqpiS49RGxh+WM2FAiV6yApwsuPYXESmY1i72RclZpB6/KTtKAndKZ1PTaMvS40MM
         zpRzPVCPJe3SUj7ExGcZvKVur9O2pSr9X0EmLfwzXD5HQNbizL5v9e1sleZwslA52z
         5/D+hA8BvhqJ0/1uadLTC4BjFfXCKv6vTQ3cdS+9uj+ChglV9eICLcxk+QZ79ry3+F
         osUtEQ35VsPIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3114FE22AEC;
        Tue, 23 May 2023 18:03:04 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGz1wpqyI+lfCaUA@debian>
References: <ZGz1wpqyI+lfCaUA@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZGz1wpqyI+lfCaUA@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc4-fixes
X-PR-Tracked-Commit-Id: cf7f2732b4b83026842832e7e4e04bf862108ac2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fe326b4467689ef3690491ee2ad25ff4d81fe59
Message-Id: <168486498418.10175.448428344867124366.pr-tracker-bot@kernel.org>
Date:   Tue, 23 May 2023 18:03:04 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sandeep Dhavale <dhavale@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 May 2023 01:20:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.4-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fe326b4467689ef3690491ee2ad25ff4d81fe59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
