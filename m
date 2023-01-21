Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BA676860
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAUTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAUTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024621420C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:23:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FE0B8085D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AE23C433A0;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=875/ZYrtYEjx3zhPRYUvX0my+LWCFXELKIgzPaC2jdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H3doU7mmg9TfIIXD+DWc6V2hUYLHKuRiipGMAFRZdML+8tUvZ5x0vYoJuf7u1u6l+
         GthgoTi9ECpWSYapeJHGAVpCcGdO0et04aeX3jvjgkS+pDfLlEiuh60Z+reygLBf8S
         /cMqGOHUWPOtMnn6OZvxiv+E+gdcD5jOVeGocj8WZOq7CxiWc+VyL9q4nt2Dol6DfE
         nL43uyjTup9dXm9W8qbJ7U750c3h4bEEPsi6KUUZ7oMmUmUykiNrSZeSKetlzuy88U
         qGR45dkQja24xyxGfaIoAfb7wBIBhj5bLQSnWnG2UhpapaTcN5dvbmW5NJI7tKEN1L
         c4j0D5FPZPDBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43A38C39564;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8wE3Tu3muhrYchq@kroah.com>
References: <Y8wE3Tu3muhrYchq@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8wE3Tu3muhrYchq@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc5
X-PR-Tracked-Commit-Id: 7d83299351fe7c812c529f5e39fe63b5312e4233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb86d65775cc3835152c08882384c2534b56f1d3
Message-Id: <167432901827.17568.17566802839838116779.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 16:29:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb86d65775cc3835152c08882384c2534b56f1d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
