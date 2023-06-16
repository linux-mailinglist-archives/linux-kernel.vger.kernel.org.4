Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970847325AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjFPDKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbjFPDKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B442D4C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CF662653
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AA38C433C0;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686885019;
        bh=hsodhLuklH4bboM1Ggrkx1gigC2Wx4c6oMddP5BgT48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PWqQbVcLwq4NOGSwB/tg1Q8qP7nqtSg0/+xo0AwPfJVzYDE+tfvzxLsjGHY403xx8
         DEP1QoLjUQ3y6Z9g7c0V36/Jr4ms4zKbFLDSl39jAoWgUuo7Py+z2/jOAfUtFPWYWo
         A5OBgSf2OLbR/a1rxfgRaTd220XoAFSZjNUrL4hizOeHyQtMxpqhgmPcU1W6QcoyeA
         sosWg28VdjyvjkevAEBsl2PzgbCKhStDY22JQI9MQOa5IXFdY36juLfs4lyzOX/Dkj
         et2fk0KiyzefWXEs7VtncFGqSn1Q5cj4igvze6b6rjTv1+ShCpCKfFua0wvJLw2bX8
         0IiZQ3e/SeryQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07D8FC3274B;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615114330.8A41EC433C8@smtp.kernel.org>
References: <20230615114330.8A41EC433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615114330.8A41EC433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc6
X-PR-Tracked-Commit-Id: b00de0000a69579f4d730077fe3ea8ca31404255
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eee71c3473e6830e8e20017b2429bcd83e1fce9b
Message-Id: <168688501902.31465.4533177515527485250.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 03:10:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 12:43:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eee71c3473e6830e8e20017b2429bcd83e1fce9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
