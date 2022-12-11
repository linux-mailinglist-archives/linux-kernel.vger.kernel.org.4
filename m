Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FFE6495BE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiLKSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLKSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 13:33:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0CDBC13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 10:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E51460E26
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78EA7C433EF;
        Sun, 11 Dec 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670783631;
        bh=ULrQ9kAJdlN8FOWy6OZJnfAR4nlgpU+Oegbq+ErLvlY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TsmB8CwS02zIYQWwP636yC1vxpjsGPeY+KPnZZJ5HsS9VukPXSFluzdljwrj+nh3P
         iJKMjwU7YytQuH0+joBrRi1YO8sLwxa9jtQlwBpgb8yjMhgIKzYqYQBHf5G9ur0ZH5
         n3zMnMbbys4MQRNz0XuZT3ryL77WTiP4HM+iGzlxzSZpl3sUmps9BT/uYnFufinWkX
         72OFrgtNq1124Nqmo7otrSgCXbjiq/Qm3pHdNBYb0lU2/rcrgQFW3pNT6AexoAWyWm
         GEsaZ+LmIeGTBHYAkhZUdr3nd9ydl81V3jFReGrP6wilYLsPIz1KCsDVKxWl8u/mhG
         Vgl7Ly4rM6m6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65F14C433D7;
        Sun, 11 Dec 2022 18:33:51 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5XgdLWLDDRac92s@8bytes.org>
References: <Y5XgdLWLDDRac92s@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5XgdLWLDDRac92s@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.1-rc8
X-PR-Tracked-Commit-Id: 81c95fbaebfa5990c3c786c8c3e87426a33106fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d92b86f672a42d9d74a24a63a1e59793c4116830
Message-Id: <167078363141.9533.17574340125800472883.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Dec 2022 18:33:51 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Dec 2022 14:51:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d92b86f672a42d9d74a24a63a1e59793c4116830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
