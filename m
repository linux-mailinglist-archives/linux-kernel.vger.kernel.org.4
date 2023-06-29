Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE37430AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjF2Wjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjF2Wj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EF1BD1;
        Thu, 29 Jun 2023 15:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B2EB6154A;
        Thu, 29 Jun 2023 22:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CABB2C433C8;
        Thu, 29 Jun 2023 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688078364;
        bh=6d9B5AcU2wwq9Fhnvxng6PN9qFwpvh3KRw6WPBQokbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HzStRt1P4Vaa5ixo94QlJeaRSJ2YFxq3Xa/GFSe/Os8s9hXc8NSVpTQHkZQzHTu1C
         1XBuL+Pu3j/937exZh6php4Ph4A5u5zUkxRWCqx+l5Gpvbp4j/a8pr05PtXo2P3oh1
         VNSGSgZLf0xRylGF/aIeRfunIFwSJVjK/fN3Qb7ee22eADY9LWcE61o9ml8pCZs4r4
         ZydIFGGgkCzHFEM2MAmFcwjDUSf67mGfeG330UsYKhBCe6IBcljo+8nOr9F6KW6WTs
         32RKHWM65gR7kpiyhyDubt87l5in++W2Hy87dwR7gqIGjRglQhFBvn9AO8cy8qfI9+
         lHtJpO5Ft5iUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B478FE5381B;
        Thu, 29 Jun 2023 22:39:24 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627191433.GA2599784-robh@kernel.org>
References: <20230627191433.GA2599784-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627191433.GA2599784-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5
X-PR-Tracked-Commit-Id: ecdb004843ed91222be38ed838e7ce7167018222
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18f38fedfa71b5b7e954fc8f1e31bda75d8f1d7c
Message-Id: <168807836473.26000.8653346580065925638.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 22:39:24 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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

The pull request you sent on Tue, 27 Jun 2023 13:14:33 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18f38fedfa71b5b7e954fc8f1e31bda75d8f1d7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
