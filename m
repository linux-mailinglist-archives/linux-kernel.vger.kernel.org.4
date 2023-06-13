Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF172EB91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjFMTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFMTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4492;
        Tue, 13 Jun 2023 12:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBAC46392C;
        Tue, 13 Jun 2023 19:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43FC0C433F0;
        Tue, 13 Jun 2023 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686683157;
        bh=5vbYuIEb6QKhapm/2VgTnuc2Gtp0IUWgKxB5DXkxtZM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q+TEQZEIIExv35oEWb0ms5sJBAnta5loMEMOMW0ao7ZwDTUjCORAo7NP+Hpohfmn/
         EfblQYb2EnBelDgA3YG7k4LbtZckqa10PSJta6ObrTQLG6dzCKc2NZrP6wuvSv07VP
         ZqxF2nj03H/P4BG2J1VTqIt3uomT185jcR7SsO1MXtKkT17ozWhbzn/BjNtgQ4SUNr
         vzI+wrYKiDQcBXY4KDQiq6zRa8wsmasBYD/XDv+3/oa18y9hRaxCZwKvraLPDFRB7Z
         ZY2PTZGje+iM7J+3vgHMQlFk3AFXDJUm6qp+w65UjLykDyB3d+GwZ/oT0szhcatDej
         ifKtc+9aWem3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EFF1C1614E;
        Tue, 13 Jun 2023 19:05:57 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.4, part 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230613151814.GA2133279-robh@kernel.org>
References: <20230613151814.GA2133279-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230613151814.GA2133279-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-3
X-PR-Tracked-Commit-Id: c7753ed71c160f75f92ff5679e9fc22526e56fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15adb51c04ccfcf58ac3eec7464a2768fe175fcc
Message-Id: <168668315718.16387.7965827940599492506.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Jun 2023 19:05:57 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Jun 2023 09:18:14 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15adb51c04ccfcf58ac3eec7464a2768fe175fcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
