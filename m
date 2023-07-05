Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446FB748E80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjGET5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjGET5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C712A;
        Wed,  5 Jul 2023 12:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B43061700;
        Wed,  5 Jul 2023 19:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DA20C433C7;
        Wed,  5 Jul 2023 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688587052;
        bh=lLc9FYZXiuh2cyrSucNAoRIe+T6XIRtry6xTVljQ8Ok=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TJS8bEA+vkYfNOGvOPLlAAXHttEw9THVu5AbmYIwXvDGiDuybtaegz+o3j/nHqUJ/
         hC+S3fsu+m+S285eJGRGa+CUQvpIjScUXWoYnN6zsvze7vZ6qnKFkPCrX3sL7axX+F
         st4nWDVnDUA1L3raDOZzoN2dSX8LehNHoa8gK22YmrZxbcUJ6OJ8COf3HJfpyMvlzg
         n3NRNQ68WvJou78N+76CiSO3FeXkfCbmPij3yekBgAoWdCxB8bF9NvrDiQFYakZTVR
         GrydqRnCutpcoX99LTHQAGP/J6kVJsW9VKwpOI9r+ZfTCBvD+Ocaksq0xqkBP5tvRu
         aqwkF/CHoquCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 796F7C39563;
        Wed,  5 Jul 2023 19:57:32 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.5, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230705174652.GA1203382-robh@kernel.org>
References: <20230705174652.GA1203382-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705174652.GA1203382-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5-2
X-PR-Tracked-Commit-Id: 31e9f406efae513156c129e9f7ad16b9f0ec7a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9861581641225262b836508ec2980e1c4fd0c91
Message-Id: <168858705249.23936.14748148573789033477.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 19:57:32 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 11:46:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9861581641225262b836508ec2980e1c4fd0c91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
