Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72627444D4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjF3W3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjF3W3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45093AB6;
        Fri, 30 Jun 2023 15:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A706181E;
        Fri, 30 Jun 2023 22:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF33FC433C8;
        Fri, 30 Jun 2023 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688164168;
        bh=cDtg7/DxJ9RFpGIs8alnozRtGmdL5ZVuQwb4+eihNVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rqy91jD3ODoFuNU7tXCaw11v+ZCFXALKoUMhpIMLiS+rdlzRPNgJsFyJ0b09ihvKX
         2xeyRsUVTGFoZv5MEPGqtJzPrRaYfmNPyuw0byIkhDXiRAkYgmFgl9lJYEb8JI08dm
         SmwDYNl/LTIimcU6DDVlULpzkoiMp+I7eahnJZmFcmiLWZeIuUqlAXj64HfiNV2Xta
         uHeOmCFbUvjJFzTNh2Dn/fPusfkMe1LGtNthWsOC9rmBEHCukLaAoFl5ENB0z5VYvd
         6Iq3ZjfbRJiPmbN9/KP3rAKCsdYkXUFRvV2vEsMjyBeeff51Fbe9RpbOrPVgKIlxrY
         lzgrdh3lPwi/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF763C395D8;
        Fri, 30 Jun 2023 22:29:28 +0000 (UTC)
Subject: Re: [GIT PULL] Pin control changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYdnrDJ8=76DHT3yLyCKqCRyLEObhUaKFOHSMy9y5jVHw@mail.gmail.com>
References: <CACRpkdYdnrDJ8=76DHT3yLyCKqCRyLEObhUaKFOHSMy9y5jVHw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYdnrDJ8=76DHT3yLyCKqCRyLEObhUaKFOHSMy9y5jVHw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-1
X-PR-Tracked-Commit-Id: 9f0648f13e34a01f2e1a7a0d5801988a7bca6988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28968f384be3c064d66954aac4c534a5e76bf973
Message-Id: <168816416884.26572.2531265346010814686.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 22:29:28 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 09:46:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28968f384be3c064d66954aac4c534a5e76bf973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
