Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035F5FA6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJJU5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJJU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB1491D4;
        Mon, 10 Oct 2022 13:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC8D6101C;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D371C433C1;
        Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435397;
        bh=YfuYLfbSwFRdAJbZgTNL8Vz59IQm8RUSXQVayhUp9DU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D0+zZIf1SClXvPZCpm3ENK4b2NZyn4/AVO9VmVRZer7eoG5BHZaRM4aVeKyhVOVR1
         ubH8kkKtJl3VPE26910m2X2T1GWgMLarQy3QQOvcurQgzexQ63uizk3VozpBpHq3z4
         hMxaWPYpAi5ED07nJd420vAO36NorqcU1A2joT2MhtdJxewzz6z7RRyw1tp8nrdQX8
         jD07zfrdjPAIrTDZLnpuaNbMsrw0HbUn4iphoOuoHwoTycPNTAkkCUp8GRGDHWHYac
         xUg5VZcdzju3qKGlGKoSGcw1EQaR+SFGV9gTAZl2qqduhOVYyKiTIC0y8bS6pulzgb
         KDYU5IVvaPwYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0CA4E43EFE;
        Mon, 10 Oct 2022 20:56:36 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003203129.GA2767725-robh@kernel.org>
References: <20221003203129.GA2767725-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003203129.GA2767725-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.1
X-PR-Tracked-Commit-Id: 7a7f58575483a74db4cc2c1e37f21ddda057083d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 706eacadd5c5cc13510ba69eea2917c2ce5ffa99
Message-Id: <166543539698.11766.8360550134750164141.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:36 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 15:31:29 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/706eacadd5c5cc13510ba69eea2917c2ce5ffa99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
