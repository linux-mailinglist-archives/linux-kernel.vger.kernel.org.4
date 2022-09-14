Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F15B850A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiINJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiINJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:33:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3D7C1E0;
        Wed, 14 Sep 2022 02:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 778E9B818B8;
        Wed, 14 Sep 2022 09:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A581C433C1;
        Wed, 14 Sep 2022 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663147633;
        bh=X1DSiwb9uHY3lDCoqJ+AqQWHe05H+jxrCBpwcLHgL2Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J6szvWgqjftUPpX+uYVyJuE/TGxRf3i3q3ccBXT17B2SNRr5kaW7mfjKtTYHyvBr5
         u2uDMbAJq5WglfHXYuhwYL0K5x1K2DJByTqsddk9KbL4HytshrIGIfTUoEFo+mJTq5
         9j0MU10EJrR3qcPvaZ1Ba9tY+ayv2BMlzcwPrtfriP/jevSo1i1IMFz7bIMSVWPFEu
         FQrdO03qw8ohfqIe78wupFU+pnWIlIiYjYiCrutTlVVlRisK/lrxpAaeBeWw2Dzg6c
         O6aGbBEA3g1TAOTKn4ZLt/XezXH1l20pmUdXQ2ZsY2D0+I/CmR0BBikr8uWE4OMrhE
         dOynRR/zYDGoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25202E8834D;
        Wed, 14 Sep 2022 09:27:13 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.0, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220913183605.GA155025-robh@kernel.org>
References: <20220913183605.GA155025-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220913183605.GA155025-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-2
X-PR-Tracked-Commit-Id: de11663b75b0a8f1cfeb00d3b4acec9bd5a49cad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3245cb65fd91cd514801bf91f5a3066d562f0ac4
Message-Id: <166314763314.6005.7719363482819298941.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Sep 2022 09:27:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Sep 2022 13:36:05 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3245cb65fd91cd514801bf91f5a3066d562f0ac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
