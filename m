Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9F73AE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFWBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFWBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC32107;
        Thu, 22 Jun 2023 18:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F64A61946;
        Fri, 23 Jun 2023 01:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7886FC433CA;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482214;
        bh=w7atJ7NLEGr6zxnPBqWFbrMDJybsPULYgvMY7vFPRn4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nOsO6wNq6W+I93d/D1bNZ7S90+SLAAifoV2Snluig8haNYPjtF8MyD8sbLlTg7Jum
         poMDxybBBjmeirxwMpsaIRQQJ512PzmKHwJ3UCB8MWCMvQDzWu6sfqsfOJU8BIpWXq
         luAFgBu6DVVScPvi7dvlMrY2Q0gvV973gN4QERjBQb0abEe5fJvRZB+5/+Cw0smPXT
         0dO/vRl+R5glp44zJ7qX+J1ZUtZoslviToyOTr0FP85u/ZCdGcbFjNQUDA3g1W8nEe
         FtDsVv5y2U/5sH7NgDqzKVy2kDIoQsml4Ou+FUjKjAK2hb1KCHZDS+XlV2LtskHUWf
         A66Dmv2e4Cvzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65AE0C395FF;
        Fri, 23 Jun 2023 01:03:34 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.4-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230622134139.78695-1-ulf.hansson@linaro.org>
References: <20230622134139.78695-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230622134139.78695-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc6
X-PR-Tracked-Commit-Id: 413db499730248431c1005b392e8ed82c4fa19bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 937650021171f20e3fc743ef34fb4792f111946d
Message-Id: <168748221440.12146.10278936077302812901.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:34 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jun 2023 15:41:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/937650021171f20e3fc743ef34fb4792f111946d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
