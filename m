Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9173F105
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjF0C43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjF0C4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA719B0;
        Mon, 26 Jun 2023 19:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A6A60FFB;
        Tue, 27 Jun 2023 02:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B051C433C9;
        Tue, 27 Jun 2023 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687834577;
        bh=6BVyUR2xPIBYOUd8VmWACIWr36olEZrQpQmDGVBeuaM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sRFqCUsDg52+ouQF89iaidejjTvdiW0sJkPl5fEKJoyU7yqymAd1WbXnhsPgc7Nvu
         9y0Jy+Kr7pu6DbVyDM6smB8sODG49H5T1BS+a+Xm47waJu90D7FW5QHh0J2cyBCiBN
         1zdxKZAEXMwaimJiMFxojDUCyYvoETaPqWuTul0iAyVmRfbDUy/ad8fZTB3C/G1LBE
         6Yudk6bcgzisr0J6A6DN2usXuZJDSGR2BtG1WSbvTEIikFTOomnMIkI8PaJ1bGEhlM
         Jo1JwOsfM8oIoP7JaRqhOl+etMWzHQb0WwziYXrCphzVynUMiOXejmNP1K3cWsoqdB
         pUXdqopzlZbag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E75A2E537FE;
        Tue, 27 Jun 2023 02:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h6P7rCOmZXChsYvdYm5HGZhuMLgHFHq_CtNgTHgdeF0g@mail.gmail.com>
References: <CAJZ5v0h6P7rCOmZXChsYvdYm5HGZhuMLgHFHq_CtNgTHgdeF0g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h6P7rCOmZXChsYvdYm5HGZhuMLgHFHq_CtNgTHgdeF0g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.5-rc1
X-PR-Tracked-Commit-Id: a8460ba59464c038c817844f67a74fe847b56613
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d7868c41df58edabc4e408d119a1aef58a54d9d
Message-Id: <168783457693.6991.9754687450585305547.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 02:56:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 19:22:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d7868c41df58edabc4e408d119a1aef58a54d9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
