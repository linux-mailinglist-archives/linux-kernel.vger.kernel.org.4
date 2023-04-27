Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F36F0A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbjD0RQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbjD0RQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125AD4690;
        Thu, 27 Apr 2023 10:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 803B663E7D;
        Thu, 27 Apr 2023 17:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A63C4339B;
        Thu, 27 Apr 2023 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615762;
        bh=SEC0+2QQY23qlBCPQL8g5+ICO6LMWKSNBltdfSAf+5E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GVsRr+0M3Cyw2jCNkN3cKdSTToV05BVE321n3O48swVOhYhkqCN5yfBcxkzL+MCjJ
         HLX06lI+GIgXDPFDDKb6d0tOk1VfJY5O6DJRAAO8ypod8aAI0XJ6QWh6eGkDsGMsgy
         qP4SRoliOawTvlmcEJzS09RyDha2tOCOq8VE3HNlCMCzIYiEPcjwepIzbdXYICOXk/
         WIppPe3AN4q8dFrPDojmVuPo15EyU0FzJndXfl8gDEZGlPTChUSAH03c521ngT81iy
         PiNeLHb/ZMMI2xFg5WcZFLfImCx0/UOrCpbee1LjMM4+JNNZILSJkhpgYM1bsTHqdt
         REEd95GEJQS0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD180C43158;
        Thu, 27 Apr 2023 17:16:02 +0000 (UTC)
Subject: Re: [GIT PULL 2/2] Devicetree updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425215956.GA2285208-robh@kernel.org>
References: <20230425215956.GA2285208-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230425215956.GA2285208-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-2
X-PR-Tracked-Commit-Id: 1c5e9170ad93d3bd62a7ed8380e60b62c88b90a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb6fe2ceb667eb78f252d473b03deb23999ab1cf
Message-Id: <168261576283.15936.16754628165481146857.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 17:16:02 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Apr 2023 16:59:56 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb6fe2ceb667eb78f252d473b03deb23999ab1cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
