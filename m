Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45741701F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjENTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjENTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 15:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EDE74;
        Sun, 14 May 2023 12:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B24F60E9A;
        Sun, 14 May 2023 19:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C09CCC433EF;
        Sun, 14 May 2023 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684092985;
        bh=hi4iEgGrcccHRW4H+RAeW1ChCvWZTz6frpzNwK3sRPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sZ9OK0qWTId6gTwDFY5SFcm/ZvlHh9V28EiLiAkR1hBtZtouVmC/Ds+2CrYyY74n9
         Ml5Pu2wFpxSPnv20gpyXJAMuo9hJvdvWbY18k3pBRxiGzar5wxD4IjtceelsqsfwNp
         3rNC6QMH6Cv5y0lPrSJyT6HIL6hJpksppuUSUNFPA+w99YJQkkoB8hSlShvzN/aNTw
         ZOJHmyp+JwGrrUYmCAAgJhQjPL3HtmX4T9J9aJYleFib/cIdNG+w9RiqzoG5GIw04W
         lzaltyTW9VnKtCUJNMV0Bts05hyfMPOSZRzOJ0PH6K+BoaGLTA4ZbOH+vTPco8MnEL
         0QuYQ+EPAHaxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB46E26D2A;
        Sun, 14 May 2023 19:36:25 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <646115435c15a_27662945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <646115435c15a_27662945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <646115435c15a_27662945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc2
X-PR-Tracked-Commit-Id: 764d102ef94e880ca834a7fe3968a00a05b1fb12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 533c54547153d46c0bf99ac0e396bed71f760c03
Message-Id: <168409298569.6178.11738586640241275620.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 19:36:25 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 May 2023 10:07:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/533c54547153d46c0bf99ac0e396bed71f760c03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
