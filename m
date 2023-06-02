Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BF720239
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjFBMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjFBMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4713E;
        Fri,  2 Jun 2023 05:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A8A63F0F;
        Fri,  2 Jun 2023 12:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59E28C433D2;
        Fri,  2 Jun 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709457;
        bh=rVXhCE0XtLm83wGAbC+sjEpgKbZehMvJ4jbUFyy87kQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MTueRKOSqo0hbTCa3954/FZAiSE6KftDXBQxyakHVE4uTPVmttKr9NY+2MGoio+4v
         ++HZecjEhtHytWL7Cqee7qDqdbjYYyb2qdjqsLDiggj0uInubNtv09uf3KYjYN5fHx
         mQ2Tu4xCsHEgRRt3iKIUTP/1vg2GPhX45ODRNCQeH8F80mVWbrLjeUbYUsTxjn7ChX
         Yof2EOoJAS16QxtNKAd2GBCZ+4xqt+OZVs6uNTGJ0eM1crk2GpcTCim9ImXKmu7t01
         5DGGiG9WHwome0vExfKXweNpRquhW5knRuu4rsgSCif30e/Ra2H5HzRZ5YglcRa/vO
         s8iwhLwxJOmTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47C38E52BF5;
        Fri,  2 Jun 2023 12:37:37 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230602084733.40750-1-ulf.hansson@linaro.org>
References: <20230602084733.40750-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230602084733.40750-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1-2
X-PR-Tracked-Commit-Id: 0b5d5c436a5c572a45f976cfd34a6741e143e5d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 921bdc72a0d68977092d6a64855a1b8967acc1d9
Message-Id: <168570945728.3943.9861880926621562600.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 12:37:37 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  2 Jun 2023 10:47:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/921bdc72a0d68977092d6a64855a1b8967acc1d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
