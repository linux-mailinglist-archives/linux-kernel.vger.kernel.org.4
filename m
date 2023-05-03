Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC06F5F1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjECT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjECT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44976A0;
        Wed,  3 May 2023 12:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8778362F42;
        Wed,  3 May 2023 19:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB02FC433D2;
        Wed,  3 May 2023 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683142111;
        bh=sPaIfdEpJIxGgVU7FmpRmRlGcrUsImMC4vpTygWZa2o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PkASVbYgchDpKfbBtkEti2V7jZWxnS9yGFnl5WoWyaoNQ1Y/+QnNGGVSGpIBP98jS
         uD1F3pujxijbE4oNLj8qlxQ4R1Eu7lJoKUfAMtj2ccHFL4uP9PaNK+89SXNCr4iaLC
         KiFZBUPOpcuDhkZYqDXrzvCbNllY9xKSV4qQWaVDHl3WMw/8//4OaUBwxdxyONVhEG
         iuPPEkON4nWcRfeB8bd7y6slweMbSVfQRbcr5ZkCZCUbAcKGxI/NTSTUG/LtvqJn+u
         Gppvk5Tp/VHvzFAG/2Lyl4tarkXDI1uU8kPr52loYZnCBgZ6RcmbamP6OHAifpTNt+
         h8XyjLOd+sVAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0399E5FFC9;
        Wed,  3 May 2023 19:28:30 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hv3CrvnrY=7NrpxMeUyoupB43Bu2Cv_4CD7asPFTU-cw@mail.gmail.com>
References: <CAJZ5v0hv3CrvnrY=7NrpxMeUyoupB43Bu2Cv_4CD7asPFTU-cw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hv3CrvnrY=7NrpxMeUyoupB43Bu2Cv_4CD7asPFTU-cw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1-2
X-PR-Tracked-Commit-Id: 53389edd4020514b876b01d05e851fb7d46eb51f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667de5c68440732373f571f7eac4ff44b1b93ee7
Message-Id: <168314211084.24310.16316351220410969419.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 19:28:30 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:25:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.4-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667de5c68440732373f571f7eac4ff44b1b93ee7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
