Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AE6E6BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjDRSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjDRSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573B468C;
        Tue, 18 Apr 2023 11:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D98066377A;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 497E7C4339B;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681841406;
        bh=qECPssaKOdA1Rfaall6QNi0ar+2KTfHq/RDwO0gDHIY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n7y0dSVuCKwJ6AdEjcW/1qaan1ZYJWiT4vdYzRXyuW2umCWHM9D83Cj6LJdCIqH18
         2jmbnkvjkdM7Rz2mEObVLnn78mjZR7rg83TigPVVMYiAV5hX9q1p3GWfgMjwSnYuTa
         IhJ8X3Uu5rwdfRrU2ZO+ho+rcRkgvBI0srud3CDZTgjPxX6CcZThZnY100OuAhmzSC
         gL+ROK+HVIMQ3VVvkAU0+seHCYUaMmd+aEVKl85KUoYmjsp1DtcCtAUg9XXthorLan
         somXltBbQVgsy5mlQMN/xEq/cn6Vh04WSjSiKcEisMq+hiiKq8cScuhUEg85OyO3j5
         BIdIiB4LqZIoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F215C4167B;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK fixes for v6.3-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230418084329.12066-1-ulf.hansson@linaro.org>
References: <20230418084329.12066-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230418084329.12066-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc3
X-PR-Tracked-Commit-Id: 4b6d621c9d859ff89e68cebf6178652592676013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af67688dca57999fd848f051eeea1d375ba546b2
Message-Id: <168184140604.21228.5799260324654292808.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Apr 2023 18:10:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Apr 2023 10:43:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af67688dca57999fd848f051eeea1d375ba546b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
