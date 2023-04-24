Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31176E17BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjDMWxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjDMWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916061BEA;
        Thu, 13 Apr 2023 15:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F9F6426E;
        Thu, 13 Apr 2023 22:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B87C433EF;
        Thu, 13 Apr 2023 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681426399;
        bh=QGOl8zupVwZO6Fk8KTZXKWycX31lOeAsz6KgMrURtL0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eWlC9w7I2RYKcN/M/95AbtRh4EOpdzAjrcPmAZDkkwOcljI1NHr82jp5nDS3Uh1WK
         7lLyqpsFtQjA6RIaM/mA6rIhhjLOQ+fL1neJZ/zSi66ghVxBa0V2w/OE4kOkscNWOc
         VwZQ0alwKtxSBTy/yltMDjbXI8HwRpMMC5Y35QMzWwvSH5sWMBoCnTXqhXQMHfq55s
         G51Nl5N4qiTti1yufWB/9XbSJs34MiK7CbNo3WGZo4RGHiLr3QiStFnShVr7GclzuI
         LmfZtZUDhsALFFBsXvvX+/TcbRpDbhuuXo01i5GlmD8ycoyNNV8ntAJpSk8xKJPE5t
         EQuRZNhayT8ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8004FC395C5;
        Thu, 13 Apr 2023 22:53:19 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.2, take 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230413221458.GA1938449-robh@kernel.org>
References: <20230413221458.GA1938449-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230413221458.GA1938449-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-3
X-PR-Tracked-Commit-Id: 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4413ad01e27eb989f4b19bb5b038328c220a383d
Message-Id: <168142639951.8338.5188821173054505633.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 22:53:19 +0000
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

The pull request you sent on Thu, 13 Apr 2023 17:14:58 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4413ad01e27eb989f4b19bb5b038328c220a383d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
